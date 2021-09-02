this.send_refugees_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Start = null,
		Dest = null
	},
	function create()
	{
		this.m.ID = "send_refugees_action";
		this.m.Cooldown = 300.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (this.World.FactionManager.isGreaterEvil())
		{
			return;
		}

		local hasInactive = false;

		foreach( a in _faction.getSettlements()[0] )
		{
			if (!a.isActive() && a.isMilitary())
			{
				hasInactive = true;
				break;
			}
		}

		if (!hasInactive)
		{
			return;
		}

		local mySettlements = _faction.getSettlements();
		local allSettlements = this.World.EntityManager.getSettlements();
		local settlements = this.getRandomConnectedSettlements(2, mySettlements, allSettlements, true);

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
		local party = _faction.spawnEntity(this.m.Start.getTile(), "Refugees", false, this.Const.World.Spawn.Peasants, this.Math.rand(30, 60));
		party.getSprite("banner").Visible = false;
		party.getSprite("body").setBrush("figure_civilian_0" + this.Math.rand(1, 2));
		party.setDescription("Refugees fleeing the horrors of war - beaten down, tired and desperate.");
		party.setFootprintType(this.Const.World.FootprintsType.Refugees);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = this.Math.rand(0, 50);

		if(this.LegendsMod.Configs().LegendWorldEconomyEnabled())
		{
			local resources = this.Math.max(1, this.Math.round(0.01 * this.m.Start.getResources()));
			this.m.Start.setResources(this.m.Start.getResources() - resources);
			party.setResources(resources);
			local r = this.Math.rand(1,2);
			for( local j = 0; j < r; j = ++j )
			{
				local items = [
					[1, "supplies/bread_item"],
					[1, "supplies/roots_and_berries_item"],
					[1, "supplies/dried_fruits_item"],
					[1, "supplies/ground_grains_item"],
					[1, "supplies/dried_fish_item"],
					[1, "supplies/beer_item"],
					[1, "supplies/goat_cheese_item"],
					[1, "supplies/legend_fresh_fruit_item"],
					[1, "supplies/legend_fresh_meat_item"],
					[1, "supplies/legend_pie_item"],
					[1, "supplies/legend_porridge_item"],
					[1, "supplies/legend_pudding_item"],
					[1, "supplies/mead_item"],
					[0, "supplies/medicine_item"],
					[1, "supplies/pickled_mushrooms_item"],
					[1, "supplies/preserved_mead_item"],
					[1, "supplies/smoked_ham_item"],
					[1, "supplies/wine_item"]
				]

				local item = this.Const.World.Common.pickItem(items)
				party.addToInventory(item);
			}
		}

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);

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

