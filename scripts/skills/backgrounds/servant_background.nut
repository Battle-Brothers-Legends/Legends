this.servant_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.servant";
		this.m.Name = "Servant";
		this.m.Icon = "ui/backgrounds/background_16.png";
		this.m.BackgroundDescription = "Servants are often not used to hard physical labor.";
		this.m.GoodEnding = "As it turns out, %name% the servant had been stowing away every last crown he had earned with the %companyname%. When he had enough, he retired and bought himself some land and slowly worked his way up the social ladder. He died in a comfortable bed, surrounded by friends, family, and loyal servants.";
		this.m.BadEnding = "%name% the servant grew tired of the sellsword life and left the company. He returned to serving nobility. When raiders attacked his liege\'s castle, the nobleman pushed the servant out the door with only a kitchen knife to defend himself with. He was found headless in a pile of broken chairs, a few dead raiders littered around him.";
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
			"trait.optimist",
			"trait.cocky",
			"trait.bright",
			"trait.determined",
			"trait.greedy",
			"trait.sure_footing",
			"trait.bloodthirsty"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsOffendedByViolence = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
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
				this.Const.Perks.StavesTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.FastTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.BarterClassTree,
				this.Const.Perks.ChefClassTree
			],
			Magic = []
		}
	}

	function onBuildDescription()
	{
		return "{Life is difficult. Moreso for some than others. | Some men can fall from grace. Other men have nowhere to fall to, having been born already on the ground. | If life is a throw of dice, maybe some are fools to be men rather than mice.} %name% {was a servant to a decadent lord. | served an abusive family where the kids played with fire. | was kidnapped by brigands and forced to serve their every. Last. Need. | worked feverishly for mad men who looked far too long at the stars.}  He rarely made a mistake about his place in the world. One day, though, his masters {beat him unconscious. When he awoke, he did so in the bed of a benevolent doctor who refused to return him to his \'employers\'. Instead, %name% was free to go and his masters were told he had died. | set him free, no questions asked. Not one to dally on ceremony, %name% left in earnest. | invited him to a party. Believing he was a guest, he showed up in his finest attire - a shirt with hemmed sleeves and a billowy set of pantaloons that hid his skeletal frame well. Unfortunately, he was but a show for the party - they gave him a wooden shield and sword, threw him into an arena with a wild boar, and took bets as they watched the horrific spectacle. He barely escaped the \'festivities\'.} {%name% has since sworn to never \'serve\' someone again. | The man, though now free of his duties, still bears a great deal of humiliation and pain from his long, hard life.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-7,
				-2
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				-7,
				-2
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
		local r;
		items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[1, "linen_tunic"]
		]))
	}
});

