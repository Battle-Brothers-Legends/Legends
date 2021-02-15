this.legend_nun_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_nun";
		this.m.Name = "Nun";
		this.m.Icon = "ui/backgrounds/nun.png";
		this.m.BackgroundDescription = "Nuns tend to have a high resolve in what they do, but are not used to hard physical labor or warfare.";
		this.m.GoodEnding = "%name% the nun retired back into calmer spiritual duties. She is currently out in a mountain convent, enjoying the quiet while reflecting on her time in the mercenary company. The other nuns hate her for fighting and killing, but she\'s penning a world-changing tome on the balance between peace and violence.";
		this.m.BadEnding = "After having a spiritual breakdown, %name% retired from fighting and found home in a monastery. All her fellow sisters and abbesses ostracized her for taking part in such a violent venture. Word has it she was eventually exiled when a mother superior caught her stealing an offertory.";
		this.m.HiringCost = 60;
		this.m.DailyCost = 5;
		this.m.Excluded = [
			"trait.weasel",
			"trait.hate_beasts",
			"trait.swift",
			"trait.impatient",
			"trait.clubfooted",
			"trait.brute",
			"trait.gluttonous",
			"trait.disloyal",
			"trait.cocky",
			"trait.quick",
			"trait.dumb",
			"trait.superstitious",
			"trait.iron_lungs",
			"trait.craven",
			"trait.greedy",
			"trait.bloodthirsty",
			"trait.aggressive",
			"trait.double_tongued"
		];
		this.m.Titles = [
			"the Pious",
			"the Nun",
			"the Scholar",
			"the Preacher",
			"the Devoted",
			"the Quiet",
			"the Calm"
		];
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.IsFemaleBackground = true;
		this.m.IsEducatedBackground = true;
		this.m.IsCrusaderRecruitBackground = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[3];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[3];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.FlailTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.StavesTree,
				this.Const.Perks.SlingsTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.InspirationalTree
			],
			Enemy = [
				this.Const.Perks.SkeletonTree,
				this.Const.Perks.VampireTree
			],
			Class = [
				this.Const.Perks.HealerClassTree,
				this.Const.Perks.FaithClassTree
			],
			Magic = [
			]
		}
	}



	function onBuildDescription()
	{
		return "{After raiders murdered her family, %name% retreated into the comforts of religion and became a nun at a nearby convent. | Often traveling away from her church and fellow nuns, %name% spent years preaching to peasantry in remote villages. | %name%, a quiet nun, has spent untold days worshipping the old gods in %townname%\'s monastery. | One nun amongst many, %name% used to wander the steepled temples of %randomtown%. | Abandoned on the steps of a convent, %name% grew up in the company of nuns, and soon took to their lifestyle. | Trying to find peace in a land of ruin, %name% became a nun. | Always an unruly child, %name%\'s parents handed her over to the local convent where she was quickly pacified as a nun.} {Unfortunately, her abbess\'s liking for youth and fleshen things led to a terrible scandal. %name% fled to preserve her life and her faith. | But her faith was irreversibly damaged as a hellacious attack by raiders left men castrated, women raped, and children skewered on spits. | Though a believer in the old gods, the nun could not stand what atrocities her head priest committed in their name. The nun eventually left to seek spirituality on her own terms. | As the world\'s suffering grew, %name%\'s abbess requested that she go out and heal the people of the earth. | Cults of death, beasts of nightmare, and men of cruelty. %name% left the halls of her temple to purify them all. | But when a child asked her a faith-shattering question, %name% abandoned her faith, seeking out spirituality by other means. | Unfortunately, prayer did not spare her sisters from a slaughter. %name% realized that her faith was better invested in looking out for herself than muttering to some so-called god. | Always a fiery woman, %name% left the safety of the monasteries to go out and \'right\' the world. | One of the few literate women around, %name% abandoned her ascetic life to learn more of the world and, hopefully, to cure that which sickened it. | But one night a man bedded her. She woke with her faith cratered in the crumpled sheets around her. Ashamed, she never returned to her monastery. | But she used her trusted position for ill-gotten gains, stealing from the temple\'s treasury. It didn\'t take long for the scandal to drive her out. | Unfortunately, a child accused her of behavior unbecoming of a nun. Nobody knows the truth behind the story, but %name% did not last much longer at the church. | One night, she discovered an awful truth in an old tome. Not long after, %name% quickly left the church, never quite saying what it was that she discovered.} {The woman hardly knows a thing about fighting, but she carries the mental fortitude of a mountain standing against a storm. | Years of solitude and prayer have left %name% out of shape, but it is her steeled mind that is of most value. | Perhaps never really content with her life, it\'s difficult to entirely know why someone like %name% would join a band of mercenaries. | Maybe there are too many devils in the world, or too many inside her, but you don\'t question why %name% wishes to join a band of sellswords. | Faith won\'t cleave a greenskin, but it won\'t have a woman like %name% running away from one, either. | %name%\'s stated desire to rid the world of \'the unfaithful\' is almost scary in its determination. | While %name%\'s spirituality is to be commended, the constant mutterings to the old gods are a bit annoying. | While %name%\'s hands are better clasped in prayer than around the handle of a sword, few mercenaries have the sense of resolve that she does. | A holy book practically anchored to her wrist, %name% has sought the company of sellswords. | The holy book she carries is thick enough to be used as a shield, but %name% looks absolutely horrified when you say as much out loud. | Perhaps with a romantic view of mercenaries in need of a good spiritual cleansing, %name% seeks to accompany sellswords. | Once having read of warrior priestesses, %name% now wishes to emulate those brave, unwavering soldiers of faith. | You get the feeling %name% wants release from this sinful world. If that\'s the truth then she has come to the right place.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				5
			],
			Bravery = [
				11,
				11
			],
			Stamina = [
				0,
				5
			],
			MeleeSkill = [
				-5,
				-5
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

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "legend_nun_habit"]
		]));

		items.equip(this.Const.World.Common.pickArmor([
			[2, "legend_nun_robe_dark"],
			[1, "legend_nun_robe_light"]
		]));
	}
});
