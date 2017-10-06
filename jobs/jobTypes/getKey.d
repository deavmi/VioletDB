module jobs.jobTypes.getKey;

import jobs.Job;

class getKey : Job
{
	string keyName;

	this(string keyName)
	{
		super("getKey");
		this.keyName = keyName;
	}
}
