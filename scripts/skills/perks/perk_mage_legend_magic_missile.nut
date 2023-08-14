this.perk_mage_legend_magic_missile <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mage_legend_magic_missile";
		this.m.Name = this.Const.Strings.PerkName.MageLegendMagicMissile;
		this.m.Description = this.Const.Strings.PerkDescription.MageLegendMagicMissile;
		this.m.Icon = "ui/perks/misile_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.mage_legend_magic_missile"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/mage_legend_magic_missile"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.mage_legend_magic_missile");
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}

});

