this.perk_legend_specialist_shortbow_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_shortbow_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistShortbowSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistShortbowSkill;
		this.m.Icon = "ui/perks/shortbow_02.png";
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
			if (item.getID() == "weapon.short_bow" || item.getID() == "weapon.goblin_bow" || item.getID() == "weapon.wonky_bow" || item.getID() == "weapon.goblin_heavy_bow")
			{
				_properties.RangedSkill += 12;
				_properties.DamageDirectMult *= 1.25;
			}
			else if (item.isWeaponType(this.Const.Items.WeaponType.Bow))
			{
				_properties.RangedSkill += 3;
				_properties.DamageDirectMult *= 1.08;
			}
		}
	}

});
