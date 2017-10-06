module network.server;

import std.socket;
import database.database : Database;
import std.stdio : writeln, write;
import network.Connection : Connection;
import jobs.JobManager : JobManager;
import jobs.Executor : Executor;
import misc.out2 : prettyStr;

alias ps = prettyStr;

string serviceName = "Server";

Connection[] connections;
JobManager jobMan;
Executor exec;

void createExecutor(JobManager jobMan)
{
	writeln(ps(serviceName,"Creating executor..."));
	exec = new Executor(jobMan);
	writeln(ps(serviceName,"Starting Executor thread..."));
	exec.start();
	writeln(ps(serviceName,"Executor thread started."));
}

void createJobManager(Database db)
{
	writeln(ps(serviceName,"Creating JobManager..."));
	jobMan = new JobManager(db);
	writeln(ps(serviceName,"JobManager created."));
}

void startServer(Database db, ushort port, string addr)
{
	//I need std.conv for the below thing
	//println(serviceName,"Starting server on port ", port, " with database '", db.filename , "'...");
	writeln(ps(serviceName, "Starting server..."));

	createJobManager(db);
	createExecutor(jobMan);

	AddressInfo addrInfo = AddressInfo();
	addrInfo.family = AddressFamily.INET;
	addrInfo.protocol = ProtocolType.TCP; //try out RAW
	addrInfo.type = SocketType.STREAM;
	Socket servSock = new Socket(addrInfo);
	servSock.bind(parseAddress(addr, port));
	servSock.listen(1); //what is the backlog? How many connectiosn can be qeued?

	writeln(ps(serviceName,"Waiting for connections..."));
	while (true)
	{
		Socket clientSock = servSock.accept();
		writeln(ps(serviceName,"New connection: "~clientSock.toString));
		Connection conn = new Connection(clientSock, jobMan);
		connections[connections.length++] = conn;
		conn.start();
		writeln(ps(serviceName,"Connection object spawned"));
	}

}
