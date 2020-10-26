this.scenario_test_bed <- this.inherit("scripts/scenarios/tactical/scenario_template", {
	m = {},
	function generate()
	{
		this.logDebug("ScenarioTestBed::generate()");
		this.createStash();
		this.initMap();
		this.initEntities(6, 1);
		this.initStash();
		this.Tactical.getCamera().Level = 0;
	}

	function initMap()
	{
		local testMap = this.MapGen.get("tactical.desert");
		local minX = testMap.getMinX();
		local minY = testMap.getMinY();
		this.Tactical.resizeScene(minX, minY);
		testMap.fill({
			X = 0,
			Y = 0,
			W = minX,
			H = minY
		}, null);
		local locationTemplate = clone this.Const.Tactical.LocationTemplate;
		locationTemplate.Template[0] = "tactical.barbarian_camp";
		locationTemplate.Fortification = this.Const.Tactical.FortificationType.Palisade;
		locationTemplate.CutDownTrees = true;
		locationTemplate.ShiftX = 0;
	}

	function initEntities( _numPlayer, _numEnemy )
	{
		for( local i = 0; i < _numPlayer; i = ++i )
		{
			local x = 0;
			local y = 0;

			while (1)
			{
				x = this.Math.rand(2, 6);
				y = this.Math.rand(2, 6) - x / 2;

				if (this.Tactical.getTile(x, y).Level == 3)
				{
					continue;
				}

				if (this.Tactical.getTile(x, y).IsEmpty)
				{
					break;
				}
			}

			local entity = this.spawnEntity("scripts/entity/tactical/player", x, y);
			entity.setName(this.getRandomPlayerName());
			entity.setScenarioValues();
			local items = entity.getItems();
			local helmet = [
				[1, "oriental/southern_head_wrap"]
			]
			items.equip(this.Const.World.Common.pickHelmet(helmet));


			local r = this.Math.rand(1, 3);
			local a = this.new("scripts/items/armor/oriental/gladiator_harness");
			local u;
			r = this.Math.rand(1, 2);

			if (r == 1)
			{
				u = this.new("scripts/items/armor_upgrades/light_gladiator_upgrade");
			}
			else if (r == 2)
			{
				u = this.new("scripts/items/armor_upgrades/heavy_gladiator_upgrade");
			}

			a.setUpgrade(u);
			items.equip(a);
			items.equip(this.new("scripts/items/ammo/powder_bag"));
			items.equip(this.new("scripts/items/weapons/oriental/handgonne"));
		}

		local entity = this.spawnEntity("scripts/entity/tactical/enemies/orc_berserker");
		entity.setFaction(this.Const.Faction.Orcs);
		entity.assignRandomEquipment();
	}

	function spawnEntity( _script, _minX = 10, _maxX = 28, _minY = 3, _maxY = 28 )
	{
		local x = 0;
		local y = 0;

		while (1)
		{
			x = this.Math.rand(_minX, _maxX);
			y = this.Math.rand(_minY, _maxY) - x / 2;

			if (this.Tactical.getTile(x, y).Level == 3)
			{
				continue;
			}

			if (this.Tactical.getTile(x, y).IsEmpty)
			{
				break;
			}
		}

		return this.Tactical.spawnEntity(_script, x, y);
	}

	function initStash()
	{
		this.Stash.clear();
		this.Stash.resize(63);
		this.Stash.setLocked(true);
	}

});

