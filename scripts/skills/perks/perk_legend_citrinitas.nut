this.perk_legend_citrinitas <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_citrinitas";
		this.m.Name = this.Const.Strings.PerkName.LegendCitrinitas;
		this.m.Description = this.Const.Strings.PerkDescription.LegendCitrinitas;
		this.m.Icon = "ui/perks/perk_34.png"; //todo: add icon
		this.m.IconDisabled = "ui/perks/perk_34_sw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_citrinitas_trance"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_citrinitas_trance_skill"));
		}
	}


});

