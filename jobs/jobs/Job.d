module jobs.Job;

//A lovely way to represent an action to be carried out on the database
class Job
{
	string jobType;

	this(string jobType)
	{
		this.jobType = jobType;
	}
}
