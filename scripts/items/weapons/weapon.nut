this.weapon <- this.inherit("scripts/items/item", {
	m = {
		AddGenericSkill = true,
		ShowQuiver = false,
		ShowArmamentIcon = true,
		ArmamentIcon = "",
		ArmamentIconBloody = "",
		BreakingSound = "sounds/combat/weapon_break_01.wav",
		EquipSound = this.Const.Sound.DefaultWeaponEquip,
		RangeMin = 1,
		RangeMax = 1,
		RangeIdeal = 1,
		RangeMaxBonus = 9,
		Ammo = 0,
		AmmoMax = 0,
		AmmoCost = 3,
		ShieldDamage = 0,
		RegularDamage = 0,
		RegularDamageMax = 0,
		ArmorDamageMult = 1.0,
		DirectDamageMult = 0.0,
		DirectDamageAdd = 0.0,
		ChanceToHitHead = 0,
		AdditionalAccuracy = 0,
		FatigueOnSkillUse = 0,
		StaminaModifier = 0,
		IsDoubleGrippable = false,
		IsAgainstShields = false,
		IsAoE = false,
		IsEnforcingRangeLimit = false,
		IsBloodied = false
	},
	function getRangeMin()
	{
		return this.m.RangeMin;
	}

	function getRangeMax()
	{
		return this.m.RangeMax;
	}

	function getRangeIdeal()
	{
		return this.m.RangeIdeal;
	}

	function getRangeEffective()
	{
		return this.m.RangeMax;
	}

	function getRangeMaxBonus()
	{
		return this.m.RangeMaxBonus;
	}

	function getDamageMin()
	{
		return this.m.RegularDamage;
	}

	function getDamageMax()
	{
		return this.m.RegularDamageMax;
	}

	function getArmorDamageMult()
	{
		return this.m.ArmorDamageMult;
	}

	function getAdditionalAccuracy()
	{
		return this.m.AdditionalAccuracy;
	}

	function getShieldDamage()
	{
		local bonus = 0;
		if (this.getContainer() == null)
		{
			return this.m.ShieldDamage;
		}
		if (this.getContainer().getActor() == null)
		{
			return this.m.ShieldDamage;
		}
		local skill = this.getContainer().getActor().getSkills().getSkillByID("perk.legend_smashing_shields")
		if (skill == null)
		{
			return this.m.ShieldDamage;
		}
		local bonus = skill.getModifier();
		return this.Math.round( this.m.ShieldDamage + this.m.ShieldDamage * bonus);
		}

	function isDoubleGrippable()
	{
		return this.m.IsDoubleGrippable;
	}

	function isAgainstShields()
	{
		return this.m.IsAgainstShields;
	}

	function isAoE()
	{
		return this.m.IsAoE;
	}

	function isEnforcingRangeLimit()
	{
		return this.m.IsEnforcingRangeLimit;
	}

	function getAmmo()
	{
		return this.m.Ammo;
	}

	function getAmmoMax()
	{
		return this.m.AmmoMax;
	}

	function getAmmoID()
	{
		return "";
	}

	function setAmmo( _a )
	{
		this.m.Ammo = _a;
	}

	function getAmmoCost()
	{
		return this.m.AmmoCost;
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
		return this.Const.Items.ConditionColor[this.Math.min(this.Math.max(0, this.Math.floor(this.m.Condition / (this.m.ConditionMax * 1.0) * (this.Const.Items.ConditionColor.len() - 1))), this.Const.Items.ConditionColor.len() - 1)];
	}

	function getStaminaModifier()
	{
		return this.m.StaminaModifier;
	}

	function getValue()
	{
		return this.Math.floor(this.m.Value * (this.m.Condition / (this.m.ConditionMax * 1.0)));
	}

	function setBloodied( _isBloodied )
	{
		if (_isBloodied == this.m.IsBloodied)
		{
			return;
		}

		this.m.IsBloodied = _isBloodied;

		if (this.m.ShowArmamentIcon)
		{
			if (this.m.SlotType == this.Const.ItemSlot.Offhand)
			{
				if (_isBloodied && this.doesBrushExist(this.m.ArmamentIcon + "_bloodied"))
				{
					this.getContainer().getAppearance().Shield = this.m.ArmamentIcon + "_bloodied";
				}
				else
				{
					this.getContainer().getAppearance().Shield = this.m.ArmamentIcon;
				}
			}
			else if (_isBloodied && this.doesBrushExist(this.m.ArmamentIcon + "_bloodied"))
			{
				this.getContainer().getAppearance().Weapon = this.m.ArmamentIcon + "_bloodied";
			}
			else
			{
				this.getContainer().getAppearance().Weapon = this.m.ArmamentIcon;
			}

			this.getContainer().updateAppearance();
		}
	}

	function create()
	{
		this.m.IsDroppedAsLoot = true;
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

		result.push({
			id = 65,
			type = "text",
			text = this.m.Categories
		});
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.ConditionMax > 1)
		{
			result.push({
				id = 4,
				type = "progressbar",
				icon = "ui/icons/asset_supplies.png",
				value = this.getCondition(),
				valueMax = this.getConditionMax(),
				text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
				style = "armor-body-slim"
			});
		}

		if (this.m.RegularDamage > 0)
		{
			result.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color]"
			});
		}

		if (this.m.DirectDamageMult > 0)
		{
			result.push({
				id = 64,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor((this.m.DirectDamageMult + this.m.DirectDamageAdd) * 100) + "%[/color] of damage ignores armor"
			});
		}

		if (this.m.ArmorDamageMult > 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor(this.m.ArmorDamageMult * 100) + "%[/color] effective against armor"
			});
		}

		if (this.m.ShieldDamage > 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/shield_damage.png",
				text = "Shield damage of [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.ShieldDamage + "[/color]"
			});
		}

		if (this.m.ChanceToHitHead > 0)
		{
			result.push({
				id = 9,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Chance to hit head [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ChanceToHitHead + "%[/color]"
			});
		}

		if (this.m.AdditionalAccuracy > 0)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has an additional [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] chance to hit"
			});
		}
		else if (this.m.AdditionalAccuracy < 0)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has an additional [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.AdditionalAccuracy + "%[/color] chance to hit"
			});
		}

		if (this.m.RangeMax > 1)
		{
			result.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getRangeMax() + "[/color] tiles"
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

		if (this.m.FatigueOnSkillUse > 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weapon skills build up [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.FatigueOnSkillUse + "[/color] more fatigue"
			});
		}
		else if (this.m.FatigueOnSkillUse < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weapon skills build up [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.FatigueOnSkillUse + "[/color] less fatigue"
			});
		}

		if (this.m.AmmoMax > 0)
		{
			if (this.m.Ammo != 0)
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/ammo.png",
					text = "Contains ammo for [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] uses"
				});
			}
			else
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]Is empty and useless[/color]"
				});
			}
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

	function playInventorySound( _eventType )
	{
		this.Sound.play(this.m.EquipSound[this.Math.rand(0, this.m.EquipSound.len() - 1)], this.Const.Sound.Volume.Inventory);
	}

	function isDroppedAsLoot()
	{
		if (!this.item.isDroppedAsLoot())
		{
			return false;
		}

		local isPlayer = this.m.LastEquippedByFaction == this.Const.Faction.Player || this.getContainer() != null && this.getContainer().getActor() != null && !this.getContainer().getActor().isNull() && this.isKindOf(this.getContainer().getActor().get(), "player");
		local isLucky = !this.Tactical.State.isScenarioMode() && !isPlayer && this.World.Assets.getOrigin().isDroppedAsLoot(this);
		local isBlacksmithed = isPlayer && !this.Tactical.State.isScenarioMode() && this.World.Assets.m.IsBlacksmithed;
		return (this.m.AmmoMax == 0 || isPlayer || this.m.Ammo > 0 && this.getCurrentSlotType() != this.Const.ItemSlot.Bag || this.m.Ammo > 0 && this.m.Ammo < this.m.AmmoMax && this.getCurrentSlotType() == this.Const.ItemSlot.Bag) && (this.m.Condition >= 12 || this.m.ConditionMax <= 1 || isLucky || isBlacksmithed || !isPlayer && this.isItemType(this.Const.Items.ItemType.Named) || this.isItemType(this.Const.Items.ItemType.Legendary)) && (isPlayer || isLucky || this.isItemType(this.Const.Items.ItemType.Named) || this.isItemType(this.Const.Items.ItemType.Legendary) || this.Math.rand(1, 100) <= 90);
	}

	function consumeAmmo()
	{
		this.setAmmo(this.Math.max(0, this.m.Ammo - 1));

		if (this.getContainer().getActor().isPlayerControlled())
		{
			this.Tactical.Entities.spendAmmo(this.m.AmmoCost);
		}
	}

	function updateAppearance()
	{
		if (!this.isEquipped())
		{
			return;
		}

		local changed = false;

		if (this.m.ShowArmamentIcon)
		{
			if (this.m.SlotType == this.Const.ItemSlot.Offhand)
			{
				changed = this.getContainer().getAppearance().Shield != this.m.ArmamentIcon;
				this.getContainer().getAppearance().Shield = this.m.ArmamentIcon;
			}
			else
			{
				changed = this.getContainer().getAppearance().Weapon != this.m.ArmamentIcon;
				this.getContainer().getAppearance().Weapon = this.m.ArmamentIcon;
				this.getContainer().getAppearance().TwoHanded = this.m.BlockedSlotType != null;
			}
		}
		else if (this.m.SlotType == this.Const.ItemSlot.Offhand)
		{
			changed = this.getContainer().getAppearance().Shield != "";
			this.getContainer().getAppearance().Shield = "";
		}
		else
		{
			changed = this.getContainer().getAppearance().Weapon != "";
			this.getContainer().getAppearance().Weapon = "";
			this.getContainer().getAppearance().TwoHanded = false;
		}

		if (changed)
		{
			this.getContainer().updateAppearance();
		}
	}

	function addSkill( _skill )
	{
		this.item.addSkill(_skill);

		if (_skill.isType(this.Const.SkillType.Active))
		{
			_skill.setFatigueCost(this.Math.max(0, _skill.getFatigueCostRaw() + this.m.FatigueOnSkillUse));
		}
	}

	function getAdditionalRange( _actor )
	{
		return 0;
	}

	function onEquip()
	{
		this.item.onEquip();

		if (this.m.AddGenericSkill)
		{
			this.addGenericItemSkill();
		}

		this.updateAppearance();

		if (this.getContainer().getActor().isSummoned())
		{
			return;
		}

		if (this.m.Condition == this.m.ConditionMax && !this.isKindOf(this.getContainer().getActor().get(), "player"))
		{
			this.m.Condition = this.Math.rand(1, this.Math.max(1, this.m.ConditionMax - 2)) * 1.0;
		}
	}

	function onUnequip()
	{
		this.m.IsBloodied = false;
		this.item.onUnequip();

		if (this.m.ShowArmamentIcon)
		{
			if (this.m.SlotType == this.Const.ItemSlot.Offhand)
			{
				this.getContainer().getAppearance().Shield = "";
			}
			else
			{
				this.getContainer().getAppearance().Weapon = "";
				this.getContainer().getAppearance().TwoHanded = false;
			}
		}

		this.getContainer().updateAppearance();
	}

	function onUpdateProperties( _properties )
	{
		_properties.Stamina += this.m.StaminaModifier;
		_properties.DamageRegularMin += this.m.RegularDamage;
		_properties.DamageRegularMax += this.m.RegularDamageMax;
		_properties.DamageArmorMult *= this.m.ArmorDamageMult;
		_properties.DamageDirectAdd += this.m.DirectDamageAdd;
		_properties.HitChance[this.Const.BodyPart.Head] += this.m.ChanceToHitHead;
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		local actor = this.getContainer().getActor();

		if (actor == null || actor.isNull())
		{
			return;
		}

		if (actor.isPlayerControlled() && _skill.getDirectDamage() < 1.0 && !_skill.isRanged() && this.m.ConditionMax > 1)
		{
			if (_target.getArmorMax(_hitInfo.BodyPart) >= 50 && _hitInfo.DamageInflictedArmor >= 5 || this.m.ConditionMax == 2)
			{
				this.lowerCondition();
			}
		}
	}

	function onUse( _skill )
	{
		if (this.getContainer().getActor().isPlayerControlled() && _skill.isRanged() && this.m.ConditionMax > 1)
		{
			this.lowerCondition(this.Const.Combat.WeaponDurabilityLossOnUse);
		}
	}

	function onCombatFinished()
	{
		this.item.onCombatFinished();
		this.setBloodied(false);
	}

	function onDelayedRemoveSelf( _tag )
	{
		this.drop();
	}

	function lowerCondition( _value = this.Const.Combat.WeaponDurabilityLossOnHit )
	{
		local actor = this.getContainer().getActor();
		this.m.Condition = this.Math.maxf(0.0, this.m.Condition - _value);

		if (this.m.Condition == 0 && !actor.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + "\'s " + this.getName() + " has broken!");
			this.Tactical.spawnIconEffect("status_effect_36", actor.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			this.Sound.play(this.m.BreakingSound, 1.0, actor.getPos());
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, this.onDelayedRemoveSelf, null);
		}
	}

	function onLowerWeapon()
	{
		if (!this.m.ShowArmamentIcon)
		{
			return;
		}

		local app = this.getContainer().getAppearance();
		app.LowerWeapon = true;
		this.getContainer().updateAppearance();
	}

	function onRaiseWeapon()
	{
		if (!this.m.ShowArmamentIcon)
		{
			return;
		}

		local app = this.getContainer().getAppearance();
		app.LowerWeapon = false;
		this.getContainer().updateAppearance();
	}

	function updateRuneSigil()
	{
		this.item.updateRuneSigil();
		if (this.m.ArmamentIcon.find("runed_") != null)
		{
			return;
		}
		this.m.ArmamentIcon = "runed_" + this.m.ArmamentIcon;
	}


	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
		_out.writeU16(this.m.Ammo);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
		this.m.Condition = this.Math.minf(this.m.ConditionMax, this.m.Condition);
		this.m.Ammo = _in.readU16();

		if (this.m.Ammo != 0 && this.m.AmmoMax == 0)
		{
			this.m.AmmoMax = this.m.Ammo;
		}
		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}

});

