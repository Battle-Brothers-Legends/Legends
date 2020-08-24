this.female_servant_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.female_servant";
		this.m.Name = "Housemaid";
		this.m.Icon = "ui/backgrounds/housemaid.png";
		this.m.BackgroundDescription = "Housemaids are often not used to hard physical labor.";
		this.m.GoodEnding = "As it turns out, %name% the housemaids had been stowing away every last crown she had earned with the %companyname%. When she had enough, she retired and bought herself some land and slowly worked her way up the social ladder. She died in a comfortable bed, surrounded by friends, family, and loyal servants.";
		this.m.BadEnding = "%name% the servant grew tired of the sellsword life and left the company. She returned to serving nobility. When raiders attacked her liege\'s castle, the nobleman pushed the housemaid out the door with only a kitchen knife to defend herself with. She was found headless in a pile of broken chairs, a few dead raiders littered around her.";
		this.m.HiringCost = 45;
		this.m.DailyCost = 4;
		this.m.Excluded = [
			"trait.huge",
			"trait.hate_undead",
			"trait.hate_greenskins",
			"trait.hate_beasts",
			"trait.impatient",
			"trait.iron_jaw",
			"trait.brute",
			"trait.athletic",
			"trait.strong",
			"trait.disloyal",
			"trait.fat",
			"trait.brave",
			"trait.fearless",
			"trait.optimistic",
			"trait.cocky",
			"trait.bright",
			"trait.determined",
			"trait.greedy",
			"trait.sure_footing",
			"trait.bloodthirsty"
		];
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.IsOffendedByViolence = true;
		this.m.IsFemaleBackground = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMin;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[2];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.IntelligentTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.ChefClassTree,
				this.Const.Perks.HealerClassTree
			],
			Magic = []
		}
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
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Housemaids provide [color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] stash spaces, [color=" + this.Const.UI.Color.PositiveValue + "]-5%[/color] medicine consumption, [color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] maximum medicine storage,  [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] healing while in healing tent. [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] healing while in healing tent. [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] injury healing while in healing tent. [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] repair while in the repair tent. [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] salvage while in the salvage tent. [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] crafting while in the crafting tent. [color=" + this.Const.UI.Color.PositiveValue + "]+2.5%[/color] barter while trading and delivering. [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] fletching while in the fletching tent. [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] medicine while in gathering in camp.). "
			}
		];
	}

	function onBuildDescription()
	{
		return "{Life is difficult. Moreso for some than others. | Some women can fall from grace. Other women have nowhere to fall to, having been born already on the ground. | If life is a throw of dice, maybe some are fools to be women rather than mice.} %name% {was a servant to a decadent lord. | served an abusive family where the kids played with fire. | was kidnapped by brigands and forced to serve their every. Last. Need. | worked feverishly for mad men who looked far too long at the stars.}  She rarely made a mistake about her place in the world. One day, though, her masters {beat her unconscious. When she awoke, she did so in the bed of a benevolent doctor who refused to return her to her \'employers\'. Instead, %name% was free to go and her masters were told she had died. | set her free, no questions asked. Not one to dally on ceremony, %name% left in earnest. | invited her to a party. Believing she was a guest, she showed up in her finest attire - a shirt with hemmed sleeves and a billowy dress that hid her skeletal frame well. Unfortunately, she was but a show for the party - they gave her a wooden shield and sword, threw her into an arena with a wild boar, and took bets as they watched the horrific spectacle. She barely escaped the \'festivities\'.} {%name% has since sworn to never \'serve\' someone again. | The woman, though now free of her duties, still bears a great deal of humiliation and pain from her long, hard life.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-12,
				-7
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				-2,
				3
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
				2,
				0
			],
			Initiative = [
				5,
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "linen_tunic"],
			[1, "legend_maid_dress"]
		]))
	}
});
