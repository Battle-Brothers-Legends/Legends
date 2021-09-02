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
		local party = _faction.spawnEntity(this.m.Start.getTile(), "Supply Caravan", false, spawnParty, r * 100 + this.Math.round(0.1 * this.m.Start.getResources()));
		party.getSprite("body").setBrush(this.Const.World.Spawn.NobleCaravan.Body);
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");
		party.setFootprintType(this.Const.World.FootprintsType.Caravan);
		party.getFlags().set("IsCaravan", true);
		party.getFlags().set("IsRandomlySpawned", true);

		if (this.World.Assets.m.IsBrigand && this.m.Start.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 70)
		{
			party.setVisibleInFogOfWar(true);
			party.setImportant(true);
			party.setDiscovered(true);
		}

		if (this.m.Start.getProduce().len() != 0)
		{
			local produce = 3
			if(this.LegendsMod.Configs().LegendWorldEconomyEnabled())
			{
				produce = this.Math.max(3, 3 + this.Math.round(0.05 * this.m.Start.getResources()));
			}

			for( local j = 0; j < produce; j = ++j )
			{
				party.addToInventory(this.m.Start.getProduce()[this.Math.rand(0, this.m.Start.getProduce().len() - 1)]);
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

		if(this.LegendsMod.Configs().LegendWorldEconomyEnabled())
		{
			local resources = this.Math.max(1, this.Math.round(0.05 * this.m.Start.getResources()));
			this.m.Start.setResources(this.m.Start.getResources() - resources);
			party.setResources(resources);

			local r = this.Math.rand(3,6);
			for( local j = 0; j < r; j = ++j )
			{
				local items = [
					[0, "supplies/bread_item"],
					[0, "supplies/roots_and_berries_item"],
					[0, "supplies/dried_fruits_item"],
					[0, "supplies/ground_grains_item"],
					[0, "supplies/dried_fish_item"],
					[0, "supplies/beer_item"],
					[0, "supplies/goat_cheese_item"],
					[1, "supplies/legend_fresh_fruit_item"],
					[1, "supplies/legend_fresh_meat_item"],
					[1, "supplies/legend_pie_item"],
					[1, "supplies/legend_porridge_item"],
					[1, "supplies/legend_pudding_item"],
					[0, "supplies/mead_item"],
					[0, "supplies/medicine_item"],
					[0, "supplies/pickled_mushrooms_item"],
					[0, "supplies/preserved_mead_item"],
					[0, "supplies/smoked_ham_item"],
					[0, "supplies/wine_item"]
				]

				local item = this.Const.World.Common.pickItem(items)
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

