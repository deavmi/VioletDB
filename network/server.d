module network.server;

import std.socket;
import database.database : Database;
import std.stdio : writeln, write;
import network.Connection : Connection;
import jobs.JobManager : JobManager;
import jobs.Executor : Executor;
import misc.output : createPrettyString;

string serviceName = "Server";

Connection[] connections;
JobManager jobMan;
Executor exec;

void createExecutor(JobManager jobMan)
{
	write(createPrettyString(serviceName,"Creating executor...",true));
	exec = new Executor(jobMan);
	write(createPrettyString(serviceName,"Starting Executor thread...",true));
	exec.start();
	write(createPrettyString(serviceName,"Executor thread started.",true));
}

void createJobManager(Database db)
{
	write(createPrettyString(serviceName,"Creating JobManager...",true));
	jobMan = new JobManager(db);
	write(createPrettyString(serviceName,"JobManager created.",true));
}

void startServer(Database db, ushort port, string addr)
{
	//I need std.conv for the below thing
	//println(serviceName,"Starting server on port ", port, " with database '", db.filename , "'...");
	write(createPrettyString(serviceName, "Starting server...",true));
	createJobManager(db);
	createExecutor(jobMan);
	AddressInfo addrInfo = AddressInfo();
	addrInfo.family = AddressFamily.INET;
	addrInfo.protocol = ProtocolType.TCP; //try out RAW
	addrInfo.type = SocketType.STREAM;
	Socket servSock = new Socket(addrInfo);
	servSock.bind(parseAddress(addr, port));
	servSock.listen(1); //what is the backlog? How many connectiosn can be qeued?
	write(createPrettyString(serviceName,"Waiting for connections...",true));
	while (true)
	{
		Socket clientSock = servSock.accept();
		write(createPrettyString(serviceName,"New connection: "~clientSock.toString,true));
		Connection conn = new Connection(clientSock, jobMan);
		connections[connections.length++] = conn;
		conn.start();
		write(createPrettyString(serviceName,"Connection object spawned",true));
	}

}
