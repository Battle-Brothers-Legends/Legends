this.legend_undead_legionnaire_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_undead_legionnaire";
		this.m.Name = "Undead Legionnaire";
		this.m.Icon = "ui/backgrounds/background_skelemancer.png";
		//gender neutral description
		this.m.BackgroundDescription = "An undead legionnaire armed with ancient but deadly weaponry.";
		this.m.GoodEnding = "%name% returned to the ground, and will one day rise under a new commander.";
		this.m.BadEnding = "%name% was found and destroyed by a group of peasants. No bones were left to reanimate.";
		this.m.HiringCost = 30;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.hate_undead",
			"trait.clubfooted",
			"trait.fat",
			"trait.insecure",
			"trait.dastard",
			"trait.craven",
			"trait.asthmatic"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.Level = 1;
		this.m.IsCombatBackground = true;
		this.m.IsLowborn = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SpearTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.ShieldTree
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.AgileTree
			],
			Enemy = [
				this.Const.Perks.BanditTree,
				this.Const.Perks.BarbarianTree
			],
			Class = [this.Const.Perks.MilitiaClassTree],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		local r = _gender;
		if (_gender == -1)
		{
			r = this.Math.rand(0, 9);
			if (this.World.LegendsMod.Configs().LegendGenderEnabled())
			{
				r = this.Math.rand(0, 1);
			}
		}

		if (r != 1)
		{
			return;
		}
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Beards = null;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.IsFemaleBackground = true;
	}

	function onBuildDescription()
	{
		//removed one gender specific sentence - now it is neutral
		return "{A militia recruit like %name% is only raised in times of need. | Broke and without work, %name% joined the local militia. | Caught stealing an apple, %name% was pressed into the militia as a form of punishment. | Although a member of the peasantry, %name% was always willing to join the militia and protect the homestead. | War is a hungry beast - militia conscripts like %name% are what feed it.} {While %name% got proper training, there was rarely enough food to go around for the \'second-rate soldiers\'. | %name% fought just as hard as the professionals, but was unable to garner any sort of respect for the work. | Being the bottom rung of soldiering, quickly makes it clear that your life is expendable. | %name%\'s weapons were rusted and the armor nonexistent. Unfortunately, enemies were not so kindly under-equipped.} {After a year of traipsing around with shoddy gear, %name% decided to look for something a bit more welcoming: sellswords. | Years in an outfit where %name% couldn\'t depend on the solider beside, drove %name% to find something better. Perhaps not the best soldier you\'ve ever seen, but earnest. | When the local militia was disbanded, %name% returned home to find the town had been burned to the ground. One foot already in the door, it only made sense to join one of the numerous mercenary bands roaming the land. | %name%\'s modest military garb belies one who has seen their fair share of training and combat.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				3,
				5
			],
			Stamina = [
				3,
				5
			],
			MeleeSkill = [
				5,
				5
			],
			RangedSkill = [
				6,
				5
			],
			MeleeDefense = [
				2,
				2
			],
			RangedDefense = [
				2,
				2
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();


		local actor = this.getContainer().getActor();
		actor.getFlags().add("PlayerSkeleton");
		actor.getFlags().add("undead");
		actor.getFlags().add("skeleton");

		actor.getSkills().add(this.new("scripts/skills/traits/legend_deathly_spectre_trait"));
		actor.getSkills().add(this.new("scripts/skills/racial/skeleton_racial"));
		actor.getSkills().add(this.new("scripts/skills/injury_permanent/legend_fleshless"));
		if (this.Math.rand(0, 4) == 4)
		{
			actor.setTitle(this.Const.Strings.MilitiaTitles[this.Math.rand(0, this.Const.Strings.MilitiaTitles.len() - 1)]);
		}

	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		local weapons = [
			"weapons/hooked_blade",
			"weapons/bludgeon",
			"weapons/hand_axe",
			"weapons/militia_spear",
			"weapons/shortsword"
		];

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/warfork"
			]);
		}

		items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 50)
		{
			items.equip(this.new("scripts/items/shields/buckler_shield"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_lamellar"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/gambeson"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}


		items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "aketon_cap"],
			[1, "full_aketon_cap"],
			[1, "open_leather_cap"],
			[1, "full_leather_cap"],
			[1, "straw_hat"]
		]));

	}

	function onAddLegendEquipment()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		items.equip(this.new("scripts/items/shields/ancient/tower_shield"));

		local cloths = [
			[0, ""],
			[1, "cloth/legend_sackcloth"],
			[1, "cloth/legend_sackcloth_patched"],
			[1, "cloth/legend_sackcloth_tattered"],
			[10, "cloth/legend_ancient_cloth"],
			[10, "cloth/legend_ancient_cloth_restored"],
			[0, "cloth/legend_tunic"],
			[0, "cloth/legend_tunic_noble"]
		];
		local armor = this.Const.World.Common.pickLegendArmor(cloths)

		local plates = [
				[0, ""],
				[0, "plate/legend_armor_leather_brigandine"],
				[0, "plate/legend_armor_leather_brigandine_hardened"],
				[0, "plate/legend_armor_leather_brigandine_hardened_full"],
				[0, "plate/legend_armor_leather_jacket"],
				[0, "plate/legend_armor_leather_jacket_simple"],
				[0, "plate/legend_armor_leather_lamellar"],
				[0, "plate/legend_armor_leather_lamellar_harness_heavy"],
				[0, "plate/legend_armor_leather_lamellar_harness_reinforced"],
				[0, "plate/legend_armor_leather_lamellar_heavy"],
				[0, "plate/legend_armor_leather_lamellar_reinforced"],
				[0, "plate/legend_armor_leather_noble"],
				[0, "plate/legend_armor_leather_padded"],
				[0, "plate/legend_armor_leather_riveted"],
				[0, "plate/legend_armor_leather_riveted_light"],
				[0, "plate/legend_armor_leather_scale"],
				[1, "plate/legend_armor_plate_ancient_gladiator"],
				[1, "plate/legend_armor_plate_ancient_chest"],
				[1, "plate/legend_armor_plate_ancient_chest_restored"],
				[1, "plate/legend_armor_plate_ancient_harness"],
				[1, "plate/legend_armor_plate_ancient_mail"],
				[1, "plate/legend_armor_plate_ancient_scale"],
				[1, "plate/legend_armor_plate_ancient_scale_coat"],
				[1, "plate/legend_armor_plate_ancient_scale_harness"],
				[0, "plate/legend_armor_plate_chest"],
				[0, "plate/legend_armor_plate_chest_rotten"],
				[0, "plate/legend_armor_plate_cuirass"],
				[0, "plate/legend_armor_plate_full"],
				[0, "plate/legend_armor_scale"],
				[0, "plate/legend_armor_scale_coat"],
				[0, "plate/legend_armor_scale_coat_rotten"],
				[0, "plate/legend_armor_scale_shirt"]
		]
		local plate = this.Const.World.Common.pickLegendArmor(plates)
		if (plate != null)
		{
			armor.setUpgrade(plate)
		}
		items.equip(armor);

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "ancient/legend_ancient_legionary_helmet_restored"],
			[1, "ancient/ancient_legionary_helmet"]
		]));
	}

});

