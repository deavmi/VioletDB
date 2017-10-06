module network.server;

import std.socket;
import database.database : Database;
import std.stdio : writeln;
import network.Connection : Connection;
import jobs.JobManager : JobManager;
import jobs.Executor : Executor;

Connection[] connections;
JobManager jobMan;
Executor exec;

void createExecutor(JobManager jobMan)
{
	writeln("Creating executor...");
	exec = new Executor(jobMan);
	writeln("Starting Executor thread...");
	exec.start();
	writeln("Executor thread started.");
}

void createJobManager(Database db)
{
	writeln("Creating JobManager...");
	jobMan = new JobManager(db);
	writeln("JobManager created.");
}

void startServer(Database db, ushort port, string addr)
{
	writeln("Starting server on port ", port, " with database '", db.filename , "'...");

	createJobManager(db);
	createExecutor(jobMan);

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
