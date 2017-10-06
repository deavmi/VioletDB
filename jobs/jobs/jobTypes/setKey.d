module jobs.jobTypes.setKey;

import jobs.Job;
import jobs.jobTypes.KeyValues.KeyValue;

class setKey : Job
{
	string keyName;
	KeyValue keyValue;

	this(string keyName, KeyValue keyValue)
	{
		super("setKey");
		this.keyName = keyName;
		this.keyValue = keyValue;
	}
}
