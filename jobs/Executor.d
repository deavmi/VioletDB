module jobs.Executor;

import jobs.JobManager :JobManager;
import core.thread : Thread;
import std.stdio : writeln;
import misc.out2 : prettyStr;

alias ps = prettyStr;

string serviceName = "Executor";

class Executor : Thread
{
	JobManager jobMan;

	//he can now access the Job[] jobs array
	//and manipulate it

	this(JobManager jobMan)
	{
		super(&doWork);
		this.jobMan = jobMan;
	}

	void doWork()
	{
		//do work here
		writeln(ps(serviceName,"Executor running..."));
		while (true)
		{
			//chill (not implemented yet)
		}
	}
	
}
