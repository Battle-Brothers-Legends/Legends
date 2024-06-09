this.missing_hand_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.missing_hand";
		this.m.Name = "Missing Hand";
		this.m.Icon = "ui/injury/injury_permanent_icon_07.png";
		this.m.Description = "Uh-oh! Unless something is done about this, missing a hand will prevent this character from using shields, two-handed weapons and throwing nets and from double gripping one-handed weapons.";
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded()
	{
		local items = this.getContainer().getActor().getItems();

		if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand) && items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() == this.Const.ItemSlot.Offhand)
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			//item.unequip();
			item.drop();
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand))
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
			//item.unequip();
			item.drop();
		}

		items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
	}

	function onRemoved()
	{
		this.getContainer().getActor().getItems().getData()[this.Const.ItemSlot.Offhand][0] = null;
	}

	function onUpdate (_properties)
	{
	}
});

