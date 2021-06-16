this.legends_debug_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_debug_party";
		this.m.Name = "(Developer Debug)";
		this.m.Description = "[p=c][img]gfx/ui/events/event_80.png[/img][/p]Debug mode for legends developers";
		this.m.Difficulty = 2;
		this.m.Order = 999;
		this.m.StashModifier = 2000;
	}

	function isValid()
	{
		return true;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local partysize = 2;
		local broLevelMax = 11;

		for( local i = 0; i < partysize; i = ++i )
		{
			local broLevel = broLevelMax
			local broPerks = broLevel - 1;
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.setStartValuesEx(["legend_crusader_commander_background"])//this.Const.CharacterBackgroundsRandom);
			bro.m.Level = broLevel;
			bro.m.LevelUps = broPerks;
			bro.m.PerkPoints = broPerks;
			bro.setVeteranPerks(2);
		}

		 local horsesize = 2;
		 for( local i = 0; i < horsesize; i = ++i )
		 {
		 	local broLevel = broLevelMax
		 	local broPerks = broLevel - 1;
		 	local bro;
		 	bro = roster.create("scripts/entity/tactical/player");
		 	bro.m.HireTime = this.Time.getVirtualTimeF();
		 	bro.setStartValuesEx(this.Const.HorseBackgrounds);
		 	bro.m.Level = broLevel;
		 	bro.m.LevelUps = broPerks;
		 	bro.m.PerkPoints = broPerks;
		 	bro.setVeteranPerks(2);
		 }

		this.World.Assets.getStash().resize(2000);

		local bros = roster.getAll();
		// bros[0].m.Skills.add(this.new("scripts/skills/injury/cut_arm_injury"));
		// bros[1].m.Skills.add(this.new("scripts/skills/injury/deep_chest_cut_injury"));

		this.World.Assets.m.Money = 50000;
		this.World.Assets.m.ArmorParts = 200;
		this.World.Assets.m.Medicine = 200;
		this.World.Assets.m.Ammo = 200;
		this.World.Assets.m.Food = 200;
		this.World.Assets.m.BusinessReputation = 1000;

		local banner = this.new("scripts/items/tools/player_banner");
		banner.setVariant(2);
		this.World.Assets.getStash().add(banner);
		local rune =  this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
		rune.setRuneVariant(5);
		rune.updateRuneSigilToken();
		this.World.Assets.getStash().add(rune);
	}

	function onSpawnPlayer()
	{
		local randomVillage;
		local northernmostY = 0;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			local v = this.World.EntityManager.getSettlements()[i];

			if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
			{
				northernmostY = v.getTile().SquareCoords.Y;
				randomVillage = v;
			}
		}

		randomVillage.setLastSpawnTimeToNow();
		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 2), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 2));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 2), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 2));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		local attachedLocations = randomVillage.getAttachedLocations();
		local closest;
		local dist = 99999;

		foreach( a in attachedLocations )
		{
			if (a.getTile().getDistanceTo(randomVillageTile) < dist)
			{
				dist = a.getTile().getDistanceTo(randomVillageTile);
				closest = a;
			}
		}

		if (closest != null)
		{
			closest.setActive(false);
			closest.spawnFireAndSmoke();
		}

		local s = this.new("scripts/entity/world/settlements/situations/raided_situation");
		s.setValidForDays(5);
		randomVillage.addSituation(s);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/civilians_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_random_party_scenario_intro");
		}, null);
	}

	function onBuildPerkTree( _tree)
	{
		if (_tree == null)
		{
			return;
		}

		// _tree[0].push(this.Const.Perks.PerkDefs.LegendPiercingShot);
		// _tree[0].push(this.Const.Perks.PerkDefs.LegendMedIngredients);
		// _tree[0].push(this.Const.Perks.PerkDefs.LegendCampCook);

		foreach (i, row in this.Const.Perks.HoundmasterClassTree.Tree)
		{
			foreach (p in row)
			{
				_tree[i].push(p)
			}
		}
	}

});

