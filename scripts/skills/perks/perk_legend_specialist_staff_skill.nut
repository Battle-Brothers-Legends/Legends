this.perk_legend_specialist_staff_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_staff_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecStaffSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecStaffSkill;
		this.m.Icon = "ui/perks/spear_02.png";
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
		if (item == null)
		{
			return;
		}
		if (item.getID() == "weapon.legend_staff" || item.getID() == "weapon.legend_tipstaff" || item.getID() == "weapon.legend_staff_gnarled" || item.getID() == "weapon.legend_mystic_staff" || item.getID() == "weapon.legend_staff_vala")
		{
			_properties.MeleeDefense += 16;
			_properties.RangedDefense += 16;
		}

		if (item.getID() == "weapon.legend_swordstaff" || item.getID() == "weapon.legend_named_swordstaff" || item.getID() == "weapon.legend_named_slingstaff" || item.getID() == "weapon.legend_slingstaff" || item.getID() == "weapon.legend_mage_swordstaff" || item.getID() == "weapon.lute" || item.getID() == "weapon.named_lute" || item.getID() == "weapon.drum_item" || item.getID() == "weapon.legend_drum")
		{
			_properties.MeleeDefense += 8;
			_properties.RangedDefense += 8;
		}


	}

});
