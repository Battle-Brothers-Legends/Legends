this.perk_legend_specialist_sling_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_sling_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistSlingDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistSlingDamage;
		this.m.Icon = "ui/perks/sling_01.png";
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
		if (item != null && (item.getID() == "weapon.legend_sling" || item.getID() == "weapon.legend_slingstaff" || item.getID() == "weapon.staff_sling" || item.getID() == "weapon.nomad_sling"))
		{
			_properties.DamageRegularMin += 4;
			_properties.DamageRegularMax += 12;
		}
	}

});
