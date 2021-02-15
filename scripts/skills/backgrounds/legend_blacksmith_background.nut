this.legend_blacksmith_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_blacksmith";
		this.m.Name = "Blacksmith";
		this.m.Icon = "ui/backgrounds/blacksmith.png";
		this.m.BackgroundDescription = "Blacksmiths tend to be strong and are skilled at repairing equipment.";
		this.m.GoodEnding = "Perhaps one of the strongest men you\'ve ever met, %name% the blacksmith was a vital asset in the %companyname%, repairing both his own equipment and that of his comrades with practiced hands. With plenty of crowns stored, he retired from fighting and blacksmithing both. Last you heard he was living out his years comfortably on the coast.";
		this.m.BadEnding = "%name% the blacksmith was a strong and capable sellsword in the %companyname%. He held out until the bitter end, sticking with the company as it lurched from one disaster to the next. Perhaps, had he been born in a different time he would have gone on to do great things, making legendary weapons for regal kings. Instead, many wars, invasions, and plagues spreading across the land ultimately ensured %name% and many other talented men went to total waste.";
		this.m.HiringCost = 500;
		this.m.DailyCost = 50;
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.clumsy",
			"trait.fragile",

		];
		this.m.Titles = [
			"Iron-arm",
			"the Blacksmith",
			"the Bladesmith",
			"the Armorer",
			"the Hammer",
			"the Burly",
			"the Smith",
			"the Metalsmith"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;

		this.m.IsRangerRecruitBackground = true;
		this.m.IsCrusaderRecruitBackground = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[3];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[3];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[3];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[2];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[3];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.HammerTree,
				this.Const.Perks.HammerClassTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.FitTree
			],
			Enemy = [],
			Class = [this.Const.Perks.RepairClassTree],
			Magic = []
		}
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip()
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] repair rate, [color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] maximum tools and [color=" + this.Const.UI.Color.PositiveValue + "]-20%[/color]tool usage"
			}
		)
		return ret
	}

	function onBuildDescription()
	{
		return "{Most every town has a resident blacksmith, | The local blacksmith is always an important person in the village, | Key to the success of any town is the skills of its resident blacksmith, }{needed to repair tools of every kind and the equipment of the local militia. | vital to the maintenance of sword and plow alike. | relied upon by the whole village for tools of every sort, from horseshoes to axes.}{%name%, learning from his father, was the resident blacksmith of %townname%. | Understanding this, %name% took up an apprenticeship in %randomtown% and, once having mastered the craft, settled down as the blacksmith of %townname%. | The son of one such blacksmith, %name% was forced into the profession by his overzealous father, though he cared little for it. | Hastily trained during a greenskin incursion, %name% eventually settled down as one such blacksmith, in %townname%. | %name% was one such blacksmith.}{Unfortunately, %name%\'s wife was killed in a freak accident. Unable to remain in %townname% any longer, %name% sold all he had and left, wandering aimlessly. Eventually he found himself in the company of sellswords, where his strong arms and hammer accustomed hands drew great interest. | Feeling his years wear away, %name% was overcome by restlessness, and he decided to set out as a mercenary, where his strong arms could be of different use. | After many years %name% was nearly killed by greenskin raiders, escaping only by blind chance. Thoroughly shaken, %name% quit his village, determined to learn all he could of warlore and battlecraft so that greenskins would never menace him again.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				10,
				15
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				10,
				10
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				-10,
				-10
			],
			MeleeDefense = [
				5,
				0
			],
			RangedDefense = [
				-5,
				-5
			],
			Initiative = [
				5,
				5
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_hammer"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, "legend_blacksmith_apron"]
		]));
	}
})