this.perk_rebound <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rebound";
		this.m.Name = this.Const.Strings.PerkName.Rebound;
		this.m.Description = this.Const.Strings.PerkDescription.Rebound;
		this.m.Icon = "ui/perks/rebound_circle.png";
		this.m.IconDisabled = "ui/perks/rebound_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local maxFat = actor.getFatigueMax();
		local currentFat = actor.getFatigue();
		local ratio = currentFat / maxFat;

		if (ratio > 0.9)
		{
			_properties.FatigueRecoveryRate += 5;
		}
		else if (ratio > 0.75 && actor.getSkills().hasSkill("perk.legend_recuperation"))
		{
			_properties.FatigueRecoveryRate += 5;
		}
	}

});

