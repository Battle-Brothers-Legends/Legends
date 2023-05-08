this.perk_legend_specialist_sickle_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_sickle_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistSickleDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistSickleDamage;
		this.m.Icon = "ui/perks/sickle_01.png";
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
			if (item.getID() == "weapon.sickle" || item.getID() == "weapon.goblin_notched_blade"  || item.getID() == "weapon.legend_named_sickle")
			{
				_properties.DamageRegularMin += 6;
				_properties.DamageRegularMax += 16;
			}
			else if (item.isWeaponType(this.Const.Items.WeaponType.Sword))
			{
				_properties.DamageRegularMin += 2;
				_properties.DamageRegularMax += 7;
			}
		}
	}

});
