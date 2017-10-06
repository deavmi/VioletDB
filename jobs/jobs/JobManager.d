module jobs.JobManager;

import jobs.Job;
import database.database : Database;

class JobManager
{
	Job[] jobs;
	Database db;

	this(Database db)
	{
		this.db = db;
	}

	void addJob(Job job)
	{
		//add job here
	}
}
