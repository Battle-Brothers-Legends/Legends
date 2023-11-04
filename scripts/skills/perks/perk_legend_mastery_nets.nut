this.perk_legend_mastery_nets <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_mastery_nets";
		this.m.Name = this.Const.Strings.PerkName.LegendMasteryNets;
		this.m.Description = this.Const.Strings.PerkDescription.LegendMasteryNets;
		this.m.Icon = "ui/perks/net_perk.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInNets = true;
	}

	function onAfterUpdate( _properties )
	{
		local skills = this.getContainer().getSkillsByFunction(@(_skill) _skill.getID() == "actives.break_free" || _skill.getID() == "actives.break_ally_free");
		foreach (s in skills)
		{
			s.m.ActionPointCost -= 1;
			s.m.FatigueCostMult *= 0.33;
		}
	}

});
