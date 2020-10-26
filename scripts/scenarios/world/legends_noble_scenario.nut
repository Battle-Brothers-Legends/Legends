this.legends_noble_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_noble";
		this.m.Name = "Noble";
		this.m.Description = "[p=c][img]gfx/ui/events/event_96.png[/img][/p][p]Born to a noble family, you were born to rule. With your trusted men at your side, it is time to conquer the world, as is your birthright.\n\n[color=#bcad8c]Usurper:[/color] Start as a noble, with your retainers a noble house that wants to hunt you down.\n[color=#bcad8c]Highborn:[/color] Noble and military recruits support your cause and will cost 10% less, anyone else will cost 10% more.\n[color=#bcad8c]Trained leader:[/color] Your studies at the academy gave tactical and campaign skills, everyone begins with Rotation.\n[color=#bcad8c]Avatar:[/color] if your character dies, it is game over.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 14;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}


	function onSpawnAssets()
	{

		this.World.Assets.m.BusinessReputation = 100;
		this.World.Assets.m.Money = this.World.Assets.m.Money * 3;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads())
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 7), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 7));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 7), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 7));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 4)
				{
				}
				else if (!tile.HasRoad || tile.Type == this.Const.World.TerrainType.Shore)
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
		this.World.Assets.updateLook(101);
		//this.World.State.m.Player.getSprite("body").setBrush("figure_player_noble");
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		local f = randomVillage.getFactionOfType(this.Const.FactionType.NobleHouse);
		f.addPlayerRelation(-100.0, "You picked the wrong faction");
		local banner = f.getBanner();
		local names = [];

		for( local i = 0; i < 6; i = ++i )
		{
			while (true)
			{
				local n = this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];

				if (names.find(n) == null)
				{
					names.push(n);
					break;
				}
			}
		}

		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 6; i = ++i )
		{
			local bro = roster.create("scripts/entity/tactical/player");
			bro.setPlaceInFormation(3 + i);

		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_noble_commander_background"
		]);
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].setPlaceInFormation(13);
		bros[0].setVeteranPerks(2);
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_2"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_4"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_rally_the_troops"));
		bros[1].setStartValuesEx([
		"legend_noble_shield"
		]);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		local r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/faction_kite_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/faction_heater_shield");
		}
		shield.setFaction(banner);
		items.equip(shield);
		bros[1].setPlaceInFormation(3);
		bros[1].setVeteranPerks(2);
		bros[1].getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
		bros[2].setStartValuesEx([
		"legend_noble_2h"
		]);

		bros[2].setPlaceInFormation(4);
		bros[2].setVeteranPerks(2);
		bros[2].getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
		bros[3].setStartValuesEx([
		"legend_noble_shield"
		]);
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		r = this.Math.rand(1, 2);
		local shield;

		if (r == 1)
		{
			shield = this.new("scripts/items/shields/faction_kite_shield");
		}
		else if (r == 2)
		{
			shield = this.new("scripts/items/shields/faction_heater_shield");
		}
		shield.setFaction(banner);
		items.equip(shield);
		bros[3].setPlaceInFormation(5);
		bros[3].setVeteranPerks(2);
		bros[3].getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
		bros[4].setStartValuesEx([
		"legend_noble_ranged"
		]);
		bros[4].setPlaceInFormation(12);
		bros[4].setVeteranPerks(2);
		bros[4].getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
		bros[5].setStartValuesEx([
		"legend_noble_ranged"
		]);
		bros[5].setPlaceInFormation(14);
		bros[5].setVeteranPerks(2);

		bros[5].getSkills().add(this.new("scripts/skills/perks/perk_rotation"));


		this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_rations_item"));

		if (this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{

			local brothers = this.World.getPlayerRoster().getAll();

			foreach( bro in brothers )
			{
				local items = bro.getItems();
				local armor = items.getItemAtSlot(this.Const.ItemSlot.Body)
				local tabards = [
						[0, ""],
						[1, "tabard/legend_noble_tabard"]
					]
					local tabard = this.Const.World.Common.pickLegendArmor(tabards)
					if (tabard != null && armor != null)
					{
						tabard.setVariant(banner)
						armor.setUpgrade(tabard)
					}
			}
		}

		//noble start actually doesnt go thru the generalized place for this and i'm too lazy to change it to do so because then i'd have to redo aarmor equips because there's no banner stuff etc
		// foreach (bro in this.World.getPlayerRoster().getAll())
		// {
		// 	bro.setCompanyID(this.World.State.addNewID(bro));
		// }


		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/retirement_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_noble_scenario_intro");
		}, null);
	}

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
		if (bro.getBackground().isNoble() || bro.getBackground().isCombatBackground())
		{
			bro.improveMood(0.5, "Supports your cause as a usurper, will cost less to maintain.");
		}
		else if (!bro.getBackground().isNoble() && !bro.getBackground().isCombatBackground())
		{
			bro.worsenMood(1.0, "Feels uncomfortable serving a usurper, will cost more to maintain.");
		}
		bro.improveMood(0.5, "Learned a new skill");
		bro.getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
	}

	function onUpdateHiringRoster( _roster )
	{
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (bro.getBackground().isNoble() || bro.getBackground().isCombatBackground())
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.9);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 0.75);
			}
			else if (!bro.getBackground().isNoble() && !bro.getBackground().isCombatBackground())
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost  * 1.25);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 1.25);

			}
		}
	}

	function onUpdateDraftList( _list, _gender)
	{


		local r;
		r = this.Math.rand(0, 3);
		if (r == 0)
		{
			_list.push("legend_noble_2h");
		}
		r = this.Math.rand(0, 3);
		if (r == 0)
		{
			_list.push("legend_noble_shield");
		}
		r = this.Math.rand(0, 3);
		if (r == 0)
		{
			_list.push("legend_noble_ranged");
		}
		r = this.Math.rand(0, 99);
		if (r == 0)
		{
			_list.push("legend_noble_background");
		}
	}

	function onBuildPerkTree( _tree)
	{
		if  (_tree == null)
		{
			return;
		}

		_tree[0].push(this.Const.Perks.PerkDefs.Rotation)
	}


});

