this.legend_armor <- this.inherit("scripts/items/armor/armor", {
	m = {
		Upgrades = null,
		Variants = [],
		Blocked = [],
		Type = -1
	},
	function create()
	{
		this.armor.create();
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.Upgrades = [];

		for( local i = 0; i < this.Const.Items.ArmorUpgrades.COUNT; i = ++i )
		{
			this.m.Upgrades.push(null);
			this.m.Blocked.push(false);
		}
	}

	function blockUpgrades()
	{
		for( local i = 0; i < this.Const.Items.ArmorUpgrades.COUNT; i = ++i )
		{
			this.m.Blocked[i] = true;
		}
	}

	function onAddedToStash( _stashID )
	{
	}

	function getRepair()
	{
		return this.Math.floor(this.getArmor());
	}

	function getRepairMax()
	{
		return this.Math.floor(this.getArmorMax());
	}

	function getArmor()
	{
		local value = this.m.Condition;

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			value = value + u.getCondition();
		}

		return value;
	}

	function getArmorMax()
	{
		local value = this.m.ConditionMax;

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			value = value + u.getConditionMax();
		}

		return value;
	}

	function setArmor( _a )
	{
		if (_a <= this.m.ConditionMax)
		{
			this.m.Condition = _a;
			this.updateAppearance();
			return;
		}

		local delta = _a - this.m.ConditionMax;
		this.m.Condition = this.m.ConditionMax;

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			delta = u.onRepair(delta);

			if (delta <= 0)
			{
				break;
			}
		}

		this.updateAppearance();
	}

	function isAmountShown()
	{
		return this.getArmor() != this.getArmorMax();
	}

	function getAmountString()
	{
		return "" + this.Math.floor(this.getArmor() / (this.getArmorMax() * 1.0) * 100) + "%";
	}

	function getAmountColor()
	{
		return this.Const.Items.ConditionColor[this.Math.min(this.Const.Items.ConditionColor.len() - 1, this.Math.max(0, this.Math.floor(this.getArmor() / (this.getArmorMax() * 1.0) * (this.Const.Items.ConditionColor.len() - 1))))];
	}

	function upgradeIsBlocked( _slot )
	{
		return this.m.Blocked[_slot];
	}

	function getUpgrade( _slot = -1 )
	{
		if (_slot != -1)
		{
			return this.m.Upgrades[_slot];
		}

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			return u;
		}

		return null;
	}

	function getUpgrades()
	{
		local slots = [];

		foreach( i, u in this.m.Upgrades )
		{
			if (this.m.Blocked[i])
			{
				slots.push(-1);
			}
			else if (u == null)
			{
				slots.push(0);
			}
			else
			{
				slots.push(1);
			}
		}

		return slots;
	}

	function getIconLargeOverlayNamed()
	{
		if (this.isItemType(this.Const.Items.ItemType.Named))
		{
			return "legend_armor/inventory_named_armor.png";
		}

		if (this.isItemType(this.Const.Items.ItemType.Legendary))
		{
			return "legend_armor/inventory_named_armor.png";
		}

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			if (u.isItemType(this.Const.Items.ItemType.Named))
			{
				return "legend_armor/inventory_named_armor.png";
			}

			if (u.isItemType(this.Const.Items.ItemType.Legendary))
			{
				return "legend_armor/inventory_named_armor.png";
			}
		}

		return ""
	}

	function getIconLargeOverlayRuned()
	{
		local rune = this.getUpgrade(this.Const.Items.ArmorUpgrades.Rune)
		if (rune == null)
		{
			return ""
		}

		return "legend_armor/inventory_runed_armor.png";
	}

	function getIconNamed()
	{
		if (this.isItemType(this.Const.Items.ItemType.Named))
		{
			return "";
		}

		if (this.isItemType(this.Const.Items.ItemType.Legendary))
		{
			return "";
		}

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			if (u.isItemType(this.Const.Items.ItemType.Named))
			{
				return "legend_armor/named_armor.png";
			}

			if (u.isItemType(this.Const.Items.ItemType.Legendary))
			{
				return "legend_armor/named_armor.png";
			}
		}

		return "";
	}

	function getIconRuned()
	{
		if (this.isItemType(this.Const.Items.ItemType.Named))
		{
			return "";
		}

		if (this.isItemType(this.Const.Items.ItemType.Legendary))
		{
			return "";
		}

		local rune = this.getUpgrade(this.Const.Items.ArmorUpgrades.Rune)
		if (rune == null)
		{
			return ""
		}

		return "legend_armor/runed_armor.png";
	}

	function getIconOverlay()
	{
		local L = [];

		local named = this.getIconNamed()
		local runed = this.getIconRuned()

		if (named != "" && runed != "")
		{
			L.push(runed);
		}

		if (named != "" || runed != "")
		{
			L.push(this.m.Icon);
		}

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			L.push(u.getOverlayIcon());
		}

		if (L.len() == 0)
		{
			return [
				""
			];
		}

		return L;
	}

	function getIcon()
	{
		local named = this.getIconNamed();
		local runed = this.getIconRuned();

		if (named != "")
		{
			return named;
		}

		if (runed != "")
		{
			return runed;
		}

		return this.m.Icon;
	}

	function getIconLarge()
	{
		local named = this.getIconLargeOverlayNamed();
		local runed = this.getIconLargeOverlayRuned();

		if (named != "")
		{
			return named;
		}

		if (runed != "")
		{
			return runed;
		}

		return this.m.IconLarge != "" ? this.m.IconLarge : null;
	}

	function getIconLargeOverlay()
	{
		local L = [];

		local named = this.getIconLargeOverlayNamed()
		local runed = this.getIconLargeOverlayRuned()

		if (named != "" && runed != "")
		{
			L.push(runed);
		}

		if (named != "" || runed != "")
		{
			L.push(this.m.IconLarge);
		}

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			L.push(u.getOverlayIconLarge());
		}

		if (L.len() == 0)
		{
			return [
				""
			];
		}

		return L;
	}

	function getStaminaModifier()
	{
		local value = this.m.StaminaModifier;

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			value = value + u.getStaminaModifier();
		}

		return value;
	}

	function getValue()
	{
		local value = this.m.Value * (1.0 * this.m.Condition / (1.0 * this.m.ConditionMax));

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			value = value + u.getValue();
		}

		return this.Math.floor(value);
	}

	function setUpgrade( _upgrade )
	{
		if (!this.Const.DLC.Unhold && !this.Const.DLC.Wildmen)
		{
			return false;
		}

		if (_upgrade == null)
		{
			return true;
		}

		if (_upgrade != null && this.m.Blocked[_upgrade.getType()])
		{
			return false;
		}

		if (this.m.Upgrades[_upgrade.getType()] != null)
		{
			local app;

			if (this.getContainer() != null && this.isEquipped())
			{
				app = this.getContainer().getAppearance();
			}

			local item = this.m.Upgrades[_upgrade.getType()];
			item.onRemoved(app);

			if (!item.isDestroyedOnRemove())
			{
				this.World.Assets.getStash().add(item);
			}
		}

		this.m.Upgrades[_upgrade.getType()] = _upgrade;
		this.m.Upgrades[_upgrade.getType()].setArmor(this);
		this.m.Upgrades[_upgrade.getType()].onAdded();
		this.updateAppearance();
		return true;
	}

	function removeUpgrade( _slot )
	{
		if (this.m.Upgrades[_slot] == null)
		{
			return null;
		}

		local app = this.getContainer().getAppearance();
		local item = this.m.Upgrades[_slot];
		this.m.Upgrades[_slot] = null;
		item.onRemoved(app);
		this.updateAppearance();
		return item;
	}

	function makeName()
	{
		local NAME = this.getName();

		if (this.getUpgrade(1) != null)
		{
			NAME = this.getUpgrade(1).getName() + " on " + this.getName();

			if (this.getUpgrade(0) != null)
			{
				NAME = this.getUpgrade(1).getName() + " on " + this.getUpgrade(0).getName();
			}
		}
		else if (this.getUpgrade(0) != null)
		{
			NAME = this.getUpgrade(0).getName() + " on " + this.getName();
		}

		if (this.getUpgrade(5) != null)
		{
			NAME = "[color=" + this.Const.UI.Color.RuneColor + "] (Runed)[/color]" + NAME;
		}

		return NAME;
	}

	function getTooltip()
	{
		local description = this.getDescription();

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			description = description + (" " + u.getArmorDescription());
		}

		local result = [
			{
				id = 1,
				type = "title",
				text = this.makeName()
			},
			{
				id = 2,
				type = "description",
				text = description
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		result.push({
			id = 3,
			type = "image",
			image = this.m.IconLarge != "" ? this.m.IconLarge : this.m.Icon,
			isLarge = this.m.IconLarge != "" ? true : false
		});


		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			if (u.getIconLarge() != null)
			{
				result.push({
					id = 3,
					type = "image",
					image = u.getIconLarge(),
					isLarge = true
				});
			}
			else
			{
				result.push({
					id = 3,
					type = "image",
					image = u.getIcon()
				});
			}
		}

		result.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/armor_body.png",
			value = this.Math.floor(this.getArmor()),
			valueMax = this.Math.floor(this.getArmorMax()),
			text = "" + this.Math.floor(this.getArmor()) + " / " + this.Math.floor(this.getArmorMax()) + "",
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
		}

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.getArmorTooltip(result);
		}

		if (this.isRuned())
		{
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = this.getRuneSigilTooltip()
			});
		}

		return result;
	}

	function isDroppedAsLoot()
	{
		if (!this.item.isDroppedAsLoot())
		{
			return false;
		}

		local isPlayer = this.m.LastEquippedByFaction == this.Const.Faction.Player || this.getContainer() != null && this.getContainer().getActor() != null && !this.getContainer().getActor().isNull() && this.isKindOf(this.getContainer().getActor().get(), "player");
		local isLucky = !this.Tactical.State.isScenarioMode() && this.World.Assets.getOrigin().isDroppedAsLoot(this);
		local repair = this.getRepair();
		local repairMax = this.getRepairMax();

		if (repair > 10 && isPlayer)
		{
			return true;
		}

		if (repair > 10 && repair / repairMax >= 0.2)
		{
			return true;
		}

		if (this.isItemType(this.Const.Items.ItemType.Named))
		{
			return true;
		}

		if (this.isItemType(this.Const.Items.ItemType.Legendary))
		{
			return true;
		}

		if (isLucky)
		{
			return true;
		}

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			if (u.isItemType(this.Const.Items.ItemType.Named))
			{
				return true;
			}

			if (u.isItemType(this.Const.Items.ItemType.Legendary))
			{
				return true;
			}

		}

		return false;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play(this.m.InventorySound[this.Math.rand(0, this.m.InventorySound.len() - 1)], this.Const.Sound.Volume.Inventory);
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_body_" + variant;
		this.m.SpriteDamaged = "bust_body_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_body_" + variant + "_dead";
		this.m.IconLarge = "armor/inventory_body_armor_" + variant + ".png";
		this.m.Icon = "armor/icon_body_armor_" + variant + ".png";
	}

	function updateAppearance()
	{
		if (this.getContainer() == null || !this.isEquipped())
		{
			return;
		}

		if (!this.m.ShowOnCharacter)
		{
			return;
		}

		local app = this.getContainer().getAppearance();
		app.CorpseArmor = this.m.SpriteCorpse;
		app.HideBody = this.m.HideBody;
		local sound = this.m.ImpactSound;

		if (this.m.Upgrades[this.Const.Items.ArmorUpgrades.Plate] != null)
		{
			sound = this.m.Upgrades[this.Const.Items.ArmorUpgrades.Plate].m.ImpactSound;
		}
		else if (this.m.Upgrades[this.Const.Items.ArmorUpgrades.Chain] != null)
		{
			sound = this.m.Upgrades[this.Const.Items.ArmorUpgrades.Chain].m.ImpactSound;
		}

		app.ImpactSound[this.Const.BodyPart.Body] = sound;

		if (this.m.Condition / this.m.ConditionMax <= this.Const.Combat.ShowDamagedArmorThreshold)
		{
			if (this.m.SpriteDamaged != null)
			{
				app.Armor = this.m.SpriteDamaged;
			}
		}
		else if (this.m.Sprite != null)
		{
			app.Armor = this.m.Sprite;
		}

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.updateAppearance(app);
		}

		this.getContainer().updateAppearance();
	}

	function onEquip()
	{
		this.item.onEquip();

		if (this.m.AddGenericSkill)
		{
			this.addGenericItemSkill();
		}

		this.updateAppearance();

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.onEquip();
		}
	}

	function onUnequip()
	{
		this.item.onUnequip();

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.onUnequip();
		}

		if (this.m.ShowOnCharacter)
		{
			local app = this.getContainer().getAppearance();
			app.Armor = "";
			app.ArmorLayerChain = "";
			app.ArmorLayerPlate = "";
			app.ArmorLayerTabbard = "";
			app.ArmorLayerCloak = "";
			app.ArmorUpgradeFront = "";
			app.ArmorUpgradeBack = "";
			app.CorpseArmor = "";
			app.CorpseArmorLayerChain = "";
			app.CorpseArmorLayerPlate = "";
			app.CorpseArmorLayerTabbard = "";
			app.CorpseArmorLayerCloak = "";
			app.CorpseArmorUpgradeFront = "";
			app.CorpseArmorUpgradeBack = "";
			app.HideBody = false;
			app.ImpactSound[this.Const.BodyPart.Body] = [];
			this.getContainer().updateAppearance();

			if (this.getContainer().getActor() != null && !this.getContainer().getActor().isNull())
			{
				this.getContainer().getActor().resetBloodied();
			}
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.onBeforeDamageReceived(_attacker, _skill, _hitInfo, _properties);
		}
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
		local totalDamage = _damage;

		for( local i = this.Const.Items.ArmorUpgrades.COUNT - 1; i >= 0; i = --i )
		{
			local u = this.m.Upgrades[i];

			if (u == null)
			{
			}
			else
			{
				totalDamage = u.onDamageReceived(totalDamage, _fatalityType, _attacker);
			}
		}

		if (this.m.Condition == 0)
		{
			this.updateAppearance();
			return;
		}

		this.m.Condition = this.Math.max(0, this.m.Condition - totalDamage) * 1.0;

		if (this.m.Condition == 0 && !this.m.IsIndestructible)
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s " + this.makeName() + " is hit for [b]" + this.Math.floor(_damage) + "[/b] damage and has been destroyed!");
		}
		else
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s " + this.makeName() + " is hit for [b]" + this.Math.floor(_damage) + "[/b] damage");
		}
		this.updateAppearance();
	}

	function onUpdateProperties( _properties )
	{
		if (this.getContainer().getActor() == null)
		{
			return;
		}

		local staminaMult = 1.0;

		if (this.getContainer().getActor().getSkills().hasSkill("perk.brawny"))
		{
			staminaMult = 0.70;
		}

		_properties.Armor[this.Const.BodyPart.Body] += this.getArmor();
		_properties.ArmorMax[this.Const.BodyPart.Body] += this.getArmorMax();
		_properties.Stamina += this.Math.ceil(this.getStaminaModifier() * staminaMult);

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.onUpdateProperties(_properties);
		}
	}

	function onTurnStart()
	{
		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.onTurnStart();
		}
	}

	function onUse( _skill )
	{
		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.onUse(_skill);
		}
	}

	function onTotalArmorChanged()
	{
		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.onTotalArmorChanged();
		}
	}

	function onCombatFinished()
	{
		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.onCombatFinished();
		}
	}

	function onActorDied( _onTile )
	{
		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.onActorDied(_onTile);
		}
	}

	// function getBuyPrice()
	// {
	// 	local basePrice = this.armor.getBuyPrice();

	// 	foreach( u in this.m.Upgrades )
	// 	{
	// 		if (u == null)
	// 		{
	// 			continue;
	// 		}

	// 		basePrice = basePrice + u.getBuyPrice();
	// 	}

	// 	return basePrice;
	// }

	// function getSellPrice()
	// {
	// 	local basePrice = this.armor.getSellPrice();

	// 	foreach( u in this.m.Upgrades )
	// 	{
	// 		if (u == null)
	// 		{
	// 			continue;
	// 		}

	// 		basePrice = basePrice + u.getSellPrice();
	// 	}

	// 	return basePrice;
	// }

	function onSerialize( _out )
	{
		this.armor.onSerialize(_out);
		_out.writeU8(this.m.Upgrades.len());

		for( local i = 0; i != this.m.Upgrades.len(); i = ++i )
		{
			local item = this.m.Upgrades[i];

			if (item == null)
			{
				_out.writeBool(false);
			}
			else
			{
				_out.writeBool(true);
				_out.writeI32(item.ClassNameHash);
				item.onSerialize(_out);
			}
		}
	}

	function onDeserialize( _in )
	{
		this.armor.onDeserialize(_in);
		local count = _in.readU8();
		this.m.Upgrades = [];

		for( local i = 0; i < count; i = ++i )
		{
			this.m.Upgrades.push(null);
			local hasItem = _in.readBool();

			if (!hasItem)
			{
				continue
			}

			local item = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
			item.onDeserialize(_in);
			this.m.Upgrades[i] = item;
			this.m.Upgrades[i].setArmor(this);

		}
	}

});

