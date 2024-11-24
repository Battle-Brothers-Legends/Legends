::mods_hookExactClass("contracts/contracts/defend_holy_site_southern_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Northern soldiers are seeking to conquer a place sacred in the Eye of the Gilder. Such heresy cannot be allowed.",
			"Northern rats are coming to defile a sacred place with their presence. The South will pay well to defend it.",
			"The Gilder faithful are edging to mass hysteria at the blasphemy of possibly yielding a revered holy site to the North. This should pay well.",
			"Southern faith demands the defence of all holy places, even if that means hiring heathen crownlings to do so.",
		];
	}

	o.spawnAlly = function ()
	{
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 4; x < o.X + 4; x = ++x )
		{
			for( local y = o.Y - 6; y <= o.Y - 3; y = ++y )
			{
				if (!this.World.isValidTileSquare(x, y))
				{
				}
				else
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean)
					{
					}
					else
					{
						local s = this.Math.rand(0, 3);

						if (tile.Type == this.Const.World.TerrainType.Mountains)
						{
							s = s - 10;
						}

						if (tile.HasRoad)
						{
							s = s + 10;
						}

						tiles.push({
							Tile = tile,
							Score = s
						});
					}
				}
			}
		}

		if (tiles.len() == 0)
		{
			tiles.push({
				Tile = this.m.Destination.getTile(),
				Score = 0
			});
		}

		tiles.sort(function ( _a, _b )
		{
			if (_a.Score > _b.Score)
			{
				return -1;
			}
			else if (_a.Score < _b.Score)
			{
				return 1;
			}

			return 0;
		});
		local f = this.World.FactionManager.getFaction(this.getFaction());
		local candidates = [];

		foreach( s in f.getSettlements() )
		{
			candidates.push(s);
		}

		local party = f.spawnEntity(tiles[0].Tile, "Regiment of " + candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(100, 150) * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("Conscripted soldiers loyal to their city state.");
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
		move.setDestination(this.m.Destination.getTile());
		c.addOrder(move);
		local guard = this.new("scripts/ai/world/orders/guard_order");
		guard.setTarget(this.m.Destination.getTile());
		guard.setTime(240.0);
		c.addOrder(guard);
		return party;
	}

	o.spawnEnemy = function ()
	{
		local cityState = this.World.FactionManager.getFaction(this.getFaction());
		local o = this.m.Destination.getTile().SquareCoords;
		local tiles = [];

		for( local x = o.X - 4; x < o.X + 4; x = ++x )
		{
			for( local y = o.Y + 4; y <= o.Y + 6; y = ++y )
			{
				if (!this.World.isValidTileSquare(x, y))
				{
				}
				else
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean)
					{
					}
					else
					{
						local s = this.Math.rand(0, 3);

						if (tile.Type == this.Const.World.TerrainType.Mountains)
						{
							s = s - 10;
						}

						if (tile.HasRoad)
						{
							s = s + 10;
						}

						tiles.push({
							Tile = tile,
							Score = s
						});
					}
				}
			}
		}

		if (tiles.len() == 0)
		{
			tiles.push({
				Tile = this.m.Destination.getTile(),
				Score = 0
			});
		}

		tiles.sort(function ( _a, _b )
		{
			if (_a.Score > _b.Score)
			{
				return -1;
			}
			else if (_a.Score < _b.Score)
			{
				return 1;
			}

			return 0;
		});
		local f = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyID"));
		local candidates = [];

		foreach( s in f.getSettlements() )
		{
			if (s.isMilitary())
			{
				candidates.push(s);
			}
		}

		local party = f.spawnEntity(tiles[0].Tile, candidates[this.Math.rand(0, candidates.len() - 1)].getNameOnly() + " Company", true, this.Const.World.Spawn.Noble, (this.m.Flags.get("IsEnemyLuredAway") ? 130 : 160) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
		party.setDescription("Professional soldiers in service to local lords.");
		party.setAttackableByAI(false);
		party.setAlwaysAttackPlayer(true);
		party.getLoot().Money = this.Math.rand(50, 200);
		party.getLoot().ArmorParts = this.Math.rand(0, 25);
		party.getLoot().Medicine = this.Math.rand(0, 3);
		party.getLoot().Ammo = this.Math.rand(0, 30);
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

		local c = party.getController();
		local attack = this.new("scripts/ai/world/orders/attack_zone_order");
		attack.setTargetTile(this.m.Destination.getTile());
		c.addOrder(attack);
		local occupy = this.new("scripts/ai/world/orders/occupy_order");
		occupy.setTarget(this.m.Destination);
		occupy.setTime(10.0);
		occupy.setSafetyOverride(true);
		c.addOrder(occupy);
		local guard = this.new("scripts/ai/world/orders/guard_order");
		guard.setTarget(this.m.Destination.getTile());
		guard.setTime(999.0);
		c.addOrder(guard);
		return party;
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Preparation3")
			{
				s.start <- function ()
				{
					for( local i = 0; i < 2; i = ++i )
					{
						local r = this.Math.rand(1, 12);
						local item;

						switch(r)
						{
						case 1:
							item = this.new("scripts/items/weapons/oriental/saif");
							break;

						case 2:
							item = this.new("scripts/items/tools/throwing_net");
							break;

						case 3:
							item = this.new("scripts/items/weapons/oriental/polemace");
							break;

						case 4:
							item = this.new("scripts/items/weapons/ancient/broken_ancient_sword");
							break;

						case 5:
							item = this.Const.World.Common.pickArmor([
								[1, "ancient/ancient_mail"],
							]);
							break;

						case 6:
							item = this.new("scripts/items/supplies/ammo_item");
							break;

						case 7:
							item = this.new("scripts/items/supplies/armor_parts_item");
							break;

						case 8:
							item = this.new("scripts/items/shields/ancient/tower_shield");
							break;

						case 9:
							item = this.new("scripts/items/loot/ancient_gold_coins_item");
							break;

						case 10:
							item = this.new("scripts/items/loot/silver_bowl_item");
							break;

						case 11:
							item = this.new("scripts/items/weapons/wooden_stick");
							break;

						case 12:
							local helmet = [
								[1, "oriental/spiked_skull_cap_with_mail"]
							];
							item = this.Const.World.Common.pickHelmet(helmet);
							break;
						}

						if (item.getConditionMax() > 1)
						{
							item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 50) * 0.01));
						}

						this.World.Assets.getStash().add(item);
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You gain " + item.getName()
						});
					}

					local amount = this.Math.rand(10, 30);
					this.World.Assets.addArmorParts(amount);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_supplies.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] Tools and Supplies."
					});
				}
			}
			if (s.ID == "Task")
			{
				s.Title = "Defend Holy Site";
			}
		}
	}
});
