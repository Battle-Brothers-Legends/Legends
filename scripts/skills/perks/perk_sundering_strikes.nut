this.perk_sundering_strikes <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.sundering_strikes";
		this.m.Name = this.Const.Strings.PerkName.SunderingStrikes;
		this.m.Description = this.Const.Strings.PerkDescription.SunderingStrikes;
		this.m.Icon = "ui/perks/sunderingstrikes_circle.png";
		this.m.IconDisabled = "ui/perks/sunderingstrikes_circle_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	/* -- old code
	function onUpdate( _properties )
	{
		_properties.DamageArmorMult += 0.2;
	}*/
	//new version starts here ---
	function onUpdate(_properties) {};
	
	function onAnySkillUsed(_skill, _targetEntity, _properties) 
	{
		local actor = this.getContainer().getActor();
		local weapon = actor.getMainhandItem();
		local bonus;
		if (weapon != null) //check if holding weapon or not
		{
			if (weapon.isItemType(this.Const.Items.ItemType.TwoHanded)) //if holding 2h
			{
				bonus = _skill.b.ActionPointCost >= 6 ? 0.3 : 0.25; //If the weapon is 2h, the "bonus" variable is assigned a value of 0.3 if the AP cost of the associated skill is greater than or equal to 6, and 0.25 otherwise
			} 
			else 
			{
				bonus = _skill.b.ActionPointCost >= 6 ? 0.25 : 0.20; //If the weapon is not 2h, the "bonus" variable is assigned a value of 0.25 if the AP cost of the associated skill is greater than or equal to 6, and 0.20 otherwise
			} //This strives for more balance in that a smaller damage and armor multiplier bonus if they are wielding a one-handed weapon and the associated skill has a high action point cost
			_properties.DamageArmorMult += bonus; //finally adds the "bonus" variable to the "DamageArmorMult", hence the damage and armor multiplier is modified based on the weapon they are wielding and the action point cost of the associated skill.
		}
	}; //new version ends here --
});

