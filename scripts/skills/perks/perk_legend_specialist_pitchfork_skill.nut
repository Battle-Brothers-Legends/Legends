this.perk_legend_specialist_pitchfork_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_pitchfork_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistPitchforkSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistPitchforkSkill;
		this.m.Icon = "ui/perks/pitchfork_02.png";
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
			switch(true) {
				case item.isItemType(this.Const.Items.ItemType.Pitchfork):
					_properties.MeleeSkill += 12;
					_properties.DamageArmorMult += 0.25;
				case item.isWeaponType(this.Const.Items.WeaponType.Polearm):
					_properties.MeleeSkill += 3;
					_properties.DamageArmorMult += 0.08;
			}
		}
	}
});
