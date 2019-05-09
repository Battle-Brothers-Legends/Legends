this.perk_duelist <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.duelist";
		this.m.Name = this.Const.Strings.PerkName.Duelist;
		this.m.Description = this.Const.Strings.PerkDescription.Duelist;
		this.m.Icon = "skills/passive_03.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (off == null || !this.getContainer().getActor().getItems().hasBlockedSlot(this.Const.ItemSlot.Offhand) && off.isItemType(this.Const.Items.ItemType.Tool))
		{
			_properties.DamageDirectAdd += 0.25;
		}
	}

});

