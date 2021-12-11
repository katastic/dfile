// [ ] Allow auto overwrite files mode -o (and default to not)
//		[ ] Overwrite if newer
// [ ] Output Folder
// [ ] Send folder (and recursive send/subfolders?)
 
import std.datetime, std.datetime.stopwatch : benchmark, StopWatch;
import std.stdio, std.format, std.string;
import std.file, std.socket;
import std.conv, std.bitmanip;
import std.zlib;
import crypto.aes, crypto.padding;

//extern(C) ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count); //#include <sys/sendfile.h>
extern(C) int sched_yield(); // include <sched.h>

immutable uint DEBUG_SIZE = 2000;
immutable int SEND_SIZE_MAX = 32768-1;

struct globalstate
	{
	bool is_server = false;
	bool is_client = false;
	string client_string = "";
	string ip_string = "127.0.0.1";
	ushort port = 8001;
	bool using_compression = true;
	bool using_encryption = true;
	string path = ".";
	immutable int SEND_SIZE = 32767; //1024;
	string key = "12341234123412341234123412341234"; //must be at least 16 bytes
	ubyte[] iv = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; //initialization vector
	}

globalstate g;

void server(string[] file_to_parse, string ip_string, ushort port) 
	{
	writeln("MODE: SERVER, with file(s):", file_to_parse);
	assert(file_to_parse.length > 0);		
	auto listener = new Socket(AddressFamily.INET, SocketType.STREAM);
	listener.bind(new InternetAddress(ip_string, port));
	listener.listen(10);
	auto readSet = new SocketSet();
	Socket[] connectedClients;
	char[SEND_SIZE_MAX] buffer;
	bool isRunning = true;
	while(isRunning) 
		{
		readSet.reset();
		readSet.add(listener);
		
		foreach(client; connectedClients)
			{
			readSet.add(client);
			}
		
		if(Socket.select(readSet, null, null)) 
			{
			foreach(client; connectedClients)
				{
				if(readSet.isSet(client)) 
					{
					// read from it and echo it back
					auto got = client.receive(buffer);
					if(got == 0)
						{
						// == 0 means hangup, right?
						// https://stackoverflow.com/questions/283375/detecting-tcp-client-disconnect
						isRunning = false; // ? will this terminate?
						continue;
						}
					if(got == -1)
						{
						writeln("SOMETHING ODD HAPPENED. buffer -1 length.");
						// is this because we hung up? or is it breaking somehow?
						// is client closing connection after 96 packets?
						break; // this was crashing here with -1 length
						}
					client.send(buffer[0 .. got]);
					}
				import core.thread : Thread;
				Thread.sleep( dur!("msecs")(3) );  // don't use all my CPU waiting!!!
				}
				
			if(readSet.isSet(listener)) 
				{
				// the listener is ready to read, that means
				// a new client wants to connect. We accept it here.
				auto newSocket = listener.accept();    
				writeln("SERVER: CONNECTION STARTED, # files = ", file_to_parse.length);
					foreach(f; file_to_parse)
						{
						string text = "hello";
						newSocket.send( format("TC\x00%r%s", text.length, text) ); 
						readFile(f, newSocket);
						text = "goodbye";
						newSocket.send( format("TC\x00%r%s", text.length, text) ); 
						}

					connectedClients ~= newSocket; // add to our list
					
					newSocket.send( format("CX\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00") ); // sent [close connection] packet.
				writeln("SERVER: CONNECTION SENT/FINISHED.");
				}
			}
       
		import core.thread : Thread;
		Thread.sleep( dur!("msecs")(0) ); 
		}
	}

void client(string ip_string, ushort port) 
	{
	auto socket = new Socket(AddressFamily.INET,  SocketType.STREAM);
	socket.connect(new InternetAddress(ip_string, port));	
	char[SEND_SIZE_MAX] buffer;
	bool is_normal_file = true;
		
	bool handle_packet(string data)
		{
		if(data[0] == 'F')  //file
			{
			ubyte flen = data[2]; //filename length
			writeln("flen:", flen);
			ulong plen =  //payload length (EIGHT. BYTES.)
				data[3 ] +
				data[3 + 1]*256^^1 + 
				data[3 + 2]*256^^2 + 
				data[3 + 3]*256^^3 +
				data[3 + 4]*256^^4 +
				data[3 + 5]*256^^5 + 
				data[3 + 6]*256^^6 + 
				data[3 + 7]*256^^7;
			writeln("plen:", plen);
			
			string filename = data[3+4+4 .. 3+4+4+flen];
			string payload = data[3+4+4+flen .. $];
			
			if(data[1] != 'C' && data[1] != 'N' && data[1] != 'X' && data[1] != 'Y')
				{
				assert(false, "PACKET ERROR in compression identifier!");
				}
			
			if(data[1] == 'N') //normal file
				{
				writeln("starting normal file");
				}

			if(data[1] == 'C') //compressed file (using -x, this is confusing)
				{
				writeln("starting compressed file");
				payload = cast(string)uncompress(payload); 
				}
				
			if(data[1] == 'X') // encrypted file  (using -y, this is confusing)
				{
				writeln("starting normal encrypted file");
//				writefln("payload: %s", payload); 
				ubyte[] payload2 = cast(ubyte[])(payload);
//				writefln("payload2: %s", payload2); 			
				payload = cast(string)AESUtils.decrypt!AES128(payload2, g.key, g.iv, PaddingMode.PKCS7);
//				writefln("payload-now: %s", payload); 
				}
				
				
			bool file_failure = false;
			if(data[1] == 'Y') // compressed then encrypted file
				{
				import std.string : assumeUTF;
				writeln("starting encrypted, compressed file");
				ubyte[] payload2 = cast(ubyte[])(payload);
//				writefln("payload: %s", payload);  //string
//				writefln("payload2: %s", payload2); 
//				writefln("payload2-string: %s", cast(string)payload2); 
				ubyte[] temp;
				try{
					temp = AESUtils.decrypt!AES128(payload2, g.key, g.iv, PaddingMode.PKCS7);
					payload = cast(string)(uncompress(temp));
					}catch(Exception e){
					writeln("FILE FAILED. Decryption exception! Is the key correct?");
					writeln(e.msg);
					file_failure = true;
					}
//				writefln("uncompress: %s", uncompress(temp));
//				writefln("payload-now: %s", payload); 
				}

			if(!file_failure) // TODO: Announce to server of file failure
				{
				writefln("filename [[%s]]", filename);
				if(payload.length < DEBUG_SIZE)writefln("payload [[%s]] of len=%d", payload, payload.length);
			
				string output_filename = format("%s.out", filename);
				writefln("WRITING TO FILE [%s]", output_filename);
				try{
					std.file.write(output_filename, payload);	 
					}catch(Exception e){
					writefln("Writing to DISK failure! [%s]", e.msg);
					}
				}
			}
			
		if(data[0] == 'T') //text/chat packet
			{
			}
			
		if(data[0] == 'C') //command packet  (we could put EXIT in here)
			{
			if(data[1] == 'X'){writeln("EXIT CONNECTION."); return 1;} // EXIT
			
			if(data[1] == 'R'){} // Read limit (bytes/KB/whatever / sec)
			if(data[1] == 'W'){} // Write limit
			if(data[1] == 'P'){} // Pause/resume	PP pause,  PR resume ? (or P0 vs P1 byte value)
			if(data[1] == 'S'){} // reStart last file
				// auto pause if client hard drive is full
				// might need to be able to request restarting the file?
			} 
			
		if(data[0] == 'X') {writeln("EXIT CONNECTION.2"); return 1;} // exit/close connection
	
		return 0;
		}
	
	string zbuffer = ""; // everything we have so far
	bool done = false;		
	socket.blocking(true);
	
	uint current_packet_seek_length = 1253152;

	do{
		if(zbuffer.length < DEBUG_SIZE)writefln("waiting for packet. Buffer (len=%d) is [%s] ", zbuffer.length, zbuffer);
		auto buffer_length = socket.receive(buffer); // wait for the server to say hello
		writeln("got : ", buffer_length);
		
		zbuffer ~= buffer[0 .. buffer_length];
			
		if(zbuffer.length < DEBUG_SIZE)
			{
			writefln("buffer: <<%s>> ", buffer[0 .. buffer_length]);
			writefln("zbuffer: <<%s>> ", zbuffer);
			}
//	payload = format("FN%r%r%r%r", cast(ubyte)filename.length, filename, x.length, x[0 .. $]);
//				      012 
/+
						x 1
						 filename[x]
						  y 12345678
							data[y]

	x.length is >> EIGHT. BYTES. <<
+/

		chop:
		if(zbuffer.length < 7) continue; //not enough data to form a packet header!

		if(zbuffer[0] != 'F' && zbuffer[0] != 'X' && zbuffer[0] != 'T' && zbuffer[0] != 'C')
			{
			writefln("malformed packet. We got [%s] for packet header.", zbuffer[0]);
			}
		
		if(zbuffer[0] == 'T')
			{
			// 01234567890
			// TC012345687texttogo
			// TC0		-- header (T, the rest doesn't matter. flen = 0)
			//	  12345678	-- payload length=text length
			
			uint payload_length = 
				zbuffer[3] + 
				zbuffer[3+1]*256^^1 + 
				zbuffer[3+2]*256^^2 + 
				zbuffer[3+3]*256^^3 +
				zbuffer[3+4]*256^^4 +
				zbuffer[3+5]*256^^5 +
				zbuffer[3+6]*256^^6 +
				zbuffer[3+7]*256^^7;
				
			writefln("TEXT RECEIVED len=%d", payload_length);
			string payload = zbuffer[3+8 .. 3+8 + payload_length]; //trim preceding header 
			writefln("TEXT RECEIVED [%s] %d", payload, payload.length);

			if(3+8 +payload.length != zbuffer.length)
				{
				writeln(3+8+payload.length, " ",zbuffer.length);
				writefln("buffer was <<%s>>", zbuffer);
				zbuffer = zbuffer[3+8 + payload_length .. $];
				writefln("buffer is now <<%s>>", zbuffer);
				}else{
				zbuffer = "";
				}
			goto chop;
			}
		
		if(zbuffer[0] == 'X')
			{
			socket.close();
			writeln("we got the kill signal!");
			return ;
			}

		ubyte flen = zbuffer[2]; //filename length
		writeln("flen:", flen);

		if(zbuffer[0] == 'F')
			{
			current_packet_seek_length = 
				3 + 	// 'F' 'N' x (where x=filename length)
				4 + 	// 1234 bytes of packet length
				4 + 	// why 4??? is this 8 byte packet length???
				flen +	// 'filename.txt'
				zbuffer[3 ] +
				zbuffer[3 + 1]*256^^1 + 
				zbuffer[3 + 2]*256^^2 + 
				zbuffer[3 + 3]*256^^3 + 
				zbuffer[3 + 4]*256^^4 + 
				zbuffer[3 + 5]*256^^5 + 
				zbuffer[3 + 6]*256^^6 + 
				zbuffer[3 + 7]*256^^7;
			}
			
		if(zbuffer[0] == 'T')
			{ // TC00
			current_packet_seek_length = 3 + 4 + 4 + 
				zbuffer[3 ] +
				zbuffer[3 + 1]*256^^1 + 
				zbuffer[3 + 2]*256^^2 + 
				zbuffer[3 + 3]*256^^3 + 
				zbuffer[3 + 4]*256^^4 + 
				zbuffer[3 + 5]*256^^5 + 
				zbuffer[3 + 6]*256^^6 + 
				zbuffer[3 + 7]*256^^7; 
			}
			
		writefln("buffer length: <<%d>> ", buffer_length);
		writefln("current_packet_seek_length: <<%d>> ", current_packet_seek_length);
		  
		if(zbuffer.length > current_packet_seek_length)
			{
			string pbuffer = zbuffer[0 .. current_packet_seek_length]; //single packet of data;
			zbuffer = zbuffer[current_packet_seek_length .. $]; // shrink zbuffer
			writeln("---------------------------------------------------");
			if(pbuffer.length < DEBUG_SIZE)writefln("dealing with packet of [%s]", pbuffer);
			writeln("---------------------------------------------------");
			
			if(handle_packet(pbuffer))done = true;
			//time to parse!
			
			if(zbuffer.length < 2000)writefln("new zbuffer was [%s]", zbuffer);
			goto chop;
			}else{
			continue; //we need more data
			}
		
		}while(!done);
		
		/+
				writefln("compressed (sent) size: %d", total_buffer.length);		
				writefln("extracted         size: %d",  output.length);
				if(total_buffer.length != 0)writefln("ratio: %d",  output.length / total_buffer.length);		
				writefln("saved: %d bytes",  output.length - total_buffer.length);		
	+/
	}

void readFile(string filename, Socket mySocket)
	{
/*	auto fileDescriptor = 0;	
	auto fileSize = 1024;
	sendfile(mySocket.handle, fileDescriptor, null, fileSize);
		// This can also be split into chunks then by using a different start position and length.
		// i mean, whatever is EASIEST at this point is what needs to be done.
	*/
	
	try{
		auto norm = read(filename);
	ubyte[] enc;
	if(g.using_compression)
		{
		writeln("COMPRESSION");
		writeln("------------------------------------------------" );		
		writeln(norm.length);
		enc = std.zlib.compress(norm, 9);
		writeln (enc.length);
		writeln ("Compression ratio: ", to!float(enc.length) / to!float(norm.length));
		//TODO FIXME: only run compression when we're using it!
		}
		
	ubyte[] aes_buffer;	
	if(g.using_encryption)
		{
		writeln();
		writeln( "ENCRYPTION");
		writeln( "------------------------------------------------" );
		
		ubyte[] message_to_process;
		if(g.using_compression)
			{
			message_to_process = cast(ubyte[])enc;
			}else{
			message_to_process = cast(ubyte[])norm;
			}
		aes_buffer = AESUtils.encrypt!AES128(message_to_process, g.key, g.iv, PaddingMode.PKCS7);
//		ubyte[] decoded_buffer = AESUtils.decrypt!AES128(aes_buffer, key, iv, PaddingMode.PKCS7);
//		writeln("original: ", norm.length);
//		writeln("aes: ", aes_buffer.length);
//		writeln("original: ", decoded_buffer.length);
//		writeln("NOTE if length of AES is a few larger, it has to work on blocks of 16 bytes so I'm guessing it pads the source before encryption.");
//		writeln("AES");
//		writeln("aes:", aes_buffer);
//		writeln();
//		writeln("decoded:", decoded_buffer);
//		writeln("vs");
//		writeln("x:      ", x);
		writeln("aes_buffer.length: ", aes_buffer.length);
		}
		
	string payload;
	
	writeln("SENDING DATA");
	writeln("----------------------------------------------");
			writeln("length was: ", norm.length);
	//		writeln(typeid(norm.length));
		//	writeln(norm.length.sizeof);
	//		writeln(format("%b", norm.length));

			// not encrypted
			if(g.using_compression == false && g.using_encryption == false)
				payload = format("FN%r%r%r%r", cast(ubyte)filename.length, norm.length, filename, norm[0 .. $]);
			if(g.using_compression == true && g.using_encryption == false)
				payload = format("FC%r%r%r%r", cast(ubyte)filename.length, enc.length, filename, enc[0 .. $]);
								
			// encrypted
			if(g.using_compression == false && g.using_encryption == true)
				payload = format("FX%r%r%r%r", cast(ubyte)filename.length, aes_buffer.length, filename, aes_buffer[0 .. $]);
			if(g.using_compression == true && g.using_encryption == true)
				payload = format("FY%r%r%r%r", cast(ubyte)filename.length, aes_buffer.length, filename, aes_buffer[0 .. $]);

			for(int i = 0; i < payload.length; i += g.SEND_SIZE)
				{
				if(i+g.SEND_SIZE < payload.length)
					{
					writefln("sending from %d to %d", i , i+g.SEND_SIZE); 
					writeln(payload[i .. i+g.SEND_SIZE]);
					mySocket.send(payload[i .. i+g.SEND_SIZE]);
					}else{
					writefln("sending from %d to %d", i , payload.length); 
					writeln(payload[i .. i+payload.length]);
					mySocket.send(payload[i .. payload.length]);
					}
				}
		} catch(Exception e) { //why doesn't this catch with a FileException like the online guide? //https://tour.dlang.org/tour/en/basics/exceptions
		writeln("Exception: ", e);
		}
	}

int main(string[] args)
	{
	import std.getopt;
	GetoptResult helpInformation;
	string usageInfo = "Usage\ndfile [opts] file1 [file2 .. etc]";
	
	bool disable_encryption = false;
	bool disable_compression = false;
	
	try{
		helpInformation = getopt(args,
			std.getopt.config.bundling, // allow combined arguments -cpzspfnapsfon
			"s", "run as server", &g.is_server,
			"c", "run as client (specify IP to connect to, e.g. -c=192.168.1.1) ", &g.client_string,
			"p", format("specify port (default: %d)", g.port), &g.port,
			"k", "set encryption (k)ey= [MUST be >=16 bytes]", &g.key,
			"x", "disable encryption", &disable_encryption,
			"y", "disable compression", &disable_compression,
			"f", "destination folder path (default: .)", &g.path);			
	}catch(GetOptException e){
		writefln("Exception: %s", e.msg);
		return -1;
	}
	
	
	//because getopts will only add true (to default true), not set true to false.
	if(disable_encryption){ writeln("Disabling encryption"); g.using_encryption = false; }
	if(disable_compression){ writeln("Disabling compression"); g.using_compression = false; }
	
	
	if(g.key.length < 16){writeln("ERROR: Key MUST be at least 16 bytes!"); return 0;} 
	if(g.client_string != ""){g.is_client = true; g.ip_string = g.client_string;}
	if(g.client_string == "localhost"){g.ip_string = "127.0.0.1";}

	if( (!g.is_server && !g.is_client) || (g.is_server && g.is_client))
		{
		defaultGetoptPrinter(usageInfo, helpInformation.options);
		return -1;
		}

	if(g.is_client)
		{
//		if(g.ip_string == "") writeln("YOU NEED TO SPECIFY CLIeNT IP");  commented out for quick testing.  
		client(g.ip_string, g.port);
		}

	if(g.is_server)
		{
		if(args.length > 1)
			{
			server(args[1 .. $], g.ip_string, g.port); //getopt removes args that are recognized and leaves the rest
			}else{
			writeln("ERROR: You need to specify file(s)!");
			defaultGetoptPrinter(usageInfo, helpInformation.options);
			return 0;
			}
		}
		
	if (helpInformation.helpWanted){defaultGetoptPrinter(usageInfo, helpInformation.options);return 0;}

	return 0; 
	}
