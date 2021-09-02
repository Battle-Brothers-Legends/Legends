this.perk_legend_specialist_shovel_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_specialist_shovel_skill";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecialistShovelSkill;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecialistShovelSkill;
		this.m.Icon = "ui/perks/shovel_02.png";
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
			if (this.hasShovel(item))
			{
				_properties.MeleeSkill += 12;
			}

			local ids = [
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
				_properties.MeleeSkill += 3;
			}
		}
	}

	function hasShovel(_item)
	{
		local ids = [
			"weapon.legend_shovel",
			"weapon.legend_named_shovel"
		];

		if (_item != null && ids.find(_item.getID()) != null)
		{
			return true;
		}
		return false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (this.hasShovel(item) && !actor.getSkills().hasSkill("actives.knock_out"))
		{
			item.addSkill(this.new("scripts/skills/actives/knock_out"));
		}
	}

	function onRemoved()
	{
		this.getContainer().getActor().getSkills().removeByID("actives.knock_out");
	}

});
