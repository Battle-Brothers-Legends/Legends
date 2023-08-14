this.send_supplies_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Start = null,
		Dest = null
	},
	function create()
	{
		this.m.ID = "send_supplies_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 3;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (!_faction.isReadyToSpawnUnit())
		{
			return;
		}

		local starts = [];
		local dests = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.isIsolatedFromRoads())
			{
				continue;
			}

			if (s.isMilitary())
			{
				dests.push(s);
			}
			else if (!(s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF()))
			{
				starts.push(s);
			}
		}

		if (starts.len() != 0 && dests.len() != 0)
		{
			this.m.Start = starts[this.Math.rand(0, starts.len() - 1)];
			this.m.Dest = dests[this.Math.rand(0, dests.len() - 1)];

			if (this.m.Start.isConnectedToByRoads(this.m.Dest))
			{
				this.m.Score = 5;
			}
			else
			{
				this.m.Start = null;
				this.m.Dest = null;
				return;
			}
		}
	}

	function onClear()
	{
		this.m.Start = null;
		this.m.Dest = null;
	}

	function onExecute( _faction )
	{
		local party;
		local value = 0; 
		local tradegoods = 0; 
		local totalValue = 0;
		local itemList = [];
		// If we have world economy on, check how much the caravan is worth 
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{

			foreach (building in this.m.Start.getBuildings())
			{
				local stash = building.getStash()
				if (stash != null)
				{
					foreach (item in stash.getItems())
					{
						if (item == null) continue;

						if (item.isItemType(this.Const.Items.ItemType.TradeGood))
						{
							
							tradegoods += item.getResourceValue();
							itemList.append(item) // Store item in array instead of directly adding to party
						}
						else if (this.Math.rand(1,10) == 1)
						{								
							
							if (item.getValue() > 0)
							{
								value += item.getValue() * 0.01;
							}
							itemList.append(item) // Store item in array instead of directly adding to party
						}
					}
				}
			}
			value = this.Math.floor(value);
			tradegoods = this.Math.floor(tradegoods);
			totalValue = value + tradegoods;
		}
		else
		{
		// if there is no world economy use the vanilla resource calculation
		tradegoods = this.Math.round(0.1 * this.m.Start.getResources());
		totalValue = this.m.Start.getResources() * 0.1;
		}
	
	
		local spawnParty = this.Const.World.Spawn.NobleCaravan;
		local r = this.Math.rand(1, 100)
		if (r > 75)
		{
			spawnParty = this.Const.World.Spawn.Mercenaries;
		}
		else if (r > 50)
		{
			spawnParty = this.Const.World.Spawn.MixedNobleCaravan;
		}
		r = this.Math.rand(100, 200) * 0.01;
		local party = _faction.spawnEntity(this.m.Start.getTile(), "Supply Caravan", false, spawnParty, r * 100 + this.Math.round(totalValue * 2));
		party.getSprite("body").setBrush(this.Const.World.Spawn.NobleCaravan.Body);
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");
		party.setFootprintType(this.Const.World.FootprintsType.Caravan);
		party.getFlags().set("IsCaravan", true);
		party.getFlags().set("IsRandomlySpawned", true);
		party.setOrigin(this.m.Start);

		if (this.World.Assets.m.IsBrigand && this.m.Start.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 70)
		{
			party.setVisibleInFogOfWar(true);
			party.setImportant(true);
			party.setDiscovered(true);
		}

		// the inital goods this caravan has
		if (this.m.Start.getProduce().len() != 0)
		{
			local produce = 3;
			if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			{
				produce = this.Math.max(3, 3 + this.Math.round(0.05 * this.m.Start.getResources()));
			}

			local getAsString = !::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue(); 
			for( local j = 0; j < produce; j = ++j )
			{
				local p = ::MSU.Array.rand(this.m.Start.getProduce())
				party.addToInventory(getAsString ? p : this.new("scripts/items/" + p));
			}
		}

		party.getLoot().Money = this.Math.floor(this.Math.rand(0, 100) * r);
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			party.getLoot().ArmorParts = this.Math.rand(15 * r, 30 * r);
		}
		else if (r == 2)
		{
			party.getLoot().Medicine = this.Math.rand(10 * r, 20 * r);
		}
		else if (r == 3)
		{
			party.getLoot().Ammo = this.Math.rand(25 * r, 50 * r);
		}

		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{

			// Now that party has been spawned, transfer items from itemList to party's inventory
			foreach(item in itemList)
			{
				party.addToInventory(item);
			}		
		}
		else
		{
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				party.addToInventory("supplies/bread_item");
			}
			else if (r == 2)
			{
				party.addToInventory("supplies/roots_and_berries_item");
			}
			else if (r == 3)
			{
				party.addToInventory("supplies/dried_fruits_item");
			}
			else if (r == 4)
			{
				party.addToInventory("supplies/ground_grains_item");
			}
		}

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Dest.getTile());
		move.setRoadsOnly(true);

		local unload = this.new("scripts/ai/world/orders/unload_order");
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move);
		c.addOrder(unload);
		c.addOrder(despawn);
	}

});

