this.perk_legend_specialist_knife_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_knife_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistKnifeDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistKnifeDamage;
		this.m.Icon = "ui/perks/knife_01.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item == null) return;
		local id = item.getID();

		if (id == "weapon.knife" || id == "weapon.legend_shiv")
		{
			_properties.DamageRegularMin += 4;
			_properties.DamageRegularMax += 12;
		}

		if (id == "weapon.dagger" || id == "weapon.rondel_dagger" || id == "weapon.named_dagger" || id == "weapon.obsidian_dagger" || id == "weapon.legend_redback_dagger" || id == "weapon.goblin_notched_blade" || id == "weapon.qatal_dagger" || id == "weapon.named_qatal_dagger")
		{
			_properties.DamageRegularMin += 1;
			_properties.DamageRegularMax += 4;
		}
		if (item != null && (item.getID() == "weapon.qatal_dagger" || item.getID() == "weapon.named_qatal_dagger"))
		{
			_properties.DamageRegularMin += 1;
			_properties.DamageRegularMax += 4;
		}		
	}

});
