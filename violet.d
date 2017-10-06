import std.stdio : writeln, write, readln;
import database.database : Database;
import misc.stringTools : chomp;
import network.server : startServer;
import std.file : exists;
import misc.out2 : prettyStr;

string versionStr = "0.0.1 (Working Hard)";

string serviceName = "Violet";

void main()
{

	//Display welcome message
	welcome();

	write("Before we can start, enter the database file to use: ");
	string filename = chomp(readln());

	if (exists(filename))
	{
		ushort port = 25515; //use std.conv to ask user for this
		Database db = new Database(filename);
		db.addKey("nasme","string"); //testing code
		writeln("[" ~ serviceName ~ "] Starting server component...");
		startServer(db, port, "0.0.0.0");
	}
	else
	{
		writeln("["~serviceName~"] File '" ~ filename ~ "' not found.");
	}

}

void welcome()
{
	writeln(prettyStr(serviceName,"Welcome to VioletDB v"~versionStr~"!"));
}
