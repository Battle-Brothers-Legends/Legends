this.statistics_manager <- {
	m = {
		Flags = null,
		News = [],
		Fallen = []
	},
	function getFlags()
	{
		return this.m.Flags;
	}

	function getFallen()
	{
		return this.m.Fallen;
	}

	function getNews()
	{
		return this.m.News;
	}

	function isNewsReady()
	{
		return this.m.News.len() != 0;
	}

	function hasNews( _type )
	{
		foreach( i, n in this.m.News )
		{
			if (n.Type == _type)
			{
				return true;
			}
		}

		return false;
	}

	function popNews( _type )
	{
		foreach( i, n in this.m.News )
		{
			if (n.Type == _type)
			{
				this.m.News.remove(i);

				if (this.m.News.len() != 0)
				{
					this.World.Events.resetLastEventTime();
				}

				return n;
			}
		}
	}

	function addNews( _type, _news )
	{
		_news.Type <- _type;
		_news.Time <- this.Time.getVirtualTimeF();

		if (this.m.News.len() >= 10)
		{
			this.m.News.remove(0);
		}

		this.m.News.push(_news);
		this.World.Events.resetLastEventTime();
	}

	function clearNews()
	{
		this.m.News = [];
	}

	function createNews()
	{
		return this.new("scripts/tools/tag_collection");
	}

	function addFallen( bro, _killedby = "Left to die")
	{
		local b = bro.getBaseProperties();
		local bstats = [
			b.Hitpoints,
			b.Stamina,
			b.Bravery,
			b.Initiative,
			b.MeleeSkill,
			b.RangedSkill,
			b.MeleeDefense,
			b.RangedDefense
		];
		local _fallen = {
			Name = bro.getName(),
			Time = this.World.getTime().Days,
			TimeWithCompany = this.Math.max(1, bro.getDaysWithCompany()),
			Kills = bro.getLifetimeStats().Kills,
			Battles = bro.getLifetimeStats().Battles,
			KilledBy = _killedby,
			Expendable = bro.getBackground().getID() == "background.slave",
			level = bro.getLevel(),
			traits = bro.getDeadTraits(),
			stats = bstats,
			talents = bro.getTalents(),
		};
		this.m.Fallen.insert(0, _fallen);
	}

	function create()
	{
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.Flags.set("GreaterEvilsDefeated", 0);
		this.m.Flags.set("ItemsCrafted", 0);
		this.m.Flags.set("LastLocationDestroyedName", "");
		this.m.Flags.set("LastLocationDestroyedFaction", 0);
		this.m.Flags.set("LastLocationDestroyedForContract", false);
		this.m.Flags.set("LastEnemiesDefeatedCount", 0);
		this.m.Flags.set("LastCombatResult", 0);
		this.m.Flags.set("LastCombatFaction", 0);
		this.m.Flags.set("LastCombatKills", 0);
		this.m.Flags.set("LastCombatSavedCaravan", false);
		this.m.Flags.set("LastCombatSavedCaravanProduce", "");
		this.m.Flags.set("LastCombatWasOngoingBattle", false);
	}

	function clear()
	{
		this.m.News = [];
	}

	function onSerialize( _out )
	{
		this.m.Flags.onSerialize(_out);
		_out.writeU8(this.m.News.len());

		foreach( n in this.m.News )
		{
			_out.writeString(n.Type);
			_out.writeF32(n.Time);
			n.onSerialize(_out);
		}

		_out.writeU32(this.m.Fallen.len());

		foreach( f in this.m.Fallen )
		{
			_out.writeString(f.Name);
			_out.writeU32(f.Time);
			_out.writeU32(f.TimeWithCompany);
			_out.writeU32(f.Kills);
			_out.writeU32(f.Battles);
			_out.writeString(f.KilledBy);

			if (f.len() > 6)
			{
				_out.writeU8(f.level);
				_out.writeU8(f.traits.len());

				foreach( trait in f.traits )
				{
					_out.writeString(trait);
				}

				_out.writeU8(f.stats.len());

				foreach( stat in f.stats )
				{
					_out.writeU32(stat);
				}

				_out.writeU8(f.talents.len());

				foreach( talent in f.talents )
				{
					_out.writeU8(talent);
				}
			}
			else
			{
				_out.writeU8(-99);
				_out.writeU8(4);

				for( local i = 0; i < 4; i = ++i )
				{
					_out.writeString("");
				}

				_out.writeU8(8);

				for( local i = 0; i < 8; i = ++i )
				{
					_out.writeU32(-99);
				}

				_out.writeU8(8);

				for( local i = 0; i < 8; i = ++i)
				{
					_out.writeU8(-99);
				}
			}

			_out.writeBool(f.Expendable);
			//_out.writeBool(false);
		}
	}

	function onDeserialize( _in )
	{
		if (_in.getMetaData().getVersion() <= 53)
		{
			this.m.Flags.set("LastLocationDestroyedName", _in.readString());
			this.m.Flags.set("LastLocationDestroyedFaction", _in.readU8());
			this.m.Flags.set("LastLocationDestroyedForContract", _in.readBool());
			this.m.Flags.set("LastEnemiesDefeatedCount", _in.readU16());
			this.m.Flags.set("LastCombatResult", _in.readU8());

			if (_in.getMetaData().getVersion() >= 42)
			{
				this.m.Flags.set("LastCombatFaction", _in.readU8());
			}
			else
			{
				this.m.Flags.set("LastCombatFaction", 0);
			}

			this.m.Flags.set("LastCombatSavedCaravan", false);
			this.m.Flags.set("LastCombatSavedCaravanProduce", "");
		}

		this.m.Flags.onDeserialize(_in);
		local numNews = _in.readU8();
		this.m.News.resize(numNews);

		for( local i = 0; i < numNews; i = ++i )
		{
			local news = this.new("scripts/tools/tag_collection");
			news.Type <- _in.readString();
			news.Time <- _in.readF32();
			news.onDeserialize(_in);
			this.m.News[i] = news;
		}

		local numFallen = _in.readU32();
		this.m.Fallen.resize(numFallen);

		for( local i = 0; i < numFallen; i = ++i )
		{
			local f = {};
			f.Name <- _in.readString();
			f.Time <- _in.readU32();
			f.TimeWithCompany <- _in.readU32();
			f.Kills <- _in.readU32();
			f.Battles <- _in.readU32();
			f.KilledBy <- _in.readString();

			if (_in.getMetaData().getVersion() >= 57)
			{
				f.level <- _in.readU8();
				f.traits <- [];
				local numtraits = _in.readU8();

				for( local i = 0; i != numtraits; i++ )
				{
					f.traits.push(_in.readString());
				}

				f.stats <- [];
				local numstats = _in.readU8();

				for( local i = 0; i != numstats; i++ )
				{
					f.stats.push(_in.readU32());
				}

				f.talents <- [];
				local numtalents = _in.readU8();

				for( local i = 0; i != numtalents; i++ )
				{
					f.talents.push(_in.readU8());
				}
			}

			f.Expendable <- _in.readBool();
			//_in.readBool();
			this.m.Fallen[i] = f;
		}
	}

};

