module network.server;

import std.socket;
import database.database : Database;
import std.stdio;
import network.Connection;
import jobs.JobManager;

Connection[] connections;
JobManager jobMan;

void createJobManager(Database db)
{
	jobMan = new JobManager(db);
}

void startServer(Database db, ushort port, string addr)
{
	writeln("Starting server on port ", port, " with database '", db.filename , "'...");

	writeln("Creating JobManager...");
	createJobManager(db);
	writeln("JobManager created.");

	AddressInfo addrInfo = AddressInfo();
	addrInfo.family = AddressFamily.INET;
	addrInfo.protocol = ProtocolType.TCP; //try out RAW
	addrInfo.type = SocketType.STREAM;
	Socket servSock = new Socket(addrInfo);
	servSock.bind(parseAddress(addr, port));
	servSock.listen(1); //what is the backlog? How many connectiosn can be qeued?
	writeln("Waiting for connections...");
	while (true)
	{
		Socket clientSock = servSock.accept();
		writeln("New connection: ", clientSock);
		Connection conn = new Connection(clientSock, jobMan);
		connections[connections.length++] = conn;
		conn.start();
		writeln("Connection object spawned");
	}

}
