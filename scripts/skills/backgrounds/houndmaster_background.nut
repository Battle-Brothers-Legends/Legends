this.houndmaster_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.houndmaster";
		this.m.Name = "Houndmaster";
		this.m.Icon = "ui/backgrounds/background_50.png";
		this.m.BackgroundDescription = "Houndmasters are used to handle dogs of war.";
		this.m.GoodEnding = "Dogs were not simply \'hounds\' to %name%, despite his title as \'houndmaster.\' To him, they were the most loyal friends of his life. After leaving the company, he discovered an ingenious way to breed the animals specifically tailored to the desires of the nobility. Wanted a brutish beast for a guard dog? He could do it. Wanted something small and cuddly for the children? He could do that, too. The former mercenary now earns an incredible earning doing what he loves - working with dogs.";
		this.m.BadEnding = "What\'s merely a hound to one man is a loyal beast to %name%. After leaving the company, the houndmaster went out to work for the nobility. Unfortunately, he refused to let hundreds of his dogs be used as a battle vanguard to be thrown away for some short-lived tactical advantage. He was hanged for his \'traitorous ideals\'.";
		this.m.HiringCost = 80;
		this.m.DailyCost = 7;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_beasts",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.bleeder",
			"trait.bright",
			"trait.asthmatic",
			"trait.fainthearted",
			"trait.tiny"
		];
		this.m.Titles = [
			"the Houndmaster",
			"the Kennelmaster",
			"the Dogkeeper"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsLowborn = true;
		this.m.IsRangerRecruitBackground = true;
		this.m.IsDruidRecruitBackground = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.StavesTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.PolearmTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [this.Const.Perks.HoundmasterClassTree],
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
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Wardogs unleashed by this character will start at confident morale."
			}
		];
	}

	function onBuildDescription()
	{
		return "{%name%\'s fondness for dogs started after his father won a pup in a shooting contest. | When a dog saved him from a bear, %name% dedicated his life to the canine lot. | Seeing a dog stave off a would-be robber, %name%\'s fondness for the mutts only grew. | A young, bird-hunting %name% quickly saw the honor, loyalty, and workmanship of a dog. | Once bitten by a wild dog, %name% confronted his fear of canines by learning to train them.} {The houndmaster spent many years working for a local lord. He gave up the post after the liege struck a dog down just for sport. | Quick with training his mongrels, the houndmaster put his dogs into a lucrative traveling tradeshow. | The man made a great deal of money on the dog-fighting circuits, his mutts renowned for their easily commanded - and unleashed - ferocity. | Employed by lawmen, the houndmaster used his strong-nosed dogs to hunt down many a criminal element. | Used by a local lord, many of the houndmaster\'s dogs found their way onto the battlefield. | For many years, the houndmaster used his dogs to help lift the spirits of orphaned children and the crippled.} {Now, though, %name% seeks a change of vocation. | When he heard word of a mercenary\'s pay, %name% decided to try his hand at being a sellsword. | Approached by a sellsword to buy one of his dogs, %name% became more interested in the prospect of he, himself, becoming a mercenary. | Tired of training dogs for this purpose or that, %name% seeks to train himself for... well, this purpose or that. | An interesting prospect, you can only hope %name% is as loyal as the dogs he once commanded.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				0
			],
			Bravery = [
				5,
				5
			],
			Stamina = [
				5,
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
				3,
				3
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				5,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if ("LegendsMod" in this.World && this.World.LegendsMod != null && this.World.LegendsMod.Configs().LegendTherianthropyEnabled())
		{
			if(this.Math.rand(1, 50) == 1)
			{
				this.getContainer().add(this.new("scripts/skills/injury_permanent/legend_lycanthropy_injury"));
			}
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Math.rand(1, 100) >= 50)
		{
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "ragged_surcoat"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "open_leather_cap"],
			[1, ""]
		]));
	}

});

