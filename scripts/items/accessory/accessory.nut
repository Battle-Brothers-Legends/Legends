this.accessory <- this.inherit("scripts/items/item", {
	m = {
		StaminaModifier = 0,
		StashModifier = 0,
		AddGenericSkill = true,
		ShowOnCharacter = false,
		Sprite = null,
		SpriteCorpse = null
	},
	function getStaminaModifier()
	{
		return this.m.StaminaModifier;
	}

	function getStashModifier()
	{
		return this.m.StashModifier;
	}

	function create()
	{
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.ItemType = this.Const.Items.ItemType.Accessory;
	}

	function getTooltip()
	{
		local result = [
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
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.SlotType == this.Const.ItemSlot.Accessory)
		{
			result.push({
				id = 64,
				type = "text",
				text = "Worn in Accessory Slot"
			});
		}
		else
		{
			result.push({
				id = 64,
				type = "text",
				text = "Carried in Bag"
			});
		}

		result.push({
			id = 65,
			type = "text",
			text = "Usable in Combat"
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}
		else if (this.m.StaminaModifier > 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}

		if (this.m.StashModifier > 0)
		{
			result.push({
				id = 9,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Provides [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.StashModifier + "[/color] stash spaces. If you remove the bag, spaces at the bottom of the stash will be lost, along with any items in those spaces."
			});
		}

		return result;
	}

	function onEquip()
	{
		this.item.onEquip();

		if (this.m.AddGenericSkill)
		{
			this.addGenericItemSkill();
		}

		if (this.m.ShowOnCharacter)
		{
			local app = this.getContainer().getAppearance();
			app.Accessory = this.m.Sprite;
			this.getContainer().updateAppearance();
		}

		if (this.m.StashModifier > 0)
		{
			if (this.World.State.getPlayer() == null)
			{
				return;
			}
			this.World.State.getPlayer().calculateStashModifier()
		}

	}

	function onUnequip()
	{
		this.item.onUnequip();

		if (this.m.ShowOnCharacter)
		{
			local app = this.getContainer().getAppearance();
			app.Accessory = "";
			this.getContainer().updateAppearance();
		}

		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		if (this.m.StashModifier > 0)
		{
			this.getContainer().unequipNoUpdate(this);
			this.World.State.getPlayer().calculateStashModifier()
		}

	}

	function onUpdateProperties( _properties )
	{
	}

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
		this.updateVariant();
	}

});

