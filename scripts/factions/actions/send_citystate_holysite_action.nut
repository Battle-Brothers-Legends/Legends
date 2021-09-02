this.send_citystate_holysite_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "send_citystate_holysite_action";
		this.m.Cooldown = 600.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!(this.World.FactionManager.getGreaterEvilType() == this.Const.World.GreaterEvilType.HolyWar && this.World.FactionManager.getGreaterEvilPhase() >= this.Const.World.GreaterEvilPhase.Warning))
		{
			return;
		}

		if (_faction.getUnits().len() >= 8)
		{
			return;
		}

		local abort = true;
		local sites = [
			"location.holy_site.oracle",
			"location.holy_site.meteorite",
			"location.holy_site.vulcano"
		];
		local activeContract = this.World.Contracts.getActiveContract();
		local locations = this.World.EntityManager.getLocations();

		foreach( v in locations )
		{
			foreach( s in sites )
			{
				if (v.getTypeID() == s && (v.getFaction() == 0 || !this.World.FactionManager.isAllied(_faction.getID(), v.getFaction())) && (activeContract == null || !activeContract.isTileUsed(v.getTile())))
				{
					abort = false;
					break;
				}
			}

			if (!abort)
			{
				break;
			}
		}

		if (abort)
		{
			return true;
		}

		this.m.Score = 10;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local potential_origins = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			potential_origins.push({
				D = s,
				P = s.getResources()
			});
		}

		if (potential_origins.len() == 0)
		{
			return;
		}

		local origin = this.pickWeightedRandom(potential_origins);
		local myTile = origin.getTile();
		local spawnpoints = [];
		spawnpoints.push(myTile);

		foreach( a in origin.getAttachedLocations() )
		{
			if (a.isActive() && a.isMilitary())
			{
				spawnpoints.push(a.getTile());
			}
		}

		local sites = [
			"location.holy_site.oracle",
			"location.holy_site.meteorite",
			"location.holy_site.vulcano"
		];
		local locations = this.World.EntityManager.getLocations();
		local activeContract = this.World.Contracts.getActiveContract();
		local target;
		local closestDist = 9000;

		foreach( v in locations )
		{
			foreach( s in sites )
			{
				if (v.getTypeID() == s && (v.getFaction() == 0 || !this.World.FactionManager.isAllied(_faction.getID(), v.getFaction())) && (activeContract == null || !activeContract.isTileUsed(v.getTile())))
				{
					local d = myTile.getDistanceTo(v.getTile());

					if (d < closestDist)
					{
						target = v;
						closestDist = d;
					}
				}
			}
		}

		if (target == null)
		{
			return;
		}

		local num = target.getFaction() == 0 ? 1 : spawnpoints.len();

		for( local i = 0; i < num; i = ++i )
		{
			local party = _faction.spawnEntity(spawnpoints[i], "Regiment of " + _faction.getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(90, 120) * this.getScaledDifficultyMult());
			party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + _faction.getBannerString());
			party.setDescription("Conscripted soldiers loyal to their city state.");
			party.setFootprintType(this.Const.World.FootprintsType.CityState);
			party.getFlags().set("IsRandomlySpawned", true);
			party.getLoot().Money = this.Math.rand(100, 300);
			party.getLoot().ArmorParts = this.Math.rand(10, 35);
			party.getLoot().Medicine = this.Math.rand(5, 15);
			party.getLoot().Ammo = this.Math.rand(10, 40);
			local r = this.Math.rand(1, 4);

			if (r <= 2)
			{
				party.addToInventory("supplies/rice_item");
			}
			else if (r == 3)
			{
				party.addToInventory("supplies/dates_item");
			}
			else if (r == 4)
			{
				party.addToInventory("supplies/dried_lamb_item");
			}

			local arr = ["trade/silk_item", "trade/silk_item", "trade/incense_item", "trade/spices_item"]
			for(local i = 0; i < this.Math.round(r/2); i++) //adds either 1 silk, 1 silk, 2 incense, 2 spices
			{
				party.addToInventory(arr[r-1])
			}

			local c = party.getController();
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(target.getTile());
			move.setRoadsOnly(false);
			move.setAvoidSettlements(true);
			c.addOrder(move);
			local attack = this.new("scripts/ai/world/orders/attack_zone_order");
			attack.setTargetTile(target.getTile());
			c.addOrder(attack);
			local occupy = this.new("scripts/ai/world/orders/occupy_order");
			occupy.setTarget(target);
			occupy.setTime(10.0);
			c.addOrder(occupy);

			if (i == 0)
			{
				local guard = this.new("scripts/ai/world/orders/guard_order");
				guard.setTarget(target.getTile());
				guard.setTime(240.0);
				c.addOrder(guard);
			}
		}

		origin.setLastSpawnTimeToNow();
		return true;
	}

});

