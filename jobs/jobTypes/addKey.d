module jobs.jobTypes.addKey;

import jobs.Job;

class addKey : Job
{

	string keyName;
	string type;

	this(string keyName, string type)
	{
		super("addKey");
		this.keyName = keyName;
		this.type = type;
	}
}
