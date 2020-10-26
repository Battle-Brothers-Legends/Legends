this.perk_legend_specialist_sling_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_sling_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistSlingSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistSlingSkill;
		this.m.Icon = "ui/perks/shortbow_02.png";
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
			_properties.RangedSkill += 12;
			_properties.DamageArmorMult *= 1.25;
		}
	}

});
