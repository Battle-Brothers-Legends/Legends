this.pacified_flagellant_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.pacified_flagellant";
		this.m.Name = "Pacified Flagellant";
		this.m.Icon = "ui/backgrounds/background_13.png";
		this.m.HiringCost = 60;
		this.m.DailyCost = 5;
		this.m.Excluded = [
			"trait.clubfooted",
			"trait.tough",
			"trait.strong",
			"trait.disloyal",
			"trait.insecure",
			"trait.cocky",
			"trait.fat",
			"trait.fainthearted",
			"trait.bright",
			"trait.craven",
			"trait.greedy",
			"trait.gluttonous"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.IsOffendedByViolence = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Kind;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[3];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[3];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
				this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.FlailTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.SlingsTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.SturdyTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.NinetailsClassTree,
				this.Const.Perks.HealerClassTree,
				this.Const.Perks.FaithClassTree
				],
			Magic = [
			]
		}
	}

	function onBuildDescription()
	{
		return "After a long talk with a monk, %name% was converted to a more peaceful means of expressing his faith. Now when he picks up a weapon you can be assured it will only be pointed at someone other than himself.";
	}

	function onAddEquipment()
	{
	}
});

