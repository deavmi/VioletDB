module server;

import std.socket;
import core.Thread;
import database;
import std.stdio;

Connection[] connections;

class Connection : Thread
{

	Socket client;

	this(Socket client)
	{
		//this.client = client;
		super(&doWork);
		this.client = client;
	}

	void doWork()
	{
		while(true)
		{
			writeln("Working working...");
		}
	}

}

void startServer(Database db, ushort port)
{
	writeln("Starting server on port ", port, " with database '", db.filename , "'...");

	AddressInfo addrInfo = AddressInfo();
	addrInfo.family = AddressFamily.INET;
	addrInfo.protocol = ProtocolType.TCP; //try out RAW
	addrInfo.type = SocketType.STREAM;
	Socket servSock = new Socket(addrInfo);
	servSock.bind(parseAddress("0.0.0.0", port));
	servSock.listen(1); //what is the backlog? How many connectiosn can be qeued?
	while (true)
	{
		Socket clientSock = servSock.accept();
		Connection conn = new Connection(clientSock);
		connections[connections.length++] = conn;
		conn.start();
	}

}
