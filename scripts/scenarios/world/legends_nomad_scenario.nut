this.legends_nomad_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_nomad";
		this.m.Name = "Nomad Tribe";
		this.m.Description = "[p=c][img]gfx/ui/events/event_170.png[/img][/p][p]Displaced from your land, take control of 4 nomads and a conscript hunted in the desert. \n[color=#bcad8c]Hunted:[/color] Start in the desert away from civilisation. City States are hostile and will always decline in favour with you while Northern Nobles will have a cold relationship with you but will not decline. The more nomads in your party the stronger this effect will be.\n[color=#bcad8c]Nomadic:[/color] Vision radius is increased by 30% on the world map. Settlements may contain Nomads and Bladedancers displaced from their lands willing to fight for you.\n[color=#bcad8c]The Path of the Interloper:[/color] Nomads and Muladis gain the \'Wind Reader\' perk when recruited. Bladedancers gain the \'Dodge\' perk. Other Nomads are friendly to you.[/p]"; 
		this.m.Difficulty = 2;
		this.m.Order = 181;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(5);
		// this.m.RosterTierMax = this.Const.Roster.getTierForSize(22);
		this.m.StartingBusinessReputation = -50;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 5; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll(); //composed of: 1 combat wildcard | 1 elite (ranged) | 1 ranged | 2 melee

		bros[0].setPlaceInFormation(2);
		bros[0].setVeteranPerks(2);
		bros[0].getSprite("socket").setBrush("bust_base_nomads");
		bros[0].getSkills().add(this.new("scripts/skills/traits/nomad_trait"));
		bros[0].getBackground().m.RawDescription = "{%name% is someone who you have known since they were a child. They always had a keen eye but had more interest in shooting things point blank with their sling instead. Their discovery of maces and swords changed their world for the better.}";
		bros[0].setStartValuesEx([ // melee
			"nomad_background"
		]);
		
		bros[1].setPlaceInFormation(3);
		bros[1].setVeteranPerks(2);
		bros[1].getSprite("socket").setBrush("bust_base_nomads");
		bros[1].getSkills().add(this.new("scripts/skills/traits/nomad_trait"));
		bros[1].getBackground().m.RawDescription = "{%name% came from another tribe that merged with yours not too long ago. Their family was butched in the night by \'skin men\' who could travel thirty paces in a blink of the eye. While many think them unsettled by what appears to be a raid, you can\'t help but notice how they always sleep closest to the fire every night.}";
		bros[1].setStartValuesEx([ //melee always to prevent all ranged parties
			"nomad_background"
		]);

		bros[2].setPlaceInFormation(4);
		bros[2].setVeteranPerks(2);
		bros[2].getSkills().add(this.new("scripts/skills/effects_world/exhausted_effect"));
		bros[2].getBackground().m.RawDescription = "{This outsider was close to death when you found them in the sands. While they lack the mindset and resolve you have come to expect from others, their training from the City States makes %them% a useful weapon to use against them.}";
		bros[2].setStartValuesEx([ ///elite for story purposes. Always ranged. No benefit from nomad trait.
			"legend_conscript_ranged_background"
		]);

		bros[3].setPlaceInFormation(11);
		bros[3].setVeteranPerks(2);
		bros[3].getSprite("socket").setBrush("bust_base_nomads");
		bros[3].getSkills().add(this.new("scripts/skills/traits/nomad_trait"));
		bros[3].getBackground().m.RawDescription = "{You know little about %name%, they prefer to stay quiet and keep to themselves. However their loyalty to the tribe has never come into question.}";
		bros[3].setStartValuesEx([ //wildcard 1
			"nomad_background",
			"nomad_ranged_background"
		]);

		bros[4].setPlaceInFormation(12);
		bros[4].setVeteranPerks(2);
		bros[4].getSprite("socket").setBrush("bust_base_nomads");
		bros[4].getSkills().add(this.new("scripts/skills/traits/nomad_trait"));
		bros[4].getBackground().m.RawDescription = "{Be it rabbit, snake or hyena - little stands a chance against %name% who readily hits their target with all the same precision. The change to conscripts over wildlife came as a challange at first until they realised they just needed to aim slightly lower than normal.}";
		bros[4].setStartValuesEx([ //always ranged for variety
			"nomad_ranged_background"
		]);

		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/dried_lamb_item"));
		// this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 5);
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine * 1.5;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo * 3;
	}

	function onSpawnPlayer()
	{
		local spawnTile;
		local settlements = this.World.EntityManager.getSettlements();
		local nearestVillage;
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(5, this.Const.World.Settings.SizeX - 5);
			local y = this.Math.rand(5, this.Const.World.Settings.SizeY - 5);

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}
				else if (tile.Type != this.Const.World.TerrainType.Desert && tile.Type != this.Const.World.TerrainType.DesertHills)
				{
				}
				else
				{
					local next = true;

					foreach( s in settlements )
					{
						local d = s.getTile().getDistanceTo(tile);

						if (d > 6 && d < 15)
						{
							local path = this.World.getNavigator().findPath(tile, s.getTile(), navSettings, 0);

							if (!path.isEmpty())
							{
								next = false;
								nearestVillage = s;
								break;
							}
						}
					}

					if (next)
					{
					}
					else
					{
						spawnTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		local oriental = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

		foreach( n in oriental )
		{
			n.addPlayerRelation(-100.0, "You are an outlaw to the City States");
		}

		local orientalbandits = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalBandits);

		foreach( n in orientalbandits )
		{
			n.addPlayerRelation(100.0, "You walk the same path, but should not be seeing this message");
		}

		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

		foreach( n in nobles )
		{
			n.addPlayerRelation(-30.0, "You are considered an outlaw");
		}

		this.m.StaticRelationsToFaction[this.Const.FactionType.OrientalCityState] = true;
		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		// this.World.Assets.updateLook(8);
		this.World.State.m.Player.getSprite("body").setBrush("figure_nomad_03"); // World map look, could be 01 (there is no '02')
		this.World.State.m.Player.getSprite("body").setHorizontalFlipping(true); // Flip world map look
		this.World.State.m.Player.setSpriteOffset("body", this.createVec(4, 0)) // x axis, y axis. Postive values move left, negative values move right.
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/gilded_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legends_nomad_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();

		if (this.World.State.getPlayer() != null)
		{											 //+30%
			this.World.State.getPlayer().m.VisionRadius = 670; //500 is default during daytime on normal terrain
		}
	}

	function onUpdateDraftList( _list, _gender = null )
	{
	}

	function onHiredByScenario( bro )
	{								//also contains nomad_ranged
		if (bro.getBackground().getID() == "background.nomad" || bro.getBackground().getID() == "background.muladi")
		{
			bro.improveMood(1.5, "I walk with those on the path of the Interloper");
			bro.getSkills().add(this.new("scripts/skills/traits/nomad_trait"));
			bro.getSprite("socket").setBrush("bust_base_nomads");
			bro.getSkills().add(this.new("scripts/skills/perks/perk_legend_wind_reader"));
		}
		else if (bro.getBackground().getID() == "background.bladedancer")
		{
			bro.improveMood(1.5, "I walk with those on the path of the Interloper");
			bro.getSkills().add(this.new("scripts/skills/traits/nomad_trait"));
			bro.getSprite("socket").setBrush("bust_base_nomads");
			bro.getSkills().add(this.new("scripts/skills/perks/perk_dodge"));
		}
		else
		{
			bro.worsenMood(2.0, "Nomadic life isn\'t for me...");
		}
	}

	function onGenerateBro(bro)
	{
	}

	function onUpdateHiringRoster( _roster )
	{
		local bros = _roster.getAll();
		this.addBroToRoster(_roster, "nomad_background", 4);
		this.addBroToRoster(_roster, "nomad_ranged_background", 4);
		this.addBroToRoster(_roster, "legend_bladedancer_background", 8);
	}
});
