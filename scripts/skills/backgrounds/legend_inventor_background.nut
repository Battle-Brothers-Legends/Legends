this.legend_inventor_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_inventor";
		this.m.Name = "Inventor";
		this.m.Icon = "ui/backgrounds/legend_inventor.png";
		this.m.BackgroundDescription = "Inventors are trenchant problem solvers, fueled by a burning passion for knowledge.";
		this.m.GoodEnding = null;
		this.m.BadEnding = null;
		this.m.HiringCost = 1250;
		this.m.DailyCost = 25;
		this.m.Excluded = [
			"trait.asthmatic",
			"trait.clumsy",
			"trait.cocky",
			"trait.dumb",
			"trait.superstitious"
		];
		this.m.Titles = [
			"the Inventor",
			"the Curious",
			"the Peculiar",
			"the Inquisitive",
			"the Utilitarian",
			"the Serendipitous",
			"the Eclectic",
			"the Tinkerer"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.IsCrusaderRecruitBackground = true;
		this.m.IsRangerRecruitBackground = true;
		this.m.IsEducatedBackground = true;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[2];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[3];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.HammerTree,
				this.Const.Perks.StavesTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.CrossbowTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.OrganisedTree
			],
			Enemy = [],
			Class = [this.Const.Perks.RepairClassTree],
			Magic = [
				this.Const.Perks.PhilosophyMagicTree,
				this.Const.Perks.InventorMagicTree
			]
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
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] Experience Gain"
			}
		];
	}

	function onBuildDescription()
	{
		return "{Having spent most of his life in and around %townname%, covered in books, conducting various experiments and creating all sort of contraptions, %name% eventually turned his eyes towards knights, soldiers, sellswords, brigands and others that live and die by the sword. Perhaps his knowledge could be applied to their circumstances? Could he possibly become a great fighter himself? Tempted and intrigued by his own thoughts, he wasted no time setting out to look for a mercenary company that would consider taking him in. What could go wrong?}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
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
				0,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle(this.Const.Strings.InventorTitles[this.Math.rand(0, this.Const.Strings.InventorTitles.len() - 1)]);
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		items.equip(this.Const.World.Common.pickArmor([
			[1, "apron"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "mouth_piece"],
			[1, "headscarf"]
		]));

		r = this.Math.rand(0, 1);
		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
	}
	function onUpdate (_properties)
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.2;
	}
});