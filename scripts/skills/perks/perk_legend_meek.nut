this.perk_legend_meek <- this.inherit("scripts/skills/skill", {
	m = {
		BonusMin = 0
	},
	function create()
	{
		this.m.ID = "perk.legend_meek";
		this.m.Name = this.Const.Strings.PerkName.LegendMeek;
		this.m.Description = "Gains a scaling lucky reroll chance based on low defenses";
		this.m.Icon = "ui/perks/meek.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();

		if (bonus > this.m.BonusMin)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "%[/color] chance for enemies to be forced to reroll their attack"
			});

		}
		else if (bonus = this.m.BonusMin)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character\'s [color=" + this.Const.UI.Color.NegativeValue + "]Melee Defence and Resolve is too high[/color] and is gaining no bonus from the \'Meek\' perk"
			});
		}

		return tooltip;
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		local mdef = actor.getCurrentProperties().getMeleeDefense();
		local resolve = actor.getCurrentProperties().getBravery();
		local stack = mdef + resolve;
		local bonus = this.Math.max(10, 100 - stack);
		return this.Math.floor(bonus);
	}


	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.RerollDefenseChance += bonus;
	}

});
