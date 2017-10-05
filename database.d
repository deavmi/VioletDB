module database;

import std.stdio;
import dbMisc.general;
import dbMisc.types;
import dbMisc.KeyStuff;

class Database
{

	string filename;
	File db;

	this(string filename)
	{
		this.filename = filename;
	}

	void addKey(string name, string type)
	{
		//are there (or are there not) bytes in the file
		bool isEmpty = isDBEmpty(filename);

		uint dbSize; //size of the database (if any)

		//Database into memory
		ubyte[] data;

		if (isEmpty) //Database is empty
		{
			dbSize = 0;
		}
		else //Database is not empty
		{
			dbSize = getSize(filename);
		}


		//work out storage stuff

		uint spaceNeeded = 1 + getKeyLength(name) + getSpaceForType(type);

		//work out storage for database too
		data.length = spaceNeeded + dbSize;
		//let's read current data (if any into data)
		if (!isEmpty)
		{
			db = File(filename, "rb");
			db.rawRead(data);
			db.close();
		}


		uint beginPos = dbSize;

		uint pos = 0;

		uint keyPosRead = 0;
		
		//string data-type (in the database scheme) specific
		uint valuePosRead = 0;

		//Debug
		writeln("Space needed: ", spaceNeeded);
		writeln("Begin pos: ", beginPos);
		writeln("DB SIze: ", dbSize);
		writeln("Key length: ", getKeyLength(name));
		//end debug

		for (uint i = beginPos; i < spaceNeeded+dbSize; i++)
		{
			if (pos == 0)
			{
				data[i] = getTypeID(type);
			}
			else if (pos == 1) //readin key name till we reach the end (nuull-terminator included)
			{
				if (keyPosRead < getKeyLength(name))
				{
					writeln("KeyPosRead: ", keyPosRead);
					if (keyPosRead != getKeyLength(name)-1)
					{
						data[i] = (cast(ubyte[])name)[keyPosRead++];
					}
					else
					{
						data[i] = 0;
						keyPosRead++;
					}
					continue;
				}
			}
			else if (pos == 2)
			{
				if (type == "string" || type == "byte" || type == "boolean")
				{
					data[i] = 0;
				}
			}
			pos++;
		}

		//Write back to database
		db = File(filename, "wb");
		db.rawWrite(data);
		db.close();
		

	}

}
