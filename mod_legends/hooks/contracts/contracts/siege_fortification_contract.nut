::mods_hookExactClass("contracts/contracts/siege_fortification_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Laying Siege";
		this.m.DescriptionTemplates = [
			"Sieges often lead to violent, unpredictable outcomes. %s are seeking hardened sellswords to provide a steadying hand should things turn to ratshit.",
			"Finishing a siege is always a dicey business. %s wants some hardened mercenaries to tip the odds.",
			"Dying with an arrow in your gut from attacking a fortified position is not exactly high in your list of priorities.",
			"Siege actions nearly always turn to ratshit in your experience. Probably why %s wants you down there.",
		];
	}

	local start = o.start;
	o.start = function ()
	{
		start();
		this.m.Name = "Siege %objective%";
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
			if (s.ID == "PrisonersLetGo")
			{
				s.Text = "Enough death for one day. (Increase Moral Reputation)";
			}
			if (s.ID == "PrisonersKilled")
			{
				s.Text = "On to more important things... (Decrease Moral Reputation)";
			}
			if (s.ID == "PrisonersSold")
			{
				s.Text = "On to more important things... (Decrease Moral Reputation)";
				s.start <- function ()
				{
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]250[/color] Crowns"
					});
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
		}
	}

	o.spawnReliefForces = function ()
	{
		local tile;
		local originTile = this.m.Origin.getTile();

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 8, originTile.SquareCoords.X + 8);
			local y = this.Math.rand(originTile.SquareCoords.Y - 8, originTile.SquareCoords.Y + 8);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Mountains)
			{
				continue;
			}

			break;
		}

		local enemyFaction = this.m.Origin.getOwner();
		local party = enemyFaction.spawnEntity(tile, this.m.Origin.getOwner().getName() + " Army", true, this.Const.World.Spawn.Noble, 200 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + enemyFaction.getBannerString());
		party.getSprite("banner").setBrush(enemyFaction.getBannerSmall());
		party.setDescription("Professional soldiers in service to local lords.");
		party.setFootprintType(this.Const.World.FootprintsType.Nobles);
		party.getLoot().Money = this.Math.rand(100, 300);
		party.getLoot().ArmorParts = this.Math.rand(10, 35);
		party.getLoot().Medicine = this.Math.rand(5, 15);
		party.getLoot().Ammo = this.Math.rand(10, 40);
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

		party.setAttackableByAI(false);
		this.m.UnitsSpawned.push(party.getID());
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		c.addOrder(move);
		local wait = this.new("scripts/ai/world/orders/wait_order");
		wait.setTime(10.0);
		c.addOrder(wait);
	}

	o.spawnSupplyCaravan = function ()
	{
		local tile;
		local originTile = this.m.Origin.getTile();

		while (true)
		{
			local x = this.Math.rand(originTile.SquareCoords.X - 7, originTile.SquareCoords.X + 7);
			local y = this.Math.rand(originTile.SquareCoords.Y - 7, originTile.SquareCoords.Y + 7);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (!tile.HasRoad)
			{
				continue;
			}

			break;
		}

		local enemyFaction = this.m.Origin.getOwner();
		local party = enemyFaction.spawnEntity(tile, "Supply Caravan", false, this.Const.World.Spawn.NobleCaravan, this.Math.rand(100, 150));
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");

		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			for( local i = 0; i < 5; i = ++i )
			{
				party.addToInventory(this.new("scripts/items/supplies/ground_grains_item"));
			}
		}
		else
		{
			for( local i = 0; i < 5; i = ++i )
			{
				party.addToInventory("supplies/ground_grains_item");
			}
		}

		party.getLoot().Money = this.Math.rand(0, 100);
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		move.setRoadsOnly(true);
		c.addOrder(move);
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(despawn);
	}

});
