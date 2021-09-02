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
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item == null) return;
		local id = item.getID();

		if (id == "weapon.knife" || id == "weapon.legend_shiv")
		{
			_properties.MeleeSkill += 12;
			_properties.DamageDirectMult += 0.4;
		}

		if (id == "weapon.dagger" || id == "weapon.rondel_dagger" || id == "weapon.named_dagger" || id == "weapon.obsidian_dagger" || id == "weapon.legend_redback_dagger" || id == "weapon.goblin_notched_blade" || id == "weapon.qatal_dagger" || id == "weapon.named_qatal_dagger")
		{
			_properties.MeleeSkill += 3;
			_properties.DamageDirectMult += 0.1;
		}
	}

});
