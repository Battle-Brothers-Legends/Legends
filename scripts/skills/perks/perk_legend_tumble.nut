this.perk_legend_tumble <- this.inherit("scripts/skills/skill", {
	m = {
		Skills = [
			"actives.lunge",
			"actives.footwork",
			"actives.rotation",
			"actives.legend_unarmed_lunge",
			"actives.legend_tumble",
			"actives.legend_leap",
		]
	},
	function create()
	{
		this.m.ID = "perk.legend_tumble";
		this.m.Name = this.Const.Strings.PerkName.LegendTumble;
		this.m.Description = this.Const.Strings.PerkDescription.LegendTumble;
		this.m.Icon = "ui/perks/tumble_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate(_properties)
	{
		local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
		foreach (skill in skills)
		{
			if (this.m.Skills.find(skill.getID()) != null)
			{
				skill.m.FatigueCostMult *= 0.5;

				if (skill.getID() == "actives.legend_leap")
				{
					skill.m.ActionPointCost /= 2;
				}
				else
				{
					skill.m.ActionPointCost -= 1;
				}
			}
		}
	}
});

