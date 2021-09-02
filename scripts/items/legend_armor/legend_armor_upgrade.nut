this.legend_armor_upgrade <- this.inherit("scripts/items/item", {
	m = {
		OverlayIcon = "",
		OverlayIconLarge = "",
		SpriteFront = null,
		SpriteBack = null,
		SpriteDamagedFront = null,
		SpriteDamagedBack = null,
		SpriteCorpseFront = null,
		SpriteCorpseBack = null,
		ArmorDescription = "",
		Armor = null,
		ConditionModifier = 0,
		StaminaModifier = 0,
		Type = -1,
		ImpactSound = this.Const.Sound.ArmorLeatherImpact,
		InventorySound = this.Const.Sound.ArmorLeatherImpact,
		IsDestroyedOnRemove = false,
		Variants = [],
	},
	function create()
	{
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.ItemType = this.Const.Items.ItemType.Armor;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
	}

	function isAmountShown()
	{
		return this.m.Condition != this.m.ConditionMax;
	}

	function getAmountString()
	{
		return "" + this.Math.floor(this.m.Condition / (this.m.ConditionMax * 1.0) * 100) + "%";
	}

	function getAmountColor()
	{
		if (this.Math.floor(this.m.Condition / (this.m.ConditionMax * 1.0) * (this.Const.Items.ConditionColor.len() - 1)) > 4)
		{
			return 4;
		}

		return this.Const.Items.ConditionColor[this.Math.max(0, this.Math.floor(this.m.Condition / (this.m.ConditionMax * 1.0) * (this.Const.Items.ConditionColor.len() - 1)))];
	}

	function getValue()
	{
		return this.Math.floor(this.m.Value * (1.0 * this.m.Condition / (1.0 * this.m.ConditionMax)));
	}

	function getType()
	{
		return this.m.Type;
	}

	function getOverlayIcon()
	{
		return this.m.OverlayIcon;
	}

	function getOverlayIconLarge()
	{
		return this.m.OverlayIconLarge;
	}

	function isUsed()
	{
		return this.m.Armor != null;
	}

	function isDestroyedOnRemove()
	{
		return this.m.IsDestroyedOnRemove;
	}

	function getArmor()
	{
		return this.m.Armor;
	}

	function setArmor( _a )
	{
		this.m.Armor = _a == null ? null : this.WeakTableRef(_a);
	}

	function getArmorDescription()
	{
		return this.m.ArmorDescription;
	}

	function getStaminaModifier()
	{
		return this.m.StaminaModifier;
	}

	function getIconOverlay()
	{

		local L = [];

		if (this.isNamed())
		{
			L.push("layers/named_icon_glow.png")
		}

		L.push(this.m.Icon)

		switch (this.m.Type)
		{
			case this.Const.Items.ArmorUpgrades.Chain:
				L.push("layers/layer_1.png");
				break;
			case this.Const.Items.ArmorUpgrades.Plate:
				L.push("layers/layer_2.png");
				break;
			case this.Const.Items.ArmorUpgrades.Tabbard:
				L.push("layers/layer_3.png");
				break;
			case this.Const.Items.ArmorUpgrades.Cloak:
				L.push("layers/layer_4.png");
				break;
			case this.Const.Items.ArmorUpgrades.Attachment:
				L.push("layers/layer_5.png");
				break;
		}

		if (L.len() == 0)
		{
			return [
				""
			];
		}

		return L;
	}

	function getIconLargeOverlay()
	{
		return this.getIconOverlay();
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
				text = this.m.Description
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getOverlayIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getOverlayIconLarge(),
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

		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto an armor carried by the currently selected character in order to attach the armor upgrade."
		});
		result.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/armor_body.png",
			value = this.getCondition(),
			valueMax = this.getConditionMax(),
			text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
			style = "armor-body-slim"
		});

		if (this.getStaminaModifier() < 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + this.Const.UI.Color.NegativeValue + "]" + this.getStaminaModifier() + "[/color]"
			});
		} else if (this.getStaminaModifier() > 0){
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + this.Const.UI.Color.PositiveValue + "] +" + this.getStaminaModifier() + "[/color]"
			});
		}

		return result;
	}

	function getArmorTooltip( _result )
	{
		this.onArmorTooltip(_result);
		_result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/plus.png",
			text = this.getDescription()
		});
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play(this.m.ImpactSound[0], this.Const.Sound.Volume.Inventory);
	}

	function addArmor( _a)
	{
		if (_a + this.m.Condition <= this.m.ConditionMax)
		{
			this.m.Condition += _a
			return 0
		}

		this.m.Condition = this.m.ConditionMax;
		return _a - (this.m.ConditionMax - this.m.Condition);
	}

	function removeArmor( _a)
	{
		if (this.m.Condition - _a >= 0)
		{
			this.m.Condition -= _a
			return 0
		}
		local delta = _a - this.m.Condition
		this.m.Condition = 0;
		return delta;
	}

	function onRepair( _a)
	{
		this.setCondition(_a);
	}

	function setCondition( _a )
	{
		if (this.m.Condition <= _a)
		{
			this.addArmor(_a - this.m.Condition);
		}
		else
		{
			this.removeArmor(this.m.Condition - _a)
		}

		if (this.m.Armor == null)
		{
			return
		}

		if (this.m.Armor.getContainer() != null && this.m.Armor.isEquipped())
		{
			local app = this.m.Armor.getContainer().getAppearance();
			this.updateAppearance(app);
		}
	}

	function getContainer()
	{
		return this.m.Armor == null ? this.item.getContainer() : this.m.Armor.getContainer();
	}

	function getRepair()
	{
		return this.Math.floor(this.getCondition());
	}

	function getRepairMax()
	{
		return this.Math.floor(this.getConditionMax());
	}

	function updateAppearance( _app )
	{
		local frontSprite = "";
		local backSprite = "";

		if (this.m.Condition / this.m.ConditionMax <= this.Const.Combat.ShowDamagedArmorThreshold)
		{
			frontSprite = this.m.SpriteDamagedFront != null ? this.m.SpriteDamagedFront : this.m.SpriteFront != null ? this.m.SpriteFront : "";
			backSprite = this.m.SpriteDamagedBack != null ? this.m.SpriteDamagedBack : this.m.SpriteBack != null ? this.m.SpriteBack : "";
		}
		else
		{
			frontSprite = this.m.SpriteFront != null ? this.m.SpriteFront : "";
			backSprite = this.m.SpriteBack != null ? this.m.SpriteBack : "";
		}

		if (_app == null)
		{
			return;
		}

		switch(this.m.Type)
		{
		case this.Const.Items.ArmorUpgrades.Chain:
			_app.ArmorLayerChain = backSprite;
			_app.CorpseArmorLayerChain = this.m.SpriteCorpseBack != null ? this.m.SpriteCorpseBack : "";
			break;

		case this.Const.Items.ArmorUpgrades.Plate:
			_app.ArmorLayerPlate = backSprite;
			_app.CorpseArmorLayerPlate = this.m.SpriteCorpseBack != null ? this.m.SpriteCorpseBack : "";
			break;

		case this.Const.Items.ArmorUpgrades.Tabbard:
			_app.ArmorLayerTabbard = backSprite;
			_app.CorpseArmorLayerTabbard = this.m.SpriteCorpseBack != null ? this.m.SpriteCorpseBack : "";
			break;

		case this.Const.Items.ArmorUpgrades.Cloak:
			_app.ArmorLayerCloak = backSprite;
			_app.CorpseArmorLayerCloak = this.m.SpriteCorpseBack != null ? this.m.SpriteCorpseBack : "";
			break;

		case this.Const.Items.ArmorUpgrades.Attachment:
			_app.ArmorUpgradeFront = frontSprite;
			_app.ArmorUpgradeBack = this.m.SpriteBack != null ? this.m.SpriteBack : "";
			_app.CorpseArmorUpgradeFront = backSprite;
			_app.CorpseArmorUpgradeBack = this.m.SpriteCorpseBack ? this.m.SpriteCorpseBack : "";
			break;
		}
	}

	function onEquip()
	{
		this.item.onEquip();
		this.setCurrentSlotType(this.m.SlotType);
	}

	function onUnequip()
	{
		this.item.onUnequip()
		this.setCurrentSlotType(this.Const.ItemSlot.None);
	}

	function clearAppearance( _app )
	{
		this.Sound.play("sounds/inventory/armor_upgrade_use_01.wav", this.Const.Sound.Volume.Inventory);

		if (_app == null) return;

		switch(this.m.Type)
		{
		case this.Const.Items.ArmorUpgrades.Chain:
			_app.ArmorLayerChain = "";
			_app.CorpseArmorLayerChain = "";
			break;

		case this.Const.Items.ArmorUpgrades.Plate:
			_app.ArmorLayerPlate = "";
			_app.CorpseArmorLayerPlate = "";
			break;

		case this.Const.Items.ArmorUpgrades.Tabbard:
			_app.ArmorLayerTabbard = "";
			_app.CorpseArmorLayerTabbard = "";
			break;

		case this.Const.Items.ArmorUpgrades.Cloak:
			_app.ArmorLayerCloak = "";
			_app.CorpseArmorLayerCloak = "";
			break;

		case this.Const.Items.ArmorUpgrades.Attachment:
			_app.ArmorUpgradeFront = "";
			_app.ArmorUpgradeBack = "";
			_app.CorpseArmorUpgradeFront = "";
			_app.CorpseArmorUpgradeBack = "";
			break;
		}

		return this.m.IsDestroyedOnRemove;
	}

	function onUse( _actor, _item = null )
	{
		if (this.isUsed()) return false;

		local armor = _item == null ? _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body) : _item;

		if (armor == null) return false;

		local success = armor.setUpgrade(this);

		if (success)
		{
			this.Sound.play("sounds/inventory/armor_upgrade_use_01.wav", this.Const.Sound.Volume.Inventory);
		}

		return success;
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
		if (_damage >= this.m.Condition)
		{
			local leftoverDamage = _damage - this.m.Condition;
			this.m.Condition = 0.0;
			return leftoverDamage;
		}

		this.m.Condition = this.Math.max(0, this.m.Condition - _damage) * 1.0;
		return 0.0;
	}

	function onArmorTooltip( _result )
	{
	}

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
	}
});
