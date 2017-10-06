module misc.out2;

string prettyStr(string service, string message)
{
	return "["~service~"] "~message;
}
