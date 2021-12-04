/+
	D equivalent of
	File Transfer 1.2j


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

import std.stdio;
import std.socket;
import std.file; 

import std.zlib;
import std.conv;

struct ip4
	{
	ubyte x;
	ubyte y;
	ubyte z;
	ubyte w;
	}

void reciever(ushort port)
	{
	}

void sender(ip4 addr, ushort port) 
	{
	}

void readFile(string path)
	{
	}

int main(string[] args)
	{
	
	if(args.length == 1){writeln("no file specified and piping doesn't work yet."); return -1;}
	if(args.length == 2)writeln(args[1]);
	
	try{
		auto x = read(args[1]);
		writeln( x.length / 1024, "K");
		auto y = std.zlib.compress( x, 9 );
		writeln ( y.length / 1024, "K");
		
		writeln ( "ratio: ", to!float(y.length)/ to!float(x.length));
		/*
		
		auto fd = File(args[1], "r"); //this will fire off exception if it can't find file.
		
		while(!fd.eof())
			{
			string s = fd.readln();
			writeln("[", s, "]");
			}
			
		fd.close();
		*/
//		string data = read(args[1]);
	
//		foreach(string s; data)
			{
	//		writeln(data);
			}
	
	} catch(Exception e){ //why doesn't this catch with a FileException like the online guide? //https://tour.dlang.org/tour/en/basics/exceptions
		writeln("Exception: ", e);
	}
	
	
	return 0;
	}
