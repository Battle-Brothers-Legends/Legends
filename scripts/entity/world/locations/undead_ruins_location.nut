this.undead_ruins_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "A once proud fortress now lying in ruins.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.undead_ruins";
		this.m.LocationType = this.Const.World.LocationType.Lair | this.Const.World.LocationType.Passive;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.ZombiesAndGhosts);
		}
		else if (r == 2)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.ZombiesAndGhouls);
		}
		else if (r == 3)
		{
			this.setDefenderSpawnList(this.Const.World.Spawn.Necromancer);
		}

		this.m.Resources = 180;
	}

	function onSpawned()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.Ruins);
		this.location.onSpawned();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		local treasure = [
			"loot/silver_bowl_item",
			"loot/gemstones_item",
			"loot/signet_ring_item",
			"loot/signet_ring_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item",
			"loot/golden_chalice_item"
		];

		if (this.Const.DLC.Unhold)
		{
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.push("armor_upgrades/metal_plating_upgrade");
			treasure.push("armor_upgrades/metal_pauldrons_upgrade");
			treasure.push("armor_upgrades/mail_patch_upgrade");
			treasure.push("armor_upgrades/leather_shoulderguards_upgrade");
			treasure.push("armor_upgrades/leather_neckguard_upgrade");
			treasure.push("armor_upgrades/joint_cover_upgrade");
			treasure.push("armor_upgrades/heraldic_plates_upgrade");
			treasure.push("armor_upgrades/double_mail_upgrade");
		}

		this.dropMoney(this.Math.rand(0, 200), _lootTable);
		this.dropTreasure(this.Math.rand(2, 3), treasure, _lootTable);
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_ruins_0" + this.Math.rand(1, 3));
	}

});

