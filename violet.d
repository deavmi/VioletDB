import std.stdio : writeln, write, readln;
import database.database : Database;
import misc.stringTools : chomp;
import network.server : startServer;
import std.file : exists;
import misc.output;

string versionStr = "0.0.1 (Working Hard)";	

string serviceName = "Violet";

void main()
{
	welcome();

	write("Before we can start, enter the database file to use: ");
	string filename = chomp(readln());
	//ushort port = getPort(chomp(readln())); //oh hell I don't know how to use std.conv (we're in for a ride) (grabs ascii table, or not)
	if (exists(filename))
	{
		ushort port = 25515;
		//testing code
		Database db = new Database(filename);
		db.addKey("nasme","string");
		println(serviceName, "Starting server component...");
		startServer(db, port, "0.0.0.0");
	}
	else
	{
		println(serviceName,"File '" ~ filename ~ "' not found.");
	}

}

void welcome()
{
	println(serviceName,"Welcome to VioletDB v"~versionStr~"!");
}
