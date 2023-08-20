this.female_disowned_noble_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.female_disowned_noble";
		this.m.Name = "Disowned noblewoman";
		this.m.Icon = "ui/backgrounds/background_08.png";
		this.m.BackgroundDescription = "Disowned nobles often have profited from some training in melee fighting at court.";
		this.m.GoodEnding = "A noble at heart, the disowned nobleman %name% returned to her family. Word has it she kicked in the doors and demanded a royal seat. An usurper challenged her in combat and, well, %name% learned a lot in her days with the %companyname% and she now sits on a very, very comfortable throne.";
		this.m.BadEnding = "A woman of nobility at heart, %name% the disowned noble returned to her family home. Word has it an usurper arrested her at the gates. Her head currently rests on a pike with crows for a crown.";
		this.m.HiringCost = 160;
		this.m.DailyCost = 18;
		this.m.Excluded = [
			"trait.teamplayer",
			"trait.clumsy",
			"trait.spartan",
			"trait.clubfooted",
			"trait.hate_nobles"
		];
		this.m.Titles = [
			"the Disowned",
			"the Exiled",
			"the Disgraced"
		];
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Level = this.Math.rand(1, 3);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Noble | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Educated;
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.BowTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.TrainedTree
			],
			Enemy = [
				this.Const.Perks.ArchersTree
				],
			Class = [],
			Magic = []
		}
	}




	function onBuildDescription()
	{
		return "{A constant disappointment to a delusional father | A victim of court intrigue involving poison and cake | After openly denouncing her own heritage | After an incestous relationship with her brother came to light | After a coup to dispose her older sister failed | After pride and hubris had her leading her father\'s army to total defeat | For accidentally killing her oldest brother and heir to the throne on a hunt | As a price to be paid for choosing her allies poorly in a war of succession | For attempting to sell captured poachers as slaves | Caught bedding a fellow noblewoman | Discovered to be the head of a child stealing plot that shocked the peasantry | For turning her back on the gods and causing a riot amongst the laymen | Seen with the cultists\' book of Davkul tucked under an arm}, %name% {was disowned and cast away from her family\'s estate, never to return. | was stripped of her titles and exiled from the land. | was forcibly removed from her land and told never to return. | came to see, by the threat of an executioner\'s axe, that she no longer belonged in the court. | saw the hangman\'s noose, and only by a clever ploy did she slip it. | was branded with the symbol of shame and cast out from her lands. | was believed to have been involved in one too many conspiracies and was removed from the lands. | was seen as being too ambitious, a dangerous trait amongst the nobility.} {%name% now seeks to redeem herself and live up to the family name. A bit selfish for a mercenary outfit, noble nonetheless. | Her posture slumped by scandal, %name%\'s resistance to difficulties has diminished. | A skilled fighter she may be, but %name% rarely talks about anyone but herself. | Though quick with a sword, you get the feeling someone like %name% was disowned for a reason. | Down on her luck and essentially broke, %name% ventures in the field of sellswords. | Without title or land, %name% seeks to join the sort of men she used to lord over. | Well-geared this former noble may be, you do notice that the most used piece of equipment %name% has are her boots.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-7,
				-2
			],
			Bravery = [
				-6,
				-1
			],
			Stamina = [
				5,
				-5
			],
			MeleeSkill = [
				0,
				10
			],
			RangedSkill = [
				5,
				15
			],
			MeleeDefense = [
				-3,
				2
			],
			RangedDefense = [
				0,
				5
			],
			Initiative = [
				-5,
				5
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/arming_sword"));
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}


		items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_leather"],
			[1, "gambeson"],
			[1, "basic_mail_shirt"],
			[1, "mail_shirt"],
			[1, "mail_hauberk"]
		]))

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "nasal_helmet"],
			[1, "padded_nasal_helmet"],
			[1, "aketon_cap"],
			[1, "full_aketon_cap"],
			[1, "mail_coif"],
			[1, "feathered_hat"],
			[3, ""]
		]));
	}

});
