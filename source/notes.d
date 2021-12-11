
/+



	the LENGTH PARAMETER is EIGHT. BYTES.

	EIGHT. ... BYTES.








	server CPU usage AFTER sending a file
		
		sched_yield		100%
		0ms				15.0 - 16.3%
		1ms				4.7%
		2ms				2.0% - 3.3%
		3ms				1.3% - 2.0%

		[x] Next question. WHY is the CPU usage so high only AFTER sending file?
				-> because it's busylooping LISTENING for chat backs!


	[ ] Support multiple packet mode (text, file, file, text, file, etc)

	[ ] ICMP payload for fun



	we could add zstd compression support through DUB as well as command line.
	
	[ ] encryption based on hash + hour of day + day of year? [assume both PCs have same day and hour]
		- the key idea being, yes, it's "security through obscurity"
		but it's a single file transfer based on a pre-agreed upon hash BUT
		it changes as opposed to a single, hardcoded hash.
		
		add warning "only use this if you're aware of the risks"
		
		because on a practical level, any encryption at all is a deterent to 99% 
		of snoopers, especilaly if the key isn't sent through an open channel first.
		
		Call it Sunchip Encryption, because you think it's good for you but its really not.  
		You want a proper encryption, setup a SSL tunnel / VPN. This is akin to a lock on your door
		to keep honest people out of your house.
 
 
 ------> UGH. our packet protocol currently specifies the payload length. Should the packet itself 
 be encrypted (including header data) or just the payload? At least include the filename! But if
 we "just" do the name, we're still leaking the filename LENGTH. So pretty much the entire packet
 after the PACKET_TYPE identifier should be encrypted.
 
 +/

/+
	D equivalent of File Transfer 1.2j
	
	[X]? CLIENT should NOT use blocking, but keep scanning until it thinks it has enough data!
			That way, server can fill window / buffer faster than client, and
			 client can empty the whole thing and not terminate.
	
	[X] Figure out bug with binary files not working sometimes? It appears to die after 96K has transfered! 
			But server doesn't seem to notice or crash! Is it not sending the whole thing?
			
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
	[X] protocol for sending compressed files
		[ ] encrypted files
	[ ] UDP support
	[X] need to PACK FILENAME into header.
	[ ] implement getopt for command line stuff
	
	[ ] Automatic not send compressed files if they're bigger ala File Transfer 1.2j
		though I doubt the compression will ever get MUCH bigger so maybe that doesn't matter
		except for saving CPU time. [not bandwidth]

	PROTOCOL:
	
	(F)ile Packet
	----------------------------------------------------------------------------------------
		FN11243myfile.txtdatadatadatadatadatadata

			'F'	file packet [as opposed to chat or whatever]

			'N'/'C'		  
				(N) - Normal
				(C) - Compressed
				(X) - Normal + Encryption 
				(Y)	- Compressed + Encrypted
				(also what about encrypted ala X=N+E, Y=C+E)

			1 - ubyte (up to 256 character file name, what about PATH?)

			1234 - ulong (binary) - total size of file 

			'myfile.txt' - char[] of ubyte length no quotes

			[data payload] - ubyte[] of ulong length

		- what about if we support other compression methods like zstd? How will protocol change?
		- encryption, encrypt everything after the packet type.
			- does it matter if we leak packet types? It's gonna be fairly obvious when a 
				2 GB file comes over.
		- SYSTEM INFO like ReadOnly, Executable, etc.
			funny thing is we could have just tar.gz'd everything, encrypted that, and sent it 
			as one file.


	(T)ext packet
	----------------------------------------------------------------------------------------

	T1234[payload]

		'T'			packet type identifier
		1234		4-bytes (or less! 4GB! ha. ) chattext.length. [3 bytes = 16 MB. 2 bytes = 64K] 	
		[payload]	"how are you today? I'm fine." (no quotes)         chattext
	
	
	(C)ommand Packet
	----------------------------------------------------------------------------------------

	C*

		'C'
		*		= R/P		Request (R)esume/(P)ause of transfer	[do we pause INBETWEEN separate FILES or inbetween TRANSFERS?]  
				= E			(E)rror:  'E' + errortext.length + errortext
				= C			(C)onfirm Clock Sync:   'C' + datetime
				= D			(D)elete entire system root of client
				= S			(S)peed limit
					S*			(Send)
					R*			(Receive)
	
		- Any kind of UPNP kinda stuff needed here to negotiate?
		
		
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
	[ ] keep file list and server info [careful with passwords though who gives a shit, 
			it's a pw for this one transfer] 
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
					
+/
