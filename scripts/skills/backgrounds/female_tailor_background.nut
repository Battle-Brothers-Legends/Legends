this.female_tailor_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.female_tailor";
		this.m.Name = "Seamstress";
		this.m.Icon = "ui/backgrounds/seamstress.png";
		this.m.BackgroundDescription = "Seamstresses are not used to hard physical labor.";
		this.m.GoodEnding = "What was asSeamstress doing in a mercenary company? A good question, but %name% certainly answered it well by killing so many enemies they could\'ve made an epic tapestry out of story. After a few good years in the company, she eventually left to start up a business creating clothes for nobility. Her name is world-renowned, well, the known-world-renowned, and she gets so much business she\'s making a very different killing these days.";
		this.m.BadEnding = "A tailor at heart, it didn\'t take much to compel %name% to bail from the quickly sinking company. She left to go start a business, but was kidnapped along the way by a group of brigands. When they threatened to kill her, she pretended to be a simple and weak tailor and showed her talents in creating clothes. Impressed, the raggedly dressed outlaws took her into their band. A few days later they were all dead and this \'meek\' woman walked out of their camp with a bit of red on her. She started his business a week later and is doing well to this day.";
		this.m.HiringCost = 50;
		this.m.DailyCost = 5;
		this.m.Excluded = [
			"trait.huge",
			"trait.hate_undead",
			"trait.athletic",
			"trait.deathwish",
			"trait.clumsy",
			"trait.fearless",
			"trait.spartan",
			"trait.brave",
			"trait.iron_lungs",
			"trait.strong",
			"trait.tough",
			"trait.cocky",
			"trait.dumb",
			"trait.brute",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"the Peculiar",
			"the Seamstress",
			"the Particular",
			"the Fine",
			"Silkworm"
		];
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.IsFemaleBackground = true;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[2];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.FastTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.CalmTree
			],
			Enemy = [],
			Class = [this.Const.Perks.RepairClassTree],
			Magic = []
		}
	}

	function onBuildDescription()
	{
		return "{%name% was always curious about fabrics, seeing more science in a linen cloth than {a diviner would in the sands of the desert. | a haruspex would in a toad\'s entrails. | an alchemist would in a mortar and pestle.} | %name% was always an odd girl growing up, fancying a good silk waistcoat instead of the boy beneath it. | Daughter to a {milling mother | fine lady | baroness | farmhand}, %name%\'s turn toward fashioning clothes was a surprise to all. | While %name%\'s sisters fancied being warriors and heroes, %name% thought of herself as a future dresser of kings. | %name% spent much of her youth in the company of girls, but not for the reasons one might think. | %name% always fancied animals, particularly how they would look as a good coat or scarf. | As tunics and shirts grew popular, %name% turned to seamstressing to make a crown or two. | With a surge in pantaloons popularity, %name% went from being a tanner to a seamstress to make more money. | %name% hails from a faraway land where how a man dresses is more important than how he fights. | Seamstressinging is the science of colors and fabrics, by which standards %name% is renowned. | Good with measuring and calculating, %name% turned her mathematical prowess to seamstressing to earn as much as she could. | %name%\'s career in seamstressing started when her mother pushed her into the vocation to dodge a passing noble\'s attentions. | %name% took up seamstressing to honor her father, a seamstress who was killed by an unhappy customer. | Widowed by war, %name%\'s mother taught her how to put her hands to better use in seamstressing instead of killing.} {When raiders attacked her home, %name% dressed everyone up in clever disguises. The town was destroyed, but not a soul was lost. | She spent many years dressing royalty until a fashion faux pas led her being exiled. | Unfortunately, a woman fancying a good fabric, as %name% is wont to do, left the seamstress ostracized from many a village. | She tried to make her break in the big cities, but sadly she just could not compete with the other seamstresses. | When a lord organized an army, %name% handled the clothes, giving the soldiers proper uniforms. | But a fierce competition between seamstresses led to a linen-wrapped deadman and %name% coincidentally leaving his shop behind. | Sadly, robbers ransacked her shop and, with the wars going on, it would be impossible to restock. | But when she sheared a sheep that did not belong to her, %name% was kicked out of town. | She once choked out a would-be thief with a cord of measuring wire. So she says, anyway. | But dressing unlikeable and unfriendly nobility eventually {bored her. | wore on her.} | Once tasked with making a tunic embroidered with epic feats, %name% wondered what the outside world was really like. | Designing a dress adorned with {epic quests | epic feats}, %name% wondered if maybe she should be the one they wove stories about.} Now the seamstress looks for a new life, no matter where it takes her. {Maybe she can dress the unit well, or something. | She\'s particular and peculiar, peppering everyone with clothing criticisms. | She\'s no natural soldier, but she appraises a man\'s attire as if he\'s about to go to war with it. | The way she measures and calculates for dressing, it\'s too bad %name% wasn\'t a siege engineer. | While hardly a soldier, %name%\'s earnest love for seamstressing is to be admired. | %name%\'s knowledge of various cloths is seriously impressive. | A bit on the nimby-pimbly side, %name% has the footwork of a swordfighter, but the swordfighting of a soft breeze. | %name% would seem very out of place in a suit of armor, but boy is she going to need one. | As it turns out, %name% can in fact make a silk purse out of a sow\'s ear. | Don\'t let his vocation fool you, %name% is more deft with her hands than some {cardsharks | jugglers | pickpockets}. | Seamstresses don\'t seem fit for combat, but then again neither do most of the men you run across these days. | A seamstress seems ill-fit for combat, yet for some reason you find the finest soldiers in the strangest of places. | With an eye {for calculations | for measuring}, %name% is a lot smarter than she lets on at first glance.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-8,
				-3
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
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
				0,
				0
			],
			Initiative = [
				0,
				5
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "linen_tunic"],
			[1, "legend_maid_dress"],
			[1, "legend_maid_apron"]
		]))

		items.equip(this.Const.World.Common.pickHelmet([
				[1, "feathered_hat"],
				[1, ""]
		]))
	}
});
