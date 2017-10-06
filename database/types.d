module database.types;

uint getSpaceForType(string type)
{
	uint typeSize = 0;
	if (type == "string")
	{
		typeSize = 1; //so far just the null-terminator
	}
	else if (type == "byte" || type == "ubyte")
	{
		typeSize = 1;
	}
	else if (type == "short" || type == "ushort")
	{
		typeSize = 2;
	}
	else if (type == "int" || type == "uint")
	{
		typeSize = 4;
	}
	else if (type == "ulong" || type == "long")
	{
		typeSize = 8;
	}
	else
	{
		//effing compiler
		typeSize = 0;
	}
	return typeSize;
}

ubyte getTypeID(string type)
{
	ubyte typeID = 0;
	if (type == "string")
	{
		typeID = 1;
	}
	else if (type == "byte")
	{
		typeID = 2;
	}
	else
	{
		//effing compiler
		typeID = 0;
	}
	return typeID;
}
