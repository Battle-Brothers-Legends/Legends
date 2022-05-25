this.perk_legend_specialist_shortbow_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_shortbow_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistShortbowDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistShortbowDamage;
		this.m.Icon = "ui/perks/shortbow_01.png";
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
				_properties.DamageRegularMin += 6;
				_properties.DamageRegularMax += 16;
			}
			else if (item.isWeaponType(this.Const.Items.WeaponType.Bow))
			{
				_properties.DamageRegularMin += 2;
				_properties.DamageRegularMax += 7;
			}
		}
	}

});
