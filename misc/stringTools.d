module misc.stringTools;

//fuck that module name is annoying

string chomp(string str) //if only I knew where this was in std package
{
	ubyte[] strBs = cast(ubyte[])str;
	strBs.length--;
	return cast(string)strBs;	
}
