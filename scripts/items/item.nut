this.item <- {
	m = {
		ID = "",
		OldID = "",
		Name = "",
		Icon = "",
		IconLarge = "",
		Description = "",
		Categories = "",
		MagicNumber = this.Math.rand(1, 100),
		Variant = 0,
		Condition = 1.0,
		ConditionMax = 1.0,
		MedicinePerDay = 0,
		SlotType = this.Const.ItemSlot.Bag,
		CurrentSlotType = this.Const.ItemSlot.None,
		BlockedSlotType = null,
		ItemType = this.Const.Items.ItemType.None,
		ItemProperty = this.Const.Items.Property.None,
		Container = null,
		SkillPtrs = [],
		Tile = null,
		Value = 0,
		PriceMult = 1.0,
		LastEquippedByFaction = 0,
		IsGarbage = false,
		IsDroppedAsLoot = false,
		IsChangeableInBattle = true,
		IsIndestructible = false,
		IsToBeRepaired = false,
		IsToBeRepairedQueue = 0,
		IsToBeSalvagedQueue = 0,
		IsConsumed = false,
		IsAllowedInBag = true,
		IsUsable = false,
		IsSold = false,
		IsBought = false,
		RuneVariant = 0,
		RuneBonus1 = 0,
		RuneBonus2 = 0,
		IsToBeSalvaged = false,
		Type = -1
	},

	function setContainer( _c )
	{
		if (_c != null)
		{
			this.m.Container = this.WeakTableRef(_c);
		}
		else
		{
			this.m.Container = null;
		}
	}

	function getContainer()
	{
		return this.m.Container;
	}

	function getName()
	{
		return this.m.Name;
	}

	function getID()
	{
		return this.m.ID;
	}

	function getOldInstanceID()
	{
		return this.m.OldID;
	}

	function getInstanceID()
	{
		return this.toHash(this).tostring();
	}

	function getIcon()
	{
		return this.m.Icon;
	}

	function getIconLarge()
	{
		return this.m.IconLarge != "" ? this.m.IconLarge : null;
	}

	function getIconOverlay()
	{
		return [""];
	}

	function getIconLargeOverlay()
	{
		return [""];
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function getCategories()
	{
		return this.m.Categories;
	}

	function getSlotType()
	{
		return this.m.SlotType;
	}

	function getCurrentSlotType()
	{
		return this.m.CurrentSlotType;
	}

	function getBlockedSlotType()
	{
		return this.m.BlockedSlotType;
	}

	function getLastEquippedByFaction()
	{
		return this.m.LastEquippedByFaction;
	}

	function setCurrentSlotType( _t )
	{
		this.m.CurrentSlotType = _t;
	}

	function isItemType( _t )
	{
		return (this.m.ItemType & _t) != 0;
	}

	function getItemType()
	{
		return this.m.ItemType;
	}

	function getType()
	{
		return this.m.Type;
	}

	function hasProperty( _t )
	{
		return (this.m.ItemProperty & _t) != 0;
	}

	function isInBag()
	{
		return this.m.CurrentSlotType == this.Const.ItemSlot.Bag;
	}

	function isEquipped()
	{
		return this.m.CurrentSlotType != this.Const.ItemSlot.Bag && this.m.CurrentSlotType != this.Const.ItemSlot.None;
	}

	function isGarbage()
	{
		return this.m.IsGarbage;
	}

	function isChangeableInBattle( _actor = null)
	{
		return this.m.SlotType >= 0 ? this.m.IsChangeableInBattle && this.Const.ItemSlotChangeableInBattle[this.m.SlotType] : false;
	}

	function isDroppedAsLoot()
	{
		return this.m.IsDroppedAsLoot;
	}

	function isSold()
	{
		return this.m.IsSold;
	}

	function isBought()
	{
		return this.m.IsBought;
	}

	function isToBeRepaired()
	{
		return this.m.IsToBeRepaired;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	function isToBeRepairedQ()
	{
		return this.m.IsToBeRepairedQueue;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	function isToBeSalvaged()
	{
		return this.m.IsToBeSalvaged;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	function isToBeSalvagedQ()
	{
		return this.m.IsToBeSalvagedQueue;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	function isConsumed()
	{
		return this.m.IsConsumed;
	}

	function isIndestructible()
	{
		return this.m.IsIndestructible;
	}

	function isUsable()
	{
		return this.m.IsUsable;
	}

	function setToBeRepaired( _r, _idx )
	{
		if (_r && this.getRepair() == this.getRepairMax())
		{
			this.m.IsToBeRepairedQueue = 0;
			return false;
		}

		this.m.IsToBeRepaired = _r;
		this.m.IsToBeRepairedQueue = _idx;
		return true;
	}

	function setToBeSalvaged( _r, _idx )
	{
		if (_r && this.getRepair() <= 0)
		{
			this.m.IsToBeSalvagedQueue = 0;
			return false;
		}

		this.m.IsToBeSalvaged = _r;
		this.m.IsToBeSalvagedQueue = _idx;
		return true;
	}

	function canBeSalvaged()
	{
		return (this.getItemType() & (this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MagicStaff)) != 0 || (this.getItemType() & this.Const.Items.ItemFilter.Armor) != 0
	}

	function getVariant()
	{
		return this.m.Variant;
	}

	function getMagicNumber()
	{
		return this.m.MagicNumber;
	}

	function getArmor()
	{
		return 0;
	}

	function getArmorMax()
	{
		return 0;
	}

	function getCondition()
	{
		return this.Math.floor(this.m.Condition);
	}

	function getConditionMax()
	{
		return this.Math.floor(this.m.ConditionMax);
	}

	function getRepair()
	{
		return this.Math.floor(this.m.Condition);
	}

	function getRepairMax()
	{
		return this.Math.floor(this.m.ConditionMax);
	}

	function getValue()
	{
		return this.m.Value;
	}

	function getPriceMult()
	{
		return this.m.PriceMult;
	}

	function setValue( _v )
	{
		this.m.Value = _v;
	}

	function setPriceMult( _m )
	{
		this.m.PriceMult = _m;
	}

	function setSold( _f )
	{
	}

	function setBought( _f )
	{
	}

	function setCondition( _a )
	{
		this.m.Condition = _a;
		this.updateAppearance();
	}

	function setArmor( _a )
	{
		this.setCondition( _a)
	}

	function onRepair( _a)
	{
		this.setArmor(_a);
		return 0;
	}

	function setMagicNumber( _m )
	{
		this.m.MagicNumber = _m;
	}

	function isAmountShown()
	{
	}

	function getAmount()
	{
		return 0;
	}

	function getAmountMax()
	{
		return 0;
	}

	function getAmountColor()
	{
		return "#ffffff";
	}

	function getAmountString()
	{
		return "";
	}

	function getStaminaModifier()
	{
		return 0;
	}

	function isAllowedInBag( _actor = null )
	{
		if (!this.m.IsAllowedInBag || this.m.SlotType == this.Const.ItemSlot.Body || this.m.SlotType == this.Const.ItemSlot.Head || this.m.SlotType == this.Const.ItemSlot.None)
		{
			return false;
		}

		return true;
	}

	function getValueString()
	{
		if (this.getValue() != 0)
		{
			return "Worth [img]gfx/ui/tooltips/money.png[/img][b]" + this.getValue() + "[/b]";
		}
		else
		{
			return "Worth nothing.";
		}
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()]));
		}
		else
		{
			return this.Math.ceil(this.getValue() * this.getPriceMult());
		}
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice * this.World.State.getCurrentTown().getSellPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
		}
		else
		{
			return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice);
		}
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

		if (!this.isItemType(this.Const.Items.ItemType.Crafting))
		{
			if (this.m.Categories.len() != 0)
			{
				result.push({
					id = 65,
					type = "text",
					text = this.m.Categories
				});
			}

			result.push({
				id = 66,
				type = "text",
				text = this.getValueString()
			});

			if (!this.isItemType(this.Const.Items.ItemType.Misc) || this.isItemType(this.Const.Items.ItemType.Usable) || this.isItemType(this.Const.Items.ItemType.Legendary))
			{
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
			}
		}
		else
		{
			result.push({
				id = 66,
				type = "text",
				text = this.getValueString()
			});

			if (this.Const.DLC.Unhold)
			{
				result.push({
					id = 50,
					type = "hint",
					icon = "ui/icons/plus.png",
					text = "Can be used to craft items"
				});
			}
		}

		return result;
	}

	function removeSelf()
	{
		this.m.IsGarbage = true;
		this.m.Container.collectGarbage();
	}

	function addSkill( _skill )
	{
		_skill.setItem(this);
		this.m.SkillPtrs.push(_skill);
		this.getContainer().getActor().getSkills().add(_skill, this.m.SkillPtrs.len());
	}

	function addGenericItemSkill()
	{
		local skill = this.new("scripts/skills/items/generic_item");
		skill.setItem(this);
		this.addSkill(skill);
	}

	function removeSkill( _skill )
	{
		local idx = this.m.SkillPtrs.find(_skill);

		if (idx != null)
		{
			this.m.SkillPtrs.remove(idx);
		}

		_skill.setItem(null);
		this.getContainer().getActor().getSkills().remove(_skill);
	}

	function clearSkills()
	{
		if (this.getContainer() == null || this.getContainer().getActor() == null || this.getContainer().getActor().isNull())
		{
			return;
		}

		foreach( i, skill in this.m.SkillPtrs )
		{
			this.getContainer().getActor().getSkills().remove(skill);
		}

		this.m.SkillPtrs = [];
	}

	function removeFromContainer()
	{
		this.m.Container = null;
		this.m.CurrentSlotType = this.Const.ItemSlot.None;
	}

	function drop( _tile = null )
	{
		local isPlayer = this.m.LastEquippedByFaction == this.Const.Faction.Player || this.m.Container != null && this.m.Container.getActor() != null && !this.m.Container.getActor().isNull() && this.isKindOf(this.m.Container.getActor().get(), "player");
		local isDropped = this.isDroppedAsLoot() && (this.Tactical.State.getStrategicProperties() == null || !this.Tactical.State.getStrategicProperties().IsArenaMode || isPlayer);

		if (this.m.Container != null)
		{
			if (_tile == null && this.m.Container.getActor() != null && this.m.Container.getActor().isPlacedOnMap())
			{
				_tile = this.m.Container.getActor().getTile();
			}

			if (this.m.CurrentSlotType != this.Const.ItemSlot.Bag)
			{
				this.m.Container.unequip(this);
			}
			else
			{
				this.m.Container.removeFromBag(this);
			}
		}

		if (!isDropped)
		{
			this.m.IsDroppedAsLoot = false;
			return false;
		}

		if (_tile == null)
		{
			this.logWarning("Attempted to drop item, but no tile specified!");
			return false;
		}

		_tile.Items.push(this);
		_tile.IsContainingItems = true;
		this.m.Tile = _tile;
		this.onDrop(_tile);
		return true;
	}

	function removeFromTile()
	{
		if (this.m.Tile == null)
		{
			return;
		}

		local n = this.m.Tile.Items.find(this);
		this.m.Tile.Items.remove(n);
		this.m.Tile.IsContainingItems = this.m.Tile.Items.len() != 0;
		this.m.Tile = null;
	}

	function pickup()
	{
		this.removeFromTile();
	}

	function setVariant( _v )
	{
		this.m.Variant = _v;
		this.updateVariant();
	}

	function updateVariant()
	{
	}

	function updateAppearance()
	{
	}

	function playInventorySound( _eventType )
	{
	}

	function onFactionChanged( _faction )
	{
		this.m.LastEquippedByFaction = _faction;
	}

	function onPutIntoBag()
	{
	}

	function onRemovedFromBag()
	{
		this.clearSkills();
	}

	function onPickedUp()
	{
	}

	function onDrop( _tile )
	{
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
	}

	function onDamageReceived( _damage, _fatalityType, _attacker )
	{
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
	}

	function onShieldHit( _attacker, _skill )
	{
	}

	function onUpdateProperties( _properties )
	{
	}

	function onTurnStart()
	{
	}

	function onUse( _skill )
	{
	}

	function onTotalArmorChanged()
	{
	}

	function onMovementFinished()
	{
	}

	function onCombatFinished()
	{
	}

	function onActorDied( _onTile )
	{
	}

	function onAddedToStash( _stashID )
	{
	}

	function onRemovedFromStash( _stashID )
	{
	}

	function onUse( _actor, _item = null )
	{
	}

	function onUnequip()
	{
		this.clearSkills();
	}

	function onEquip()
	{
		if (this.m.Container != null && this.m.Container.getActor() != null)
		{
			this.m.LastEquippedByFaction = this.m.Container.getActor().getFaction();
		}

		if (this.isRuned())
		{
			this.onEquipRuneSigil();
		}

		if (this.isToBeSalvaged())
		{
			this.setToBeSalvaged(false, 0);
		}
	}

	function onEquipRuneSigil()
	{
		switch (this.m.RuneVariant)
		{
			case 1:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_power"));
				break;

			case 2:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_accuracy"));
				break;

			case 3:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_feeding"));
				break;

			case 4:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_poison"));
				break;

			case 5:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_bleeding"));
				break;

			case 6:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSW_unbreaking"));
				break;

			case 11:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSH_clarity"));
				break;

			case 12:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSH_bravery"));
				break;

			case 13:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSH_luck"));
				break;

			case 21:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSA_endurance"));
				break;

			case 22:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSA_safety"));
				break;

			case 23:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSA_resilience"));
				break;

			case 31:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSS_defense"));
				break;

			case 32:
				this.addSkill(this.new("scripts/skills/rune_sigils/legend_RSS_radiance"));
				break;

			default:
				break;
		}
	}

	function getRuneSigilTooltip()
	{
		switch (this.m.RuneVariant)
		{
			case 1:
				return "This item has the power of the rune sigil of Power:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Damage inflicted.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "%[/color] Max damage.";
				break;

			case 2:
				return "This item has the power of the rune sigil of Accuracy:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Melee skill.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "%[/color] Ranged skill.";
				break;

			case 3:
				return "This item has the power of the rune sigil of Feeding:\n[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus1 + "%[/color] of inflicted health damage recovers fatigue.";
				break;

			case 4:
				return "This item has the power of the rune sigil of Poison:\n[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus1 + "[/color] turn(s) of poison applied, with a strength of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus2 + "[/color]. Lowers action points and initiative.";
				break;

			case 5:
				return "This item has the power of the rune sigil of Bleeding:\n[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus1 + "[/color] bleed damage every turn for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus2 + "[/color] turn(s).";
				break;

			case 6:
				return "This item has the power of the rune sigil of Unbreaking:\n[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus1 + "[/color] to [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RuneBonus2 + "[/color] durability restored on every kill.";
				break;

			case 11:
				return "This item has the power of the rune sigil of Clarity:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "[/color] Vision.\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "%[/color] Experience gain.";
				break;

			case 12:
				return "This item has the power of the rune sigil of Bravery:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Resolve.\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "[/color] Resolve at all morale checks.";
				break;

			case 13:
				return "This item has the power of the rune sigil of Luck:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] chance to have any attacker require two successful attack rolls in order to hit.";
				break;

			case 21:
				return "This item has the power of the rune sigil of Endurance:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "[/color] Fatigue recovery per turn.\n[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.RuneBonus2 + "%[/color] Fatigue cost and effects multiplier.";
				break;

			case 22:
				return "This item has the power of the rune sigil of Safety:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Hitpoints.\n[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.RuneBonus2 + "%[/color] Damage received.";
				break;

			case 23:
				return "This item has the power of the rune sigil of Resilience:\n[color=" + this.Const.UI.Color.PositiveValue + "]Immune[/color] to stuns, knockbacks and grabs.";
				break;

			case 31:
				return "This item has the power of the rune sigil of Defense:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "%[/color] Melee defense.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus2 + "%[/color] Ranged defense.";
				break;

			case 32:
				return "This item has the power of the rune sigil of Radiance:\n[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.RuneBonus1 + "%[/color] to all adjacent enemies\' Melee skill.\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.RuneBonus2 + "%[/color] to all adjacent enemies\' Melee defense.";
				break;

			default:
				return "This item is inscribed with a rune sigil, even though it shouldn't have been: please report this bug.";
				break;
		}
	}

	function setRuneBonus( _bonus = false)
	{
		local bonus = 0;
		local bonus2 = 0;
		switch (this.m.RuneVariant)
		{
			case 1:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9)
					bonus2 = this.Math.rand(3, 9)
				}
				else
				{
					bonus = this.Math.rand(3, 6)
					bonus2 = this.Math.rand(3, 6)
				}
				break;

			case 2:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9)
					bonus2 = this.Math.rand(3, 9)
				}
				else
				{
					bonus = this.Math.rand(3, 6)
					bonus2 = this.Math.rand(3, 6)
				}
				break;

			case 3:
				if (_bonus)
				{
					bonus = this.Math.rand(2, 6)
				}
				else
				{
					bonus = this.Math.rand(2, 4)
				}
				break;

			case 4:
				if (_bonus)
				{
					bonus = this.Math.rand(1, 3)
					bonus2 = this.Math.rand(3, 9)
				}
				else
				{
					bonus = this.Math.rand(1, 2)
					bonus2 = this.Math.rand(3, 9)
				}
				break;

			case 5:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9)
					bonus2 = this.Math.rand(1, 3)
				}
				else
				{
					bonus = this.Math.rand(3, 6)
					bonus2 = this.Math.rand(1, 2)
				}
				break;

			case 6:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9)
					bonus2 = this.Math.rand(1, 3)
				}
				else
				{
					bonus = this.Math.rand(3, 6)
					bonus2 = this.Math.rand(1, 2)
				}
				break;

			case 11:
				if (_bonus)
				{
					bonus = this.Math.rand(0, 2)
					bonus2 = this.Math.rand(3, 9)
				}
				else
				{
					bonus = this.Math.rand(0, 1)
					bonus2 = this.Math.rand(3, 6)
				}
				break;

			case 12:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9)
					bonus2 = this.Math.rand(1, 5)
				}
				else
				{
					bonus = this.Math.rand(3, 6)
					bonus2 = this.Math.rand(1, 3)
				}
				break;

			case 13:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9)
				}
				else
				{
					bonus = this.Math.rand(3, 6)
				}
				break;

			case 21:
				if (_bonus)
				{
					bonus = this.Math.rand(0, 3)
					bonus2 = this.Math.rand(3, 9)
				}
				else
				{
					bonus = this.Math.rand(0, 1)
					bonus2 = this.Math.rand(3, 6)
				}
				break;

			case 22:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9)
					bonus2 = this.Math.rand(3, 9)
				}
				else
				{
					bonus = this.Math.rand(3, 6)
					bonus2 = this.Math.rand(3, 6)
				}
				break;

			case 23:
				break;

			case 31:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 9)
					bonus2 = this.Math.rand(3, 9)
				}
				else
				{
					bonus = this.Math.rand(3, 9)
					bonus2 = this.Math.rand(3, 9)
				}
				break;

			case 32:
				if (_bonus)
				{
					bonus = this.Math.rand(3, 12)
					bonus2 = this.Math.rand(3, 12)
				}
				else
				{
					bonus = this.Math.rand(3, 9)
					bonus2 = this.Math.rand(3, 9)
				}
				break;

			default:
				break;
		}
		this.setRuneBonus1(bonus);
		this.setRuneBonus2(bonus2);
	}

	function updateRuneSigilToken()
	{
		switch (this.m.RuneVariant)
		{
			case 1:
				this.m.Name = "Weapon Rune Sigil: Power";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 2:
				this.m.Name = "Weapon Rune Sigil: Accuracy";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 3:
				this.m.Name = "Weapon Rune Sigil: Feeding";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 4:
				this.m.Name = "Weapon Rune Sigil: Poison";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 5:
				this.m.Name = "Weapon Rune Sigil: Bleeding";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 6:
				this.m.Name = "Weapon Rune Sigil: Unbreaking";
				this.m.Description = "An inscribed rock that can be attached to a character\'s weapon.";
				this.m.Icon = "rune_sigils/rune_stone_1.png";
				this.m.IconLarge = "rune_sigils/rune_stone_1.png";
				break;

			case 11:
				this.m.Name = "Helmet Rune Sigil: Clarity";
				this.m.Description = "An inscribed rock that can be attached to a character\'s helmet.";
				this.m.Icon = "rune_sigils/rune_stone_2.png";
				this.m.IconLarge = "rune_sigils/rune_stone_2.png";
				break;

			case 12:
				this.m.Name = "Helmet Rune Sigil: Bravery";
				this.m.Description = "An inscribed rock that can be attached to a character\'s helmet.";
				this.m.Icon = "rune_sigils/rune_stone_2.png";
				this.m.IconLarge = "rune_sigils/rune_stone_2.png";
				break;

			case 13:
				this.m.Name = "Helmet Rune Sigil: Luck";
				this.m.Description = "An inscribed rock that can be attached to a character\'s helmet.";
				this.m.Icon = "rune_sigils/rune_stone_2.png";
				this.m.IconLarge = "rune_sigils/rune_stone_2.png";
				break;

			case 21:
				this.m.Name = "Armor Rune Sigil: Endurance";
				this.m.Description = "An inscribed rock that can be attached to a character\'s armor.";
				this.m.Icon = "rune_sigils/rune_stone_3.png";
				this.m.IconLarge = "rune_sigils/rune_stone_3.png";
				break;

			case 22:
				this.m.Name = "Armor Rune Sigil: Safety";
				this.m.Description = "An inscribed rock that can be attached to a character\'s armor.";
				this.m.Icon = "rune_sigils/rune_stone_3.png";
				this.m.IconLarge = "rune_sigils/rune_stone_3.png";
				break;

			case 23:
				this.m.Name = "Armor Rune Sigil: Resilience";
				this.m.Description = "An inscribed rock that can be attached to a character\'s armor.";
				this.m.Icon = "rune_sigils/rune_stone_3.png";
				this.m.IconLarge = "rune_sigils/rune_stone_3.png";
				break;

			case 31:
				this.m.Name = "Shield Rune Sigil: Defense";
				this.m.Description = "An inscribed rock that can be attached to a character\'s shield.";
				this.m.Icon = "rune_sigils/rune_stone_4.png";
				this.m.IconLarge = "rune_sigils/rune_stone_4.png";
				break;

			case 32:
				this.m.Name = "Shield Rune Sigil: Radiance";
				this.m.Description = "An inscribed rock that can be attached to a character\'s shield.";
				this.m.Icon = "rune_sigils/rune_stone_4.png";
				this.m.IconLarge = "rune_sigils/rune_stone_4.png";
				break;

			default:
				this.m.Name = "Unknown Rune Sigil: Error";
				this.m.Description = "An inscribed rock that cannot be attached to a character\'s equipment.";
				this.m.Icon = "rune_sigils/legend_vala_rune_sigil_blank.png";
				this.m.IconLarge = "rune_sigils/legend_vala_rune_sigil_blank.png";
				break;
		}
	}

	function setRuneVariant(_rune)
	{
		this.m.RuneVariant = _rune;
	}

	function getRuneVariant()
	{
		return this.m.RuneVariant;
	}

	function setRuneBonus1(_mult)
	{
		this.m.RuneBonus1 = _mult;
	}

	function getRuneBonus1()
	{
		return this.m.RuneBonus1;
	}

	function setRuneBonus2(_mult)
	{
		this.m.RuneBonus2 = _mult;
	}

	function getRuneBonus2()
	{
		return this.m.RuneBonus2;
	}

	function isRuned()
	{
		if (this.m.RuneVariant > 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	function updateRuneSigil()
	{
		local iconLargeParts = split(this.m.IconLarge, "/");
		local iconParts = split(this.m.Icon, "/");
		local text = ""
		if(this.m.IconLarge.find("runed_") == null) {
			for (local i = 0; i < iconLargeParts.len(); i = ++i)
			{
				if (i == iconLargeParts.len() - 1)
				{
					text = text + "runed_" + iconLargeParts[i]
				} else {
					text = text + iconLargeParts[i] + "/";
				}
			}
			this.m.IconLarge = text;
		}
		if(this.m.Icon.find("runed_") == null) {
			text = ""
			for (local i = 0; i < iconParts.len(); i = ++i)
			{
				if (i == iconParts.len() - 1)
				{
					text = text + "runed_" + iconParts[i]
				} else {
					text = text + iconParts[i] + "/";
				}
			}
			this.m.Icon = text;
		}
		if (this.m.Name.find("(Runed)") == null)
		{
			this.m.Name =  this.m.Name + "[color=" + this.Const.UI.Color.RuneColor + "] (Runed)[/color]";
		}
	}

	function onNewDay()
	{
	}

	function getMedicinePerDay()
	{
		return this.m.MedicinePerDay;
	}

	function getUpgrades()
	{
		return [];
	}

	function getLootLayers()
	{
		return [this];
	}

	function onPaint( _color )
	{
	}

	function onSerialize( _out )
	{
		_out.writeBool(this.m.IsToBeRepaired);
		_out.writeU16(this.m.Variant);
		_out.writeF32(this.m.Condition);
		_out.writeF32(this.m.PriceMult);
		_out.writeString(this.getInstanceID()); //Need old ID for saved formations
		_out.writeU8(this.m.RuneVariant);
		_out.writeBool(this.m.IsToBeSalvaged);
		_out.writeU16(this.m.IsToBeRepairedQueue);
		_out.writeU16(this.m.IsToBeSalvagedQueue);
		_out.writeU8(this.m.RuneBonus1);
		_out.writeU8(this.m.RuneBonus2);
		_out.writeU8(this.m.MagicNumber);
	}

	function onDeserialize( _in )
	{
		this.m.IsToBeRepaired = _in.readBool();
		this.m.Variant = _in.readU16();
		this.m.Condition = _in.readF32();
		this.m.PriceMult = _in.readF32();
		if (_in.getMetaData().getVersion() >= 46)
		{
			this.m.OldID = _in.readString();
		}

		if (_in.getMetaData().getVersion() >= 51)
		{
			this.m.RuneVariant = _in.readU8();
		}

		if (_in.getMetaData().getVersion() >= 52)
		{
			this.m.IsToBeSalvaged = _in.readBool();
		}

		if (_in.getMetaData().getVersion() >= 53)
		{
			this.m.IsToBeRepairedQueue = _in.readU16();
			this.m.IsToBeSalvagedQueue = _in.readU16();
			this.m.RuneBonus1 =  _in.readU8();
		}

		if (_in.getMetaData().getVersion() >= 54)
		{
			this.m.RuneBonus2 =  _in.readU8();
		}

		if (_in.getMetaData().getVersion() >= 58)
		{
			this.m.MagicNumber = _in.readU8();
		}

		this.updateVariant();
	}

};

