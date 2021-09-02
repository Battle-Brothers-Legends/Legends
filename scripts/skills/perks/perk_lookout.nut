this.perk_lookout <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.lookout";
		this.m.Name = this.Const.Strings.PerkName.Lookout;
		this.m.Description = this.Const.Strings.PerkDescription.Lookout;
		this.m.Icon = "ui/perks/lookout_circle.png";
		this.m.IconDisabled = "ui/perks/lookout_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
	}


});

