import std.datetime;
import std.datetime.stopwatch : benchmark, StopWatch; //this is separate and important (see docs)
import crypto.aes;
import crypto.padding;
import std.stdio, std.format, std.string;
import std.socket;
import std.file; 
import std.conv;
import std.bitmanip;
import std.zlib;

//#include <sys/sendfile.h>
extern(C)  ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count);
extern(C)  int sched_yield(); // include <sched.h>

void server(string file_to_parse) 
	{
	auto listener = new Socket(AddressFamily.INET, SocketType.STREAM);
	listener.bind(new InternetAddress(ip_string, port));
	listener.listen(10);
	auto readSet = new SocketSet();
	Socket[] connectedClients;
	char[1024] buffer;
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
				import core.thread;
				Thread.sleep( dur!("msecs")(3) );  // don't use all my CPU waiting!!!
				}
				
			if(readSet.isSet(listener)) 
				{
				// the listener is ready to read, that means
				// a new client wants to connect. We accept it here.
				auto newSocket = listener.accept();    
				writeln("CONNECTION STARTED");
				readFile(file_to_parse, newSocket);     
				// newSocket.send("Hello!\n"); // say hello
				connectedClients ~= newSocket; // add to our list
				writeln("CONNECTION SENT/FINISHED.");
				}
			}
       
		// If we're done doing any messages, let's yield back to the CPU so we don't 100% the core
//		sched_yield(); //one, other, or both?
		import core.thread;
		Thread.sleep( dur!("msecs")(0) ); 
		}
	}

void client() 
	{


	StopWatch sw;
	StopWatch sw2;
	StopWatch sw3;
	
	sw.start();
	
	int number_of_packets = 0;
    char[1024] buffer;
    
    auto socket = new Socket(AddressFamily.INET,  SocketType.STREAM);
    socket.connect(new InternetAddress(ip_string, port));   
    auto received = socket.receive(buffer); // wait for the server to say hello

	if(received == -1){writeln("no packet! bailing out."); return;} //this shouldn't fire off when using blocking
  //  writeln("Server said: [", buffer[0 .. received],"]");
	writeln("recieved length was: ", received);

	socket.blocking(false); //after first packet keep going to we run out.

	ubyte filename_length = 0;
	char[] filename;
	ulong filesize;
	bool is_normal_file = true;

	if(buffer[0] != 'F') //file packet
		{
		writeln("PACKET ERROR");
		return;
		}else{
		if(buffer[1] == 'N'){is_normal_file = true;  writeln("starting a NORMAL file transfer!");}
		if(buffer[1] == 'C'){is_normal_file = false; writeln("starting a COMPRESSED file transfer!");}
		if(! (buffer[1] == 'N' || buffer[1] == 'C') ){writeln("PACKET ERROR 2"); return;}
		writeln("is_normal_file: ", is_normal_file);
		
		number_of_packets++;
		//ubyte[] size_str = cast(ubyte[])(buffer[1..9].idup); //why idup required: https://forum.dlang.org/thread/bgkklxwbhrqdhvethnco@forum.dlang.org
		//ulong size = size_str.read!ulong; 
		filename_length = buffer[1+1];
		writeln("FILENAME length: ", filename_length);
		filename = buffer[2+1 .. filename_length + 2 + 1];
		writefln("FILENAME [%s]", filename);
	
		filesize = 
			buffer[2+1+filename_length] + 
			buffer[3+1+filename_length]*256^^1 + 
			buffer[4+1+filename_length]*256^^2 + 
			buffer[5+1+filename_length]*256^^3; 
		
		writefln("FILE PACKET RECIEVED of size: %d %d %d %d", buffer[1+1], buffer[2+1], buffer[3+1], buffer[4+1]);
		writefln("filesize: %d", filesize);	
		}
	
	writeln("END OF PACKET ---------------------------------------------------");
		
	string total_buffer;
	import std.conv;
	char[] abuffer; //accumulation buffer
	bool single_packet = true;
	
	// SECOND PACKET AND FOLLOWING
	// --------------------------------------------------------------------------
	do{
		char[1024] buffer2;
		auto len2 = socket.receive(buffer2);

		if(len2 != -1)
			{
	// DEBUG
	//		writeln("Server said: [", buffer2[0 .. len2],"]");
			writeln("recieved length was: ", len2);
			if(len2 == 0)break;	
			number_of_packets++;
			abuffer ~= cast(char[])(buffer2[0 .. len2]); 
			
			if(buffer.length + abuffer.length >= 1 + 1 + 8 + 1 + filename_length + filesize)
				{
				writeln("hanging up!");
				break;
				}else{
				writefln("BUFFER LENGTH %d of %d", buffer.length + abuffer.length
					,  1 + 1 + 8 + 1 + filename_length + filesize);
				}
			
			single_packet = false;
			writeln("END OF PACKET ---------------");
			}else{
//			writeln("we're done here!");
	//		break;
			}

	}while(true);

	import std.format;
	
	if(!single_packet)
		{
		total_buffer = to!string(buffer[ 1 + 1 + 8 + 1 + filename_length  ..  1024]) ~ to!string(abuffer);
		}else{
		total_buffer = to!string(buffer[ 1 + 1 + 8 + 1 + filename_length  ..
										 1 + 1 + 8 + 1 + filename_length + filesize]); 
		}
		
	socket.close();
	sw.stop(); //let's not count STDOUT time.

	string output;
	if(!is_normal_file)
		{
	sw3.start();
		output = cast(string)uncompress(total_buffer);
	sw3.stop();
		}else{
		output = total_buffer;
		}

	writeln("TOTAL PACKET");
	writeln("==========================================================================");
//DEBUG
	//writeln(output);
	writeln("==========================================================================");
	writeln("Packet count: ", number_of_packets);
	writeln("Payload: ", output.length);
	writeln("Payload with HEADER: ", 1 + 1 + 8 + 1 + filename_length + output.length);

	sw2.start();
		string output_filename = format("%s.out", filename);
		writefln("WRITING FILE %s", output_filename);
		std.file.write(output_filename, output);	
	sw2.stop();
	
	writefln("Net time [%d] ms", sw.peek.total!"msecs");
	writefln("File write time [%d] ms", sw2.peek.total!"msecs");
	
	if(!is_normal_file)
		{
		writefln("Decompression time [%d] ms", sw3.peek.total!"msecs");
		writeln();


		writefln("compressed (sent) size: %d", total_buffer.length);		
		writefln("extracted         size: %d",  output.length);
		if(total_buffer.length != 0)writefln("ratio: %d",  output.length / total_buffer.length);		
		writefln("saved: %d bytes",  output.length - total_buffer.length);		
		}
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
		auto x = read(filename);

		writeln("COMPRESSION");
		writeln("------------------------------------------------" );
		
		writeln(x.length);
		auto y = std.zlib.compress(x, 9);
		writeln (y.length);
		writeln ("Compression ratio: ", to!float(y.length) / to!float(x.length));
		
		//TODO FIXME: only run compression when we're using it!
		
		/*
		writeln();
		writeln( "ENCRYPTION");
		writeln( "------------------------------------------------" );
			
		string key = "12341234123412341234123412341234"; //must be at least 16 bytes
		ubyte[] iv = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; //initialization vector
		ubyte[] message = cast(ubyte[])x;
		
		ubyte[] aes_buffer = AESUtils.encrypt!AES128(message, key, iv, PaddingMode.PKCS7);
		ubyte[] decoded_buffer = AESUtils.decrypt!AES128(aes_buffer, key, iv, PaddingMode.PKCS7);
		
		writeln("original: ", x.length);
		writeln("aes: ", aes_buffer.length);
		writeln("original: ", decoded_buffer.length);
		writeln("NOTE if length of AES is a few larger, it has to work on blocks of 16 bytes so I'm guessing it pads the source before encryption.");
				
		writeln("AES");
//		writeln("aes:", aes_buffer);
		writeln();
//		writeln("decoded:", decoded_buffer);
		writeln("vs");
//		writeln("x:      ", x);
		*/
	string payload;
	
	writeln("SENDING DATA");
	writeln("----------------------------------------------");
			writeln("length was: ", x.length);
			writeln(typeid(x.length));
			writeln(x.length.sizeof);
			writeln(format("%b", x.length));

			if(using_compressed == false)
				payload = format("FN%r%r%r%r", cast(ubyte)filename.length, filename, x.length, x[0 .. $]);
			else
				payload = format("FC%r%r%r%r", cast(ubyte)filename.length, filename, y.length, y[0 .. $]);
				// note we're using y and y.length, not x here
					
			for(int i = 0; i < payload.length; i += 1024)
				{
				if(i+1024 < payload.length)
					{
					writefln("sending from %d to %d", i , i+1024); 
					mySocket.send(payload[i .. i+1024]);
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

bool is_server = false;
bool is_client = false;
string client_string = "";
string ip_string = "127.0.0.1";
ushort port = 8001;
bool using_compressed = true;
string path = ".";
import std.getopt;

int main(string[] args)
	{
	//https://dlang.org/phobos/std_getopt.html#.GetoptResult
	GetoptResult helpInformation;
	try{
	helpInformation = getopt(args,
		std.getopt.config.bundling, // allow combined arguments -cpzspfnapsfon
		"s", "run as server", &is_server,
		"c", "run as client (specify IP to connect to, e.g. -c=192.168.1.1) ", &client_string,
		"p", "specify port (default: 8000)", &port,
		"z", "use compression (default: yes)", &using_compressed,
		"f", "destination folder path (default: .)", &path);
		
}catch(GetOptException e)
{
	writefln("Exception [%s]", e);
}
	
	if(client_string != "")
		{
		is_client = true;
		ip_string = client_string;
		}
	
	if(client_string == "localhost")
		{
		ip_string = "127.0.0.1";
		}
	
	if(is_server && is_client){writeln("fuck you.");}
		
	if(is_client)
		{
		client();
		}

	if(is_server)
		{
		server(args[1]); //getopt REMOVES ARGS that are recognized and leaves the rest!
		}
		
	if (helpInformation.helpWanted)
		{
		defaultGetoptPrinter("Some information about the program.", helpInformation.options);
		return 0;
		}

	return 0; 
	}
