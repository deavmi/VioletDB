module network.Connection;

import core.thread: Thread;
import std.socket : Socket;
import std.stdio : writeln;
import jobs.JobManager : JobManager;
import misc.output;

string serviceName = "Connection";

class Connection : Thread
{

        Socket client;
	JobManager jobMan;

        this(Socket client, JobManager jobMan)
        {
                //this.client = client;
                super(&doWork);
                this.client = client;
		this.jobMan = jobMan;
        }

        void doWork()
        {
		println(serviceName, "Client thread running...");
                while(true)
                {
                        //just hang here for now
                }
        }

}

