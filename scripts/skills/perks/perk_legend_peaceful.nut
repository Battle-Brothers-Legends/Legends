this.perk_legend_peaceful <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_peaceful";
		this.m.Name = this.Const.Strings.PerkName.LegendPeaceful;
		this.m.Description = this.Const.Strings.PerkDescription.LegendPeaceful;
		this.m.Icon = "ui/perks/peaceful_circle.png";
		this.m.IconDisabled = "ui/perks/peaceful_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onUpdate( _properties )
	{
		_properties.IsContentWithBeingInReserve = true;
		_properties.Bravery += 20;
		_properties.MeleeSkill += -20;
		_properties.RangedSkill += -20;
		_properties.XPGainMult *= 1.05;
		_properties.SurviveWithInjuryBonusChance -= 10;
			
	}
	
	function onCombatStarted()
	{
		local actors = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());
		foreach( a in actors )
		{
			if (a.getFaction() == this.getContainer().getActor().getFaction() && !a.getSkills().hasSkill("effectspeaceful_reassured_effect"))
			{
				local effect = this.new("scripts/skills/effects/peaceful_reassured_effect")
				a.getSkills().add(effect);
			}
		}
	}


});
