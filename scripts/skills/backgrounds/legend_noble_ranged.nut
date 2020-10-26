this.legend_noble_ranged <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_noble_ranged";
		this.m.Name = "Arbalester";
		this.m.Icon = "ui/traits/trait_icon_32.png";
		this.m.HiringCost = 150;
		this.m.DailyCost = 16;
		this.m.DailyCostMult = 1.0;
		this.m.Excluded = [
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.hate_greenskins",
			"trait.huge",
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.paranoid",
			"trait.night_blind",
			"trait.impatient",
			"trait.asthmatic",
			"trait.greedy",
			"trait.clubfooted",
			"trait.dumb",
			"trait.fragile",
			"trait.short_sighted",
			"trait.disloyal",
			"trait.drunkard",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.dastard",
			"trait.insecure",
			"trait.hesitant"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.MeleeSkill,
			this.Const.Attributes.MeleeDefense
		];
		this.m.GoodEnding = "He supported you from the start, %name%, and he was with you in retirement, leaving the company not long after you did. But he wasn\'t yet done with the fighting life and took up fighting for another company - his own. Having learned so much from your leadership, he is making you about as proud as any son could. Ironically, he hates the notion of you being a father figure to him, and you always tell him you\'d never father a son so ugly to begin with. You keep in touch to this day.";
		this.m.BadEnding = "Supporting you from the start, %name% was as loyal as he was talented. He stayed with the company for a time before eventually leaving to forge out a path for himself. The other day, you received a letter from the mercenary stating that he had started his own company and was in dire need of help. Unfortunately, the message was dated to nearly a full year ago. When you investigated the existence of his company, you learned that it had been completely annihilated in a battle between nobles.";
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.IsCombatBackground = true;
		this.m.IsRangerRecruitBackground = true;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.BowTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.FastTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		local r = _gender;
		if (_gender == -1)
		{
			r = 0;
			if (this.World.LegendsMod.Configs().LegendGenderEnabled())
			{
				r = this.Math.rand(0, 1);
			}
		}

		if (r != 1)
		{
			return
		}
		this.m.Faces = this.Const.Faces.AllFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.IsFemaleBackground = true;
		this.m.GoodEnding = "Supporting your cause from the start, %name% was with you in retirement, leaving the company not long after you did. Though she was a lowly peasant, she proved herself in battle after battle and slowly became as trusted and valued a friend as one can have in a mercenary company.";
		this.m.BadEnding = "A supporter of your cause from the start, %name% was as loyal as she was talented. She stayed with the company for a time before eventually leaving to forge out a path for himself. The other day, you received a letter from the mercenary stating that she had started her own company and was in dire need of help. Unfortunately, the message was dated to nearly a full year ago. When you investigated the existence of her company, you learned that it had been completely annihilated in a battle between nobles.";

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
		if (this.m.IsFemaleBackground == true)
		{
			return "%name% is one of the more talented markswoman you\'ve encountered in your travels. {After she saved your life with an arrow into the heart of a would-be assassin, you hired the woman on the spot. | Learning of the woman was easy - you just had to find the winner of a local shooting competition. | She once won an archery contest that had over a hundred participants from all the lands. | It is said that she can split an arrow - mid-flight. | You found the woman on a farm where, obviously, you thought her shooting talents were going to waste. | A poacher, a bowyer, an archer, the woman\'s skills have gotten plenty of use. You suspect she readily accepted your offer for mercenary work just to say \'she\'s done it all\'. | You once saw her shoot the moon, but that may have been some sort of trick. | A clever bowman, she once loosed two arrows simultaneously to kill a charging set of brigands.} While she has a fondness for killing from afar, %name%\'s no slouch in close-quarters combat.";
		}
		else
		{
			return "%name% is one of the more talented marksman you\'ve encountered in your travels. {After he saved your life with an arrow into the heart of a would-be assassin, you hired the man on the spot. | Learning of the man was easy - you just had to find the winner of a local shooting competition. | He once won an archery contest that had over a hundred participants from all the lands. | It is said that he can split an arrow - mid-flight. | You found the man on a farm where, obviously, you thought his shooting talents were going to waste. | A poacher, a bowyer, an archer, the man\'s skills have gotten plenty of use. You suspect he readily accepted your offer for mercenary work just to say \'he\'s done it all\'. | You once saw him shoot the moon, but that may have been some sort of trick. | A clever bowman, he once loosed two arrows simultaneously to kill a charging set of brigands.} While he has a fondness for killing from afar, %name%\'s no slouch in close-quarters combat.";
		}

	}

	function onPrepareVariables( _vars )
	{
		_vars.extend(this.World.Assets.getFounderNames());
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				-5
			],
			Bravery = [
				5,
				5
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				0,
				3
			],
			RangedSkill = [
				23,
				20
			],
			MeleeDefense = [
				0,
				4
			],
			RangedDefense = [
				3,
				6
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

		if (this.Math.rand(0, 3) == 3)
		{
			actor.setTitle(this.Const.Strings.SellswordTitles[this.Math.rand(0, this.Const.Strings.SellswordTitles.len() - 1)]);
		}

	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hunters_hat"],
			[1, "aketon_cap"],
			[1, "open_leather_cap"]
		]));

		items.equip(this.new("scripts/items/weapons/light_crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/knife"));
		
		items.equip(this.Const.World.Common.pickArmor([
			[2, "padded_surcoat"],
			[1, "basic_mail_shirt"]
		]));
	}

});
