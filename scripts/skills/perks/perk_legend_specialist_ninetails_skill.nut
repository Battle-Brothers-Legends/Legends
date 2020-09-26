this.perk_legend_specialist_ninetails_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_ninetails_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistNinetailsSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistNinetailsSkill;
		this.m.Icon = "ui/perks/spear_02.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local resolve = actor.getCurrentProperties().Bravery;

		if (item != null)
		{
			if(item.getID() == "weapon.legend_cat_o_nine_tails")
			{
				_properties.MeleeSkill += this.Math.floor(resolve * 0.1);
			}
			if(item.getID() == "weapon.battle_whip" || item.getID() == "weapon.thorned_whip" || item.getID() == "weapon.named_battle_whip" || item.getID() == "weapon.flail" || item.getID() == "weapon.two_handed_flail" || item.getID() == "weapon.two_handed_wooden_flail" || item.getID() == "weapon.legend_pole_flail" || item.getID() == "weapon.legend_ranged_reinforced_flail" || item.getID() == "weapon.legend_ranged_wooden_flail")
			{
				_properties.MeleeSkill += this.Math.floor(resolve * 0.05);
			}
		}
	}

});
