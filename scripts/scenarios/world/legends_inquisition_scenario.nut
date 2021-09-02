this.legends_inquisition_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_inquisition";
		this.m.Name = "The Inquisition";
		this.m.Description = "[p=c][img]gfx/ui/events/event_40.png[/img][/p]There is a great evil in the world, the undead walk the earth and cultists hide in every town. The holy must purge the filth. \n\n[color=#bcad8c]Righteous Cause:[/color] Cannot recruit outlaw backgrounds; however, the pious will flock to join your cause. \n[color=#bcad8c]Penitence:[/color] Anyone you hire gains the Mind over Body perk.\n";
		this.m.Difficulty = 2;
		this.m.Order = 280;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
	local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"flagellant_background"
		]);
		bros[0].getBackground().m.RawDescription = "{%name% has no greater joy than suffering in the name of the old gods. Pain and pleasure and intimately linked, just as creation and desctruction are intwined. Each lash of the whip is like the caress of an angel, and their belief is that in only through suffering can we find salvation. Few laymen understand this viewpoint, but it is respected by other servants of the old gods.}";
		bros[0].setPlaceInFormation(4);
		bros[0].setVeteranPerks(2);
		bros[0].getBaseProperties().Hitpoints += 10;
		bros[0].getBaseProperties().MeleeDefense += 5;
		bros[0].getSkills().add(this.new("scripts/skills/traits/legend_inquisition_disciple_trait"));
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
		bros[0].m.PerkPointsSpent += 1;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.Const.World.Common.pickHelmet([[1, "barbarians/leather_helmet"]]));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 3;
		talents[this.Const.Attributes.Hitpoints] = 3;
		bros[0].fillTalentValues(1, true);
		bros[1].setStartValuesEx([
			"witchhunter_background"
		]);

		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 3;
		talents[this.Const.Attributes.RangedSkill] = 3;
		bros[1].fillTalentValues(1, true);
		bros[1].getBaseProperties().RangedSkill += 5;
		bros[1].getBaseProperties().Bravery += 10;
		bros[1].getBackground().m.RawDescription = "{%name% has seen well the damage magic can bring to the world. The witches who steal the minds of men, the nightmares that end lives, and the necromancers who bring them back again. Hunting these foul creatures is the duty of all who serve the good of the gods. If the war is to be won, %name% will need a witch hunter army.}";
		bros[1].improveMood(1.0, "Recently purged the unworthy");
		bros[1].setPlaceInFormation(3);
		bros[1].m.PerkPoints = 1;
		bros[1].m.LevelUps = 1;
		bros[1].m.Level = 2;
		bros[1].setVeteranPerks(2);
		bros[1].getSkills().add(this.new("scripts/skills/traits/legend_undead_killer_trait"));
		bros[1].getSkills().add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
		bros[1].m.PerkPointsSpent += 1;

		bros[2].setStartValuesEx([
			"legend_nun_background"
		]);
		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 3;
		bros[2].fillTalentValues(1, true);
		bros[2].getBaseProperties().Hitpoints += 10;
		bros[2].getBaseProperties().MeleeSkill += 5;
		bros[2].getBackground().m.RawDescription = "{%name% is a huge figure, who spent many years in a temple healing and carrying the sick, learning the power of both strength and compassion. It was clear the ills of the world must be sought out and healed at their source. While healing a witch hunter, %name% was convinced to join the hunt to heal the world. }";
		bros[2].setPlaceInFormation(5);
		local heavy = this.new("scripts/skills/traits/heavy_trait");
		foreach(skill in heavy.m.Excluded)
		{
			bros[2].getSkills().removeByID(skill);
		}
		bros[2].getSkills().add(heavy);
		bros[2].getSkills().add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
		bros[2].m.PerkPointsSpent += 1;
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		local shield = this.new("scripts/items/shields/heater_shield");
		shield.onPaintSpecificColor(23);
		items.equip(shield);
		local cloths = [
			[1, "cloth/legend_robes_nun"]
		];
		local armor = this.Const.World.Common.pickLegendArmor(cloths)

		if (armor != null)
		{
			local chains = [
                [1, "chain/legend_armor_mail_shirt"],
				[1, "chain/legend_armor_mail_shirt_simple"],
				[1, "chain/legend_armor_short_mail"]
			]
			local chain = this.Const.World.Common.pickLegendArmor(chains)
			if (chain != null)
			{
				armor.setUpgrade(chain)
			}

			local plates = [
				[1, "plate/legend_armor_leather_jacket"],
				[1, "plate/legend_armor_leather_jacket_simple"]
			]
			local plate = this.Const.World.Common.pickLegendArmor(plates)
			if (plate != null)
			{
				armor.setUpgrade(plate)
			}
			local tabards = [
						[0, ""],
						[1, "tabard/legend_common_tabard"]
					]
			local tabard = this.Const.World.Common.pickLegendArmor(tabards)
			if (tabard != null && armor != null)
			{
				tabard.setVariant(113)
				armor.setUpgrade(tabard)
			}
			items.equip(armor);
		}
		if (this.LegendsMod.Configs().LegendArmorsEnabled())
		{
			foreach( bro in bros )
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
						tabard.setVariant(102)
						armor.setUpgrade(tabard)
					}
			}
		}

		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		//this.World.Assets.getStash().add(this.new("scripts/items/accessory/legend_wolfsbane_necklace_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/tools/holy_water_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_wooden_stake"))
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_wooden_stake"));
		this.World.Assets.getStash().add(this.new("scripts/items/weapons/legend_wooden_stake"));
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 1), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 1));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 1), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 1));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) == 0)
				{
				}
				else if (!tile.HasRoad)
				{
				}
				else
				{
					randomVillageTile = tile;
					break;
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(113);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/noble_02.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_inquisition_scenario_intro");
		}, null);

	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.Assets.m.BrothersMax = 25;

	}


	function onHiredByScenario( bro )
	{
		if (bro.getBackground().isCrusaderRecruitBackground())
		{
			bro.improveMood(1.0, "Joined a righteous cause");
		}
		else
		{
			bro.worsenMood(1.0, "Dislikes your sermons");
		}
		bro.improveMood(0.5, "Learned a new skill");
		bro.getSkills().add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (bro.getBackground().isCrusaderRecruitBackground())
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 0.75);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 0.75);

			}
			else
			{
				bro.m.HiringCost = this.Math.floor(bro.m.HiringCost * 1.25);
				bro.getBaseProperties().DailyWage = this.Math.floor(bro.getBaseProperties().DailyWage * 1.25);
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

	function onBuildPerkTree( _tree)
	{
		if  (_tree == null)
		{
			return;
		}

		_tree[0].push(this.Const.Perks.PerkDefs.LegendMindOverBody);
	}

	function onUpdateDraftList( _list, _gender)
	{
		if (_list.len() < 5)
		{
			local r;
			r = this.Math.rand(0, 2);
			if (r == 0)
			{
			_list.push("flagellant_background");
			}
			r = this.Math.rand(0, 4);
			if (r == 0)
			{
			_list.push("monk_background");
			}
			r = this.Math.rand(0, 6);
			if (r == 0 && _gender)
			{
			_list.push("legend_nun_background");
			}
			r = this.Math.rand(0, 8);
			if (r == 0)
			{
				_list.push("witchhunter_background");
			}
			r = this.Math.rand(0, 49);
			if (r == 0)
			{
				_list.push("legend_crusader_background");
			}
		}
		if (_list.len() >= 5)
		{
			local r;
			r = this.Math.rand(0, 2);
			if (r == 0)
			{
				_list.push("flagellant_background");
			}
			r = this.Math.rand(0, 3);
			if (r == 0)
			{
				_list.push("monk_background");
			}
			r = this.Math.rand(0, 4);
			if (r == 0 && _gender)
			{
				_list.push("legend_nun_background");
			}
			r = this.Math.rand(0, 5);
			if (r == 0)
			{
				_list.push("witchhunter_background");
			}
			r = this.Math.rand(0, 19);
			if (r == 0)
			{
				_list.push("legend_crusader_background");
			}
		}
	}

});

