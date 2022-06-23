this.perk_legend_barter_greed <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_barter_greed";
		this.m.Name = this.Const.Strings.PerkName.LegendBarterGreed;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBarterGreed;
		this.m.Icon = "ui/perks/BarterT1.png";
		this.m.Type = this.Const.SkillType.Perk;
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (0.01 * this.World.Assets.getMoney / 7) + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (0.01 * this.World.Assets.getMoney / 7) + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + (0.008 * this.World.Assets.getMoney / 5) + "[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (0.005 * this.World.Assets.getMoney / 7) + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (0.005 * this.World.Assets.getMoney / 7) + "[/color] Ranged Defense"
			}
		];
	}
	function onUpdate( _properties ) //used 10k coin as a baseline
	{
		_properties.MeleeSkill += 0.01 * this.World.Assets.getMoney / 7; //+14 @ 10K
		_properties.RangedSkill += 0.01 * this.World.Assets.getMoney / 7;
		_properties.Bravery += 0.008 * this.World.Assets.getMoney / 5; //+16 @ 10k
		_properties.MeleeDefense += 0.005 * this.World.Assets.getMoney / 7; //+7 @ 10K
		_properties.RangedDefense += 0.005 * this.World.Assets.getMoney / 7; 
	}

	// function getModifier() 
	// {
	// 	return this.m.Amount;
	// }

	// function onAdded()
	// {
	// 				if (this.World.State.getPlayer() == null)
	// 		{
	// 			return;
	// 		}

	// 	this.World.State.getPlayer().calculateBarterMult();
	// 	this.World.State.getPlayer().calculateWageModifier(); 
	// }

	// function onRemoved()
	// {
	// 				if (this.World.State.getPlayer() == null)
	// 		{
	// 			return;
	// 		}

	// 	this.World.State.getPlayer().calculateBarterMult();
	// 	this.World.State.getPlayer().calculateWageModifier(); 

	// }


});
