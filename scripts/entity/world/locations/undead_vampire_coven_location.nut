this.undead_vampire_coven_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "Hidden for centuries, this ancient place became a safe haven for a coven of hemovores.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.undead_vampire_coven";
		this.m.LocationType = this.Const.World.LocationType.Lair;
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.Vampires);
		}
		else if (r == 2)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.VampiresAndSkeletons);
		}

		this.m.Resources = 250;
		this.m.RoamerSpawnList = this.Const.World.Spawn.Vampires;
	}

	function onSpawned()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.VampireCoven);
		this.location.onSpawned();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropFood(this.Math.rand(1, 3), [
			"strange_meat_item",
			"wine_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(2, 4), [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item"
		], _lootTable);
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_vampire_coven");
	}

});
