this.retinue_manager <- {
	m = {
		Followers = [],
		Slots = [],
		InventoryUpgrades = 0
	},
	function getInventoryUpgrades()
	{
		return this.m.InventoryUpgrades;
	}

	function getFollower( _id )
	{
		if (_id.len() == 0)
		{
			return null;
		}

		foreach( a in this.m.Followers )
		{
			if (a.getID() == _id)
			{
				return a;
			}
		}

		return null;
	}

	function hasFollower( _id )
	{
		foreach( a in this.m.Slots )
		{
			if (a != null && a.getID() == _id)
			{
				return true;
			}
		}

		return false;
	}

	function getNumberOfCurrentFollowers()
	{
		local n = 0;

		foreach( a in this.m.Slots )
		{
			if (a != null)
			{
				n = ++n;
			}
		}

		return n;
	}

	function getNumberOfUnlockedSlots()
	{
		local unlocked = 0;

		for( local i = 0; i < this.m.Slots.len(); i = ++i )
		{
			if (this.World.Assets.getBusinessReputation() >= this.Const.BusinessReputation[this.Const.FollowerSlotRequirements[i]])
			{
				unlocked = ++unlocked;
			}
		}

		return unlocked;
	}

	function getCurrentFollowersForUI()
	{
		local ret = [];
		ret.resize(this.m.Slots.len());
		local unlocked = 0;

		for( local i = 0; i < this.m.Slots.len(); i = ++i )
		{
			if (this.World.Assets.getBusinessReputation() >= this.Const.BusinessReputation[this.Const.FollowerSlotRequirements[i]])
			{
				unlocked = ++unlocked;
			}
		}

		foreach( i, p in this.m.Slots )
		{
			if (p != null)
			{
				ret[i] = {
					Image = p.getImage(),
					ID = p.getID(),
					Slot = i
				};
			}
			else if (i >= unlocked)
			{
				ret[i] = {
					Image = "ui/campfire/locked_slot",
					ID = "locked",
					Slot = i
				};
			}
			else
			{
				ret[i] = {
					Image = "ui/campfire/free_slot",
					ID = "free",
					Slot = i
				};
			}
		}

		return ret;
	}

	function getFollowersForUI()
	{
		local ret = [];

		foreach( p in this.m.Followers )
		{
			if (this.hasFollower(p.getID()) || !p.isVisible())
			{
				continue;
			}

			p.evaluate();
			ret.push({
				ImagePath = p.getImage() + ".png",
				ID = p.getID(),
				Name = p.getName(),
				Description = p.getDescription(),
				IsUnlocked = p.isUnlocked(),
				Cost = p.getCost(),
				Effects = p.getEffects(),
				Requirements = p.getRequirements()
			});
		}

		ret.sort(this.onFollowerCompare);
		return ret;
	}

	function setFollower( _slot, _follower )
	{
		this.m.Slots[_slot] = _follower;
		this.update();

		if (this.getNumberOfCurrentFollowers() == this.m.Slots.len())
		{
			this.updateAchievement("FullHouse", 1, 1);
		}
		else
		{
			this.updateAchievement("CampfireCompany", 1, 1);
		}
	}

	function upgradeInventory()
	{
		++this.m.InventoryUpgrades;
		this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 27);
	}

	function create()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local scriptFiles = this.IO.enumerateFiles("scripts/retinue/followers/");

		foreach( scriptFile in scriptFiles )
		{
			local f = this.new(scriptFile);

			if (f.isValid())
			{
				this.m.Followers.push(f);
			}
		}

		this.m.Slots.resize(5);
	}

	function update()
	{
		this.World.Assets.resetToDefaults();

		foreach( p in this.m.Slots )
		{
			if (p != null)
			{
				p.update();
			}
		}
	}

	function clear()
	{
		this.m.Slots = [];
		this.m.Slots.resize(5);
	}

	function onNewDay()
	{
		foreach( p in this.m.Slots )
		{
			if (p != null)
			{
				p.onNewDay();
			}
		}
	}

	function onFollowerCompare( _f1, _f2 )
	{
		if (_f1.IsUnlocked && !_f2.IsUnlocked)
		{
			return -1;
		}
		else if (!_f1.IsUnlocked && _f2.IsUnlocked)
		{
			return 1;
		}
		else if (_f1.Cost < _f2.Cost)
		{
			return -1;
		}
		else if (_f1.Cost > _f2.Cost)
		{
			return 1;
		}
		else if (_f1.Name < _f2.Name)
		{
			return -1;
		}
		else if (_f1.Name > _f2.Name)
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	function onSerialize( _out )
	{
		_out.writeU8(this.m.Slots.len());

		foreach( p in this.m.Slots )
		{
			if (p == null)
			{
				_out.writeBool(false);
			}
			else
			{
				_out.writeBool(true);
				_out.writeString(p.getID());
				p.onSerialize(_out);
			}
		}

		_out.writeU8(this.m.InventoryUpgrades);
	}

	function onDeserialize( _in )
	{
		this.clear();
		local numPerks = _in.readU8();

		for( local i = 0; i < numPerks; i = ++i )
		{
			local isFollower = _in.readBool();

			if (isFollower)
			{
				local p = this.getFollower(_in.readString());

				if (p != null)
				{
					p.onDeserialize(_in);
					this.m.Slots[i] = p;
				}
				else
				{
				}
			}
		}

		this.m.InventoryUpgrades = _in.readU8();
		this.update();
	}

};

