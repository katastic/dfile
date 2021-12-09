import std.datetime;
import std.datetime.stopwatch : benchmark, StopWatch; //this line is separate from std.datetime and important (see docs)
import std.stdio, std.format, std.string;
import std.file, std.socket;
import std.conv, std.bitmanip;
import std.zlib;
import crypto.aes, crypto.padding;

extern(C) ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count); //#include <sys/sendfile.h>
extern(C) int sched_yield(); // include <sched.h>

void server(string[] file_to_parse, string ip_string, ushort port) 
	{
	writeln("MODE: SERVER, with file(s):", file_to_parse);
		
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
//	payload = format("FN%r%r%r%r", cast(ubyte)filename.length, x.length, filename, x[0 .. $]);
						string text = "hello";
						newSocket.send( format("TC\x00%r%s", text.length, text) ); 
						readFile(f, newSocket);
						text = "goodbye";
						newSocket.send( format("TC\x00%r%s", text.length, text) ); 
						}
					// newSocket.send("Hello!\n"); // say hello
					connectedClients ~= newSocket; // add to our list
					
					newSocket.send( format("X\x00\x00\x00\x00\x00\x00") ); // sent [close connection] packet.
				writeln("SERVER: CONNECTION SENT/FINISHED.");
				}
			}
       
		// If we're done doing any messages, let's yield back to the CPU so we don't 100% the core
//		sched_yield(); //one, other, or both?
		import core.thread : Thread;
		Thread.sleep( dur!("msecs")(0) ); 
		}
	}

void client(string ip_string, ushort port) 
	{
	StopWatch sw;
	StopWatch sw2;
	StopWatch sw3;
	
	sw.start();
//	do{
		auto socket = new Socket(AddressFamily.INET,  SocketType.STREAM);
		socket.connect(new InternetAddress(ip_string, port));
		
		//int number_of_packets = 0;
		char[SEND_SIZE_MAX] buffer;
		//ubyte filename_length = 0;
		//char[] filename;
		//ulong filesize;
		bool is_normal_file = true;
				
		// [X] THE PROBLEM IS, we may recieve more than one packet worth in our buffer!
		// We might ALSO recieve... LESS than an entire packet!
		// fuck this, let's just use a serializer library.
		
		bool handle_packet(string data)
			{
			if(data[0] == 'F')  //file
				{
				ubyte flen = data[2]; //filename length
				writeln("flen:", flen);
				uint plen =  //payload length
					data[3 ] +
					data[3 + 1]*256 + 
					data[3 + 2]*256*256 + 
					data[3 + 3]*256*256*256;
				writeln("plen:", plen);
				
				string filename = data[3+4+4 .. 3+4+4+flen];
				string payload = data[3+4+4+flen .. $];
				
				if(data[1] != 'C' && data[1] != 'N')
					{
					assert(false, "PACKET ERROR in compression identifier!");
					}
				
				if(data[1] == 'C') //compressed file
					{
					payload = cast(string)uncompress(payload); 
					}

				writefln("filename [[%s]]", filename);
				if(payload.length < 2000)writefln("payload [[%s]] of len=%d", payload, payload.length);
				
				string output_filename = format("%s.out", filename);
				writefln("WRITING FILE [%s]", output_filename);
				std.file.write(output_filename, payload);	
				}
				
			if(data[0] == 'T')
				{
				}
				
				
			if(data[0] == 'X') return 1; // exit/close connection
		
			return 0;
			}
		
		string zbuffer = ""; // everything we have so far
		bool done = false;		
		socket.blocking(true);
		
		uint current_packet_seek_length = 1253152;

		do{
			if(zbuffer.length < 2000)writefln("waiting for packet. Buffer (len=%d) is [%s] ", zbuffer.length, zbuffer);
			auto buffer_length = socket.receive(buffer); // wait for the server to say hello
			writeln("got : ", buffer_length);
			
			zbuffer ~= buffer[0 .. buffer_length];
				
			if(zbuffer.length < 2000)
				{
				writefln("buffer: <<%s>> ", buffer[0 .. buffer_length]);
				writefln("zbuffer: <<%s>> ", zbuffer);
				}
	//	payload = format("FN%r%r%r%r", cast(ubyte)filename.length, filename, x.length, x[0 .. $]);
	//				      012 
	/+
						    x 1
						     filename[x]
							  y 1234
							    data[y]
	+/

			chop:
			if(zbuffer.length < 7) continue; //not enough data to form a packet header!

			if(zbuffer[0] != 'F' && zbuffer[0] != 'X' && zbuffer[0] != 'T')
				{
				writefln("malformed packet. We got [%s] for packet header.", zbuffer[0]);
				}
			
			if(zbuffer[0] == 'T')
				{
				// 01234567890
				// TC01234texttogo
				// TC0		-- header (T, the rest doesn't matter. flen = 0)
				//	  1234	-- payload length=text length
				
				uint payload_length = 
					zbuffer[3] + 
					zbuffer[3+1]*256 + 
					zbuffer[3+2]*256*256 + 
					zbuffer[3+3]*256*256*256;
					
				writefln("TEXT RECEIVED len=%d", payload_length);
				string payload = zbuffer[3+8 .. 3+8 + payload_length]; 
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
					zbuffer[3 + 1]*256 + 
					zbuffer[3 + 2]*256*256 + 
					zbuffer[3 + 3]*256*256*256; 
				}
				
			if(zbuffer[0] == 'T')
				{
				current_packet_seek_length = 3 + 4 + 4 + zbuffer[3 ] +
					zbuffer[3 + 1]*256 + 
					zbuffer[3 + 2]*256*256 + 
					zbuffer[3 + 3]*256*256*256; 
				}
				
			writefln("buffer length: <<%d>> ", buffer_length);
			writefln("current_packet_seek_length: <<%d>> ", current_packet_seek_length);
			  
			if(zbuffer.length > current_packet_seek_length)
				{
				string pbuffer = zbuffer[0 .. current_packet_seek_length]; //single packet of data;
				zbuffer = zbuffer[current_packet_seek_length .. $]; // shrink zbuffer
				writeln("---------------------------------------------------");
				if(pbuffer.length < 2000)writefln("dealing with packet of [%s]", pbuffer);
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

		writeln("COMPRESSION");
		writeln("------------------------------------------------" );
		
		writeln(norm.length);
		auto enc = std.zlib.compress(norm, 9);
		writeln (enc.length);
		writeln ("Compression ratio: ", to!float(enc.length) / to!float(norm.length));
		
		//TODO FIXME: only run compression when we're using it!
		
		
		writeln();
		writeln( "ENCRYPTION");
		writeln( "------------------------------------------------" );
			
		string key = "12341234123412341234123412341234"; //must be at least 16 bytes
		ubyte[] iv = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; //initialization vector
		ubyte[] message = cast(ubyte[])norm;
		
		ubyte[] aes_buffer = AESUtils.encrypt!AES128(message, key, iv, PaddingMode.PKCS7);
		//ubyte[] decoded_buffer = AESUtils.decrypt!AES128(aes_buffer, key, iv, PaddingMode.PKCS7);
		
		writeln("original: ", norm.length);
//		writeln("aes: ", aes_buffer.length);
//		writeln("original: ", decoded_buffer.length);
		writeln("NOTE if length of AES is a few larger, it has to work on blocks of 16 bytes so I'm guessing it pads the source before encryption.");
				
		writeln("AES");
//		writeln("aes:", aes_buffer);
		writeln();
//		writeln("decoded:", decoded_buffer);
		writeln("vs");
//		writeln("x:      ", x);
		
	string payload;
	
	writeln("SENDING DATA");
	writeln("----------------------------------------------");
			writeln("length was: ", norm.length);
//			writeln(typeid(x.length));
//			writeln(x.length.sizeof);
//			writeln(format("%b", x.length));

			if(g.using_compression == false)
				payload = format("FN%r%r%r%r", cast(ubyte)filename.length, norm.length, filename, norm[0 .. $]);
			else
				payload = format("FC%r%r%r%r", cast(ubyte)filename.length, enc.length, filename, enc[0 .. $]);
								
			for(int i = 0; i < payload.length; i += g.SEND_SIZE)
				{
				if(i+g.SEND_SIZE < payload.length)
					{
					writefln("sending from %d to %d", i , i+g.SEND_SIZE); 
					mySocket.send(payload[i .. i+g.SEND_SIZE]);
					}else{
					writefln("sending from %d to %d", i , payload.length); 
					mySocket.send(payload[i .. payload.length]);
					}
				}
			// do we need to chop up packets here? can't we just dump the whole thing into the channel / stream?

		} catch(Exception e) { //why doesn't this catch with a FileException like the online guide? //https://tour.dlang.org/tour/en/basics/exceptions
		writeln("Exception: ", e);
		}
	}

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
	}

globalstate g;

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
			"x", "disable encryption", &disable_encryption,
			"y", "disable compression", &disable_compression,
			"f", "destination folder path (default: .)", &g.path);			
	}catch(GetOptException e){
		writefln("Exception: %s", e.msg);
		return -1;
	}
	
	//because getopts will only add true (to default true), not set true to false.
	if(disable_encryption)
		{
		writeln("Disabling encryption");
		g.using_encryption = false; 
		}
		
	if(disable_compression)
		{
		writeln("Disabling compression");
		g.using_compression = false; 
		}
	
	if(g.client_string != "")
		{
		g.is_client = true;
		g.ip_string = g.client_string;
		}
	
	if(g.client_string == "localhost")
		{
		g.ip_string = "127.0.0.1";
		}
	
	if(g.is_server && g.is_client)
		{
		writeln("Bad llama."); 
		defaultGetoptPrinter("Usage\ndfile [opts] file1 [file2 .. etc]", helpInformation.options);
		return -1;
		}
	if(!g.is_server && !g.is_client)
		{
		defaultGetoptPrinter(usageInfo, helpInformation.options);
		return -1;
		}

	if(g.is_client)client(g.ip_string, g.port);
	if(g.is_server)
		{
		if(args.length > 1)
			{
			server(args[1 .. $], g.ip_string, g.port); //getopt removes args that are recognized and leaves the rest
			}
		else
			{
			writeln("ERROR: You need to specify file(s)!");
			defaultGetoptPrinter(usageInfo, helpInformation.options);
			return 0;
			}
		}
		
	if (helpInformation.helpWanted)
		{
		defaultGetoptPrinter(usageInfo, helpInformation.options);
		return 0;
		}

	return 0; 
	}
