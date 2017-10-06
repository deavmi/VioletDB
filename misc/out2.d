module misc.out2;

import std.datetime.date : DateTime;

string prettyStr(string service, string message)
{
	string time = DateTime().toString();
	return "[" ~ service ~ "] (" ~ time ~ ") " ~ message;
}
