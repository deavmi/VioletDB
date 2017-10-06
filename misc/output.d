module misc.output;

import std.stdio : write;

alias print = prettyPrint;
alias println = prettyPrintLn;

string createPrettyString(string service, string message, bool linefeed)
{
	ubyte[] lf = [10];
	if (linefeed)
	{
		return "[" ~ service ~ "] " ~ message ~ cast(string)lf;
	}
	else
	{
		return "[" ~ service ~ "] " ~ message;
	}
}

void prettyPrint(string service, string message)
{
	write(createPrettyString(service,message, false));
}

void prettyPrintLn(string service, string message)
{
	write(createPrettyString(service, message, true));
}
