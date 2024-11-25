// TODO edit strings, image
this.perk_legend_magic_daze <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_magic_daze";
		this.m.Name = this.Const.Strings.PerkName.LegendMagicDaze;
		this.m.Description = this.Const.Strings.PerkDescription.LegendMagicDaze;
		this.m.Icon = "ui/perks/daze56_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_magic_daze"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_magic_daze_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_magic_daze");
	}

});