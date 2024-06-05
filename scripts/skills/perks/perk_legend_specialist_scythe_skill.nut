this.perk_legend_specialist_scythe_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_scythe_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistScytheSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistScytheSkill;
		this.m.Icon = "ui/perks/scythe_01.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local item = this.getContainer().getActor().getMainhandItem();
		if (item != null)
		{
			if (item.getID() == "weapon.legend_grisly_scythe" || item.getID() == "weapon.legend_scythe" || item.getID() == "weapon.warscythe" || item.getID() == "weapon.named_warscythe")
			{
				_properties.DamageRegularMin += 10;
				_properties.DamageRegularMax += 15;
			}
		}
	}

});
