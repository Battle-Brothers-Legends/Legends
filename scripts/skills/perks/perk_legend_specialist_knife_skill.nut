this.perk_legend_specialist_knife_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_knife_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistKnifeSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistKnifeSkill;
		this.m.Icon = "ui/perks/knife_02.png";
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
			if (item.getID() == "weapon.knife" || item.getID() == "weapon.legend_shiv")
			{
				_properties.MeleeSkill += 12;
				_properties.DamageDirectAdd += 0.4;
			} 
			else if (item.isWeaponType(this.Const.Items.WeaponType.Dagger))
			{
				_properties.MeleeSkill += 3;
				_properties.DamageDirectAdd += 0.1;
			}
		}
	}

});
