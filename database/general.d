module database.general;

import std.stdio : File;

bool isDBEmpty(string filename)
{
	File db = File(filename, "rb");
	uint dbSize = cast(uint)db.size();
	db.close();
	return !cast(bool)dbSize;
}

uint getSize(string filename)
{
	File db = File(filename, "rb");
	uint dbSize = cast(uint)db.size();
	db.close();
	return dbSize;
}
