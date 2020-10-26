this.legend_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {
		Upgrades = null,
		Blocked = [],
		Variants = [],
		Type = -1
	},

	function create()
	{
		this.helmet.create();
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.Upgrades = [];

		for( local i = 0; i < this.Const.Items.HelmetUpgrades.COUNT; i = ++i )
		{
			this.m.Upgrades.push(null);
			this.m.Blocked.push(false);
		}
	}

	function onPaint(_variant)
	{

	}

	function getHideHair()
	{
		if (this.m.HideHair)
		{
			return true;
		}

		foreach (u in this.m.Upgrades)
		{
			if (u == null)
			{
				continue;
			}

			if (u.m.HideHair)
			{
				return true;
			}
		}

		return false;

	}

	function getHideBeard()
	{
		if (this.m.HideBeard)
		{
			return true;
		}

		foreach (u in this.m.Upgrades)
		{
			if (u == null)
			{
				continue;
			}

			if (u.m.HideBeard)
			{
				return true;
			}
		}

		return false;

	}

	function getIconLargeOverlayNamed()
	{
		return "";
		// if (this.isItemType(this.Const.Items.ItemType.Named))
		// {
		// 	return "legend_armor/inventory_named_armor.png";
		// }

		// if (this.isItemType(this.Const.Items.ItemType.Legendary))
		// {
		// 	return "legend_armor/inventory_named_armor.png";
		// }

		// foreach( u in this.m.Upgrades )
		// {
		// 	if (u == null)
		// 	{
		// 		continue;
		// 	}

		// 	if (u.isItemType(this.Const.Items.ItemType.Named))
		// 	{
		// 		return "legend_armor/inventory_named_armor.png";
		// 	}

		// 	if (u.isItemType(this.Const.Items.ItemType.Legendary))
		// 	{
		// 		return "legend_armor/inventory_named_armor.png";
		// 	}
		// }

		// return ""
	}

	function getIconLargeOverlayRuned()
	{
		return "";
		// local rune = this.getUpgrade(this.Const.Items.ArmorUpgrades.Rune)
		// if (rune == null)
		// {
		// 	return ""
		// }

		// return "legend_armor/inventory_runed_armor.png";
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

		return "";

		// foreach( u in this.m.Upgrades )
		// {
		// 	if (u == null)
		// 	{
		// 		continue;
		// 	}

		// 	if (u.isItemType(this.Const.Items.ItemType.Named))
		// 	{
		// 		return "legend_armor/named_armor.png";
		// 	}

		// 	if (u.isItemType(this.Const.Items.ItemType.Legendary))
		// 	{
		// 		return "legend_armor/named_armor.png";
		// 	}
		// }

		// return "";
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

		return "";

		// local rune = this.getUpgrade(this.Const.Items.HelmetUpgrades.Rune)
		// if (rune == null)
		// {
		// 	return ""
		// }

		// return "legend_armor/runed_armor.png";
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

		return this.getIcon();

		// local items = this.getIconLargeOverlay();
		// foreach (i in items)
		// {
		// 	if (i != "")
		// 	{
		// 		return i;
		// 	}
		// }

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

	function blockUpgrades()
	{
		for( local i = 0; i < this.Const.Items.HelmetUpgrades.COUNT; i = ++i )
		{
			this.m.Blocked[i] = true;
		}
	}

	function getRepair()
	{
		return this.Math.floor(this.getArmor());
	}

	function getRepairMax()
	{
		return this.Math.floor(this.getArmorMax());
	}

	function getCondition()
	{
		return this.Math.floor(this.m.Condition);
	}

	function getConditionMax()
	{
		return this.Math.floor(this.m.ConditionMax);
	}

	function setCondition( _a )
	{
		this.m.Condition = _a;
		this.updateAppearance();
	}

	function getVision()
	{
		local value = this.m.Vision;

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			value = value + u.getVision();
		}

		return value;
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

			delta = u.setCondition(delta);

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

	function setPlainVariant()
	{
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

		local item = this.m.Upgrades[_slot];
		local app = null;
		if (this.getContainer() != null) 
		{
			app = this.getContainer().getAppearance();
		}
		item.onRemoved(app);
		this.m.Upgrades[_slot] = null;
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
				text = this.getName()
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
			icon = "ui/icons/armor_head.png",
			value = this.Math.floor(this.getArmor()),
			valueMax = this.Math.floor(this.getArmorMax()),
			text = "" + this.Math.floor(this.getArmor()) + " / " + this.Math.floor(this.getArmorMax()) + "",
			style = "armor-head-slim"
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

		if (this.getVision() < 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Vision [color=" + this.Const.UI.Color.NegativeValue + "]" + this.getVision() + "[/color]"
			});
		}
		else if (this.getVision() > 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Vision [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getVision() + "[/color]"
			});
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

		if (this.getArmor() > 15 && isPlayer || this.getArmor() > 30 && this.getArmor() / this.getArmorMax() >= 0.25 && (isLucky || this.Math.rand(1, 100) <= 70) || this.isItemType(this.Const.Items.ItemType.Named) || this.isItemType(this.Const.Items.ItemType.Legendary))
		{
			return true;
		}

		if (repair > 15 && isPlayer)
		{
			return true;
		}

		if (repair > 30 && repair / repairMax >= 0.25 && (isLucky || this.Math.rand(1, 100) <= 70))
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

		if (this.getArmor() == 0 && this.m.HideHelmetIfDestroyed)
		{
			if (app.Helmet != "")
			{
				app.HelmetColor = this.createColor("#ffffff");
				app.HelmetDamage = "";
				app.HelmetLayerVanityLower = "";
				app.Helmet = "";
				app.HelmetLayerHelm = "";
				app.HelmetLayerTop = "";
				app.HelmetLayerVanity = "";
				app.HelmetLayerVanityLowerCorpse = "";
				app.HelmetCorpse = "";
				app.HelmetLayerHelmCorpse = "";
				app.HelmetLayerTopCorpse = "";
				app.HelmetLayerVanityCorpse = "";
				app.HideHead = false;
				app.HideHair = false;
				app.HideBeard = false;
				app.HideCorpseHead = false;
				this.getContainer().updateAppearance();
			}
			return;
		}

		local changed = false
		 if (this.m.Condition / this.m.ConditionMax <= this.Const.Combat.ShowDamagedArmorThreshold)
		 {
			 changed = app.Helmet != this.m.SpriteDamaged;
			 app.Helmet = this.m.SpriteDamaged;
		 }
		 else
		 {
			changed = app.Helmet != this.m.Sprite;
			app.Helmet = this.m.Sprite
		 }

		app.HelmetColor = this.m.SpriteColor;
		app.HelmetCorpse = this.m.SpriteCorpse;
		app.HideHead = this.m.HideCharacterHead;
		app.HideHair = this.getHideHair();
		app.HideBeard = this.getHideBeard();
		app.HideCorpseHead = this.m.HideCorpseHead;

		local changed = false;
		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			if (u.updateAppearance(app))
			{
				changed = true;
			};
		}

		// if (changed)
		// {
			this.getContainer().updateAppearance();
		//}

	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "";
		this.m.SpriteDamaged = ""//"bust_helmet_" + variant + "_damaged";
		this.m.SpriteCorpse = ""//"bust_helmet_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = ""//"helmets/inventory_helmet_" + variant + ".png";
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
			app.ImpactSound[this.Const.BodyPart.Head] = this.m.ImpactSound;
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
	}

	function onUnequip()
	{
		this.item.onUnequip();

		if (this.m.ShowOnCharacter)
		{
			local app = this.getContainer().getAppearance();
			app.HelmetColor = this.createColor("#ffffff");
			app.HelmetDamage = "";
			app.HelmetLayerVanityLower = "";
			app.Helmet = "";
			app.HelmetLayerHelm = "";
			app.HelmetLayerTop = "";
			app.HelmetLayerVanity = "";
			app.HelmetLayerVanityLowerCorpse = "";
			app.HelmetCorpse = "";
			app.HelmetLayerHelmCorpse = "";
			app.HelmetLayerTopCorpse = "";
			app.HelmetLayerVanityCorpse = "";
			app.HideHead = false;
			app.HideCorpseHead = false;
			app.HideHair = false;
			app.HideBeard = false;
			app.ImpactSound[this.Const.BodyPart.Head] = [];
			this.getContainer().updateAppearance();
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

		for( local i = this.Const.Items.HelmetUpgrades.COUNT - 1; i >= 0; i = --i )
		{
			local u = this.m.Upgrades[i];

			if (u == null)
			{
				continue;
			}
			totalDamage = u.onDamageReceived(totalDamage, _fatalityType, _attacker);
		}

		if (this.m.Condition == 0)
		{
			this.updateAppearance();
			return;
		}

		this.m.Condition = this.Math.max(0, this.m.Condition - totalDamage) * 1.0;

		if (this.m.Condition == 0 && !this.m.IsIndestructible)
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s " + this.getName() + " is hit for [b]" + this.Math.floor(_damage) + "[/b] damage and has been destroyed!");
		}
		else
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "\'s " + this.getName() + " is hit for [b]" + this.Math.floor(_damage) + "[/b] damage");
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

		_properties.Armor[this.Const.BodyPart.Head] += this.getArmor();
		_properties.ArmorMax[this.Const.BodyPart.Head] += this.getArmorMax();
		_properties.Stamina += this.Math.ceil(this.getStaminaModifier() * staminaMult);
		_properties.Vision += this.getVision();

		foreach( u in this.m.Upgrades )
		{
			if (u == null)
			{
				continue;
			}

			u.onUpdateProperties(_properties);
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
	// 	local basePrice = this.helmet.getBuyPrice();

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
	// 	local basePrice = this.helmet.getSellPrice();

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
		this.helmet.onSerialize(_out);
		_out.writeF32(this.m.Condition);
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
		this.helmet.onDeserialize(_in);
		this.m.Condition = this.Math.minf(this.m.ConditionMax, _in.readF32());
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

		this.updateVariant();
		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}

});

