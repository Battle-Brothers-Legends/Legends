this.perk_full_force <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.full_force";
		this.m.Name = this.Const.Strings.PerkName.LegendFullForce;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFullForce;
		this.m.Icon = "ui/perks/fullforce_circle.png";
		this.m.IconDisabled = "ui/perks/fullforce_circle_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
			local fat = 0;
			local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
			local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);
			local mainhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local offhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (body != null)
			{
				fat = fat + body.getStaminaModifier();
			}

			if (head != null)
			{
				fat = fat + head.getStaminaModifier();
			}

			if (mainhand != null)
			{
				fat = fat + mainhand.getStaminaModifier();
			}

			if (offhand != null)
			{
				fat = fat + offhand.getStaminaModifier();
			}

			local bonus = this.Math.abs(fat / 10);
			_properties.MeleeDefense += this.Math.floor(bonus);
	}

});
