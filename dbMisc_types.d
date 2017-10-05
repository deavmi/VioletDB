module dbMisc_types;

uint getSpaceForType(string type)
{
	if (type == "string")
	{
		return 1; //so far just the null-terminator
	}
	else if (type == "byte")
	{
		return 1;
	}
	else
	{
		//effing compiler
		return 0;
	}
}

ubyte getTypeID(string type)
{
	if (type == "string")
	{
		return 1;
	}
	else if (type == "byte")
	{
		return 2;
	}
	else
	{
		//effing compiler
		return 0;
	}
}
