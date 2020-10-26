this.perk_legend_specialist_pitchfork_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_pitchfork_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistPitchforkDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistPitchforkDamage;
		this.m.Icon = "ui/perks/pitchfork_01.png";
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
			local itemID = item.getID();
			if(itemID == "weapon.pitchfork" || itemID == "weapon.legend_wooden_pitchfork"  || itemID == "weapon.legend_hoe"  || itemID == "weapon.legend_scythe"  || itemID == "weapon.wooden_flail")
			{
				_properties.DamageRegularMin += 4;
				_properties.DamageRegularMax += 12;
			}
			if(itemID == "weapon.pike" || itemID == "weapon.hooked_blade" || itemID == "weapon.billhook"  || itemID == "weapon.goblin_pike"   || itemID == "weapon.bladed_pike"  || itemID == "weapon.broken_bladed_pike" || itemID == "weapon.named_pike" || itemID == "weapon.named_billhook" || itemID == "weapon.warscythe" || itemID == "weapon.legend_halberd" || itemID == "weapon.legend_military_voulge" || itemID == "weapon.legend_voulge" || itemID == "weapon.legend_named_halberd" || itemID == "weapon.legend_named_voulge" || itemID == "weapon.swordlance" || itemID == "weapon.named_swordlance")
			{
				_properties.DamageRegularMin += 1;
				_properties.DamageRegularMax += 3;
			}
		}
	}

});
