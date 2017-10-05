module server;

import std.socket;
import core.Thread;
import database;
import std.stdio;

void startServer(Database db, ushort port)
{
	writeln("Starting server on port ", port, " with database '", db.filename , "'...");
}
