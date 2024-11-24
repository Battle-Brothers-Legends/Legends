this.perk_legend_vala_premonition <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_vala_premonition";
		this.m.Name = this.Const.Strings.PerkName.LegendValaPremonition;
		this.m.Description = this.Const.Strings.PerkDescription.LegendValaPremonition;
		this.m.Icon = "ui/perks/legend_vala_premonition.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 9;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return false;
	}


	function getTooltip()
	{
		local bonus = this.Math.round(11.0 + ((this.getContainer().getActor().getLevel() * 22.0) / this.Const.LevelXP.len()));

		if (bonus > 33)
		{
			bonus = 33;
		}
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "%[/color] chance to have any attacker require two successful attack rolls in order to hit."
		});
		
		return ret;
	}


	function onUpdate (_properties)
	{
		local RerollBonus = 11.0 + ((this.getContainer().getActor().getLevel() * 22.0) / this.Const.LevelXP.len());

		if (RerollBonus > 33)
		{
			RerollBonus = 33;
		}

		local Attraction = 11.0 + ((this.getContainer().getActor().getLevel() * 22.0) / this.Const.LevelXP.len());
		local AttractionMult = 1.0 - ((Attraction + 0.0) / 100.0);

		if (AttractionMult < 0.67)
		{
			AttractionMult = 0.67;
		}

		_properties.RerollDefenseChance += RerollBonus;
		_properties.TargetAttractionMult *= AttractionMult;
	}
});
