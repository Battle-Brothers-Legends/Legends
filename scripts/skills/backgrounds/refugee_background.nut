this.refugee_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.refugee";
		this.m.Name = "Refugee";
		this.m.Icon = "ui/backgrounds/background_38.png";
		//gender neutral descriptions
		this.m.BackgroundDescription = "Refugees lack the conviction to fight for their homes, but they are used to long and exhausting travel by now.";
		this.m.GoodEnding = "%name% the refugee proved to be a natural fighter, but eventually retired from the %companyname%. Word has it %name% returned home and is using the wealth gained in the company to help rebuild the town.";
		this.m.BadEnding = "With the downfall of the %companyname% written plainly on the wall, %name% the refugee split with the company. Using their remaining scant crowns to purchase a set of shoes and returned to a destroyed home, to try and rebuild it. While walking home, an illiterate wildman murdered %name% and ate the shoes.";
		this.m.HiringCost = 40;
		this.m.DailyCost = 4;
		this.m.Excluded = [
			"trait.impatient",
			"trait.iron_jaw",
			"trait.athletic",
			"trait.tough",
			"trait.strong",
			"trait.loyal",
			"trait.cocky",
			"trait.fat",
			"trait.bright",
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.deathwish",
			"trait.greedy",
			"trait.bloodthirsty",
			"trait.aggressive",
			"trait.natural"
		];
		this.m.Titles = [
			"the Refugee",
			"the Survivor",
			"Runsfar",
			"the Derelict",
			"the Surbated"
		];
		this.m.Ethnicity = this.Math.rand(1, 2);
		if (this.m.Ethnicity == 1)
		{
			this.m.Ethnicity = 0;
			this.m.Faces = this.Const.Faces.AllWhiteMale;
			this.m.Hairs = this.Const.Hair.UntidyMale;
			this.m.HairColors = this.Const.HairColors.All;
			this.m.Beards = this.Const.Beards.Untidy;
			this.m.Bodies = this.Const.Bodies.Skinny;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanMale;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Beards = this.Const.Beards.Untidy;
		}
		
		this.m.IsOffendedByViolence = true;
		this.m.IsLowborn = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.StavesTree,
				this.Const.Perks.SlingsTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [this.Const.Perks.FistsClassTree],
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
			if (this.LegendsMod.Configs().LegendGenderEnabled())
			{
				r = this.Math.rand(0, 1);
			}
		}

		if (r != 1)
		{
			return
		}
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Beards = null;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleSkinny;
		this.m.IsFemaleBackground = true;
	}



	function onBuildDescription()
	{
		//gender neutral description
		return "{Catastrophes are cheap. | Disease, the ultimate invisible hand. | Win or lose a war, everything is as it has been.} %name% hails from a tiny village that {is now only remembered by spoken word, a generation away from being forgotten. | was destroyed, to put it succinctly. | now stands as a mere footnote, wasting little of the historian\'s ink. | suffered the world\'s wrath.} But %name% is a survivor. {%name% fled the disaster with only clothes. | With home ablaze, %name% saved what little could be saved, and fled. | After stumbling upon their dead family, %name% gathered what could be saved and ran. | War, famine, disease. It\'s all a blur now.} {%name% is merely anxious to look ahead rather than behind. | %name% carries little more than a sense of steeled determination, but that is something worth having. | A horrific history scars %name%\'s body and glazes their eyes, but the mercenary is easily motivated to never experience that past again. | Whatever befell the %name%\'s town didn\'t get %name% and, judging by the rumors you hear, that\'s saying something. | %name% isn\'t skilled in martial arts, but is damn sure determined to survive. | Whatever vocation %name% had in the past is now lost. Like many others, seeking mercenary work to get by in this increasingly bloody world. | One of many refugees you\'ve seen, this victim has decided to stop running and start fighting.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-8,
				-5
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				7,
				5
			],
			MeleeSkill = [
				0,
				0
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
				1,
				0
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}


	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "tattered_sackcloth"],
			[1, "sackcloth"],
			[1, "legend_rabble_tunic"]
		]))
	}
});

