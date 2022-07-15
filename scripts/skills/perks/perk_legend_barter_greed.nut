this.perk_legend_barter_greed <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_barter_greed";
		this.m.Name = this.Const.Strings.PerkName.LegendBarterGreed;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBarterGreed;
		this.m.Icon = "ui/perks/BarterT1.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription() // —
	{
		return "This character is keen to guard the horde of gold the company has accumulated — and intends to protect it with their life.";
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getOffensiveBonus() + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getOffensiveBonus() + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getDefensiveBonus() + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getDefensiveBonus() + "[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getResolveBonus() + "[/color] Resolve"
			}
		];
	}
	function onUpdate( _properties ) //used 10k coin as a baseline
	{
		_properties.MeleeSkill += this.getOffensiveBonus();
		_properties.RangedSkill += this.getOffensiveBonus();
		_properties.MeleeDefense += this.getDefensiveBonus();
		_properties.RangedDefense += this.getDefensiveBonus();
		_properties.Bravery += this.getResolveBonus();
	}

	function getOffensiveBonus() //+14 @ 10K
	{
		return this.Math.floor(0.01 * this.World.Assets.getMoney() / 7);
	}

	function getDefensiveBonus() //+7 @ 10K
	{
		return this.Math.floor(0.005 * this.World.Assets.getMoney() / 5);;
	}

	function getResolveBonus() //+16 @ 10k
	{
		return this.Math.floor(0.008 * this.World.Assets.getMoney() / 5);
	}

	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		this.World.State.getPlayer().calculateBarterMult();
		this.World.State.getPlayer().calculateWageModifier();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		this.World.State.getPlayer().calculateBarterMult();
		this.World.State.getPlayer().calculateWageModifier();
	}


});
