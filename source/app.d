
bool using_compressed = true;
immutable ushort port = 2503;

import std.datetime;
import std.datetime.stopwatch : benchmark, StopWatch; //this is separate and important (see docs)

/+
	D equivalent of File Transfer 1.2j
	
		
	 [ ] CLIENT should NOT use blocking, but keep scanning until it thinks it has enough data!
			That way, server can fill window / buffer faster than client, and
			 client can empty the whole thing and not terminate.
	
	
	 [X] Figure out bug with binary files not working sometimes? It appears to die after 96K has transfered! 
			But server doesn't seem to notice or crash! Is it not sending the whole thing?

			--> AM I HITTING TCP SEGMENT LIMIT?
				
				>>OMFG<< am I sending a SINGLE PACKET and not using a connection stream?
				Did I have it right the first time and remove it?
					TCP is supposed to be STREAM oriented!
					Am I ... using UDP by accident?
						- No! We're using SocketType.STREAM!
						
				Maybe we can SEND TONS but we have to specify "packets" anyway?
				
					https://www.google.com/search?channel=fs&client=ubuntu&q=tcp+socket+send+max+size

					here it says the send window could be 1 GB of bytes!
					
					but the SEND BUFFER SIZE could be 32768???
					
					https://www3.physnet.uni-hamburg.de/physnet/Tru64-Unix/HTML/APS2WDTE/DOCU_003.HTM

		OH SHIT. anything of payload >= 68470 triggers it HOWEVER slightly smaller
		SOMETIMES. TRIGGERS. IT.

			Packet Count: 67
			Payload: 68470
			Payload with HEADER: 68488

			Packet count: 32
			Payload: 32750
			Payload with HEADER: 32768		(snipped at 1/2 of 16-bit boundary 65536?)
		
			almost 50/50% of it happening. 
			with a file exactly 68470 bytes. (add 18 bytes for the HEADER)
			with filename of [helper.d] (the length of the string matters)
			

	 [X] support less than one packet size [1024 byte] files
	 [X] support changing files instead of hardcoded
	 [ ] support multiple files
		-> just support bash enumeration of all args after the command ones. Each one a file.
		ala  
			dfile -s [ports/etc new options] onefile 
			dfile -s [ports/etc new options] onefile twofile threefile fourfile
	 [ ] support directories
	 [ ] specify output directory
	 [ ] preserve EXECUTE/READONLY bit and others
	 [ ] custom port and ip address for remote computers!
	 [ ] protocol for sending compressed files
		[ ] encrypted files


need to PACK FILENAME into header.

F*myfile.txt****datadatadatadatadatadata

'F'
'N'/'C'	- (N)ormal, (C)ompressed			(also what about encrypted ala X=N+E, Y=C+E)
	5 - ubyte (up to 256 character file name, what about PATH?)
	'myfile.txt' - char[] of ubyte length no quotes

	1234 - ulong (binary) - total size of file 
	[data payload] - ubyte[] of ulong length

	- failure modes. 
		- check if destination HDD has space first.
		- HDD runs out of space after initial check during transfer (or hdd gets unplugged).
		- network failure and timeout recovery
		- missing files after adding them on SENDER.

https://github.com/msgpack/msgpack-d


https://stackoverflow.com/questions/25634483/send-binary-file-over-tcp-ip-connection
https://stackoverflow.com/questions/7697538/sending-binary-files-through-tcp-sockets-c?rq=1

"If you're transferring a whole file from a filesystem, you should probably use TransmitFile() (if on Windows), or sendfile() (if on Unix) "

	https://man7.org/linux/man-pages/man2/sendfile.2.html			unix
	msdn.microsoft.com/en-us/library/ms740565(VS.85).aspx			windows
	
	but what about BETWEEN linux and windows and vice-versa. 

packet:
	- packet header "F:", send total data size in bytes [text?], filename [text], relative_path [text], [attributes], then file data.
		relative_path is for subdirectories. . or "" blank for root destination.


	- UDP
	- TCP
	- SDR? Steam Datagram Relay? (small files only?) [silly but possible]
		https://partner.steamgames.com/doc/features/multiplayer/networking
		- Server IP is never revealed to players but must be public. Players all use SteamIDs


		https://docstore.mik.ua/orelly/networking_2ndEd/fire/ch04_03.htm
		https://stackoverflow.com/questions/42546097/transfer-file-over-icmp
			"Technically it is not possible in any case to use ICMP as data transfer protocol,"
			
				https://github.com/seladb/PcapPlusPlus/tree/master/Examples/IcmpFileTransfer lullil

  [ ] recursive send directory
  [ ] chat
  [ ] remember permissions [we could just tar.gz and then send that]
 
 
 we could use a lot of command line stuff to simplify our libraries
	- openssl commandline tool (or a D binding) has lots less liability than a 1 off user's implementation.
	- tar.gz for compression
		https://www.tecmint.com/encrypt-decrypt-files-tar-openssl-linux/
		
		tar -czf - * | openssl enc -e -aes256 -out secured.tar.gz
		
		also gpg
		

 pause/resume on connection lost
	[ ] file resend
	[ ] chunk resume/resend

 
 pause/resume on CRASH
	[ ] keep file list and server info [careful with passwords though who gives a shit, it's a pw for this one transfer] 
		and allow option to resume	
		"job"
	
check out general library dlib:
https://code.dlang.org/packages/dlib

	- Compresion (dlang only supports decompress natively. Use libz or something.)
		https://code.dlang.org/packages/archive
		https://code.dlang.org/search?q=compress
		
			zcompress facebook (realtime?)
				http://facebook.github.io/zstd/#benchmarks
				https://github.com/repeatedly/zstd-d/tree/v0.2.1/examples
				
				https://github.com/inikep/lzbench
				
					INTERESTING. compression to reduce memory bandwidth to cache:
							https://www.blosc.org/pages/blosc-in-depth/
							
				google's one but only command line unless I make my own bindings?
					
					http://manpages.ubuntu.com/manpages/bionic/man1/brotli.1.html
					https://en.wikipedia.org/wiki/Brotli
					designed for text files.
					
	- Encryption

	wait does Dlang finally support COMPRESSION too?

+/

void server(string file_to_parse) 
	{
	import std.socket;
	auto listener = new Socket(AddressFamily.INET, SocketType.STREAM);
	listener.bind(new InternetAddress("localhost", port));
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
			{readSet.add(client);}
		
		if(Socket.select(readSet, null, null)) 
			{
			foreach(client; connectedClients)
				{
				if(readSet.isSet(client)) 
					{
					// read from it and echo it back
					auto got = client.receive(buffer);
					if(got == -1)
						{
						writeln("SOMETHING ODD HAPPENED. buffer -1 length.");
						// is this because we hung up? or is it breaking somehow?
						// is client closing connection after 96 packets?
						break; // this was crashing here with -1 length
						}
					client.send(buffer[0 .. got]);
					}
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
		sched_yield(); //one, other, or both?
		import core.thread;
		Thread.sleep( dur!("msecs")(1) ); 
		}
	}

void client() 
	{
	StopWatch sw;
	StopWatch sw2;
	sw.start();
	
	int number_of_packets = 0;
    import std.socket, std.stdio;
    import std.bitmanip;
    
    auto socket = new Socket(AddressFamily.INET,  SocketType.STREAM);
    
    socket.connect(new InternetAddress("localhost", port));   
        
    char[1024] buffer;
    auto received = socket.receive(buffer); // wait for the server to say hello
	if(received == -1){writeln("no packet! bailing out."); return;} //this shouldn't fire off when using blocking
    writeln("Server said: [", buffer[0 .. received],"]");
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
		if(buffer[1] == 'N'){is_normal_file = true; }
		if(buffer[1] == 'C'){is_normal_file = false;}
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
		// NOTE: Not required to be PACKET SIZE (currently 1024 chunks)
	
		// 1448 bytes max size with default MTU of 1500
		// https://superuser.com/questions/1341012/practical-vs-theoretical-max-limit-of-tcp-packet-size
		// 9000 with common type of jumbo frames
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
			writeln("we're done here!");
			break;
			}

	}while(true);

	import std.format;
	
	// note we start at 2 to remove the file size header.
	// TODO: WHY IS THE START AT 9+1.
	// FN1234 = 5 (or 4 starting from 0)
	// wait, am I using 8 bytes for size? ala 64-bit?
	// oh shit, ulong, 8 bytes. wait, ulong... is 64-bit? OH, IT IS, on 64-bit systems even with C. Didn't realize!
	
	if(!single_packet)
		{
		total_buffer = to!string(buffer[ 1 + 1 + 8 + 1 + filename_length  ..  1024]) ~ to!string(abuffer); //format("%s%s", buffer[2 .. received], buffer2[0 .. len2]);
		}else{
		total_buffer = to!string(buffer[ 1 + 1 + 8 + 1 + filename_length  ..  1 + 1 + 8 + 1 + filename_length + filesize]); 
		}
		
	socket.close();
	sw.stop(); //let's not count STDOUT time.

	string output;
	if(!is_normal_file)
		{
		output = cast(string)uncompress(total_buffer);
		}else{
		output = total_buffer;
		}
	writeln("TOTAL PACKET");
	writeln("==========================================================================");
//DEBUG
	writeln(output);
	writeln("==========================================================================");
	writeln("Packet count: ", number_of_packets);
	writeln("Payload: ", output.length);
	writeln("Payload with HEADER: ", 1 + 1 + 8 + 1 + filename_length + output.length);

	sw2.start();
		import std.file;	
		string output_filename = format("%s.out", filename);
		writefln("WRITING FILE %s", output_filename);
		std.file.write(output_filename, output);	
	sw2.stop();
	
	writefln("Net time [%d] ms", sw.peek.total!"msecs");
	writefln("File write time [%d] ms", sw2.peek.total!"msecs");
	}

import crypto.aes;
import crypto.padding;

import std.stdio;
import std.socket;
import std.file; 

import std.zlib;
import std.conv;

//#include <sys/sendfile.h>
extern(C)  ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count);
extern(C)  int sched_yield(); // include <sched.h>


void readFile(string filename, Socket mySocket)
	{
/*	auto fileDescriptor = 0;	
	auto fileSize = 1024;
	sendfile(mySocket.handle, fileDescriptor, null, fileSize);
		// This can also be split into chunks then by using a different start position and length.
		// i mean, whatever is EASIEST at this point is what needs to be done.
	*/
	
	try{
		writeln( "COMPRESSION");
		writeln( "------------------------------------------------" );
		auto x = read(filename);
		
		writeln( x.length);
		auto y = std.zlib.compress( x, 9 );
		writeln ( y.length);
		writeln ( "ratio: ", to!float(y.length)/ to!float(x.length));
		
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
	import std.format;
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

int main(string[] args)
	{
	
	if(args.length == 1){writeln("no file specified and piping doesn't work yet. \n\nUsage: \n  -c \n  -s FILENAME"); return -1;}
	if(args.length == 2)
		{
		writeln(args[1]);
		if(args[1] == "-c")client(); // -c 
		if(args[1] == "-s")
			{
			writeln("GIVE ME A FILE NAME."); // -s MISSINGFILENAME
			return 2;
			}
		}
	if(args.length == 3) // -s [FILENAME]
		{
		writeln(args[1]);
		writeln(args[2]);

		if(args[1] == "-s")
			{
			server(args[2]);
			}
		}
	
	return 0; 
	}
