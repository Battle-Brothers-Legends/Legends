this.perk_legend_specialist_shovel_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_shovel_damage";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistShovelDamage;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistShovelDamage;
		this.m.Icon = "ui/perks/woodaxe_01.png";
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
			local ids = [
				"weapon.legend_shovel",
				"weapon.legend_named_shovel"
			];

			if (ids.find(item.getID()) != null)
			{
				_properties.DamageRegularMin += 4;
				_properties.DamageRegularMax += 12;
			}

			ids = [
				"weapon.two_handed_mace",
				"weapon.two_handed_flanged_mace",
				"weapon.named_two_handed_mace",
				"weapon.named_two_handed_spiked_mace",
				"weapon.goedendag",
				"weapon.legend_military_goedendag",
				"weapon.legend_two_handed_club",
				"weapon.two_handed_spiked_mace",
				"weapon.legend_bough",
				"weapon.named_polemace",
				"weapon.polemace",
				"weapon.legend_military_goedendag",
				"weapon.legend_named_military_goedendag"
			];

			if (ids.find(item.getID()) != null)
			{
				_properties.DamageRegularMin += 1;
				_properties.DamageRegularMax += 3;
			}
		}
	}

});
