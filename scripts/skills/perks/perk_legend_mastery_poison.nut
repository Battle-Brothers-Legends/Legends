this.perk_legend_mastery_poison <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_mastery_poison";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecPoison;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecPoison;
		this.m.Icon = "ui/perks/mastery_poison.png";
		this.m.IconDisabled = "ui/perks/mastery_poison_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.coat_with_poison_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_poison_weapon_skill"));
		}
	}
		function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_poison_weapon");
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToPoison = true;
	}

});
