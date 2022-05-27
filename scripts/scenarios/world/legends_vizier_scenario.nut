this.legends_vizier_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_vizier";
		this.m.Name = "Vizier";
		this.m.Description = "[p=c][img]gfx/ui/events/event_96.png[/img][/p][p]The Sands shift as the Gilder moves; a movement which requires a superb guide as excellent as yourself. With such opulence and purity as you carry, you set out upon the shaken sands in search of the Gilder\'s path..\n\n[color=#bcad8c]Vizionary:[/color] Start as a resented Vizier, followed by a retinue of like-minded radicals.\n[color=#bcad8c]Highborn:[/color] Noble\'s will cost 25% less, lowborns will cost 50% more, can\'t hire outlaws\n[color=#bcad8c]Trained leader:[/color] Your studies at the academy gave tactical and campaign skills, everyone begins with Rotation.\n[color=#bcad8c]Avatar:[/color] if your character dies, it is game over.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 170;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 6; i = i )
		{
			local bro = roster.create("scripts/entity/tactical/player");
			bro.getSkills().add(this.new("scripts/skills/perks/perk_rotation"));

			if (i != 0)
			{
				bro.fillTalentValues(3);
			}

			i = ++i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
			i = i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_vizier_commander_background"
		], false);
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].setPlaceInFormation(13);
		bros[0].setVeteranPerks(2);
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_2"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_4"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_rally_the_troops"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/drunkard_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/traits/legend_noble_killer_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/effects_world/drunk_effect"));
		bros[1].setStartValuesEx([
			"legend_conscript"
		], false);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		local r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/oriental/metal_round_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/oriental/southern_light_shield");
		}

		items.equip(shield);
		bros[1].getBackground().m.RawDescription = "Though a lowly foot soldier %name% has one of the most upbeat outlooks on life you\'ve ever encountered. Unfortunately that extends to an over evaluation of self worth, expecting more pay than most.";
		bros[1].getBackground().buildDescription(true);
		bros[1].getSkills().add(this.new("scripts/skills/traits/optimist_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/traits/determined_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/traits/greedy_trait"));
		bros[1].setPlaceInFormation(3);
		bros[1].setVeteranPerks(2);
		bros[2].setStartValuesEx([
			"legend_officer"
		], false);
		bros[2].getBackground().m.RawDescription = "%name% is a hulking figure, both upward and outward. Not much of a talker, but a big eater.";
		bros[2].getBackground().buildDescription(true);
		bros[2].getSkills().removeByID("trait.tiny");
		bros[2].getSkills().add(this.new("scripts/skills/traits/huge_trait"));
		bros[2].getSkills().add(this.new("scripts/skills/traits/fat_trait"));
		bros[2].getSkills().add(this.new("scripts/skills/traits/gluttonous_trait"));
		bros[2].setPlaceInFormation(4);
		bros[2].setVeteranPerks(2);
		bros[3].setStartValuesEx([
			"legend_conscript"
		], false);
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/oriental/metal_round_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/oriental/southern_light_shield");
		}

		items.equip(shield);
		bros[3].getBackground().m.RawDescription = "%name%\'s parents both served your family, it runs in the blood. While %name% is dependable in a fight and would never dream of leaving you, it also reduces their %name%\'s ambition and drive";
		bros[3].getBackground().buildDescription(true);
		bros[3].getSkills().add(this.new("scripts/skills/traits/pragmatic_trait"));
		bros[3].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[3].getSkills().add(this.new("scripts/skills/traits/slack_trait"));
		bros[3].setPlaceInFormation(5);
		bros[3].setVeteranPerks(2);
		bros[4].setStartValuesEx([
			"legend_engineer"
		], false);
		bros[4].getBackground().m.RawDescription = "%name% has been a servant in your family for 5 generations now, it is unclear how anyone has survived this long, but there are no indications of the old coot giving up any time soon.";
		bros[4].getBackground().buildDescription(true);
		bros[4].getSkills().add(this.new("scripts/skills/traits/old_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/loyal_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/lucky_trait"));
		bros[4].getSkills().add(this.new("scripts/skills/traits/survivor_trait"));
		bros[4].setPlaceInFormation(12);
		bros[4].setVeteranPerks(2);
		items.equip(this.new("scripts/items/supplies/legend_pudding_item"));
		items.addToBag(this.new("scripts/items/supplies/wine_item"));
		bros[5].setStartValuesEx([
			"legend_gunner"
		], false);
		bros[5].getBackground().m.RawDescription = "%name% has one the house archery contest several years running, but never shuts up about it. The constant stream of narration, makes the great aim easy to dodge.";
		bros[5].getBackground().buildDescription(true);
		bros[5].getSkills().add(this.new("scripts/skills/traits/sureshot_trait"));
		bros[5].getSkills().add(this.new("scripts/skills/traits/teamplayer_trait"));
		bros[5].getSkills().add(this.new("scripts/skills/traits/predictable_trait"));

		if (bros[5].getBaseProperties().RangedSkill <= 60)
		{
			bros[5].getBaseProperties().RangedSkill += 5;
		}

		bros[5].setPlaceInFormation(14);
		bros[5].setVeteranPerks(2);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_rations_item"));
		this.World.Assets.m.BusinessReputation = 100;
		this.World.Assets.m.Money = this.World.Assets.m.Money * 3;
	}

function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isIsolatedFromRoads() && randomVillage.isSouthern())
			{
				break;
			}

			i = ++i;
			i = i;
			i = i;
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

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

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(13);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/worldmap_11.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.southern_quickstart_scenario_intro");
		}, null);
	}

});
	function onCombatFinished()
	{
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				return true;
			}
		}

		return false;
	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Assets.m.BrothersMax = 6;
		this.World.Flags.set("IsLegendsNoble", true);
	}

	function onHiredByScenario( bro )
	{
		if (bro.getBackground().isNoble())
		{
			bro.improveMood(0.5, "Supports your cause as a usurper, will cost less to maintain.");
		}
		else if (!bro.getBackground().isLowborn())
		{
			bro.worsenMood(0.5, "Resents you as nobility, will try to squeeze money from you.");
		}

		bro.improveMood(0.5, "Learned a new skill");
		bro.getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (bro.getBackground().isNoble())
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 0.75);
			}
			else if (!bro.getBackground().isLowborn())
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.5);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 1.5);
			}

			if (bro.getBackground().isOutlawBackground())
			{
				garbage.push(bro);
			}
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

	function onUpdateDraftList( _list, _gender )
	{
		local r;
		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			_list.push("legend_officer");
		}

		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			_list.push("legend_conscript");
		}

		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			_list.push("legend_gunner");
		}

		r = this.Math.rand(0, 19);

		if (r == 0)
		{
			_list.push("legend_noble_background");
		}
	}

	function onUpdateHiringRoster( _roster )
	{
	}

	function onBuildPerkTree( _tree )
	{
		if (_tree == null)
		{
			return;
		}

		_tree[0].push(this.Const.Perks.PerkDefs.Rotation);
	}

});

