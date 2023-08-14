this.send_caravan_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Start = null,
		Dest = null
	},
	function create()
	{
		this.m.ID = "send_caravan_action";
		this.m.Cooldown = 100.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (_faction.isEnemyNearby())
		{
			return;
		}

		if (_faction.getUnits().len() >= 1)
		{
			return;
		}

		local mySettlements = _faction.getSettlements();
		local allSettlements = this.World.EntityManager.getSettlements();
		local destinations;

		if (!this.World.FactionManager.isGreaterEvil())
		{
			destinations = allSettlements;
		}
		else
		{
			destinations = [];

			foreach( s in allSettlements )
			{
				if (s.getOwner() == null || s.getOwner().isAlliedWith(_faction.getID()))
				{
					destinations.push(s);
				}
			}
		}

		local settlements = this.getRandomConnectedSettlements(2, mySettlements, destinations, true);

		if (settlements.len() < 2)
		{
			return;
		}

		this.m.Start = settlements[0];
		this.m.Dest = settlements[1];
		this.m.Score = 5;
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
							else if (this.Math.rand(1,50) == 1)
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
			tradegoods = this.Math.round(0.025 * this.m.Start.getResources());
			totalValue = this.m.Start.getResources() * 0.6;
			}

			//set the caravan strength to match its totalValue 
			if (_faction.hasTrait(this.Const.FactionTrait.OrientalCityState))
			{
				party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Caravan", false, this.Const.World.Spawn.CaravanSouthern, totalValue * 1.1);
			}
			else
			{
				party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Caravan", false, this.Const.World.Spawn.Caravan, totalValue * 1);
			}
			

			party.getSprite("banner").Visible = false;
			party.getSprite("base").Visible = false;
			party.setMirrored(true);
			party.setDescription("A trading caravan from " + this.m.Start.getName() + " that is transporting all manner of goods between settlements.");
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



				if (this.m.Start.getProduce().len() != 0)
				{
					local produce = 3
					if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
					{
						produce = this.Math.max(3, 3 + this.Math.round(0.025 * this.m.Start.getResources()));
					}

					local getAsString = !::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue(); 
					for( local j = 0; j < produce; j = ++j )
					{
						local p = ::MSU.Array.rand(this.m.Start.getProduce())
						party.addToInventory(getAsString ? p : this.new("scripts/items/" + p));
					}
				}

					

				party.getLoot().Money = this.Math.rand(0, 100);

				if (this.Math.rand(1, 100) <= 50)
				{
					party.getLoot().ArmorParts = this.Math.rand(0, 10);
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					party.getLoot().Medicine = this.Math.rand(0, 10);
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					party.getLoot().Ammo = this.Math.rand(0, 25);
				}


				//remove the tradegoods value 
					this.m.Start.setResources(this.m.Start.getResources() - tradegoods);
				// give the carvan the total value 
					party.setResources(totalValue);
					this.logInfo("Exporting " + totalValue + " resources and " + party.getStashInventory().getItems().len() + " items from " + this.m.Start.getName() + " via a caravan bound for " + this.m.Dest.getName() + " town")
				
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

