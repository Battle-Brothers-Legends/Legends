this.perk_legend_specialist_ninetails_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_ninetails_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistNinetailsDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistNinetailsDamage;
		this.m.Icon = "ui/perks/woodaxe_01.png";
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
				_properties.DamageRegularMin += this.Math.floor(resolve * 0.1);
				_properties.DamageRegularMax +=this.Math.floor(resolve * 0.05);
			}
			if(item.getID() == "weapon.battle_whip" || item.getID() == "weapon.thorned_whip" || item.getID() == "weapon.named_battle_whip" || item.getID() == "weapon.flail" || item.getID() == "weapon.two_handed_flail" || item.getID() == "weapon.two_handed_wooden_flail" || item.getID() == "weapon.legend_pole_flail" || item.getID() == "weapon.legend_ranged_reinforced_flail" || item.getID() == "weapon.legend_ranged_wooden_flail")
			{
				_properties.DamageRegularMin += this.Math.floor(resolve * 0.05);
				_properties.DamageRegularMax += this.Math.floor(resolve * 0.025);
			}
		}
	}

});
