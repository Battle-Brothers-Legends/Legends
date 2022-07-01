this.perk_legend_assured_conquest <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_assured_conquest";
		this.m.Name = this.Const.Strings.PerkName.LegendAssuredConquest;
		this.m.Description = this.Const.Strings.PerkDescription.LegendAssuredConquest;
		this.m.Icon = "ui/perks/assured_conquest_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Confident)
		{
			_properties.RangedSkill *= 1.1;
			_properties.MeleeSkill *= 1.1;
			_properties.MeleeDefense *= 1.1;
			_properties.RangedDefense *= 1.1;
		}

		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Steady)
		{
			_properties.RangedSkill *= 1.05;
			_properties.MeleeSkill *= 1.05;
			_properties.MeleeDefense *= 1.05;
			_properties.RangedDefense *= 1.05;
		}

		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Breaking)
		{
			_properties.RangedSkill *= 0.95;
			_properties.MeleeSkill *= 0.95;
			_properties.MeleeDefense *= 0.95;
			_properties.RangedDefense *= 0.95;
		}

		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			_properties.RangedSkill *= 0.9;
			_properties.MeleeSkill *= 0.9;
			_properties.MeleeDefense *= 0.9;
			_properties.RangedDefense *= 0.9;
		}
	}
});
