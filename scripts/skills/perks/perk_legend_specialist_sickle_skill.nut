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
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null)
		{
			if(item.getID() == "weapon.sickle" || item.getID() == "weapon.goblin_notched_blade"  || item.getID() == "weapon.legend_named_sickle")
			{
			_properties.MeleeSkill += 12;
			_properties.DamageDirectMult += 0.25;
			}
			if(item.getID() == "weapon.arming_sword" || item.getID() == "weapon.noble_sword" || item.getID() == "weapon.shortsword" || item.getID() == "weapon.scimitar" || item.getID() == "weapon.falchion" || item.getID() == "weapon.shamshir" || item.getID() == "weapon.goblin_falchion" || item.getID() == "weapon.broken_ancient_sword" ||  item.getID() == "weapon.named_sword" || item.getID() == "weapon.ancient_sword" || item.getID() == "weapon.fencing_sword" || item.getID() == "weapon.legend_skin_flayer")
			{
			_properties.MeleeSkill += 3;
			_properties.DamageDirectMult += 0.08;
			}
		}
	}

});
