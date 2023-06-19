this.perk_legend_specialist_sickle_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_sickle_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistSickleSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistSickleSkill;
		this.m.Icon = "ui/perks/sickle_02.png";
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
				_properties.MeleeSkill += 12;
				_properties.DamageDirectMult += 0.25;
			}
			else if (item.isWeaponType(this.Const.Items.WeaponType.Sword))
			{
				_properties.MeleeSkill += 3;
				_properties.DamageDirectMult += 0.08;
			}
		}
	}

});
