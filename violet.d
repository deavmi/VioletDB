import std.stdio;
import database;

import cruft_dont_touch_just_leave_it_alone_to_do;

void main()
{

	write("Before we can start, enter the database file to use:");
	string filename = chomp(readln());
	writeln(filename.length);
	//testing code
	Database db = new Database(filename);
	db.addKey("nasme","string");

}
