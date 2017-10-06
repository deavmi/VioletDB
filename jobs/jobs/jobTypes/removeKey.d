module jobs.jobTypes.removeKey;

import jobs.Job;

class removeKey : Job
{
	string keyName;

	this(string keyNam)
	{
		super("removeKey");
		this.keyName = keyName;
	}
}
