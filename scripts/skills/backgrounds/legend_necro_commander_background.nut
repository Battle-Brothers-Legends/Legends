this.legend_necro_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_necro";
		this.m.Icon = "ui/backgrounds/warlock_01.png";
		local r = this.Math.rand(0, 3);

		if (r == 0)
		{
			this.m.Name = "Necromancer";
		}
		else if (r == 1)
		{
			this.m.Name = "Seance";
		}
		else if (r == 2)
		{
			this.m.Name = "Sorcerer";
		}
		else if (r == 3)
		{
			this.m.Name = "Warlock";
		}

		this.m.HiringCost = 250;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.brave",
			"trait.athletic",
			"trait.brute",
			"trait.dexterous",
			"trait.eagleyes",
			"trait.fearless",
			"trait.huge",
			"trait.loyal",
			"trait.quick",
			"trait.swift",
			"trait.sure_footing",
			"trait.tough",
			"trait.disloyal"
		];
		this.m.Titles = [
			"the Sickening",
			"the Wretched",
			"the Widow Taunter",
			"the Fleshturner",
			"The Corpse Dancer",
			"the Puppeteer"
		];
		this.m.Faces = this.Const.Faces.NecromancerMale;
		this.m.Hairs = this.Const.Hair.Necromancer;
		this.m.HairColors = this.Const.HairColors.Zombie;
		this.m.Beards = this.Const.Beards.Raider;

		this.m.Level = 2;
		this.m.IsUntalented = true;
		this.m.IsOutlawBackground = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[3];

		if (!this.World.LegendsMod.Configs().LegendMagicEnabled())
		{
				this.m.CustomPerkTree = [
				[
					this.Const.Perks.PerkDefs.NineLives,
					this.Const.Perks.PerkDefs.CripplingStrikes,
					this.Const.Perks.PerkDefs.BagsAndBelts,
					this.Const.Perks.PerkDefs.Student,
					this.Const.Perks.PerkDefs.Recover,
					this.Const.Perks.PerkDefs.LegendWither,
					this.Const.Perks.PerkDefs.LegendSpawnZombieLow,
					this.Const.Perks.PerkDefs.LegendSpawnSkeletonLow,
					this.Const.Perks.PerkDefs.LegendSpecialistNinetailsSkill,
					this.Const.Perks.PerkDefs.LegendSpecialistScytheSkill
				],
				[
					this.Const.Perks.PerkDefs.CoupDeGrace,
					this.Const.Perks.PerkDefs.FortifiedMind,
					this.Const.Perks.PerkDefs.Gifted,
					this.Const.Perks.PerkDefs.LegendTrueBeliever,
					this.Const.Perks.PerkDefs.LegendRust,
					this.Const.Perks.PerkDefs.LegendMedPackages,
					this.Const.Perks.PerkDefs.LegendPrepareBleed,
					this.Const.Perks.PerkDefs.LegendPrepareGraze,
					this.Const.Perks.PerkDefs.LegendRoster1
				],
				[
					this.Const.Perks.PerkDefs.Backstabber,
					this.Const.Perks.PerkDefs.Debilitate,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
					this.Const.Perks.PerkDefs.Lookout,
					this.Const.Perks.PerkDefs.LegendExtendendAura,
					this.Const.Perks.PerkDefs.LegendSpecialistNinetailsDamage,
					this.Const.Perks.PerkDefs.LegendSpecialistScytheDamage,
					this.Const.Perks.PerkDefs.LegendSpecStaffSkill,
					this.Const.Perks.PerkDefs.LegendBloodbath,
					this.Const.Perks.PerkDefs.LegendRoster2
				],
				[
					this.Const.Perks.PerkDefs.SpecDagger,
					this.Const.Perks.PerkDefs.SpecMace,
					this.Const.Perks.PerkDefs.SpecCleaver,
					this.Const.Perks.PerkDefs.LegendMasteryStaves,
					this.Const.Perks.PerkDefs.SpecThrowing,
					this.Const.Perks.PerkDefs.LegendSpecPoison,
					this.Const.Perks.PerkDefs.LegendLacerate,
					this.Const.Perks.PerkDefs.LegendSpawnZombieMed,
					this.Const.Perks.PerkDefs.LegendSpawnSkeletonMed
				],
				[
					this.Const.Perks.PerkDefs.LoneWolf,
					this.Const.Perks.PerkDefs.LegendLithe,
					this.Const.Perks.PerkDefs.LegendSpecStaffStun,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyGhoul,
					this.Const.Perks.PerkDefs.LegendBlendIn,
					this.Const.Perks.PerkDefs.LegendReclamation,
					this.Const.Perks.PerkDefs.LegendMedIngredients,
					this.Const.Perks.PerkDefs.LegendConservation,
					this.Const.Perks.PerkDefs.LegendSlaughter,
					this.Const.Perks.PerkDefs.LegendRoster3
				],
				[
					this.Const.Perks.PerkDefs.LegendClarity,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyHexen,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyAlps,
					this.Const.Perks.PerkDefs.LegendBrinkOfDeath,
					this.Const.Perks.PerkDefs.LegendHidden,
					this.Const.Perks.PerkDefs.LegendChanneledPower,
					this.Const.Perks.PerkDefs.LegendPossession,
					this.Const.Perks.PerkDefs.LegendRoster5
				],
				[
					this.Const.Perks.PerkDefs.Fearsome,
					this.Const.Perks.PerkDefs.LegendGruesomeFeast,
					this.Const.Perks.PerkDefs.PerfectFocus,
					this.Const.Perks.PerkDefs.LegendBalance,
					this.Const.Perks.PerkDefs.LegendViolentDecomposition,
					this.Const.Perks.PerkDefs.LegendSpawnZombieHigh,
					this.Const.Perks.PerkDefs.LegendSpawnSkeletonHigh,
					this.Const.Perks.PerkDefs.LegendRoster6
				],
				[],
				[],
				[],
				[]
			];

		}
		else
		{
			this.m.CustomPerkTree = [
				[
					this.Const.Perks.PerkDefs.LegendSiphon,
					this.Const.Perks.PerkDefs.NineLives,
					this.Const.Perks.PerkDefs.CripplingStrikes,
					this.Const.Perks.PerkDefs.BagsAndBelts,
					this.Const.Perks.PerkDefs.Student,
					this.Const.Perks.PerkDefs.Recover,
					this.Const.Perks.PerkDefs.LegendWither,
					this.Const.Perks.PerkDefs.LegendSpawnZombieLow,
					this.Const.Perks.PerkDefs.LegendSpawnSkeletonLow,
					this.Const.Perks.PerkDefs.LegendSpecialistNinetailsSkill,
					this.Const.Perks.PerkDefs.LegendSpecialistScytheSkill
				],
				[
					this.Const.Perks.PerkDefs.CoupDeGrace,
					this.Const.Perks.PerkDefs.FortifiedMind,
					this.Const.Perks.PerkDefs.Gifted,
					this.Const.Perks.PerkDefs.LegendTrueBeliever,
					this.Const.Perks.PerkDefs.LegendRust,
					this.Const.Perks.PerkDefs.LegendPrepareBleed,
					this.Const.Perks.PerkDefs.LegendPrepareGraze,
					this.Const.Perks.PerkDefs.LegendMedPackages,
					this.Const.Perks.PerkDefs.LegendPrepareBleed,
					this.Const.Perks.PerkDefs.LegendRoster1
				],
				[
					this.Const.Perks.PerkDefs.Backstabber,
					this.Const.Perks.PerkDefs.Debilitate,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
					this.Const.Perks.PerkDefs.Lookout,
					this.Const.Perks.PerkDefs.LegendDeathtouch,
					this.Const.Perks.PerkDefs.LegendExtendendAura,
					this.Const.Perks.PerkDefs.LegendSpecialistNinetailsDamage,
					this.Const.Perks.PerkDefs.LegendSpecialistScytheDamage,
					this.Const.Perks.PerkDefs.LegendSpecStaffSkill,
					this.Const.Perks.PerkDefs.LegendBloodbath,
					this.Const.Perks.PerkDefs.LegendRoster2
				],
				[
					this.Const.Perks.PerkDefs.SpecDagger,
					this.Const.Perks.PerkDefs.SpecMace,
					this.Const.Perks.PerkDefs.SpecCleaver,
					this.Const.Perks.PerkDefs.LegendMasteryStaves,
					this.Const.Perks.PerkDefs.SpecThrowing,
					this.Const.Perks.PerkDefs.LegendSpecPoison,
					this.Const.Perks.PerkDefs.LegendSpawnZombieMed,
					this.Const.Perks.PerkDefs.LegendLacerate,
					this.Const.Perks.PerkDefs.LegendSpawnSkeletonMed
				],
				[
					this.Const.Perks.PerkDefs.LoneWolf,
					this.Const.Perks.PerkDefs.LegendLithe,
					this.Const.Perks.PerkDefs.LegendSpecStaffStun,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyGhoul,
					this.Const.Perks.PerkDefs.LegendBlendIn,
					this.Const.Perks.PerkDefs.LegendReclamation,
					this.Const.Perks.PerkDefs.LegendMedIngredients,
					this.Const.Perks.PerkDefs.LegendConservation,
					this.Const.Perks.PerkDefs.LegendSlaughter,
					this.Const.Perks.PerkDefs.LegendRoster3
				],
				[
					this.Const.Perks.PerkDefs.LegendClarity,
					this.Const.Perks.PerkDefs.LegendInsects,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyHexen,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyAlps,
					this.Const.Perks.PerkDefs.LegendBrinkOfDeath,
					this.Const.Perks.PerkDefs.LegendHidden,
					this.Const.Perks.PerkDefs.LegendChanneledPower,
					this.Const.Perks.PerkDefs.LegendPossession,
					this.Const.Perks.PerkDefs.LegendRoster5
				],
				[
					this.Const.Perks.PerkDefs.Fearsome,
					this.Const.Perks.PerkDefs.LegendGruesomeFeast,
					this.Const.Perks.PerkDefs.PerfectFocus,
					this.Const.Perks.PerkDefs.LegendBalance,
					this.Const.Perks.PerkDefs.LegendMiasma,
					this.Const.Perks.PerkDefs.LegendDarkflight,
					this.Const.Perks.PerkDefs.LegendFieldTriage,
					this.Const.Perks.PerkDefs.LegendViolentDecomposition,
					this.Const.Perks.PerkDefs.LegendSpawnZombieHigh,
					this.Const.Perks.PerkDefs.LegendSpawnSkeletonHigh,
					this.Const.Perks.PerkDefs.LegendRoster6
				],
				[],
				[],
				[],
				[]
			];
		}
	}

	function setGender(_gender = -1)
	{
		local r = _gender;
		if (_gender == -1)
		{
			r = 0;
			if (this.World.LegendsMod.Configs().LegendGenderEnabled())
			{
				r = this.Math.rand(0, 1);
			}
		}

		if (r != 1)
		{
			return
		}
		this.m.Faces = this.Const.Faces.NecromancerFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Zombie;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.IsFemaleBackground = true;
	}
	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onBuildDescription()
	{
		return "{Clothed in strangely colored robes, %name% appears to be more of an ambassador of the dark than a man of flesh and blood. | A curious fellow, %name% carries a slumped posture, as if he is weighted by otherworldly knowledge. | %name%\'s face is hidden well inside the dark of his cowl, a crescent of yellow teeth the only notion that a man dwells within. | Not much is known about %name%, but strange rumors of sorcery and dark arts follow him. | Wherever animals mysteriously begin to die, %name% makes an appearance. | The brooches on %name%\'s cloak seem to swirl and dance like midnight in a jug. | %name%\'s hands are rare to see, only coming out as if to portray the feelings of his face which lies hidden deep in his hood. | %name%\'s eyes could be mistaken for a cat\'s one day and for a blind man\'s the next.} {Little is known about whence he came. | From where he hails is but a mystery to most. | Some say he traveled deep into the northern foothills, returning with unspoken knowledge. | Ostensibly, the dark arts are his heritage, or so he puts on. | The man\'s past is kept from all. Maybe it\'s just uninteresting, or maybe just the opposite. | One rumor of the man says he traveled the land as a magician. | Rumors of magic surround the man, though some incredulous cynics are hardly impressed. | One rumor is that he was a conman, and another is that he\'s a sorcerer. You\'re not sure which you prefer. | With rumors of dark arts being practiced once more, the man\'s magical proclamation just might be true. | Some say he eats toads for breakfast and black cats for dinner.} {You ask %name% a lot of questions, but through some handwaves and nods, you realize you have forgotten his answers. Or did you ask the questions at all? | %name% produces a dove from his sleeve. An old trick that fancies no one - until it turns in the air, returning to him as a crow. | %name% has shown the ability to shoot smoke from his mouth. It\'s not fire, but it\'s close, and has people talking in hushed tones. | %name% floats a gold coin into the air. An amazing display that leaves the man too tired to attempt it again. | Predictions of the weather are common, but %name% is unusually accurate with his own. | %name% asks to read your palms. You decline. His presence alone is as close as you\'re willing to go. | %name% suggests that the stars are a roadmap to another world. He seems to know a lot about the heavens above. | %name% suggests that the heavens above are in fact just endless streams of beings, continuing on for eons. What a jest! | %name% points to one star in the sky and seems to suggest that is where he came from. You don\'t ask for a clarification on the matter.}";
	}


	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				20,
				25
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				10,
				10
			],
			MeleeSkill = [
				10,
				10
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				-5,
				0
			],
			Initiative = [
				10,
				15
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		//if (this.World.LegendsMod.Configs().LegendMagicEnabled())
		//{
		//	this.m.Container.add(this.new("scripts/skills/perks/perk_legend_siphon"));
		//}

		//this.m.Container.add(this.new("scripts/skills/perks/perk_legend_roster_1"));
		//this.m.Container.add(this.new("scripts/skills/perks/perk_legend_brink_of_death"));
		this.m.Container.add(this.new("scripts/skills/traits/survivor_trait"));
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 3;
		talents[this.Const.Attributes.Hitpoints] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "dark_cowl"]
		]));

		items.equip(this.Const.World.Common.pickArmor([
			[1, "thick_dark_tunic"]
		]));
		items.equip(this.new("scripts/items/weapons/legend_grisly_scythe"));
		local stash = this.World.Assets.getStash()
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		stash.add(this.new("scripts/items/supplies/strange_meat_item"));

	}
});
