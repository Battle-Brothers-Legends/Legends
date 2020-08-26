this.legends_undead_fort <- this.inherit("scripts/entity/world/settlements/legends_fort", {
	m = {},
	function create()
	{
		this.legends_fort.create();
		this.m.DefenderMult = 0.1;
		this.setDefenderSpawnList(this.Const.World.Spawn.UndeadFort);
		this.m.IsUndead = true;
		this.m.Names = [[
			"Aigosia",
			"Paridon",
			"Olbauros",
			"Tenamos",
			"Psychratus",
			"Gazenion",
			"Aegea",
			"Seutharae",
			"Naucralos",
			"Corebes",
			"Naucralos",
			"Nicous",
			"Leontossos",
			"Iolcenia"
		],[
			"Aigosia",
			"Paridon",
			"Olbauros",
			"Tenamos",
			"Psychratus",
			"Gazenion",
			"Aegea",
			"Seutharae",
			"Naucralos",
			"Corebes",
			"Naucralos",
			"Nicous",
			"Leontossos",
			"Iolcenia"
		],[
			"Aigosia",
			"Paridon",
			"Olbauros",
			"Tenamos",
			"Psychratus",
			"Gazenion",
			"Aegea",
			"Seutharae",
			"Naucralos",
			"Corebes",
			"Naucralos",
			"Nicous",
			"Leontossos",
			"Iolcenia"
		]];
		this.m.DraftLists = [[
			"legend_undead_legionnaire_background"
		],
		[
			"legend_undead_legionnaire_background"
		],
		[
			"legend_undead_legionnaire_background"
		]];

		this.m.FemaleDraftLists = [[
			"legend_undead_legionnaire_background"
		],
		[
			"legend_undead_legionnaire_background"
		],
		[
			"legend_undead_legionnaire_background"
		]];

		this.m.StablesLists = [[
			"legend_donkey",
			"legend_horse_rouncey"
		],[
			"legend_donkey",
			"legend_horse_rouncey"
		],[
			"legend_donkey",
			"legend_horse_rouncey",
			"legend_horse_destrier",
			"legend_horse_courser"
		]];
		this.m.Rumors = this.Const.Strings.RumorsForestSettlement;
		this.m.ProduceString = "wood";
	}

	function onDropLootForPlayer(_lootTable) {
		local scaledResources = this.Math.pow(this.m.Resources, 1.1) * 0.8;

        this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(scaledResources * 0.3, scaledResources * 0.6), _lootTable);
		this.dropMoney(this.Math.rand(scaledResources * 15, scaledResources * 25), _lootTable);

		this.dropTreasure(this.Math.rand(scaledResources * 0.04, 1 + scaledResources * 0.05), [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/white_pearls_item",
			"loot/golden_chalice_item",
			"loot/gemstones_item",
			"loot/ancient_gold_coins_item",
			"loot/jeweled_crown_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/white_pearls_item",
			"loot/golden_chalice_item",
			"loot/gemstones_item",
			"loot/ancient_gold_coins_item",
			"loot/jeweled_crown_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item",
			"misc/legend_ancient_scroll_item"
		], _lootTable);
    }

	function getDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "This small wooden fort hosts several wandering corpses.";
			case 2:
				return "This imposing stone keep controls a number of undead.";
			case 3:
				return "This enormous undead citadel commands terror over the region.";
			default:
				return "";
		}
	}

	function getUIDescription()
	{
		switch (this.m.Size)
		{
			case 1:
			 	return "A small undead fort";
			case 2:
				return "A mighty undead keep";
			case 3:
				return "A vast undead citadel";
			default:
				return null;
		}
	}

	function buildNewLocation()
	{
		return null;
	}

	function onBuildOne( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else if (this.Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else
		{
			local r = this.Math.rand(1, 4);

			if (r == 1 || this.Const.World.Buildings.Fletchers == 0)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}
	}

	function onBuildTwo( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else if (this.Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else
		{
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}
	}

	function onBuildThree( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if ( _settings.StackCitadels)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			return;
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));

		if (this.Math.rand(1, 100) <= 80)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
	}

});

