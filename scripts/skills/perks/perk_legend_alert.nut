this.perk_legend_alert <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_alert";
		this.m.Name = this.Const.Strings.PerkName.LegendAlert;
		this.m.Description = this.Const.Strings.PerkDescription.LegendAlert;
		this.m.Icon = "ui/perks/alert_circle.png";
		this.m.IconDisabled = "ui/perks/alert_circle_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 1.2;
	}

});

