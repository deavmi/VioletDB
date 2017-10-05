import std.stdio;
import database;
import 
utilities.stringTools;
import server;
import std.File;

void main()
{

	write("Before we can start, enter the database file to use:");
	string filename = chomp(readln());
	//ushort port = getPort(chomp(readln())); //oh hell I don't know how to use std.conv (we're in for a ride) (grabs ascii table, or not)
	//too hard for now. Will do later
	//writeln(filename.length);
	if (exists(filename))
	{
		ushort port = 25515;
		//testing code
		Database db = new Database(filename);
		db.addKey("nasme","string");
		writeln("ey");
		startServer(db, port);
	}
	else
	{
		writeln("File '", filename, "' not found.");
	}


	//How does one concatenate in Dlang? I'm going to havr to write something for that (not that I need it)

	

}
