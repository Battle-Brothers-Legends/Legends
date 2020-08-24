this.female_daytaler_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.female_daytaler";
		this.m.Name = "Washerwoman";
		this.m.Icon = "ui/backgrounds/washerwoman.png";
		this.m.BackgroundDescription = "Washerwomen are used to all kinds of physical work, scrubbing isn't easy work.";
		this.m.GoodEnding = "%name% the washerwoman retired from fighting and, well, she keeps working with her hands. Now she\'s back to the scrubbing board and boiling water instead of slaying beasts and crushing heads. She took all his mercenary money to purchase a bit of land and settle down. While not the richest woman, word has it that there is hardly a happier woman in the realm.";
		this.m.BadEnding = "%name% retired from fighting while she still had most of his fingers and toes intact. She went back to working for the nobility. Last you heard she was out {south | north | east | west} running the laundry house for some nobleman. Sadly, you also heard that wash house collapsed halfway through its construction with many workers going down with it.";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.fear_undead",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.hate_greenskins"
		];
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.IsLowborn = true;
		this.m.IsFemaleBackground = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.HammerTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.StavesTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.CalmTree
			],
			Enemy = [],
			Class = [this.Const.Perks.FistsClassTree],
			Magic = []
		}
	}

	function onBuildDescription()
	{
		return "{Working here and there | With no steady work | Working on and off | Doing this and that | Having learned no craft}, %name% is known as a washerwoman, someone to ask whenever the linens need their rinse. {Work had been sparse for a while now, so | There was little work to be a had these past weeks, so | %name% wanted to do something she had not done before, so | Despite having no experience in battle, staring too deep into the bottle made her believe that | %name% considered the fighting profession one that doesn\'t run out of work these days, so | %name% lost her loved one to sickness, as befalls so many these days, and broke down. After weeks blurred by drinking her sorrows away,} a travelling mercenary company seemed a good opportunity {to seek redemption | to earn some coin | to see a bit of the world | to clear her head | to get her to the next village while filling her pockets}.";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				-5
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				3,
				8
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
				0,
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
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[2, "legend_maid_apron"],
			[1, "legend_maid_dress"],
			[1, "linen_tunic", this.Math.rand(6, 7)]
		]))

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "headscarf"],
			[4, ""]
		]));
	}
});
