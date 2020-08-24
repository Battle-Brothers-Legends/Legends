this.ai_switchto_melee <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		WeaponToEquip = null,
		IsNegatingDisarm = false
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.SwitchToMelee;
		this.m.Order = this.Const.AI.Behavior.Order.SwitchToMelee;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.WeaponToEquip = null;
		this.m.IsNegatingDisarm = false;
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getCurrentProperties().IsStunned)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local hasQuickHands = _entity.getSkills().hasSkill("perk.quick_hands");

		if (!hasQuickHands && _entity.getActionPoints() < this.Const.Tactical.Settings.SwitchItemAPCost)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local item = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();

		if (item != null && !_entity.getCurrentProperties().IsAbleToUseWeaponSkills && hasQuickHands && _entity.getActionPoints() == _entity.getActionPointsMax() && attackSkill != null && attackSkill.getActionPointCost() <= 4)
		{
			this.m.IsNegatingDisarm = true;
			return this.Const.AI.Behavior.Score.SwitchToMelee * scoreMult * this.Const.AI.Behavior.SwitchToCounterDisarm;
		}

		local items = _entity.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag);

		if (items.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (item != null && item.isItemType(this.Const.Items.ItemType.RangedWeapon))
		{
			local isGoodReason = false;
			local myTile = _entity.getTile();

			if (item.getAmmoMax() > 0 && item.getAmmo() == 0)
			{
				this.logInfo("switching to melee weapon - no ammo!");
				isGoodReason = true;
				scoreMult = scoreMult * this.Const.AI.Behavior.SwitchToOutOfAmmoMult;
			}

			if (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageRanged) == null)
			{
				if (this.getStrategy().isDefending() && (this.getStrategy().getStats().EnemyRangedFiring > 0 || this.getStrategy().getStats().AllyRangedFiring > 0))
				{
				}
				else
				{
					local targets = this.queryTargetsInMeleeRange(this.Math.min(item.getRangeMin(), _entity.getCurrentProperties().Vision), this.Math.min(item.getRangeMax(), _entity.getCurrentProperties().Vision) + myTile.Level, 3);
					local bestTarget = this.queryBestRangedTarget(_entity, null, targets, this.Math.min(item.getRangeMax(), _entity.getCurrentProperties().Vision));

					if (bestTarget.Target == null || bestTarget.Score < 0)
					{
						this.logInfo("switching to melee weapon - noone to hit from here!");
						isGoodReason = true;
						scoreMult = scoreMult * this.Const.AI.Behavior.SwitchToEnemyInRangeMult;
					}
				}
			}

			if (!isGoodReason && this.getAgent().getIntentions().IsChangingWeapons)
			{
				return this.Const.AI.Behavior.Score.Zero;
			}

			if (!isGoodReason)
			{
				local hasReducedRangedEffectiveness = !this.World.getTime().IsDaytime && _entity.getCurrentProperties().IsAffectedByNight;
				local targets = this.queryTargetsInMeleeRange(1, hasReducedRangedEffectiveness || !this.isRangedUnit(_entity) ? 1 : 1);

				if (targets.len() == 0)
				{
					return this.Const.AI.Behavior.Score.Zero;
				}
			}
		}

		local bestWeapon;

		if (item != null && item.isItemType(this.Const.Items.ItemType.MeleeWeapon))
		{
			bestWeapon = item;
		}

		foreach( it in items )
		{
			if (!it.isItemType(this.Const.Items.ItemType.MeleeWeapon))
			{
				continue;
			}

			if (bestWeapon == null || item == null && it.getValue() > bestWeapon.getValue() || item != null && it.getValue() > bestWeapon.getValue() + 1000)
			{
				bestWeapon = it;
			}
		}

		if (bestWeapon == null || item != null && bestWeapon.getID() == item.getID())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.WeaponToEquip = bestWeapon;

		if (hasQuickHands)
		{
			scoreMult = scoreMult * this.Const.AI.Behavior.SwitchToQuickHandsMult;
		}

		if (item == null)
		{
			scoreMult = scoreMult * this.Const.AI.Behavior.SwitchToCurrentlyUnarmedMult;
		}

		if (!_entity.getCurrentProperties().IsAbleToUseWeaponSkills)
		{
			scoreMult = scoreMult * this.Const.AI.Behavior.SwitchWeaponBecauseDisarmedMult;
		}

		if (_entity.getSkills().hasSkill("special.night"))
		{
			scoreMult = scoreMult * this.Const.AI.Behavior.SwitchToMeleeAtNightMult;
		}

		return this.Const.AI.Behavior.Score.SwitchToMelee * scoreMult;
	}

	function onExecute( _entity )
	{
		if (this.m.IsNegatingDisarm)
		{
			_entity.getSkills().removeByID("effects.disarmed");
			_entity.getItems().payForAction([]);
			_entity.getItems().payForAction([]);
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " equips their weapon again");
			this.m.IsNegatingDisarm = false;
			this.m.WeaponToEquip = null;
			return true;
		}

		if (this.Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Switching to melee weapon \'" + this.m.WeaponToEquip.getID() + "\'!");
		}

		local oldWeapon = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (oldWeapon != null)
		{
			_entity.getItems().unequip(oldWeapon);
		}

		_entity.getItems().removeFromBag(this.m.WeaponToEquip);

		if (this.m.WeaponToEquip.getBlockedSlotType() != null && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
		{
			local slotsRequired = 1;

			if (oldWeapon != null)
			{
				slotsRequired = ++slotsRequired;
			}

			local shield = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (_entity.getItems().getNumberOfEmptySlots(this.Const.ItemSlot.Bag) >= slotsRequired)
			{
				_entity.getItems().unequip(shield);
				_entity.getItems().addToBag(shield);
			}
			else
			{
				shield.drop(_entity.getTile());
			}
		}

		_entity.getItems().equip(this.m.WeaponToEquip);

		if (oldWeapon != null)
		{
			_entity.getItems().addToBag(oldWeapon);
		}

		_entity.getItems().payForAction([]);
		this.m.WeaponToEquip = null;
		this.getAgent().getIntentions().IsChangingWeapons = true;
		return true;
	}

});

