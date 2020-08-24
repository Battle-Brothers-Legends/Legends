this.ratcatcher_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.ratcatcher";
		this.m.Name = "Ratcatcher";
		this.m.Icon = "ui/backgrounds/background_41.png";
		this.m.BackgroundDescription = "Ratcatchers need to have quick reflexes to catch their prey.";
		this.m.GoodEnding = "%name% the ratcatcher came from stranger stocks, and to stranger stocks he returned. After retiring from the %companyname%, he started a ratcatching company. He was doing wonderful business until it came out that he hadn\'t been killing any of the rats, but instead stowing thousands of them in a storehouse just outside town. Last you heard, the man was quite content with his new and numerous friends.";
		this.m.BadEnding = "You didn\'t think %name% would fit in with sellswords, but he proved himself capable. Unfortunately, the %companyname% fell apart and he returned to ratcatching. You got word that his body was found in a sewer utterly covered in nibbling rats. It\'s said that he had a smile on his face.";
		this.m.HiringCost = 40;
		this.m.DailyCost = 4;
		this.m.Excluded = [
			"trait.huge",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.clubfooted",
			"trait.brute",
			"trait.tough",
			"trait.strong",
			"trait.cocky",
			"trait.fat",
			"trait.hesitant",
			"trait.bright",
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.deathwish",
			"trait.greedy",
			"trait.sure_footing",
			"trait.clumsy",
			"trait.short_sighted"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsLowborn = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.SlingsTree,
				this.Const.Perks.SpearTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.CalmTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.BeastClassTree
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
			}
		];
	}

	function onBuildDescription()
	{
		return "{Catcher of rats, that\'s the title %name% once preferred. | With perhaps misplaced pride, %name% fashions himself as a man of the sewers. | Bowlegged and scrawny, %name%\'s career of hunting rats has seemingly turned him into one.} He grew up in %townname%, surviving {in the alleys | on rat, the fruit of the sewers | alongside the furry and scuttling, as well as some rats}. {For cheap entertainment, his father taught him the ways of snaring tiny rodents | His fallen brother\'s body was eaten by rats, forging an angry future of rodent-revenge | His mother demanded the finest meats he could find, and she didn\'t mean from the market}. But %townname% wears on people, and it wore on %name% like a giant, nibbling creature. {Hearing of greater rats in the world | Sensing that there must be more to life than rats | Trusting his rat-whispering skills}, %name% now seeks to {put his shriveled nose, odd gnawing habits, and quick but kind of gross hands to better use. | crush every rat, see them driven before him, and to hear the squeals of their kin. He has a thousand-yard stare and a clenched fist as he tells you this. | perhaps graduate his skills from rats to dogs and maybe humans, so he says. He doesn\'t appear to know what he\'s in for, but perhaps it is best to not tell him. | dish up some rat soup, rat salad, rat kebab, rat bread, rat stew, rat chicken, rat wine... after a while, you just stop listening.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				0
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
				18,
				15
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.RatcatcherTitles[this.Math.rand(0, this.Const.Strings.RatcatcherTitles.len() - 1)]);
		}

		if ("LegendsMod" in this.World && this.World.LegendsMod != null && this.World.LegendsMod.Configs().LegendTherianthropyEnabled())
		{
			if(this.Math.rand(1, 50) == 1)
			{
				this.m.Container.add(this.new("scripts/skills/injury_permanent/legend_vermesthropy_injury"));
			}
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		
		items.equip(this.new("scripts/items/tools/throwing_net"));
		
		items.equip(this.Const.World.Common.pickArmor([
			[1, "tattered_sackcloth"],
			[1, "sackcloth"]
		]))
	}
});

