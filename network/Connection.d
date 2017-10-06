module network.Connection;

import core.thread: Thread;
import std.socket : Socket;
import std.stdio : writeln;

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

