this.belly_dancer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.belly_dancer";
		this.m.Name = "Belly Dancer";
		this.m.Icon = "ui/backgrounds/background_64.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "%name% the southern belly dancer left the company in good time. While his... particularities made him an excellent soldier, it was not his life\'s passion. To entertain, through rhythmic, confusingly erotic motions, that is what he\'s wanted. The last you heard, he was in the court of a Vizier where he serves not only as an entertainer, but, thanks to his time with the %companyname%, also as an adviser on marital matters.";
		this.m.BadEnding = "As the company failed to achieve the success you had hoped for, many departed its ranks. The southern belly dancer %name% joined them. Unfortunately, he sought to ply his trade in the north, thinking he may be able to spread his culture there. The indigenous population was quick to accuse him of \'unregulated body sorcery\' and burn him at the stake.";
		this.m.HiringCost = 0;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			"trait.huge",
			"trait.clubfooted",
			"trait.clumsy",
			"trait.fat",
			"trait.strong",
			"trait.hesitant",
			"trait.insecure",
			"trait.clubfooted",
			"trait.short_sighted",
			"trait.brute",
			"trait.strong",
			"trait.bloodthirsty",
			"trait.deathwish"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.RangedDefense,
			this.Const.Attributes.Bravery
		];
		this.m.Bodies = this.Const.Bodies.SouthernFemale;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.SouthernYoung;
		this.m.BeardChance = 1;
		this.m.Ethnicity = 1;
		this.m.IsFemaleBackground = true;
		this.m.IsCombatBackground = false;
		this.m.IsPerformingBackground = true;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.GreatSwordTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [this.Const.Perks.SwordmastersTree],
			Class = [],
			Magic = []
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				10,
				15
			],
			RangedSkill = [
				5,
				5
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
				10,
				10
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("the Belly Dancer");
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[3, "oriental/cloth_sash"],
			[1, ""]
		]))

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[4, "legend_jewelry"]
		]));
	}
});

