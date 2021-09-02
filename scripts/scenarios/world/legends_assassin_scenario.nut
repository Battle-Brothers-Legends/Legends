this.legends_assassin_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_assassin";
		this.m.Name = "Assassin";
		this.m.Description = "[p=c][img]gfx/ui/events/event_51.png[/img][/p][p] A quick, efficient and ruthless assassin. You strike from the shadows and collect the rewards. \n\n[color=#bcad8c]Dirty Deeds:[/color] You will grant the Backstabber perk to anyone who joins you in battle. \n[color=#bcad8c]Underworld:[/color] You have a small chance of finding other Assassins for hire.\n[color=#bcad8c]Avatar:[/color] Begin alone. If you die, it is game over.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 20;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();

		local bro;
		bro = roster.create("scripts/entity/tactical/player");
		bro.setStartValuesEx([
			"legend_assassin_commander_background"
		]);
		bro.getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bro.getSkills().add(this.new("scripts/skills/perks/perk_backstabber"));
		bro.getSkills().add(this.new("scripts/skills/perks/perk_legend_hidden"));
		bro.m.PerkPointsSpent += 2;
		bro.setPlaceInFormation(4);
		bro.setVeteranPerks(2);
		bro.getFlags().set("IsPlayerCharacter", true);
		bro.getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
		this.World.Assets.m.Money = 1.5 * this.World.Assets.m.Money;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo;

	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 8), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 8));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 8), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 8));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 5)
				{
				}
				else if (!tile.HasRoad)
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
		this.World.Assets.updateLook(110);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_assassin_scenario_intro");
		}, null);

	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Assets.m.BrothersMax = 3;
		this.World.Flags.set("IsLegendsAssassin", true);
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

	function onUpdateDraftList( _list, _gender)
	{
		local r;
		r = this.Math.rand(0, 99);

		if (r == 0)
		{
			_list.push("assassin_background");
		}

		local r;
		r = this.Math.rand(0, 99);

		if (r == 0)
		{
			_list.push("assassin_southern_background");
		}

		local r;
		r = this.Math.rand(0, 9);

		if (r == 0)
		{
			_list.push("thief_background");
		}

		local r;
		r = this.Math.rand(0, 9);

		if (r == 0 && _gender)
		{
			_list.push("female_thief_background");
		}

		local r;
		r = this.Math.rand(0, 19);

		if (r == 0)
		{
			_list.push("killer_on_the_run_background");
		}

		local r;
		r = this.Math.rand(0, 19);

		if (r == 0)
		{
			_list.push("graverobber_background");
		}

		local r;
		r = this.Math.rand(0, 19);

		if (r == 0)
		{
			_list.push("gambler_background");
		}
	}

	function onUpdateHiringRoster( _roster )
	{
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (!bro.getBackground().isOutlawBackground())
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost  * 1.5);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 1.5);
			}
			else
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost  * 0.9);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 0.9);
			}
		}
	}

	function onHiredByScenario( bro )
	{
		if (!bro.getBackground().isLowborn() && !bro.getBackground().isOutlawBackground())
		{
			bro.worsenMood(1.0, "Is uncomfortable with joining an assassin");
		}
		else if (bro.getBackground().isCombatBackground() && bro.getBackground().isOutlawBackground())
		{
			bro.improveMood(1.0, "Is excited at becoming part of outlaw company");
		}
		bro.improveMood(0.5, "Learned a new skill");
		bro.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendSpecialistKnifeSkill, 1);
		bro.getBackground().addPerk(this.Const.Perks.PerkDefs.LegendSpecialistKnifeDamage, 3);
		bro.getSkills().add(this.new("scripts/skills/perks/perk_backstabber"));

	}

	function onBuildPerkTree( _tree )
	{
		if (_tree == null)
		{
			return;
		}

		_tree[0].push(this.Const.Perks.PerkDefs.Backstabber);
	}

});

