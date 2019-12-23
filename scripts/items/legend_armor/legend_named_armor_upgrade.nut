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
		PrefixList = this.Const.Strings.RandomArmorPrefix,
		NameList = [],
		UseRandomName = true
	},
	function create()
	{
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
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
		return this.Const.Items.ConditionColor[this.Math.max(0, this.Math.floor(this.m.Condition / (this.m.ConditionMax * 1.0) * (this.Const.Items.ConditionColor.len() - 1)))];
	}

	function getValue()
	{
		return this.Math.floor(this.m.Value * ((1.0 * this.m.Condition) / (1.0 * this.m.ConditionMax)));
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
		this.m.Armor = this.WeakTableRef(_a);
	}

	function getArmorDescription()
	{
		return this.m.ArmorDescription;
	}

	function getStaminaModifier()
	{
		return this.m.StaminaModifier;
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


	function setCondition( _a )
	{
		local delta = 0;
		if (_a > this.m.ConditionMax)
		{
			this.m.Condition = this.m.ConditionMax;
			delta = _a - this.m.ConditionMax;
		}
		else
		{
			this.m.Condition = _a;
		}

		if (this.m.Armor == null)
		{
			return delta
		}

		if (this.m.Armor.getContainer() != null && this.m.Armor.isEquipped())
		{
			local app = this.m.Armor.getContainer().getAppearance();
			this.updateAppearance(app);
		}

		return delta
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
			return
		}

		switch(this.m.Type)
		{
			case this.Const.Items.ArmorUpgrades.Chain:
				_app.ArmorLayerChain = backSprite;
				_app.CorpseArmorLayerChain =  this.m.SpriteCorpseBack != null ? this.m.SpriteCorpseBack : "";
				break;
			case this.Const.Items.ArmorUpgrades.Plate:
				_app.ArmorLayerPlate = backSprite;
				_app.CorpseArmorLayerPlate =  this.m.SpriteCorpseBack != null ? this.m.SpriteCorpseBack : "";
				break;
			case this.Const.Items.ArmorUpgrades.Tabbard:
				_app.ArmorLayerTabbard= backSprite;
				_app.CorpseArmorLayerTabbard =  this.m.SpriteCorpseBack != null ? this.m.SpriteCorpseBack : "";
				break;
			case this.Const.Items.ArmorUpgrades.Cloak:
				_app.ArmorLayerCloak= backSprite;
				_app.CorpseArmorLayerCloak =  this.m.SpriteCorpseBack != null ? this.m.SpriteCorpseBack : "";
				break;
			case this.Const.Items.ArmorUpgrades.Attachment:
				_app.ArmorUpgradeFront = frontSprite
				_app.ArmorUpgradeBack = this.m.SpriteBack != null ? this.m.SpriteBack : "";
				_app.CorpseArmorUpgradeFront = backSprite
				_app.CorpseArmorUpgradeBack = this.m.SpriteCorpseBack ? this.m.SpriteCorpseBack : "";
				break;
		}
	}

	function onAdded()
	{
	}

	function onRemoved(_app)
	{

		this.Sound.play("sounds/inventory/armor_upgrade_use_01.wav", this.Const.Sound.Volume.Inventory);
		this.m.Armor = null;
		if (_app == null)
		{
			return
		}

		switch(this.m.Type)
		{
			case this.Const.Items.ArmorUpgrades.Chain:
				_app.ArmorLayerChain = ""
				_app.CorpseArmorLayerChain =  ""
				break;
			case this.Const.Items.ArmorUpgrades.Plate:
				_app.ArmorLayerPlate = ""
				_app.CorpseArmorLayerPlate =  ""
				break;
			case this.Const.Items.ArmorUpgrades.Tabbard:
				_app.ArmorLayerTabbard = ""
				_app.CorpseArmorLayerTabbard = ""
				break;
			case this.Const.Items.ArmorUpgrades.Cloak:
				_app.ArmorLayerCloak = ""
				_app.CorpseArmorLayerCloak = ""
				break;
			case this.Const.Items.ArmorUpgrades.Attachment:
				_app.ArmorUpgradeFront = ""
				_app.ArmorUpgradeBack = ""
				_app.CorpseArmorUpgradeFront = ""
				_app.CorpseArmorUpgradeBack = ""
				break;
		}
		return this.m.IsDestroyedOnRemove;
	}

	function onUse( _actor, _item = null )
	{
		if (this.isUsed())
		{
			return false;
		}

		local armor = _item == null ? _actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body) : _item;

		if (armor == null)
		{
			return false;
		}

		local success = armor.setUpgrade(this);
		if (success)
		{
			this.Sound.play("sounds/inventory/armor_upgrade_use_01.wav", this.Const.Sound.Volume.Inventory);
			if (this.m.Name.len() == 0)
			{
				if (this.Math.rand(1, 100) <= 25)
				{
					this.setName(this.getContainer().getActor().getName() + "\'s ");
				}
				else
				{
					this.setName(this.createRandomName());
				}
			}

		}

		return success;
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
		//Destroyed, but damage left over
		if (_damage >= this.m.Condition)
		{
			this.m.Condition = 0.0;
			return _damage - this.m.Condition;
		}

		//Took all of the damage
		this.m.Condition = this.Math.max(0, this.m.Condition - _damage) * 1.0;
		return 0.0
	}

	function onArmorTooltip( _result )
	{
	}

	function onSerialize( _out )
	{
		_out.writeString(this.m.Name);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		this.item.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.Name = _in.readString();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();
		this.logInfo("Names armor = " + this.m.Name)
		this.item.onDeserialize(_in);
		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}

	function getRandomCharacterName( _list )
	{
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				this.Const.World.LocationNames.VillageWestern[this.Math.rand(0, this.Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(_list[this.Math.rand(0, _list.len() - 1)], vars);
	}

	function onAddedToStash( _stashID )
	{
		if (this.m.Name.len() == 0)
		{
			this.setName(this.createRandomName());
		}
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.min(-8, this.m.StaminaModifier + this.Math.rand(3, 9));
		this.m.Condition = this.Math.floor(this.m.Condition * this.Math.rand(110, 125) * 0.01) * 1.0;
		this.m.ConditionMax = this.m.Condition;
	}

	function setName( _prefix = "" )
	{
		this.m.Name = _prefix + this.m.NameList[this.Math.rand(0, this.m.NameList.len() - 1)];
	}

	function createRandomName()
	{
		if (!this.m.UseRandomName || this.Math.rand(1, 100) <= 75)
		{
			if (this.Math.rand(1, 100) <= 20)
			{
				return "";
			}
			else
			{
				return this.m.PrefixList[this.Math.rand(0, this.m.PrefixList.len() - 1)] + " ";
			}
		}
		else if (this.Math.rand(1, 2) == 1)
		{
			return this.getRandomCharacterName(this.Const.Strings.KnightNames) + "\'s ";
		}
		else
		{
			return this.getRandomCharacterName(this.Const.Strings.BanditLeaderNames) + "\'s ";
		}
	}
});

