this.tooltip_events <- {
	m = {},
	function create()
	{
	}

	function destroy()
	{
	}

	function onQueryTileTooltipData()
	{
		if (this.Tactical.isActive())
		{
			return this.TooltipEvents.tactical_queryTileTooltipData();
		}
		else
		{
			return this.TooltipEvents.strategic_queryTileTooltipData();
		}
	}

	function onQueryEntityTooltipData( _entityId, _isTileEntity )
	{
		if (this.Tactical.isActive())
		{
			return this.TooltipEvents.tactical_queryEntityTooltipData(_entityId, _isTileEntity);
		}
		else
		{
			return this.TooltipEvents.strategic_queryEntityTooltipData(_entityId, _isTileEntity);
		}
	}

	function onQueryRosterEntityTooltipData( _entityId )
	{
		local entity = this.Tactical.getEntityByID(_entityId);

		if (entity != null)
		{
			return entity.getRosterTooltip();
		}

		return null;
	}

	function onQuerySkillTooltipData( _entityId, _skillId )
	{
		return this.TooltipEvents.general_querySkillTooltipData(_entityId, _skillId);
	}

	function onQueryStatusEffectTooltipData( _entityId, _statusEffectId )
	{
		return this.TooltipEvents.general_queryStatusEffectTooltipData(_entityId, _statusEffectId);
	}

	function onQuerySettlementStatusEffectTooltipData( _statusEffectId )
	{
		return this.TooltipEvents.general_querySettlementStatusEffectTooltipData(_statusEffectId);
	}

	function onQueryUIItemTooltipData( _entityId, _itemId, _itemOwner )
	{
		if (this.Tactical.isActive())
		{
			return this.TooltipEvents.tactical_queryUIItemTooltipData(_entityId, _itemId, _itemOwner);
		}
		else
		{
			return this.TooltipEvents.strategic_queryUIItemTooltipData(_entityId, _itemId, _itemOwner);
		}
	}

	function onQueryUIPerkTooltipData( _entityId, _perkId )
	{
		return this.TooltipEvents.general_queryUIPerkTooltipData(_entityId, _perkId);
	}

	function onQueryUIElementTooltipData( _entityId, _elementId, _elementOwner )
	{
		return this.TooltipEvents.general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);
	}

	function onQueryFollowerTooltipData( _followerID )
	{
		if (typeof _followerID == "integer")
		{
			local renown = "\'" + this.Const.Strings.BusinessReputation[this.Const.FollowerSlotRequirements[_followerID]] + "\' (" + this.Const.BusinessReputation[this.Const.FollowerSlotRequirements[_followerID]] + ")";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Locked Seat"
				},
				{
					id = 4,
					type = "description",
					text = "Your company lacks the renown necessary to hire more non-combat followers. Attain at least " + renown + " renown in order to unlock this seat. Gain renown by completing ambitions and contracts, as well as by winning battles."
				}
			];
			return ret;
		}
		else if (_followerID == "free")
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Free Seat"
				},
				{
					id = 4,
					type = "description",
					text = "There\'s space here to add another non-combat follower to your company."
				},
				{
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_left_button.png",
					text = "Open Hiring Screen"
				}
			];
			return ret;
		}
		else
		{
			local p = this.World.Retinue.getFollower(_followerID);
			return p.getTooltip();
		}
	}

	function tactical_queryTileTooltipData()
	{
		local lastTileHovered = this.Tactical.State.getLastTileHovered();

		if (lastTileHovered == null)
		{
			return null;
		}

		if (!lastTileHovered.IsDiscovered)
		{
			return null;
		}

		if (lastTileHovered.IsDiscovered && !lastTileHovered.IsEmpty && (!lastTileHovered.IsOccupiedByActor || lastTileHovered.IsVisibleForPlayer))
		{
			local entity = lastTileHovered.getEntity();
			return this.tactical_helper_getEntityTooltip(entity, this.Tactical.TurnSequenceBar.getActiveEntity(), true);
		}
		else
		{
			local tooltipContent = [
				{
					id = 1,
					type = "title",
					text = this.Const.Strings.Tactical.TerrainName[lastTileHovered.Subtype],
					icon = "ui/tooltips/height_" + lastTileHovered.Level + ".png"
				}
			];
			tooltipContent.push({
				id = 2,
				type = "description",
				text = this.Const.Strings.Tactical.TerrainDescription[lastTileHovered.Subtype]
			});

			if (lastTileHovered.IsCorpseSpawned)
			{
				tooltipContent.push({
					id = 3,
					type = "description",
					text = lastTileHovered.Properties.get("Corpse").CorpseName + " was slain here."
				});
			}

			if (this.Tactical.TurnSequenceBar.getActiveEntity() != null)
			{
				local actor = this.Tactical.TurnSequenceBar.getActiveEntity();

				if (actor.isPlacedOnMap() && actor.isPlayerControlled())
				{
					if (this.Math.abs(lastTileHovered.Level - actor.getTile().Level) == 1)
					{
						tooltipContent.push({
							id = 90,
							type = "text",
							text = "Costs [b][color=" + this.Const.UI.Color.PositiveValue + "]" + actor.getActionPointCosts()[lastTileHovered.Type] + "+" + actor.getLevelActionPointCost() + "[/color][/b] AP and [b][color=" + this.Const.UI.Color.PositiveValue + "]" + actor.getFatigueCosts()[lastTileHovered.Type] + "+" + actor.getLevelFatigueCost() + "[/color][/b] Fatigue to traverse because it is at a different height level"
						});
					}
					else
					{
						tooltipContent.push({
							id = 90,
							type = "text",
							text = "Costs [b][color=" + this.Const.UI.Color.PositiveValue + "]" + actor.getActionPointCosts()[lastTileHovered.Type] + "[/color][/b] AP and [b][color=" + this.Const.UI.Color.PositiveValue + "]" + actor.getFatigueCosts()[lastTileHovered.Type] + "[/color][/b] Fatigue to traverse"
						});
					}
				}
			}

			foreach( i, line in this.Const.Tactical.TerrainEffectTooltip[lastTileHovered.Type] )
			{
				tooltipContent.push(line);
			}

			if (lastTileHovered.IsHidingEntity)
			{
				tooltipContent.push({
					id = 98,
					type = "text",
					icon = "ui/icons/vision.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]Hides anyone inside from being seen at a distance.[/color]"
				});
			}

			local allies;

			if (this.Tactical.State.isScenarioMode())
			{
				allies = this.Const.FactionAlliance[this.Const.Faction.Player];
			}
			else
			{
				allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);
			}

			if (lastTileHovered.IsVisibleForPlayer && lastTileHovered.hasZoneOfControlOtherThan(allies))
			{
				tooltipContent.push({
					id = 99,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]Is in opponent\'s Zone of Control.[/color]"
				});
			}

			if (lastTileHovered.IsVisibleForPlayer && (lastTileHovered.SquareCoords.X == 0 || lastTileHovered.SquareCoords.Y == 0 || lastTileHovered.SquareCoords.X == 31 || lastTileHovered.SquareCoords.Y == 31))
			{
				tooltipContent.push({
					id = 99,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]Any character on this tile may retreat safely and immediately from battle.[/color]"
				});
			}

			if (lastTileHovered.IsVisibleForPlayer && lastTileHovered.Properties.Effect != null)
			{
				tooltipContent.push({
					id = 100,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + lastTileHovered.Properties.Effect.Tooltip + "[/color]"
				});
			}

			if (lastTileHovered.Items != null)
			{
				local result = [];

				foreach( item in lastTileHovered.Items )
				{
					result.push(item.getIcon());
				}

				if (result.len() > 0)
				{
					tooltipContent.push({
						id = 100,
						type = "icons",
						useItemPath = true,
						icons = result
					});
				}
			}

			return tooltipContent;
		}
	}

	function tactical_queryEntityTooltipData( _entityId, _isTileEntity )
	{
		local entity = this.Tactical.getEntityByID(_entityId);

		if (entity != null)
		{
			return this.tactical_helper_getEntityTooltip(entity, this.Tactical.TurnSequenceBar.getActiveEntity(), _isTileEntity);
		}

		return null;
	}

	function tactical_queryUIItemTooltipData( _entityId, _itemId, _itemOwner )
	{
		local entity = this.Tactical.getEntityByID(_entityId);
		local activeEntity = this.Tactical.TurnSequenceBar.getActiveEntity();

		switch(_itemOwner)
		{
		case "entity":
			if (entity != null)
			{
				local item = entity.getItems().getItemByInstanceID(_itemId);

				if (item != null)
				{
					return this.tactical_helper_addHintsToTooltip(activeEntity, entity, item, _itemOwner);
				}
			}

			return null;

		case "ground":
		case "character-screen-inventory-list-module.ground":
			if (entity != null)
			{
				local item = this.tactical_helper_findGroundItem(entity, _itemId);

				if (item != null)
				{
					return this.tactical_helper_addHintsToTooltip(activeEntity, entity, item, _itemOwner);
				}
			}

			return null;

		case "stash":
		case "character-screen-inventory-list-module.stash":
			local result = this.Stash.getItemByInstanceID(_itemId);

			if (result != null)
			{
				return this.tactical_helper_addHintsToTooltip(activeEntity, entity, result.item, _itemOwner);
			}

			return null;

		case "tactical-combat-result-screen.stash":
			local result = this.Stash.getItemByInstanceID(_itemId);

			if (result != null)
			{
				return this.tactical_helper_addHintsToTooltip(activeEntity, entity, result.item, _itemOwner, true);
			}

			return null;

		case "tactical-combat-result-screen.found-loot":
			local result = this.Tactical.CombatResultLoot.getItemByInstanceID(_itemId);

			if (result != null)
			{
				return this.tactical_helper_addHintsToTooltip(activeEntity, entity, result.item, _itemOwner, true);
			}

			return null;

		case "paperdoll.remove-armor-layer":
			if (entity == null)
			{
				return null;
			}

			return entity.getRemoveLayerTooltip(this.Const.ItemSlot.Body, _itemId);

		case "paperdoll.remove-helmet-layer":
			if (entity == null)
			{
				return null;
			}

			return entity.getRemoveLayerTooltip(this.Const.ItemSlot.Head, _itemId);
		}

		return null;
	}

	function tactical_helper_findGroundItem( _entity, _itemId )
	{
		local items = _entity.getTile() != null ? _entity.getTile().Items : null;

		if (items != null && items.len() > 0)
		{
			foreach( item in items )
			{
				if (item.getInstanceID() == _itemId)
				{
					return item;
				}
			}
		}

		return null;
	}

	function tactical_helper_getEntityTooltip( _targetedEntity, _activeEntity, _isTileEntity )
	{
		if (this.Tactical.State != null && this.Tactical.State.getCurrentActionState() == this.Const.Tactical.ActionState.SkillSelected)
		{
			if (_activeEntity != null && this.isKindOf(_targetedEntity, "actor") && _activeEntity.isPlayerControlled() && _targetedEntity != null && !_targetedEntity.isPlayerControlled())
			{
				local skill = _activeEntity.getSkills().getSkillByID(this.Tactical.State.getSelectedSkillID());

				if (skill != null)
				{
					return this.tactical_helper_addContentTypeToTooltip(_targetedEntity, _targetedEntity.getTooltip(skill), _isTileEntity);
				}
			}

			return null;
		}

		if (this.isKindOf(_targetedEntity, "entity"))
		{
			return this.tactical_helper_addContentTypeToTooltip(_targetedEntity, _targetedEntity.getTooltip(), _isTileEntity);
		}

		return null;
	}

	function tactical_helper_addContentTypeToTooltip( _entity, _tooltip, _isTileEntity )
	{
		if (_isTileEntity == false && !_entity.isHiddenToPlayer())
		{
			_tooltip.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = this.Const.Strings.Tooltip.Tactical.Hint_FocusCharacter
			});
		}

		if (_isTileEntity == true)
		{
			_tooltip.push({
				contentType = "tile-entity",
				entityId = _entity.getID()
			});
		}
		else
		{
			_tooltip.push({
				contentType = "entity",
				entityId = _entity.getID()
			});
		}

		return _tooltip;
	}

	function tactical_helper_addHintsToTooltip( _activeEntity, _entity, _item, _itemOwner, _ignoreStashLocked = false )
	{
		local stashLocked = true;

		if (this.Stash != null)
		{
			stashLocked = this.Stash.isLocked();
		}

		local tooltip = _item.getTooltip();

		if (stashLocked == true && _ignoreStashLocked == false)
		{
			if (_item.isChangeableInBattle(_entity) == false)
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/icon_locked.png",
					text = this.Const.Strings.Tooltip.Tactical.Hint_CannotChangeItemInCombat
				});
				return tooltip;
			}

			if (_activeEntity == null || _entity != null && _activeEntity != null && _entity.getID() != _activeEntity.getID())
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/icon_locked.png",
					text = this.Const.Strings.Tooltip.Tactical.Hint_OnlyActiveCharacterCanChangeItemsInCombat
				});
				return tooltip;
			}

			if (_activeEntity != null && _activeEntity.getItems().isActionAffordable([
				_item
			]) == false)
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Not enough Action Points to change items ([b][color=" + this.Const.UI.Color.NegativeValue + "]" + _activeEntity.getItems().getActionCost([
						_item
					]) + "[/color][/b] required)"
				});
				return tooltip;
			}
		}

		switch(_itemOwner)
		{
		case "entity":
			if (_item.getCurrentSlotType() == this.Const.ItemSlot.Bag && _item.getSlotType() != this.Const.ItemSlot.None)
			{
				if (stashLocked == true)
				{
					if (_item.getSlotType() != this.Const.ItemSlot.Bag && (_entity.getItems().getItemAtSlot(_item.getSlotType()) == null || _entity.getItems().getItemAtSlot(_item.getSlotType()) == "-1" || _entity.getItems().getItemAtSlot(_item.getSlotType()).isAllowedInBag(_entity)))
					{
						tooltip.push({
							id = 1,
							type = "hint",
							icon = "ui/icons/mouse_right_button.png",
							text = "Equip item ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
								_item,
								_entity.getItems().getItemAtSlot(_item.getSlotType()),
								_entity.getItems().getItemAtSlot(_item.getBlockedSlotType())
							]) + "[/color][/b] AP)"
						});
					}

					tooltip.push({
						id = 2,
						type = "hint",
						icon = "ui/icons/mouse_right_button_ctrl.png",
						text = "Drop item on ground ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
							_item
						]) + "[/color][/b] AP)"
					});
				}
				else
				{
					if (_item.getSlotType() != this.Const.ItemSlot.Bag && (_entity.getItems().getItemAtSlot(_item.getSlotType()) == null || _entity.getItems().getItemAtSlot(_item.getSlotType()) == "-1" || _entity.getItems().getItemAtSlot(_item.getSlotType()).isAllowedInBag(_entity)))
					{
						tooltip.push({
							id = 1,
							type = "hint",
							icon = "ui/icons/mouse_right_button.png",
							text = "Equip item"
						});
					}

					tooltip.push({
						id = 2,
						type = "hint",
						icon = "ui/icons/mouse_right_button_ctrl.png",
						text = "Place item in stash"
					});
				}
			}
			else if (stashLocked == true)
			{
				if (_item.isChangeableInBattle(_entity) && _item.isAllowedInBag(_entity) && _entity.getItems().hasEmptySlot(this.Const.ItemSlot.Bag))
				{
					tooltip.push({
						id = 1,
						type = "hint",
						icon = "ui/icons/mouse_right_button.png",
						text = "Place item in bag ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
							_item
						]) + "[/color][/b] AP)"
					});
				}

				tooltip.push({
					id = 2,
					type = "hint",
					icon = "ui/icons/mouse_right_button_ctrl.png",
					text = "Drop item on ground ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
						_item
					]) + "[/color][/b] AP)"
				});
			}
			else
			{
				if (_item.isChangeableInBattle(_activeEntity) && _item.isAllowedInBag(_activeEntity))
				{
					tooltip.push({
						id = 1,
						type = "hint",
						icon = "ui/icons/mouse_right_button.png",
						text = "Place item in bag"
					});
				}

				tooltip.push({
					id = 2,
					type = "hint",
					icon = "ui/icons/mouse_right_button_ctrl.png",
					text = "Place item in stash"
				});
			}

			break;

		case "ground":
		case "character-screen-inventory-list-module.ground":
			if (_item.isChangeableInBattle(_entity))
			{
				if (_item.getSlotType() != this.Const.ItemSlot.None)
				{
					tooltip.push({
						id = 1,
						type = "hint",
						icon = "ui/icons/mouse_right_button.png",
						text = "Equip item ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
							_item,
							_entity.getItems().getItemAtSlot(_item.getSlotType()),
							_entity.getItems().getItemAtSlot(_item.getBlockedSlotType())
						]) + "[/color][/b] AP)"
					});
				}

				if (_item.isAllowedInBag(_entity))
				{
					tooltip.push({
						id = 2,
						type = "hint",
						icon = "ui/icons/mouse_right_button_ctrl.png",
						text = "Place item in bag ([b][color=" + this.Const.UI.Color.PositiveValue + "]" + _activeEntity.getItems().getActionCost([
							_item
						]) + "[/color][/b] AP)"
					});
				}
			}

			break;

		case "stash":
		case "character-screen-inventory-list-module.stash":
			if (_item.isUsable())
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_right_button.png",
					text = "Use item"
				});
			}
			else if (_item.getSlotType() != this.Const.ItemSlot.None && _item.getSlotType() != this.Const.ItemSlot.Bag)
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_right_button.png",
					text = "Equip item"
				});
			}

			if (_item.isChangeableInBattle(_entity) == true && _item.isAllowedInBag(_entity))
			{
				tooltip.push({
					id = 2,
					type = "hint",
					icon = "ui/icons/mouse_right_button_ctrl.png",
					text = "Place item in bag"
				});
			}

			if (_item.getRepair() >= _item.getRepairMax())
			{
				tooltip.push({
					id = 3,
					type = "hint",
					icon = "ui/icons/mouse_right_button_alt.png",
					text = "Set item to be salvaged"
				});
			}
			else if (_item.getRepair() < _item.getRepairMax())
			{
				local text = "Set item to be repaired";

				if (_item.isToBeRepaired())
				{
					text = "Set item to be salvaged";
				}
				else if (_item.isToBeSalvaged())
				{
					text = "Set item to not be salvaged or repaired";
				}

				tooltip.push({
					id = 3,
					type = "hint",
					icon = "ui/icons/mouse_right_button_alt.png",
					text = text
				});
			}

			break;

		case "tactical-combat-result-screen.stash":
			tooltip.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_right_button.png",
				text = "Drop item on the ground"
			});
			break;

		case "tactical-combat-result-screen.found-loot":
			if (this.Stash.hasEmptySlot())
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_right_button.png",
					text = "Put item into stash"
				});
			}
			else
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Stash is full"
				});
			}

			break;

		case "camp-screen-repair-dialog-module.stash":
		case "camp-screen-workshop-dialog-module.stash":
		case "world-town-screen-shop-dialog-module.stash":
			tooltip.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_right_button.png",
				text = "Sell item for [img]gfx/ui/tooltips/money.png[/img]" + _item.getSellPrice()
			});

			if (this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().getCurrentBuilding() != null && this.World.State.getCurrentTown().getCurrentBuilding().isRepairOffered() && _item.getRepairMax() > 1 && _item.getRepair() < _item.getRepairMax())
			{
				local price = (_item.getRepairMax() - _item.getRepair()) * this.Const.World.Assets.CostToRepairPerPoint;
				local value = _item.m.Value * (1.0 - _item.getRepair() / _item.getRepairMax()) * 0.2 * this.World.State.getCurrentTown().getPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()];
				price = this.Math.max(price, value);

				if (this.World.Assets.getMoney() >= price)
				{
					tooltip.push({
						id = 3,
						type = "hint",
						icon = "ui/icons/mouse_right_button_alt.png",
						text = "Pay [img]gfx/ui/tooltips/money.png[/img]" + price + " to have it repaired"
					});
				}
				else
				{
					tooltip.push({
						id = 3,
						type = "hint",
						icon = "ui/tooltips/warning.png",
						text = "Not enough crowns to pay for repairs!"
					});
				}
			}

			break;

		case "camp-screen-repair-dialog-module.shop":
		case "camp-screen-workshop-dialog-module.shop":
		case "world-town-screen-shop-dialog-module.shop":
			if (this.Stash.hasEmptySlot())
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_right_button.png",
					text = "Buy item for [img]gfx/ui/tooltips/money.png[/img]" + _item.getBuyPrice()
				});
			}
			else
			{
				tooltip.push({
					id = 1,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Stash is full"
				});
			}

			break;
		}

		return tooltip;
	}

	function strategic_queryTileTooltipData()
	{
		local lastTileHovered = this.World.State.getLastTileHovered();

		if (lastTileHovered != null)
		{
			if (this.World.Assets.m.IsShowingExtendedFootprints)
			{
				local footprints = this.World.getAllFootprintsAtPos(this.World.getCamera().screenToWorld(this.Cursor.getX(), this.Cursor.getY()), this.Const.World.FootprintsType.COUNT);
				local ret = [
					{
						id = 1,
						type = "title",
						text = "Your Lookout reports"
					}
				];

				for( local i = 1; i < footprints.len(); i = i )
				{
					if (footprints[i])
					{
						ret.push({
							id = 1,
							type = "hint",
							text = this.Const.Strings.FootprintsType[i] + " recently passed through here"
						});
					}

					i = ++i;
				}

				if (ret.len() > 1)
				{
					return ret;
				}
			}
		}

		return null;
	}

	function strategic_queryEntityTooltipData( _entityId, _isTileEntity )
	{
		if (_isTileEntity)
		{
			local lastEntityHovered = this.World.State.getLastEntityHovered();
			local entity = this.World.getEntityByID(_entityId);

			if (lastEntityHovered != null && entity != null && lastEntityHovered.getID() == entity.getID())
			{
				return this.strategic_helper_addContentTypeToTooltip(entity, entity.getTooltip());
			}
		}
		else
		{
			local entity = this.Tactical.getEntityByID(_entityId);

			if (entity != null)
			{
				return this.strategic_helper_addContentTypeToTooltip(entity, entity.getRosterTooltip());
			}
		}

		return null;
	}

	function strategic_queryUIItemTooltipData( _entityId, _itemId, _itemOwner )
	{
		local entity = _entityId != null ? this.Tactical.getEntityByID(_entityId) : null;

		switch(_itemOwner)
		{
		case "entity":
			if (entity != null)
			{
				local item = entity.getItems().getItemByInstanceID(_itemId);

				if (item != null)
				{
					return this.tactical_helper_addHintsToTooltip(null, entity, item, _itemOwner);
				}
			}

			return null;

		case "ground":
		case "character-screen-inventory-list-module.ground":
			if (entity != null)
			{
				local item = this.tactical_helper_findGroundItem(entity, _itemId);

				if (item != null)
				{
					return this.tactical_helper_addHintsToTooltip(null, entity, item, _itemOwner);
				}
			}

			return null;

		case "stash":
		case "character-screen-inventory-list-module.stash":
			local result = this.Stash.getItemByInstanceID(_itemId);

			if (result != null)
			{
				return this.tactical_helper_addHintsToTooltip(null, entity, result.item, _itemOwner);
			}

			return null;

		case "craft":
			return this.World.Crafting.getBlueprint(_itemId).getTooltip();

		case "blueprint":
			return this.World.Crafting.getBlueprint(_entityId).getTooltipForComponent(_itemId);

		case "blueprintskill":
			return this.World.Crafting.getBlueprint(_entityId).getTooltipForSkill(_itemId);

		case "world-town-screen-shop-dialog-module.stash":
			local result = this.Stash.getItemByInstanceID(_itemId);

			if (result != null)
			{
				return this.tactical_helper_addHintsToTooltip(null, entity, result.item, _itemOwner, true);
			}

			return null;

		case "world-town-screen-shop-dialog-module.shop":
			local stash = this.World.State.getTownScreen().getShopDialogModule().getShop().getStash();

			if (stash != null)
			{
				local result = stash.getItemByInstanceID(_itemId);

				if (result != null)
				{
					return this.tactical_helper_addHintsToTooltip(null, entity, result.item, _itemOwner, true);
				}
			}

			return null;

		case "paperdoll.remove-armor-layer":
			if (entity == null)
			{
				return null;
			}

			return entity.getRemoveLayerTooltip(this.Const.ItemSlot.Body, _itemId);

		case "paperdoll.remove-helmet-layer":
			if (entity == null)
			{
				return null;
			}

			return entity.getRemoveLayerTooltip(this.Const.ItemSlot.Head, _itemId);
		}

		return null;
	}

	function strategic_helper_addContentTypeToTooltip( _entity, _tooltip )
	{
		_tooltip.push({
			contentType = "tile-entity",
			entityId = _entity.getID()
		});
		return _tooltip;
	}

	function general_querySkillTooltipData( _entityId, _skillId )
	{
		local entity = this.Tactical.getEntityByID(_entityId);

		if (entity != null)
		{
			local skill = entity.getSkills().getSkillByID(_skillId);

			if (skill != null)
			{
				return skill.getTooltip();
			}
		}

		return null;
	}

	function general_queryStatusEffectTooltipData( _entityId, _statusEffectId )
	{
		local entity = this.Tactical.getEntityByID(_entityId);

		if (entity != null)
		{
			local statusEffect = entity.getSkills().getSkillByID(_statusEffectId);

			if (statusEffect != null)
			{
				return statusEffect.getTooltip();
			}
		}

		return null;
	}

	function general_querySettlementStatusEffectTooltipData( _statusEffectId )
	{
		local currentTown = this.World.State.getCurrentTown();

		if (currentTown != null)
		{
			local statusEffect = currentTown.getSituationByID(_statusEffectId);

			if (statusEffect != null)
			{
				return statusEffect.getTooltip();
			}
		}

		return null;
	}

	function general_queryUIPerkTooltipData( _entityId, _perkId )
	{
		local player = this.Tactical.getEntityByID(_entityId);
		local perk = player.getBackground().getPerk(_perkId);

		local vars = [
			[
				"name",
				player.getNameOnly()
			],
			[
				"fullname",
				player.getName()
			],
			[
				"title",
				player.getTitle()
			]
		];
		this.Const.LegendMod.extendVarsWithPronouns(vars, player.getGender());
		local tooltip = this.buildTextFromTemplate(perk.Tooltip, vars);

		if (perk != null)
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = perk.Name
				},
				{
					id = 2,
					type = "description",
					text = tooltip
				}
			];

			if (!player.hasPerk(_perkId))
			{
				if (player.getPerkPointsSpent() >= perk.Unlocks)
				{
					if (player.getPerkPoints() == 0)
					{
						ret.push({
							id = 3,
							type = "hint",
							icon = "ui/icons/icon_locked.png",
							text = "Available, but this character has no perk point to spend"
						});
					}
				}
				else if (perk.Unlocks - player.getPerkPointsSpent() > 1)
				{
					ret.push({
						id = 3,
						type = "hint",
						icon = "ui/icons/icon_locked.png",
						text = "Locked until " + (perk.Unlocks - player.getPerkPointsSpent()) + " more perk points are spent"
					});
				}
				else
				{
					ret.push({
						id = 3,
						type = "hint",
						icon = "ui/icons/icon_locked.png",
						text = "Locked until " + (perk.Unlocks - player.getPerkPointsSpent()) + " more perk point is spent"
					});
				}
			}

			return ret;
		}

		return null;
	}

	function general_queryUIElementTooltipData( _entityId, _elementId, _elementOwner )
	{
		local entity;

		if (_entityId != null)
		{
			entity = this.Tactical.getEntityByID(_entityId);
		}

		switch(_elementId)
		{
		case "CharacterName":
			local ret = [
				{
					id = 1,
					type = "title",
					text = entity.getName()
				}
			];
			return ret;

		case "CharacterNameAndTitles":
			local ret = [
				{
					id = 1,
					type = "title",
					text = entity.getName()
				}
			];

			if ("getProperties" in entity)
			{
				foreach( p in entity.getProperties() )
				{
					local s = this.World.getEntityByID(p);
					ret.push({
						id = 2,
						type = "text",
						text = "Lord of " + s.getName()
					});
				}
			}

			if ("getTitles" in entity)
			{
				foreach( s in entity.getTitles() )
				{
					ret.push({
						id = 3,
						type = "text",
						text = s
					});
				}
			}

			return ret;

		case "assets.Money":
			local money = this.World.Assets.getMoney();
			local dailyMoney = 0;
			local barterMult = 0.0;
			local brolist = [];
			local greed = 1;

			foreach(bro in this.World.getPlayerRoster().getAll())
			{
				if (bro.getSkills().hasSkill("perk.legend_barter_greed"))
				{
					greed += 1;
				}
			}

			foreach( bro in this.World.getPlayerRoster().getAll() )
			{
				local L = [];
				dailyMoney = dailyMoney + bro.getDailyCost();
				local L = [
					bro.getDailyCost(),
					bro.getName(),
					bro.getBackground().getNameOnly()
				];
				local bm = this.Math.floor(bro.getBarterModifier() * 10000.0 / greed) / 100;

				if (bm > 0)
				{
					barterMult = barterMult + bm;
					L[2] = L[2] + " [color=" + this.Const.UI.Color.PositiveValue + "]" + bm + "%[/color] Barter";
				}

				brolist.push(L);
			}

			local time = this.Math.floor(money / this.Math.max(1, dailyMoney));
			local ret = [];

			if (dailyMoney == 0)
			{
				return [
					{
						id = 1,
						type = "title",
						text = "Crowns"
					},
					{
						id = 2,
						type = "description",
						text = "The amount of coin your mercenary company has. Used to pay every mercenary daily at noon, as well as to hire new people and purchase equipment.\n\nYou currently don\'t pay anyone."
					}
				];
			}
			else if (time >= 1.0 && money > 0)
			{
				ret = [
					{
						id = 1,
						type = "title",
						text = "Crowns"
					},
					{
						id = 2,
						type = "description",
						text = "The amount of coin your mercenary company has. Used to pay every mercenary daily at noon, as well as to hire new people and purchase equipment.\n\nYou pay out [color=" + this.Const.UI.Color.NegativeValue + "]" + dailyMoney + "[/color] crowns per day. Your [color=" + this.Const.UI.Color.PositiveValue + "]" + money + "[/color] crowns will last you for [color=" + this.Const.UI.Color.PositiveValue + "]" + time + "[/color] more days."
					}
				];
			}
			else
			{
				ret = [
					{
						id = 1,
						type = "title",
						text = "Crowns"
					},
					{
						id = 2,
						type = "description",
						text = "The amount of coin your mercenary company has. Used to pay every mercenary daily, as well as to hire new people and purchase equipment.\n\nYou pay out [color=" + this.Const.UI.Color.PositiveValue + "]" + dailyMoney + "[/color] crowns per day.\n\n[color=" + this.Const.UI.Color.NegativeValue + "]You have no more crowns to pay your men with! Earn some crowns fast or let some people go before they desert you one by one.[/color]"
					}
				];
			}

			local id = 4;
			local sortfn = function ( first, second )
			{
				if (first[0] == second[0])
				{
					return 0;
				}

				if (first[0] > second[0])
				{
					return -1;
				}

				return 1;
			};
			brolist.sort(sortfn);

			foreach( bro in brolist )
			{
				ret.push({
					id = id,
					type = "hint",
					icon = "ui/tooltips/money.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + bro[0] + "[/color] " + bro[1] + " (" + bro[2] + ")"
				});
				id = ++id;
			}

			ret.push({
				id = id,
				type = "text",
				icon = "ui/icons/asset_moral_reputation.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + barterMult + "[/color]% Barter Multiplier"
			});
			id = ++id;
			return ret;

		case "assets.InitialMoney":
			return [
				{
					id = 1,
					type = "title",
					text = "Hiring Fee"
				},
				{
					id = 2,
					type = "description",
					text = "The hiring fee will be paid immediately on hiring a mercenary for signing up and proving you can back up your words with coin."
				}
			];

		case "assets.Fee":
			return [
				{
					id = 1,
					type = "title",
					text = "Up Front Costs"
				},
				{
					id = 2,
					type = "description",
					text = "This fee will have to be paid up front for services to be rendered."
				}
			];

		case "assets.TryoutMoney":
			return [
				{
					id = 1,
					type = "title",
					text = "Tryout Fee"
				},
				{
					id = 2,
					type = "description",
					text = "This fee will be paid immediately on giving this recruit a proper inspection to reveal their character traits, if any."
				}
			];

		case "assets.DailyMoney":
			return [
				{
					id = 1,
					type = "title",
					text = "Daily Wage"
				},
				{
					id = 2,
					type = "description",
					text = "The daily wage will be paid every single day as payment for serving under your command. The wage is increased automatically by a cumulative 10% per level until the 11th, and then 3% afterwards."
				}
			];

		case "assets.Food":
			local food = this.World.Assets.getFood();
			local dailyFood = this.Math.ceil(this.World.Assets.getDailyFoodCost() * this.Const.World.TerrainFoodConsumption[this.World.State.getPlayer().getTile().Type]);
			local brolist = [];

			foreach( bro in this.World.getPlayerRoster().getAll() )
			{
				local brofood = this.Math.ceil(bro.getDailyFood() * this.Const.World.TerrainFoodConsumption[this.World.State.getPlayer().getTile().Type]);
				brolist.push([
					brofood,
					bro.getName()
				]);
			}

			local time = this.Math.floor(food / dailyFood);
			local ret = [];

			if (food > 0 && time > 1)
			{
				ret = [
					{
						id = 1,
						type = "title",
						text = "Provisions"
					},
					{
						id = 2,
						type = "description",
						text = "The total amount of provisions you carry. The average mercenary requires 2 provisions per day, more on difficult terrain or when in reserve. Your mercenaries will eat the provisions closest to expiring first. Running out of provisions will lower morale and will eventually lead to your people deserting you before dying of starvation.\n\nYou use [color=" + this.Const.UI.Color.PositiveValue + "]" + dailyFood + "[/color] provisions per day. Your [color=" + this.Const.UI.Color.PositiveValue + "]" + food + "[/color] provisions will last you for [color=" + this.Const.UI.Color.PositiveValue + "]" + time + "[/color] more days at most. Keep in mind that individual provisions will eventually turn bad!"
					}
				];
			}
			else if (food > 0 && time == 1)
			{
				ret = [
					{
						id = 1,
						type = "title",
						text = "Provisions"
					},
					{
						id = 2,
						type = "description",
						text = "The total amount of provisions you carry. The average mercenary requires 2 provisions per day and more on difficult terrain. Your mercenaries will eat the provisions closest to expiring first. Running out of provisions will lower morale and will eventually lead to your people deserting you before dying of starvation.\n\nYou use [color=" + this.Const.UI.Color.PositiveValue + "]" + dailyFood + "[/color] provisions per day.\n\n[color=" + this.Const.UI.Color.NegativeValue + "]You are almost out of provisions to feed your company! Buy new provisions as fast as possible or your mercenaries will desert you one by one before they starve![/color]"
					}
				];
			}
			else
			{
				ret = [
					{
						id = 1,
						type = "title",
						text = "Provisions"
					},
					{
						id = 2,
						type = "description",
						text = "The total amount of provisions you carry. The average mercenary requires 2 provisions per day, more on difficult terrain or when in reserve. Your mercenaries will eat the provisions closest to expiring first. Running out of provisions will lower morale and will eventually lead to your people deserting you before dying of starvation.\n\nYou use [color=" + this.Const.UI.Color.PositiveValue + "]" + dailyFood + "[/color] provisions per day.\n\n[color=" + this.Const.UI.Color.NegativeValue + "]You have no more provisions to feed your company! Buy new provisions as fast as possible or your mercenaries will desert you one by one before they starve![/color]"
					}
				];
			}

			local id = 4;
			local sortfn = function ( first, second )
			{
				if (first[0] == second[0])
				{
					return 0;
				}

				if (first[0] > second[0])
				{
					return -1;
				}

				return 1;
			};
			brolist.sort(sortfn);

			foreach( bro in brolist )
			{
				ret.push({
					id = id,
					type = "text",
					icon = "ui/icons/asset_daily_food.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + bro[0] + "[/color] " + bro[1]
				});
				id = ++id;
			}

			return ret;

		case "assets.DailyFood":
			return [
				{
					id = 1,
					type = "title",
					text = "Daily Provisions"
				},
				{
					id = 2,
					type = "description",
					text = "The amount of provisions a mercenary requires each day. Running out of provisions will lower morale and will eventually lead to your people deserting you before dying of starvation."
				}
			];

		case "assets.Ammo":
			return [
				{
					id = 1,
					type = "title",
					text = "Ammunition"
				},
				{
					id = 2,
					type = "description",
					text = "Assorted arrows, bolts and throwing weapons used to automatically refill quivers after battle. Replacing one arrow or bolt will take up one point of ammunition, replacing one shot of a Handgonne will take up two points, and replacing one throwing weapon or charge of a Fire Lance will take up three. Running out of ammunition will leave your quivers empty and your people with nothing to shoot with. You can carry no more than " + this.World.Assets.getMaxAmmo() + " units at a time."
				}
			];

		case "assets.Supplies":
			local desc = "Assorted tools and supplies to keep your weapons, armor, helmets and shields in good condition. Running out of supplies may result in weapons breaking in combat and will leave your armor damaged and useless. Items can only be repaired while camping. More tools can be purchased in town or salvaged from equipment while camping.";
			desc = desc + ("  You can carry " + this.World.Assets.getMaxArmorParts() + " units at most.");
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Tools and Supplies"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];
			return ret;

		case "repairs.Supplies":
			local desc = "Number of tools on hand to repair equipment. One tool is required to repair 15 points of item condition. More tools can be purchased in towns or can be salvaged from equipment while camping ";
			desc = desc + ("  You can carry " + this.World.Assets.getMaxArmorParts() + " units at most.");
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Tools and Supplies"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];
			return ret;

		case "repairs.Required":
			local tent = this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Repair);
			local desc = "Number of tools required to repair the selected equipment. One point is required to repair " + tent.getConversionRate() + " points of item condition.";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Required Supplies"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];
			return ret;

		case "repairs.Bros":
			local tent = this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Repair);
			local repair = tent.getModifiers();
			local desc = "Number of people assigned to repair duty. The more assigned, the quicker equipment can be repaired.";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Assigned Brothers"
				},
				{
					id = 2,
					type = "description",
					text = desc
				},
				{
					id = 3,
					type = "text",
					icon = "ui/icons/repair_item.png",
					text = "Total repair modifier is [color=" + this.Const.UI.Color.PositiveValue + "]" + repair.Craft + " units per hour[/color]"
				}
			];
			local id = 4;

			foreach( bro in repair.Modifiers )
			{
				ret.push({
					id = id,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + bro[0] + " units/hour [/color] " + bro[1] + " (" + bro[2] + ")"
				});
				id = ++id;
			}

			return ret;

		case "repairs.Time":
			local desc = "Total number of hours required to repair all the queued equipment. Assign more people to this task to decrease the amout of time required. Some backgrounds are quicker than others!";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Time Required"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];
			return ret;

		case "assets.Medicine":
			local heal = this.World.Assets.getHealingRequired();
			local desc = "Medical supplies consist of bandages, herbs, salves and the like, and are used to heal the more severe injuries sustained by your men in battle. One point of medical supplies is required each day for every injury to improve and ultimately heal. Lost hitpoints heal while encamped.\n\nRunning out of medical supplies will leave your men unable to recover from severe injuries.";

			if (heal.MedicineMin > 0)
			{
				desc = desc + ("\n\nHealing up all your men will take between [color=" + this.Const.UI.Color.PositiveValue + "]" + heal.DaysMin + "[/color] and [color=" + this.Const.UI.Color.PositiveValue + "]" + heal.DaysMax + "[/color] days and requires between ");

				if (heal.MedicineMin <= this.World.Assets.getMedicine())
				{
					desc = desc + ("[color=" + this.Const.UI.Color.PositiveValue + "]");
				}
				else
				{
					desc = desc + ("[color=" + this.Const.UI.Color.NegativeValue + "]");
				}

				desc = desc + (heal.MedicineMin + "[/color] and ");

				if (heal.MedicineMax <= this.World.Assets.getMedicine())
				{
					desc = desc + ("[color=" + this.Const.UI.Color.PositiveValue + "]");
				}
				else
				{
					desc = desc + ("[color=" + this.Const.UI.Color.NegativeValue + "]");
				}

				desc = desc + (heal.MedicineMax + "[/color] Medical Supplies.");
			}

			local meds = 0;
			local stash = this.World.Assets.getStash().getItems();

			foreach( item in stash )
			{
				if (item == null)
				{
					continue;
				}

				meds = meds + item.getMedicinePerDay();
			}

			if (meds > 0)
			{
				desc = desc + (" You need [color=" + this.Const.UI.Color.NegativeValue + "]" + meds + "[/color] units each day to maintain your supply of flesh and bones for summoning.");
			}

			desc = desc + ("\n\nYou can carry " + this.World.Assets.getMaxMedicine() + " units at most.");
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Medical Supplies"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];
			local id = 4;

			if (heal.Injuries.len() > 0)
			{
				ret.push({
					id = id,
					type = "hint",
					text = "Injuries:"
				});
				id = ++id;
			}

			foreach( bro in heal.Injuries )
			{
				ret.push({
					id = id,
					type = "hint",
					icon = "ui/icons/days_wounded.png",
					text = bro[2] + " [color=" + this.Const.UI.Color.NegativeValue + "]" + bro[0] + "[/color] to [color=" + this.Const.UI.Color.NegativeValue + "]" + bro[1] + "[/color] days"
				});
				id = ++id;
			}

			return ret;

		case "assets.Brothers":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Roster (I, C)"
				},
				{
					id = 2,
					type = "description",
					text = "Show the roster of the fighting force of your mercenary company."
				}
			];
			local data = this.World.Assets.getRosterDescription();
			local id = 4;
			ret.push({
				id = id,
				type = "text",
				text = "Terrain Movement Modifiers:"
			});
			id = ++id;

			foreach( bro in data.TerrainModifiers )
			{
				ret.push({
					id = id,
					type = "text",
					text = bro[0] + " [color=" + this.Const.UI.Color.PositiveValue + "]" + bro[1] + "%[/color]"
				});
				id = ++id;
			}

			ret.push({
				id = id,
				type = "hint",
				text = "Company:"
			});
			id = ++id;

			foreach( bro in data.Brothers )
			{
				ret.push({
					id = id,
					type = "hint",
					icon = bro.Mood,
					text = "L" + bro.Level + "  " + bro.Name + " (" + bro.Background + ")"
				});
				id = ++id;
			}

			return ret;

		case "assets.BusinessReputation":
			return [
				{
					id = 1,
					type = "title",
					text = "Renown: " + this.World.Assets.getBusinessReputationAsText() + " (" + this.World.Assets.getBusinessReputation() + ")"
				},
				{
					id = 2,
					type = "description",
					text = "Your renown is your repute as a professional mercenary company and reflects how reliable and competent people judge you to be. The higher your renown, the higher-paid and more difficult contracts people will entrust you with. Renown increases on successfully completing ambitions and contracts, and winning battles, and decreases on failing to do so."
				}
			];

		case "assets.MoralReputation":
			return [
				{
					id = 1,
					type = "title",
					text = "Reputation: " + this.World.Assets.getMoralReputationAsText()
				},
				{
					id = 2,
					type = "description",
					text = "Your reputation reflects how people in the world judge your mercenary company to conduct itself based on past actions. Do you show mercy to your enemies? Do you burn down farmsteads and massacre the peasantry? Based on your reputation, people may offer you different kinds of contracts, and both contracts and events may play out differently."
				}
			];

		case "assets.Ambition":
			if (this.World.Ambitions.hasActiveAmbition())
			{
				local ret = this.World.Ambitions.getActiveAmbition().getButtonTooltip();
				ret.push({
					id = 10,
					type = "hint",
					icon = "ui/icons/mouse_right_button.png",
					text = "Cancel Ambition"
				});
				return ret;
			}
			else
			{
				return [
					{
						id = 1,
						type = "title",
						text = "Ambition"
					},
					{
						id = 2,
						type = "description",
						text = "You have not announced any ambition for your company to pursue. You\'ll be asked to do so as the game progresses."
					}
				];
			}

		case "stash.FreeSlots":
			return [
				{
					id = 1,
					type = "title",
					text = "Capacity"
				},
				{
					id = 2,
					type = "description",
					text = "Shows the current and maximum load of the stash, your global inventory."
				}
			];

		case "stash.ActiveRoster":
			return [
				{
					id = 1,
					type = "title",
					text = "Men in formation"
				},
				{
					id = 2,
					type = "description",
					text = "Shows the current and maximium number of men placed in formation to fight in the next battle.\n\nDrag and drop your men to where you want them to be; the top row is the front facing the enemy, the second row is your middle row, and the bottom row is your back row. All characters will partake in battle. There are no reserves slots but you can toggle anyone into reserves using the button near their portrait."
				}
			];

		case "ground.Slots":
			return [
				{
					id = 1,
					type = "title",
					text = "Ground"
				},
				{
					id = 2,
					type = "description",
					text = "Shows the current items laying on the ground."
				}
			];

		case "character-stats.ActionPoints":
			return [
				{
					id = 1,
					type = "title",
					text = "Action Points"
				},
				{
					id = 2,
					type = "description",
					text = "Action Points (AP) are spent for every action, like moving or using a skill. Once all points are spent, the current character\'s turn ends automatically. AP are fully refreshed each turn."
				}
			];

		case "character-stats.Hitpoints":
			return [
				{
					id = 1,
					type = "title",
					text = "Hitpoints"
				},
				{
					id = 2,
					type = "description",
					text = "Hitpoints represent the damage a character can take before dying. Once these reach zero, the character is considered dead. The higher the maximum hitpoints, the less likely it is a character will suffer debilitating injuries when hit."
				}
			];

		case "character-stats.Morale":
			return [
				{
					id = 1,
					type = "title",
					text = "Morale"
				},
				{
					id = 2,
					type = "description",
					text = "Morale is one of five states and represents the mental condition of combatants and their effectiveness in battle. At the lowest state, fleeing, a character will be outside your control - although they may eventually rally again. Morale changes as the battle unfolds, with characters that have high resolve less likely to fall to low morale states. Many of your opponents are affected by morale as well.\n\nMorale checks trigger on these occasions:\n- Killing an enemy\n- Seeing an enemy be killed\n- Seeing an ally be killed\n- Seeing an ally flee\n- Being hit for 15 or more damage to hitpoints\n- Being engaged by more than one opponent\n- Using certain skills, like \'Rally\'"
				}
			];

		case "character-stats.Fatigue":
			return [
				{
					id = 1,
					type = "title",
					text = "Fatigue"
				},
				{
					id = 2,
					type = "description",
					text = "Fatigue is gained for every action, like moving or using skills, and when being hit in combat or dodging in melee. It is reduced at a fixed rate of 15 each turn or as much as necessary for a character to start every turn with 15 less than their maximum fatigue. If a character accumulates too much fatigue they may need to rest a turn (i.e. do nothing) before being able to use more specialized skills again."
				}
			];

		case "character-stats.MaximumFatigue":
			return [
				{
					id = 1,
					type = "title",
					text = "Maximum Fatigue"
				},
				{
					id = 2,
					type = "description",
					text = "Maximum Fatigue is the amount of fatigue a character can accumulate before being unable to take any more actions and having to recuperate. It is reduced by wearing heavy equipment, especially armor."
				}
			];

		case "character-stats.ArmorHead":
			return [
				{
					id = 1,
					type = "title",
					text = "Head Armor"
				},
				{
					id = 2,
					type = "description",
					text = "Head Armor protects, surprisingly, the head, which is harder to hit than the body, but more vulnerable to damage. The more head armor, the less damage will be applied to hitpoints on taking a hit to the head."
				}
			];

		case "character-stats.ArmorBody":
			return [
				{
					id = 1,
					type = "title",
					text = "Body Armor"
				},
				{
					id = 2,
					type = "description",
					text = " The more body armor, the less damage will be applied to hitpoints on taking a hit to the body."
				}
			];

		case "character-stats.MeleeSkill":
			return [
				{
					id = 1,
					type = "title",
					text = "Melee Skill"
				},
				{
					id = 2,
					type = "description",
					text = "Determines the base probability of hitting a target with a melee attack, such as with swords and spears. Can be increased as the character gains experience."
				}
			];

		case "character-stats.RangeSkill":
			return [
				{
					id = 1,
					type = "title",
					text = "Ranged Skill"
				},
				{
					id = 2,
					type = "description",
					text = "Determines the base probability of hitting a target with a ranged attack, such as with bows and crossbows. Can be increased as the character gains experience."
				}
			];

		case "character-stats.MeleeDefense":
			return [
				{
					id = 1,
					type = "title",
					text = "Melee Defense"
				},
				{
					id = 2,
					type = "description",
					text = "A higher melee defense reduces the probability of being hit with a melee attack, such as the thrust of a spear. It can be increased as the character gains experience and by equipping a good shield."
				}
			];

		case "character-stats.RangeDefense":
			return [
				{
					id = 1,
					type = "title",
					text = "Ranged Defense"
				},
				{
					id = 2,
					type = "description",
					text = "A higher ranged defense reduces the probability of being hit with a ranged attack, such as an arrow shot from afar. It can be increased as the character gains experience and by equipping a good shield."
				}
			];

		case "character-stats.SightDistance":
			return [
				{
					id = 1,
					type = "title",
					text = "Vision"
				},
				{
					id = 2,
					type = "description",
					text = "Vision, or view range, determines how far a character can see to uncover the fog of war, discover threats and hit with ranged attacks. Heavier helmets and night time can reduce vision."
				}
			];

		case "character-stats.RegularDamage":
			return [
				{
					id = 1,
					type = "title",
					text = "Damage"
				},
				{
					id = 2,
					type = "description",
					text = "The base damage the currently equipped weapon does. Will be applied in full against hitpoints if no armor is protecting the target. If the target is protected by armor, the damage is applied to armor instead based on the weapon\'s effectiveness against armor. The actual damage done is modified by the skill used and the target hit."
				}
			];

		case "character-stats.CrushingDamage":
			return [
				{
					id = 1,
					type = "title",
					text = "Effectiveness against Armor"
				},
				{
					id = 2,
					type = "description",
					text = "The base percentage of damage that will be applied when hitting a target protected by armor. Once the armor is destroyed, the weapon damage applies at 100% to hitpoints. The actual damage done is modified by the skill used and the target hit."
				}
			];

		case "character-stats.ChanceToHitHead":
			return [
				{
					id = 1,
					type = "title",
					text = "Chance to hit head"
				},
				{
					id = 2,
					type = "description",
					text = "The base percentage chance to hit a target\'s head for increased damage. The final chance can be modified by the skill used."
				}
			];

		case "character-stats.Initiative":
			return [
				{
					id = 1,
					type = "title",
					text = "Initiative"
				},
				{
					id = 2,
					type = "description",
					text = "The higher this value, the earlier the position in the turn order. Initiative is reduced by the current fatigue, as well as any penalty to maximum fatigue (such as from heavy armor). In general, someone in light armor will act before someone in heavy armor, and someone fresh will act before someone fatigued."
				}
			];

		case "character-stats.Bravery":
			return [
				{
					id = 1,
					type = "title",
					text = "Resolve"
				},
				{
					id = 2,
					type = "description",
					text = "Resolve represents the willpower and bravery of characters. The higher, the less likely that characters fall to lower morale states at negative events, and the more likely that characters gain confidence from positive events. Resolve also acts as defense against certain mental attacks that inflict panic, fear or mind control. See also: Morale."
				}
			];

		case "character-stats.Talent":
			return [
				{
					id = 1,
					type = "title",
					text = "Talent"
				},
				{
					id = 2,
					type = "description",
					text = "TODO"
				}
			];

		case "character-stats.Undefined":
			return [
				{
					id = 1,
					type = "title",
					text = "UNDEFINED"
				},
				{
					id = 2,
					type = "description",
					text = "TODO"
				}
			];

		case "character-backgrounds.generic":
			if (entity != null)
			{
				local tooltip = entity.getBackground().getGenericTooltip();
				return tooltip;
			}

			return null;

		case "character-levels.generic":
			return [
				{
					id = 1,
					type = "title",
					text = "Higher Level"
				},
				{
					id = 2,
					type = "description",
					text = "This character already has experience in combat and starts with a higher level."
				}
			];

		case "menu-screen.load-campaign.LoadButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Load Campaign"
				},
				{
					id = 2,
					type = "description",
					text = "Load the selected campaign."
				}
			];

		case "menu-screen.load-campaign.CancelButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Cancel"
				},
				{
					id = 2,
					type = "description",
					text = "Return to the main menu."
				}
			];

		case "menu-screen.load-campaign.DeleteButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Delete Campaign"
				},
				{
					id = 2,
					type = "description",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]WARNING:[/color] Deletes the selected campaign without any further warning."
				}
			];

		case "menu-screen.save-campaign.LoadButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Save Campaign"
				},
				{
					id = 2,
					type = "description",
					text = "Save campaign at the selected slot."
				}
			];

		case "menu-screen.save-campaign.CancelButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Cancel"
				},
				{
					id = 2,
					type = "description",
					text = "Return to the main menu."
				}
			];

		case "menu-screen.save-campaign.DeleteButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Delete Campaign"
				},
				{
					id = 2,
					type = "description",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]WARNING:[/color] Deletes the selected campaign without any further warning."
				}
			];

		case "menu-screen.new-campaign.CompanyName":
			return [
				{
					id = 1,
					type = "title",
					text = "Company Name"
				},
				{
					id = 2,
					type = "description",
					text = "The name your mercenary company will be known by throughout the lands."
				}
			];

		case "menu-screen.new-campaign.Seed":
			return [
				{
					id = 1,
					type = "title",
					text = "Map Seed"
				},
				{
					id = 2,
					type = "description",
					text = "A map seed is a unique string that determines how the world in your campaign will look like. You can see the seed of ongoing campaigns in the game menu accessible by pressing the Escape key, and then share it with friends to have them play in the same world."
				}
			];

		case "menu-screen.new-campaign.EasyDifficulty":
			return [
				{
					id = 1,
					type = "title",
					text = "Beginner Difficulty"
				},
				{
					id = 2,
					type = "description",
					text = "You\'ll face fewer and less challenging opponents, your men will gain bonus experience, and retreating from battle is easier.\n\nYour men get a small bonus to hit chance, and the enemy gets a small penalty, to ease you into the game.\n\nRecommended for players new to the game.\n\nEnemy scaling is same as normal, but 25% easier per bro."
				}
			];

		case "menu-screen.new-campaign.NormalDifficulty":
			return [
				{
					id = 1,
					type = "title",
					text = "Veteran Difficulty"
				},
				{
					id = 2,
					type = "description",
					text = "Provides for a balanced playing experience that can be quite challenging.\n\nRecommended for veterans of the game or the genre.\n\nDefault vanilla linear enemy scaling but extending up to 27 bros instead of 12."
				}
			];

		case "menu-screen.new-campaign.HardDifficulty":
			return [
				{
					id = 1,
					type = "title",
					text = "Expert Difficulty"
				},
				{
					id = 2,
					type = "description",
					text = "Your opponents will be more challenging and numerous.\n\nRecommended for experts in the game who want an even deadlier challenge.\n\nUses exponential enemy scaling. Easier early game, then about 1.5x as hard as normal for mid to late game."
				}
			];

		case "menu-screen.new-campaign.LegendaryDifficulty":
			return [
				{
					id = 1,
					type = "title",
					text = "Legendary Difficulty"
				},
				{
					id = 2,
					type = "description",
					text = "Your opponents will be brutal. This is where legends are forged.\n\n Every enemy gains a series of new perks. Zombies with poisonous bites, battleforged orcs, overwhelming barbarians, crippling goblins, underdog backstabber thugs, fearsome vampires, muscular stollwurms"
				}
			];

		case "menu-screen.new-campaign.EasyDifficultyEconomic":
			return [
				{
					id = 1,
					type = "title",
					text = "Beginner Difficulty"
				},
				{
					id = 2,
					type = "description",
					text = "Contracts will pay more, there will be more recruits available, and you\'ll be able to carry more resources at once. \n\n 100% heal and repair rate outside camp. prices are 5%% better when buying and selling, +10% from contract payments, recruits are twice as common. \n\nRecommended for players new to the game."
				}
			];

		case "menu-screen.new-campaign.NormalDifficultyEconomic":
			return [
				{
					id = 1,
					type = "title",
					text = "Veteran Difficulty"
				},
				{
					id = 2,
					type = "description",
					text = "Provides for a balanced playing experience that can be quite challenging. 66% heal and repair rate outside camp. +50% more recruits available. \n\nRecommended for veterans of the game or the genre."
				}
			];

		case "menu-screen.new-campaign.HardDifficultyEconomic":
			return [
				{
					id = 1,
					type = "title",
					text = "Expert Difficulty"
				},
				{
					id = 2,
					type = "description",
					text = "Contracts will pay less, and deserters will take their equipment with them.\n\n 33% heal and repair rate outside camp. -5% buy -5% sell -5% payments \n\n Recommended for experts in the game who want more of a challenge managing the company\'s funds and supplies."
				}
			];

		case "menu-screen.new-campaign.LegendaryDifficultyEconomic":
			return [
				{
					id = 1,
					type = "title",
					text = "Legendary Difficulty"
				},
				{
					id = 2,
					type = "description",
					text = "Contract pay will be pitiful.\n\n  10% heal and repair rate outside camp. -10% buy, -10% sell, -10% payments -50% less recruits avaialable. \n\nRecommended for those who want the most challenging experience."
				}
			];

		case "menu-screen.new-campaign.EasyDifficultyBudget":
			return [
				{
					id = 1,
					type = "title",
					text = "High Starting Funds"
				},
				{
					id = 2,
					type = "description",
					text = "You\'ll start with more crowns and resources.\n\n 750 gold. 15/30 ammo. 10/20 meds. 10/20 armor parts. 60 stash. Plus starting bonuses. \n\nRecommended for new players."
				}
			];

		case "menu-screen.new-campaign.NormalDifficultyBudget":
			return [
				{
					id = 1,
					type = "title",
					text = "Medium Starting Funds"
				},
				{
					id = 2,
					type = "description",
					text = "Recommended for a balanced experience. \n\n 500 gold. 250 max food. 10/20 ammo. 5/10 meds. 5/10 armor parts. 30 stash. Plus starting bonuses."
				}
			];

		case "menu-screen.new-campaign.HardDifficultyBudget":
			return [
				{
					id = 1,
					type = "title",
					text = "Low Starting Funds"
				},
				{
					id = 2,
					type = "description",
					text = "You\'ll start with fewer crowns and resources.\n\n 250 gold.  0/10 ammo. 0/5 meds. 0/5 armor parts. 15 stash. Plus starting bonuses.\n\nRecommended for expert players."
				}
			];

		case "menu-screen.new-campaign.LegendaryDifficultyBudget":
			return [
				{
					id = 1,
					type = "title",
					text = "No Starting Funds"
				},
				{
					id = 2,
					type = "description",
					text = "You\'ll start without crowns or resources.\n\n 0 gold.  0/0 ammo. 0/0 meds. 0/0 armor parts. 5 stash. Only starting bonuses.\n\n Recommended for insane players."
				}
			];

		case "menu-screen.new-campaign.StartingScenario":
			return [
				{
					id = 1,
					type = "title",
					text = "Starting Scenario"
				},
				{
					id = 2,
					type = "description",
					text = "Choose how your company starts out in the world. Depending on your choice, you\'ll start with different men, equipment, resources, and special rules."
				}
			];

		case "menu-screen.new-campaign.Ironman":
			return [
				{
					id = 1,
					type = "title",
					text = "Ironman"
				},
				{
					id = 2,
					type = "description",
					text = "Not recommended in Legends Beta. Ironman mode disables manual saving. Only a single save will exist for the company, and the game is automatically saved during the game and on exiting it. Losing the whole company means losing the save. Not recommended in while Legends is in Beta due to possible save corruptions.\n\nNote that on weaker computers autosaves may result in the game pausing for a few seconds. "
				}
			];

		case "menu-screen.new-campaign.Autosave":
			return [
				{
					id = 1,
					type = "title",
					text = "Autosave"
				},
				{
					id = 2,
					type = "description",
					text = "Only disable for the most masochistic playthroughs. No save will exist for the company, the game will not be automatically saved during the game or when exiting it. \n\n Harder than ironman, there can be no alt f4, the entire run must happen in one sitting. "
				}
			];

		case "menu-screen.new-campaign.Exploration":
			return [
				{
					id = 1,
					type = "title",
					text = "Unexplored Map"
				},
				{
					id = 2,
					type = "description",
					text = "An optional way to play the game where the map is entirely unexplored and not visible to you at the start of your campaign. You\'ll have to discover everything on your own, which makes your campaign more difficult, but potentially also more exciting.\n\nRecommended only for experienced players that know what they\'re doing."
				}
			];

		case "menu-screen.new-campaign.EvilRandom":
			return [
				{
					id = 1,
					type = "title",
					text = "Random Late Game Crisis"
				},
				{
					id = 2,
					type = "description",
					text = "All crises will be randomly chosen between the options below."
				}
			];

		case "menu-screen.new-campaign.EvilNone":
			return [
				{
					id = 1,
					type = "title",
					text = "No Crisis"
				},
				{
					id = 2,
					type = "description",
					text = "There will be no late game crisis, and you can keep on playing the sandbox experience forever. Note that with this option selected, a significant part of the game\'s content and late game challenge won\'t be accessible. Not recommended for the best experience."
				}
			];

		case "menu-screen.new-campaign.EvilPermanentDestruction":
			return [
				{
					id = 1,
					type = "title",
					text = "Permanent Destruction"
				},
				{
					id = 2,
					type = "description",
					text = "Cities, towns and castles can be permanently destroyed during a late game crisis, and having the world go down in flames is one of the many ways you can lose your campaign."
				}
			];

		case "menu-screen.new-campaign.EvilWar":
			return [
				{
					id = 1,
					type = "title",
					text = "War"
				},
				{
					id = 2,
					type = "description",
					text = "The first late game crisis will be a ruthless war for power between noble houses. If you survive for long enough, the following ones will be chosen at random."
				}
			];

		case "menu-screen.new-campaign.EvilGreenskins":
			return [
				{
					id = 1,
					type = "title",
					text = "Greenskin Invasion"
				},
				{
					id = 2,
					type = "description",
					text = "The first late game crisis will be an invasion of greenskin hordes threatening to sweep away the world of man. If you survive for long enough, the following ones will be chosen at random."
				}
			];

		case "menu-screen.new-campaign.EvilUndead":
			return [
				{
					id = 1,
					type = "title",
					text = "Undead Scourge"
				},
				{
					id = 2,
					type = "description",
					text = "The first late game crisis will be the ancient dead arising again to take back what was once theirs. If you survive for long enough, the following ones will be chosen at random."
				}
			];

		case "menu-screen.new-campaign.EvilCrusade":
			return [
				{
					id = 1,
					type = "title",
					text = "Holy War"
				},
				{
					id = 2,
					type = "description",
					text = "The first late game crisis will be a holy war between northern and southern cultures. If you survive for long enough, the following ones will be chosen at random."
				}
			];

		case "menu-screen.options.DepthOfField":
			return [
				{
					id = 1,
					type = "title",
					text = "Depth of Field"
				},
				{
					id = 2,
					type = "description",
					text = "Enabling the Depth of Field effect will render height levels below the camera in tactical combat slightly out of focus (i.e. blurry), giving more of a miniature vibe and making it easier to differentiate heights, but potentially at the expense of some detail."
				}
			];

		case "menu-screen.options.UIScale":
			return [
				{
					id = 1,
					type = "title",
					text = "UI Scale"
				},
				{
					id = 2,
					type = "description",
					text = "Change the scale of the user interface, i.e. menus and texts."
				}
			];

		case "menu-screen.options.SceneScale":
			return [
				{
					id = 1,
					type = "title",
					text = "Scene Scale"
				},
				{
					id = 2,
					type = "description",
					text = "Change the scale of the scene, i.e. everything that isn\'t the user interface, such as the characters shown on the battlefield."
				}
			];

		case "menu-screen.options.EdgeOfScreen":
			return [
				{
					id = 1,
					type = "title",
					text = "Edge of Screen"
				},
				{
					id = 2,
					type = "description",
					text = "Scroll the screen by moving the mouse cursor to the edge of the screen."
				}
			];

		case "menu-screen.options.DragWithMouse":
			return [
				{
					id = 1,
					type = "title",
					text = "Drag with Mouse"
				},
				{
					id = 2,
					type = "description",
					text = "Scroll the screen by pressing the left mouse button and dragging it (default)."
				}
			];

		case "menu-screen.options.HardwareMouse":
			return [
				{
					id = 1,
					type = "title",
					text = "Use Hardware Cursor"
				},
				{
					id = 2,
					type = "description",
					text = "Using the hardware cursor minimizes input lag when moving the mouse in the game. Disable this if you experience problems with the mouse cursor."
				}
			];

		case "menu-screen.options.HardwareSound":
			return [
				{
					id = 1,
					type = "title",
					text = "Use Hardware Sound"
				},
				{
					id = 2,
					type = "description",
					text = "Use hardware-accelerated sound playback for better performance. Disable this if you experience any issues related to sound."
				}
			];

		case "menu-screen.options.CameraFollow":
			return [
				{
					id = 1,
					type = "title",
					text = "Always Focus AI Movement"
				},
				{
					id = 2,
					type = "description",
					text = "Always have the camera centered on any AI movement visible to you."
				}
			];

		case "menu-screen.options.CameraAdjust":
			return [
				{
					id = 1,
					type = "title",
					text = "Auto-Adjust Height Levels"
				},
				{
					id = 2,
					type = "description",
					text = "Automatically adjust the camera\'s height level to see the currently active character in combat. Disabling this will prevent the camera from changing height levels when it isn\'t strictly necessary, but will also require manual adjustment of height levels when characters happen to be obstructed by terrain."
				}
			];

		case "menu-screen.options.StatsOverlays":
			return [
				{
					id = 1,
					type = "title",
					text = "Always Show Hitpoint Bars"
				},
				{
					id = 2,
					type = "description",
					text = "Always show bars for hitpoints and armor floating above characters in combat, as opposed to only when characters get hit."
				}
			];

		case "menu-screen.options.OrientationOverlays":
			return [
				{
					id = 1,
					type = "title",
					text = "Show Orientation Icons"
				},
				{
					id = 2,
					type = "description",
					text = "Show icons at the edges of your screen indicating the direction in which any characters currently outside the screen are on the map."
				}
			];

		case "menu-screen.options.MovementPlayer":
			return [
				{
					id = 1,
					type = "title",
					text = "Faster Player Movement"
				},
				{
					id = 2,
					type = "description",
					text = "Speed up the movement of any characters controlled by you in combat significantly. Does not affect movement-related skills."
				}
			];

		case "legend.aispeed":
			return [
				{
					id = 1,
					type = "title",
					text = "Faster Mod"
				},
				{
					id = 2,
					type = "description",
					text = "Increases the overal speed of all tactical engagemenets."
				}
			];

	case "legend.enemytooltip":
		return [
			{
				id = 1,
				type = "title",
				text = "Enhanced Enemy Tooltips"
			},
			{
				id = 2,
				type = "description",
				text = "Enemy tooltips in tactical battles will show more information, like perks and statuses"
			}
		];

		case "menu-screen.options.AutoLoot":
			return [
				{
					id = 1,
					type = "title",
					text = "Auto-Loot"
				},
				{
					id = 2,
					type = "description",
					text = "Always and automatically loot everything found after combat once you close the loot screen - as long as you have the space to carry it."
				}
			];

		case "menu-screen.options.RestoreEquipment":
			return [
				{
					id = 1,
					type = "title",
					text = "Reset Equipment After Battle"
				},
				{
					id = 2,
					type = "description",
					text = "Automatically place equipment back into the inventory slot it was in before battle, if possible. For example, if a character starts battle with a crossbow, but changes to a pike during battle, they\'ll automatically have the crossbow in hand again when the battle is concluded."
				}
			];

		case "menu-screen.options.AutoPauseAfterCity":
			return [
				{
					id = 1,
					type = "title",
					text = "Auto-Pause After Leaving City"
				},
				{
					id = 2,
					type = "description",
					text = "Automatically pause the game after leaving a city so that you don\'t waste any time - but at the expense of having to manually unpause each time."
				}
			];

		case "menu-screen.options.AlwaysHideTrees":
			return [
				{
					id = 1,
					type = "title",
					text = "Always Hide Trees"
				},
				{
					id = 2,
					type = "description",
					text = "Always render the top of trees and other large map objects semi-transparent, as opposed to only when they\'re actually occluding something."
				}
			];

		case "menu-screen.options.AutoEndTurns":
			return [
				{
					id = 1,
					type = "title",
					text = "Auto-End Turns"
				},
				{
					id = 2,
					type = "description",
					text = "Automatically end turns of characters controlled by you once you don\'t have any Action Points left to perform any action."
				}
			];

		case "tactical-screen.topbar.event-log-module.ExpandButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Expand/Retract Event Log"
				},
				{
					id = 2,
					type = "description",
					text = "Expands or retracts the Combat Event Log."
				}
			];

		case "tactical-screen.topbar.round-information-module.BrothersCounter":
			return [
				{
					id = 1,
					type = "title",
					text = "Allies"
				},
				{
					id = 2,
					type = "description",
					text = "The number of Battle Brothers controlled by you and allies controlled by the AI on the battlefield."
				}
			];

		case "tactical-screen.topbar.round-information-module.EnemiesCounter":
			return [
				{
					id = 1,
					type = "title",
					text = "Opponents"
				},
				{
					id = 2,
					type = "description",
					text = "The number of opponents currently on the battlefield."
				}
			];

		case "tactical-screen.topbar.round-information-module.RoundCounter":
			return [
				{
					id = 1,
					type = "title",
					text = "Round"
				},
				{
					id = 2,
					type = "description",
					text = "The number of rounds played since the battle began."
				}
			];

		case "tactical-screen.topbar.options-bar-module.CenterButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Center Camera (Shift)"
				},
				{
					id = 2,
					type = "description",
					text = "Center the camera on the currently acting character."
				}
			];

		case "tactical-screen.topbar.options-bar-module.ToggleHighlightBlockedTilesButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Show/Hide Highlights for Blocked Tiles (B)"
				},
				{
					id = 2,
					type = "description",
					text = "Toggle between showing and hiding red overlays that indicate tiles blocked with environmental objects (such as trees) that characters can not move onto."
				}
			];

		case "tactical-screen.topbar.options-bar-module.SwitchMapLevelUpButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Raise Camera Level (+)"
				},
				{
					id = 2,
					type = "description",
					text = "Raise camera level to see the more elevated parts of the map."
				}
			];

		case "tactical-screen.topbar.options-bar-module.SwitchMapLevelDownButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Lower Camera Level (-)"
				},
				{
					id = 2,
					type = "description",
					text = "Lower camera level and hide elevated parts of the map."
				}
			];

		case "tactical-screen.topbar.options-bar-module.ToggleStatsOverlaysButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Show/Hide Hitpoint Bars (Alt)"
				},
				{
					id = 2,
					type = "description",
					text = "Toggle between showing and hiding armor and hitpoint bars, as well as status effect icons, ontop every visible character."
				}
			];

		case "tactical-screen.topbar.options-bar-module.ToggleTreesButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Show/Hide Trees (T)"
				},
				{
					id = 2,
					type = "description",
					text = "Toggle between showing and hiding trees and other large objects on the map."
				}
			];

		case "tactical-screen.topbar.options-bar-module.FleeButton":
			local ret = [];

			if (this.Tactical.State.isEnemyRetreatDialogShown())
			{
				ret.extend([
					{
						id = 1,
						type = "title",
						text = "End combat"
					},
					{
						id = 2,
						type = "description",
						text = "The enemy is fleeing the battle. There is no point in running them down."
					}
				]);
			}
			else
			{
				ret.extend([
					{
						id = 1,
						type = "title",
						text = "Retreat from combat"
					},
					{
						id = 2,
						type = "description",
						text = "Retreat from combat and run for your lives. Better to fight another day than to die here pointlessly."
					}
				]);
			}

			if (!this.Tactical.State.isScenarioMode() && this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsFleeingProhibited)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You cannot retreat from this particular fight"
				});
			}

			return ret;

		case "tactical-screen.topbar.options-bar-module.QuitButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Open Menu (Esc)"
				},
				{
					id = 2,
					type = "description",
					text = "Open menu to adjust game options."
				}
			];

		case "tactical-screen.turn-sequence-bar-module.EndTurnButton":
			return [
				{
					id = 1,
					type = "title",
					text = "End Turn (Enter, F)"
				},
				{
					id = 2,
					type = "description",
					text = "End the active character\'s turn and have the next character in line act."
				}
			];

		case "tactical-screen.turn-sequence-bar-module.WaitTurnButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Wait Turn (Spacebar)"
				},
				{
					id = 2,
					type = "description",
					text = "Pause the active character\'s turn and move them to the end of the queue. Waiting this turn will also have you act later next round."
				}
			];

		case "tactical-screen.turn-sequence-bar-module.EndTurnAllButton":
			return [
				{
					id = 1,
					type = "title",
					text = "End Round (R)"
				},
				{
					id = 2,
					type = "description",
					text = "End the current round and have all your men skip their turn until the next round starts."
				}
			];

		case "tactical-screen.turn-sequence-bar-module.OpenInventoryButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Open Inventory (I, C)"
				},
				{
					id = 2,
					type = "description",
					text = "Open the character screen and inventory for the active Battle Brother."
				}
			];

		case "tactical-combat-result-screen.LeaveButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Leave"
				},
				{
					id = 2,
					type = "description",
					text = "Leave tactical combat and return to the world map."
				}
			];

		case "tactical-combat-result-screen.statistics-panel.LeveledUp":
			local result = [
				{
					id = 1,
					type = "title",
					text = "Leveled Up"
				},
				{
					id = 2,
					type = "description",
					text = "This character just leveled up! Find them in your roster, accessible on the worldmap, to raise their attributes and select a perk."
				}
			];
			return result;

		case "tactical-combat-result-screen.statistics-panel.DaysWounded":
			local result = [
				{
					id = 1,
					type = "title",
					text = "Light Wounds"
				},
				{
					id = 2,
					type = "description",
					text = "Light bruises, flesh wounds, loss of blood and similar that caused this character to lose hitpoints without impairing their abilities."
				}
			];

			if (entity != null)
			{
				if (entity.getDaysWounded() <= 1)
				{
					result.push({
						id = 1,
						type = "text",
						icon = "ui/icons/days_wounded.png",
						text = "Will heal by tomorrow"
					});
				}
				else
				{
					result.push({
						id = 1,
						type = "text",
						icon = "ui/icons/days_wounded.png",
						text = "Will heal in [color=" + this.Const.UI.Color.NegativeValue + "]" + entity.getDaysWounded() + "[/color] days"
					});
				}
			}

			return result;

		case "tactical-combat-result-screen.statistics-panel.KillsValue":
			return [
				{
					id = 1,
					type = "title",
					text = "Kills"
				},
				{
					id = 2,
					type = "description",
					text = "The number of kills this character had during the battle."
				}
			];

		case "tactical-combat-result-screen.statistics-panel.XPReceivedValue":
			return [
				{
					id = 1,
					type = "title",
					text = "Experience Gained"
				},
				{
					id = 2,
					type = "description",
					text = "The number of experience points gained during the battle from fighting and killing opponents. Gaining enough experience points will allow this mercenary to level up, increase attributes and gain new perks."
				}
			];

		case "tactical-combat-result-screen.statistics-panel.DamageDealtValue":
			local result = [
				{
					id = 1,
					type = "title",
					text = "Damage Dealt"
				},
				{
					id = 2,
					type = "description",
					text = "The damage dealt by this character during battle, against hitpoints and against armor."
				}
			];

			if (entity != null)
			{
				local combatStats = entity.getCombatStats();
				result.push({
					id = 1,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Dealt [color=" + this.Const.UI.Color.PositiveValue + "]" + combatStats.DamageDealtHitpoints + "[/color] damage to hitpoints"
				});
				result.push({
					id = 2,
					type = "text",
					icon = "ui/icons/shield_damage.png",
					text = "Dealt [color=" + this.Const.UI.Color.PositiveValue + "]" + combatStats.DamageDealtArmor + "[/color] damage to armor"
				});
			}

			return result;

		case "tactical-combat-result-screen.statistics-panel.DamageReceivedValue":
			local result = [
				{
					id = 1,
					type = "title",
					text = "Damage Received"
				},
				{
					id = 2,
					type = "description",
					text = "The damage received by this character, split into damage to hitpoints and damage to armor. The value is after any possible damage reduction."
				}
			];

			if (entity != null)
			{
				local combatStats = entity.getCombatStats();
				result.push({
					id = 1,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "Received [color=" + this.Const.UI.Color.NegativeValue + "]" + combatStats.DamageReceivedHitpoints + "[/color] hitpoint damage"
				});
				result.push({
					id = 2,
					type = "text",
					icon = "ui/icons/shield_damage.png",
					text = "Received [color=" + this.Const.UI.Color.NegativeValue + "]" + combatStats.DamageReceivedArmor + "[/color] armor damage"
				});
			}

			return result;

		case "tactical-combat-result-screen.loot-panel.LootAllItemsButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Loot all Items"
				},
				{
					id = 2,
					type = "description",
					text = "Loot all items found until the stash is full."
				}
			];

		case "character-screen.left-panel-header-module.ChangeNameAndTitle":
			return [
				{
					id = 1,
					type = "title",
					text = "Change Name & Title"
				},
				{
					id = 2,
					type = "description",
					text = "Click here to change the character\'s name and title."
				}
			];

		case "character-screen.left-panel-header-module.Experience":
			return [
				{
					id = 1,
					type = "title",
					text = "Experience"
				},
				{
					id = 2,
					type = "description",
					text = "Characters gain experience as they or their allies slay enemies in battles. If a character has accumulated sufficient experience, they\'ll level up and be able to increase attributes and pick a perk that grants a unique bonus.\n\nBeyond the 11th character level, main characters gain a perk every two levels, and supporting characters gain a perk every five levels."
				}
			];

		case "character-screen.left-panel-header-module.Level":
			return [
				{
					id = 1,
					type = "title",
					text = "Level"
				},
				{
					id = 2,
					type = "description",
					text = "The character\'s level measures experience in battle. Characters rise in levels as they gain experience and are able to increase their attributes and gain perks that make them better at the mercenary profession.\n\nBeyond the 11th character level, main characters gain a perk every two levels, and supporting characters gain a perk every five levels."
				}
			];

		case "character-screen.brothers-list.LevelUp":
			local result = [
				{
					id = 1,
					type = "title",
					text = "Leveled Up"
				},
				{
					id = 2,
					type = "description",
					text = "This character has leveled up. Increase their attributes and select a perk!"
				}
			];
			return result;

		case "character-screen.left-panel-header-module.Reserves":
			local text = "This character is currently in the fighting line. Click to toggle character into reserves status. (Hotkey 'S', 'A' and 'D' to cycle bros)";

			if (entity.isInReserves())
			{
				text = "This character is currently in reserves. Click to toggle character into the fighting line. While in reserves, character will eat and drink more supplies, and only participate in combat if company is under attack. (Hotkey 'S', 'A' and 'D' to cycle bros)";
			}

			return [
				{
					id = 1,
					type = "title",
					text = "Reserves/Fighting Status"
				},
				{
					id = 2,
					type = "description",
					text = text
				}
			];

		case "character-screen.left-panel-header-module.Dismiss":
			return [
				{
					id = 1,
					type = "title",
					text = "Dismiss"
				},
				{
					id = 2,
					type = "description",
					text = "Dismiss this character from your roster to save daily wage and make room for someone else. Indebted characters will be freed from slavery and leave your company."
				}
			];

		case "character-screen.right-panel-header-module.InventoryButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Stash/Ground"
				},
				{
					id = 2,
					type = "description",
					text = "Switch to viewing the global stash of your mercenary company, or the ground beneath the currently selected character while in combat."
				}
			];

		case "character-screen.right-panel-header-module.PerksButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Perks"
				},
				{
					id = 2,
					type = "description",
					text = "Switch to viewing the perks of the currently selected character.\n\nThe number in braces, if any, is the number of available perk points."
				}
			];

		case "character-screen.right-panel-header-module.FormationButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Formations"
				},
				{
					id = 2,
					type = "description",
					text = "Switch to viewing the formation configurations for your mercenary company."
				}
			];

		case "character-screen.right-panel-header-module.CloseButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Close (ESC)"
				},
				{
					id = 2,
					type = "description",
					text = "Close this screen."
				}
			];

		case "character-screen.right-panel-header-module.SortButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Sort Items"
				},
				{
					id = 2,
					type = "description",
					text = "Sort items by type."
				}
			];

		case "character-screen.right-panel-header-module.FilterAllButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Filter items by type"
				},
				{
					id = 2,
					type = "description",
					text = "Show all items."
				}
			];

		case "character-screen.right-panel-header-module.FilterWeaponsButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Filter items by type"
				},
				{
					id = 2,
					type = "description",
					text = "Show only weapons, offensive tools and accessories."
				}
			];

		case "character-screen.right-panel-header-module.FilterArmorButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Filter items by type"
				},
				{
					id = 2,
					type = "description",
					text = "Show only armor, helmets and shields."
				}
			];

		case "character-screen.right-panel-header-module.FilterMiscButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Filter items by type"
				},
				{
					id = 2,
					type = "description",
					text = "Show only supplies, food, treasure and miscellaneous."
				}
			];

		case "character-screen.right-panel-header-module.FilterUsableButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Filter items by type"
				},
				{
					id = 2,
					type = "description",
					text = "Show only items usable in inventory mode, like paint or armor upgrades."
				}
			];

		case "character-screen.right-panel-header-module.FilterMoodButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Show/hide Mood"
				},
				{
					id = 2,
					type = "description",
					text = "Toggle between showing and hiding the mood of your men."
				}
			];

		case "character-screen.right-panel-header-module.ChangeFormation":
			return [
				{
					id = 1,
					type = "title",
					text = "Change Formation"
				},
				{
					id = 2,
					type = "description",
					text = "Change company formation and equipment loadouts."
				}
			];

		case "character-screen.right-panel-header-module.ClearFormation":
			return [
				{
					id = 1,
					type = "title",
					text = "Clear Formation Loadout"
				},
				{
					id = 2,
					type = "description",
					text = "Remove all items and weapons from brothers and place in inventory."
				}
			];

		case "character-screen.right-panel-header-module.ChangeFormationName":
			return [
				{
					id = 1,
					type = "title",
					text = "Change Formation Name"
				},
				{
					id = 2,
					type = "description",
					text = "Give this formation a descriptive label for your reference."
				}
			];

		case "character-screen.battle-start-footer-module.StartBattleButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Start Battle"
				},
				{
					id = 2,
					type = "description",
					text = "Start the battle using the selected equipment."
				}
			];

		case "character-screen.levelup-popup-dialog.StatIncreasePoints":
			return [
				{
					id = 1,
					type = "title",
					text = "Attribute Points"
				},
				{
					id = 2,
					type = "description",
					text = "Spend these points to increase any 3 out of 8 attributes per levelup by a random amount. A single attribute can only be increased once per levelup.\n\nStars mean that a character is especially talented with a specific attribute, resulting in consistently better dice rolls."
				}
			];

		case "character-screen.dismiss-popup-dialog.Compensation":
			return [
				{
					id = 1,
					type = "title",
					text = "Compensation"
				},
				{
					id = 2,
					type = "description",
					text = "Paying a compensation, gratuity or pension for the time spent with the company will allow the dismissed to leave with dignity and something to start a new life with, and it will prevent others in the company from reacting with anger over the dismissal.\n\nIndebted characters are paid reparations instead for their time with the company. Other indebted will appreciate it if you pay these, but no one will react with anger if you don\'t."
				}
			];

		case "world-screen.topbar.TimePauseButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Pause (Spacebar)"
				},
				{
					id = 2,
					type = "description",
					text = "Pause the game."
				}
			];

		case "world-screen.topbar.TimeNormalButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Normal Speed (1)"
				},
				{
					id = 2,
					type = "description",
					text = "Set time to pass normally. (1x Speed)"
				}
			];

		case "world-screen.topbar.TimeFastButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Fast Speed (2)"
				},
				{
					id = 2,
					type = "description",
					text = "Set time to pass faster than normal. (2x Speed)"
				}
			];

		case "world-screen.topbar.TimeVeryfastButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Very Fast Speed (3)"
				},
				{
					id = 2,
					type = "description",
					text = "Set time to pass much faster than normal. (4x Speed)"
				}
			];
		
		case "world-screen.topbar.TimeLudicrousButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Ludicrous Speed (4)"
				},
				{
					id = 2,
					type = "description",
					text = "Set time to pass insanely quickly. (8x Speed)"
				}
			];

		case "world-screen.topbar.options-module.ActiveContractButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Active Contract"
				},
				{
					id = 2,
					type = "description",
					text = "Show details of your active contract."
				}
			];

		case "world-screen.topbar.options-module.RelationsButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Show Factions & Relations (R)"
				},
				{
					id = 2,
					type = "description",
					text = "See all factions known to you and your relation to them."
				}
			];

		case "world-screen.topbar.options-module.CenterButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Center Camera (Return, Shift)"
				},
				{
					id = 2,
					type = "description",
					text = "Move the camera to center and zoom in on your mercenary company."
				}
			];

		case "world-screen.topbar.options-module.CameraLockButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Toggle Lock Camera (X)"
				},
				{
					id = 2,
					type = "description",
					text = "Lock or unlock the camera to always be centered on your mercenary company."
				}
			];

		case "world-screen.topbar.options-module.TrackingButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Toggle Tracking Footprints (F)"
				},
				{
					id = 2,
					type = "description",
					text = "Show or hide the footprints left by other parties roaming the world so you can follow or avoid them more easily."
				}
			];

		case "world-screen.topbar.options-module.CampButton":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Camp (T)"
				},
				{
					id = 2,
					type = "description",
					text = "Make or break camp. While encamped, time will go faster and your mercenaries will heal and repair their equipment at a faster rate. You\'ll also be able to make use of any camp tents you have unlocked. However, you\'re also more vulnerable to being caught in a surprise attack."
				}
			];

			if (!this.World.State.isCampingAllowed())
			{
				ret.push({
					id = 9,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]Unable to camp while travelling with other parties[/color]"
				});
			}

			return ret;

		case "world-screen.topbar.options-module.PerksButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Retinue (P)"
				},
				{
					id = 2,
					type = "description",
					text = "See your retinue of non-combat followers that grant various advantages outside combat, and upgrade your cart for more inventory space."
				}
			];

		case "world-screen.topbar.options-module.ObituaryButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Obituary (O)"
				},
				{
					id = 2,
					type = "description",
					text = "See the obituary which lists those who have fallen in service to the company since you took command."
				}
			];

		case "world-screen.topbar.options-module.QuitButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Open Menu (Esc)"
				},
				{
					id = 2,
					type = "description",
					text = "Open menu to save or load your game, adjust game options or quit the campaign and return to the main menu."
				}
			];

		case "world-screen.active-contract-panel-module.ToggleVisibilityButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Cancel Contract"
				},
				{
					id = 2,
					type = "description",
					text = "Cancel the current contract."
				}
			];

		case "world-screen.obituary.ColumnName":
			return [
				{
					id = 1,
					type = "title",
					text = "Name"
				},
				{
					id = 2,
					type = "description",
					text = "The character\'s name."
				}
			];

		case "world-screen.obituary.ColumnTime":
			return [
				{
					id = 1,
					type = "title",
					text = "Days"
				},
				{
					id = 2,
					type = "description",
					text = "The number of days that the character served in the company until their demise."
				}
			];

		case "world-screen.obituary.ColumnBattles":
			return [
				{
					id = 1,
					type = "title",
					text = "Battles"
				},
				{
					id = 2,
					type = "description",
					text = "The number of battles that the character fought in until their demise."
				}
			];

		case "world-screen.obituary.ColumnKills":
			return [
				{
					id = 1,
					type = "title",
					text = "Kills"
				},
				{
					id = 2,
					type = "description",
					text = "The number of kills that the character scored in battle until their demise."
				}
			];

		case "world-screen.obituary.ColumnKilledBy":
			return [
				{
					id = 1,
					type = "title",
					text = "Demise"
				},
				{
					id = 2,
					type = "description",
					text = "How the character ultimately died."
				}
			];

		case "world-town-screen.main-dialog-module.LeaveButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Leave"
				},
				{
					id = 2,
					type = "description",
					text = "Leave and return to the world map."
				}
			];

		case "world-town-screen.main-dialog-module.Contract":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Contract available"
				},
				{
					id = 2,
					type = "description",
					text = "Someone is looking to hire mercenaries."
				}
			];
			return ret;

		case "world-town-screen.main-dialog-module.ContractNegotiated":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Contract available"
				},
				{
					id = 2,
					type = "description",
					text = "The terms of this contract have been negotiated. All that\'s left is for you to sign it."
				}
			];
			return ret;

		case "world-town-screen.main-dialog-module.ContractDisabled":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "You already have a contract!"
				},
				{
					id = 2,
					type = "description",
					text = "You can only have one contract active at a time. Contract offers will remain while you fulfill your current contract, as long as the problem doesn\'t go away in the meantime."
				}
			];
			return ret;

		case "world-town-screen.main-dialog-module.ContractLocked":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Contracts locked"
				},
				{
					id = 2,
					type = "description",
					text = "Only contracts by the noble house owning this fortification are available here, but they don\'t recognize you as worthy of their attention. Increase your renown and fulfill the ambition of noble houses to take notice of the company in order to unlock new contracts!"
				}
			];
			return ret;

		case "world-town-screen.main-dialog-module.Crowd":
			return [
				{
					id = 1,
					type = "title",
					text = "Hire"
				},
				{
					id = 2,
					type = "description",
					text = "Hire new mercenaries for your company. The quality and quantity of volunteers depends on the size and type of settlement, as well as your reputation here. Every few days, new people will arrive, and others will travel on."
				}
			];

		case "world-town-screen.main-dialog-module.Tavern":
			return [
				{
					id = 1,
					type = "title",
					text = "Tavern"
				},
				{
					id = 2,
					type = "description",
					text = "A large tavern filled with patrons from all over the lands, offering beverages, food and a lively atmosphere in which to share news and rumors."
				}
			];

		case "world-town-screen.main-dialog-module.Temple":
			return [
				{
					id = 1,
					type = "title",
					text = "Temple"
				},
				{
					id = 2,
					type = "description",
					text = "A refuge from the harsh world outside. You can seek healing here for your wounded and pray for salvation of your eternal soul."
				}
			];

		case "world-town-screen.main-dialog-module.VeteransHall":
			return [
				{
					id = 1,
					type = "title",
					text = "Training Hall"
				},
				{
					id = 2,
					type = "description",
					text = "A meeting point for those of the fighting profession. Have your mercenaries train with and learn from experienced fighters here, so you can mold them faster into hardened mercenaries."
				}
			];

		case "world-town-screen.main-dialog-module.Taxidermist":
			return [
				{
					id = 1,
					type = "title",
					text = "Taxidermist"
				},
				{
					id = 2,
					type = "description",
					text = "For the right price, a taxidermist can create useful items from all kinds of trophies you bring them."
				}
			];

		case "world-town-screen.main-dialog-module.Kennel":
			return [
				{
					id = 1,
					type = "title",
					text = "Kennel"
				},
				{
					id = 2,
					type = "description",
					text = "A kennel where strong and fast dogs are bred for war."
				}
			];

		case "world-town-screen.main-dialog-module.Barber":
			return [
				{
					id = 1,
					type = "title",
					text = "Barber"
				},
				{
					id = 2,
					type = "description",
					text = "Customize the appearance of your mercenaries at the barber. Have their hair cut and their beards trimmed or buy dubious potions to change their appearance."
				}
			];

		case "world-town-screen.main-dialog-module.Fletcher":
			return [
				{
					id = 1,
					type = "title",
					text = "Fletcher"
				},
				{
					id = 2,
					type = "description",
					text = "A fletcher offering all kinds of expertly crafted ranged weaponry."
				}
			];

		case "world-town-screen.main-dialog-module.Alchemist":
			return [
				{
					id = 1,
					type = "title",
					text = "Alchemist"
				},
				{
					id = 2,
					type = "description",
					text = "An alchemist offering exotic and quite dangerous contraptions for a tidy sum."
				}
			];

		case "world-town-screen.main-dialog-module.Arena":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Arena"
				},
				{
					id = 2,
					type = "description",
					text = "The arena offers an opportunity to earn gold and fame in fights that are to the death, and in front of crowds that cheer for the most gruesome manner in which lives are dispatched."
				}
			];

			if (this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().getBuilding("building.arena").isClosed())
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "No more matches take place here today. Come back tomorrow!"
				});
			}

			if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() != "contract.arena" && this.World.Contracts.getActiveContract().getType() != "contract.arena_tournament")
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You cannot fight in the arena while contracted to do other work"
				});
			}
			else if (this.World.Contracts.getActiveContract() == null && this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().hasSituation("situation.arena_tournament") && this.World.Assets.getStash().getNumberOfEmptySlots() < 5)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You need at least 5 empty inventory slots to fight in the ongoing tournament"
				});
			}
			else if (this.World.Contracts.getActiveContract() == null && this.World.Assets.getStash().getNumberOfEmptySlots() < 3)
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You need at least 3 empty inventory slots to fight in the arena"
				});
			}

			return ret;

		case "world-town-screen.main-dialog-module.Port":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Harbor"
				},
				{
					id = 2,
					type = "description",
					text = "A harbor that serves both foreign trading ships and local fishermen. You\'ll likely be able to book passage by sea to other parts of the continent here."
				}
			];

			if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() == "contract.escort_caravan")
			{
				ret.push({
					id = 3,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "You cannot use the harbor while contracted to escort a caravan"
				});
			}

			return ret;

		case "world-town-screen.main-dialog-module.Marketplace":
			return [
				{
					id = 1,
					type = "title",
					text = "Marketplace"
				},
				{
					id = 2,
					type = "description",
					text = "A lively market offering all sorts of goods common in the region. New wares will be on offer every few days, and when trading caravans reach this settlement."
				}
			];

		case "world-town-screen.main-dialog-module.Weaponsmith":
			return [
				{
					id = 1,
					type = "title",
					text = "Weaponsmith"
				},
				{
					id = 2,
					type = "description",
					text = "A weapon smith\'s workshop displaying all kinds of well crafted weapons. Damaged equipment can also be repaired here for a price."
				}
			];

		case "world-town-screen.main-dialog-module.Armorsmith":
			return [
				{
					id = 1,
					type = "title",
					text = "Armorer"
				},
				{
					id = 2,
					type = "description",
					text = "This armorer\'s workshop is the right place to look for well-made and durable protection. Damaged equipment can also be repaired here for a price."
				}
			];

		case "world-town-screen.hire-dialog-module.LeaveButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Leave"
				},
				{
					id = 2,
					type = "description",
					text = "Leave this screen and return to the previous one."
				}
			];

		case "world-town-screen.hire-dialog-module.HireButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Hire Recruit"
				},
				{
					id = 2,
					type = "description",
					text = "Hire the selected recruit and have them join your roster."
				}
			];

		case "world-town-screen.hire-dialog-module.TryoutButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Try Out Recruit"
				},
				{
					id = 2,
					type = "description",
					text = "Give the selected recruit a proper tryout to reveal their hidden character traits, if any."
				}
			];

		case "world-town-screen.hire-dialog-module.DismissButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Dismiss Recruit"
				},
				{
					id = 2,
					type = "description",
					text = "Selected recruit doesn\'t make the cut, give\'em the boot."
				}
			];

		case "world-town-screen.hire-dialog-module.UnknownTraits":
			return [
				{
					id = 1,
					type = "title",
					text = "Unknown Character Traits"
				},
				{
					id = 2,
					type = "description",
					text = "This character may have unknown traits. You can pay for a tryout to reveal these."
				}
			];

		case "world-town-screen.hire-dialog-module.UnknownPerks":
			return [
				{
					id = 1,
					type = "title",
					text = "Unknown Character Perks"
				},
				{
					id = 2,
					type = "description",
					text = "This character has unknown perks. You can pay for a tryout to reveal these."
				}
			];

		case "world-town-screen.hire-dialog-module.KnownPerks":
			return [
				{
					id = 1,
					type = "title",
					text = "Character Perks"
				},
				{
					id = 2,
					type = "description",
					text = entity.getBackground().getPerkTreeDescription()
				}
			];

		case "world-town-screen.taxidermist-dialog-module.CraftButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Craft"
				},
				{
					id = 2,
					type = "description",
					text = "Pay the indicated fee, and hand over the necessary components, to receive the crafted item in return."
				}
			];

		case "world-town-screen.travel-dialog-module.LeaveButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Leave"
				},
				{
					id = 2,
					type = "description",
					text = "Leave this screen and return to the previous one."
				}
			];

		case "world-town-screen.travel-dialog-module.TravelButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Travel"
				},
				{
					id = 2,
					type = "description",
					text = "Book passage for your company and fast travel to the selected destination."
				}
			];

		case "world-town-screen.shop-dialog-module.LeaveButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Leave Shop"
				},
				{
					id = 2,
					type = "description",
					text = "Leave this screen and return to the previous one."
				}
			];

		case "world-town-screen.training-dialog-module.Train1":
			return [
				{
					id = 1,
					type = "title",
					text = "Sparring Fight"
				},
				{
					id = 2,
					type = "description",
					text = "Have your mercenary participate in a sparring fight with experienced opponents and various fighting styles. The bruises collected and lessons learned will result in [color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] Experience Gain for the next battle."
				}
			];

		case "world-town-screen.training-dialog-module.Train2":
			return [
				{
					id = 1,
					type = "title",
					text = "Veteran\'s Lessons"
				},
				{
					id = 2,
					type = "description",
					text = "Have your mercenary learn valuable lessons and insights from a true veteran of the trade. The knowledge imparted will result in [color=" + this.Const.UI.Color.PositiveValue + "]+35%[/color] Experience Gain for the duration of three battles."
				}
			];

		case "world-town-screen.training-dialog-module.Train3":
			return [
				{
					id = 1,
					type = "title",
					text = "Rigorous Schooling"
				},
				{
					id = 2,
					type = "description",
					text = "Have your mercenary undergo a rigorous training regimen to shape them into a skilled fighter. The blood and sweat spent today will benefit your mercenary in the long run with [color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] Experience Gain for the duration of five battles."
				}
			];

		case "world-game-finish-screen.dialog-module.QuitButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Quit Game"
				},
				{
					id = 2,
					type = "description",
					text = "Quit this game and return to the main menu. Your progress here will not be saved."
				}
			];

		case "world-relations-screen.Relations":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Relations"
				},
				{
					id = 2,
					type = "description",
					text = "Your relations with a faction determine whether they\'ll fight or deal peacefully with you, their willingness to hire you for contracts, as well as the prices they give you and the number of recruits available to you at their settlements.\n\nRelations increase when working successfully for factions, and decrease on failing to do so, betraying or attacking them. Over time, relations slowly trend back towards neutral."
				}
			];
			local changes = this.World.FactionManager.getFaction(_entityId).getPlayerRelationChanges();

			foreach( change in changes )
			{
				if (change.Positive)
				{
					ret.push({
						id = 11,
						type = "hint",
						icon = "ui/tooltips/positive.png",
						text = "" + change.Text + ""
					});
				}
				else
				{
					ret.push({
						id = 11,
						type = "hint",
						icon = "ui/tooltips/negative.png",
						text = "" + change.Text + ""
					});
				}
			}

			return ret;

		case "world-campfire-screen.Cart":
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.Const.Strings.InventoryHeader[this.World.Retinue.getInventoryUpgrades()]
				},
				{
					id = 2,
					type = "description",
					text = "A mercenary company has to carry a lot of equipment and supplies. By using carts and wagons, you can expand your available inventory space and carry even more."
				}
			];

			if (this.World.Retinue.getInventoryUpgrades() < this.Const.Strings.InventoryUpgradeHeader.len())
			{
				ret.push({
					id = 1,
					type = "hint",
					icon = "ui/icons/mouse_left_button.png",
					text = this.Const.Strings.InventoryUpgradeHeader[this.World.Retinue.getInventoryUpgrades()] + " for [img]gfx/ui/tooltips/money.png[/img]" + this.Const.Strings.InventoryUpgradeCosts[this.World.Retinue.getInventoryUpgrades()]
				});
			}

			return ret;

		case "dlc_1":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Lindwurm"
				},
				{
					id = 2,
					type = "description",
					text = "The free Lindwurm DLC adds a challenging new beast, a new player banner, as well as a new famed armor, helmet and shield. "
				}
			];

			if (this.Const.DLC.Lindwurm == true)
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.PositiveValue + "]This DLC has been installed.[/color]";
			}
			else
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.NegativeValue + "]This DLC is missing. It\'s available for free on Steam and GOG! [/color] Parts of Legends will not work without this DLC";
			}

			ret.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "Open store page in browser"
			});
			return ret;

		case "dlc_2":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Beasts & Exploration"
				},
				{
					id = 2,
					type = "description",
					text = "The Beasts & Exploration DLC adds a variety of new beasts roaming the wilds, a new crafting system to create items from trophies, legendary locations with unique rewards to discover, many new contracts and events, a new system of armor attachments, new weapons, armor and usable items, and more. Legends will not work without this DLC"
				}
			];

			if (this.Const.DLC.Unhold == true)
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.PositiveValue + "]This DLC has been installed.[/color]";
			}
			else
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.NegativeValue + "]This DLC is missing. It\'s available for purchase on Steam and GOG! [/color] Legends will not work without this DLC";
			}

			ret.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "Open store page in browser"
			});
			return ret;

		case "mapconfig.width":
			return [
				{
					id = 1,
					type = "title",
					text = "Map Width"
				},
				{
					id = 2,
					type = "description",
					text = "Number of tiles in wide. Default is 140. The camera renderer is hardcoded for max of 140 (this can\'t be modded). Above that and zoom in won\'t render correctly for tiles above 140"
				}
			];

		case "mapconfig.height":
			return [
				{
					id = 1,
					type = "title",
					text = "Map Height"
				},
				{
					id = 2,
					type = "description",
					text = "Number of tiles in hieght. Defualt is 140. The camera renderer is hardcoded for max of 140 (this can\'t be modded). Above that and zoom in won\'t render correctly for tiles above 140"
				}
			];

		case "mapconfig.landmass":
			return [
				{
					id = 1,
					type = "title",
					text = "Land Mass Ratio"
				},
				{
					id = 2,
					type = "description",
					text = "Minimum land to water ratio for an acceptable map. Default is 40. Going either extremes on this slider can result in map never getting generated."
				}
			];

		case "mapconfig.water":
			return [
				{
					id = 1,
					type = "title",
					text = "Water"
				},
				{
					id = 2,
					type = "description",
					text = "Impacts how much of the map is water. Small value results in patchy water around corners of map. larger numbers can create a single large island given a low enough land mass ratio."
				}
			];

		case "mapconfig.snowline":
			return [
				{
					id = 1,
					type = "title",
					text = "Snowline"
				},
				{
					id = 2,
					type = "description",
					text = "Determines where the snowline is generated. Default is 90. This value is inverted. a value of 10 would mean the top 90% of the map is snow."
				}
			];

		case "mapconfig.mountains":
			return [
				{
					id = 1,
					type = "title",
					text = "Mountain Density"
				},
				{
					id = 2,
					type = "description",
					text = "Influences density of mountains. Default is 50. This is experimental. There can be tile overlay issues with going to extremes on this slider right now."
				}
			];

		case "mapconfig.forest":
			return [
				{
					id = 1,
					type = "title",
					text = "Forest Density"
				},
				{
					id = 2,
					type = "description",
					text = "Influences density of forests. Default is 50. This is experimental. There can be tile overlay issues with going to extremes on this slider right now."
				}
			];

		case "mapconfig.swamp":
			return [
				{
					id = 1,
					type = "title",
					text = "Swamp Density"
				},
				{
					id = 2,
					type = "description",
					text = "Influences density of swamps. Default is 50. This is experimental. There can be tile overlay issues with going to extremes on this slider right now."
				}
			];

		case "mapconfig.settlements":
			return [
				{
					id = 1,
					type = "title",
					text = "Number of Settlements"
				},
				{
					id = 2,
					type = "description",
					text = "Maximum number of settlements. Depending on map size, this will try to add the number of settlements on the slider. It will keep the same ratio of settlement types as default Battle Brothers maps. Minimum distance between settlements is 12 tiles."
				}
			];

		case "mapconfig.factions":
			return [
				{
					id = 1,
					type = "title",
					text = "Number of Factions"
				},
				{
					id = 2,
					type = "description",
					text = "Maximum number of Factions to try and generate. Depending on map size, this may not add all the factions on the slider."
				}
			];

		case "mapconfig.fow":
			return [
				{
					id = 1,
					type = "title",
					text = "Hide settlements you have not visited"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, all settlements will be hidden at campaign start, giving a small scale start. For the true role playing explorer experience!"
				}
			];

		case "mapconfig.stackcitadels":
			return [
				{
					id = 1,
					type = "title",
					text = "Gaurantee Citadels Have Everything"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, every Citadel will start with all those building attachments map scummers are re-rolling for."
				}
			];

		case "mapconfig.alltradelocations":
			return [
				{
					id = 1,
					type = "title",
					text = "Guarantee All Trade Locations"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, ensures there is at least one of each trade location building on the map."
				}
			];

		case "mapconfig.legendperktrees":
			return [
				{
					id = 1,
					type = "title",
					text = "Recruits have unique perk trees"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, all recruits for hire will have a unique perk tree including new Legends perks. \n\n Detail: Dynamic perk trees are half determined by background, and half randomly chosen from perk groups. Perk groups align around a theme, and you can see hints about the perks of potential recruits in their background description. Recruits will also have their stats and talents modifed to align with their new perks"
				}
			];

		case "mapconfig.legendgenderequality_off":
			return [
				{
					id = 1,
					type = "title",
					text = "No Battle Sisters"
				},
				{
					id = 2,
					type = "description",
					text = "The vanilla experience. No backgrounds or enemy encounters with females. (Yes, your friend the Hex is still here!)"
				}
			];

		case "mapconfig.legendgenderequality_low":
			return [
				{
					id = 1,
					type = "title",
					text = "Selected Battle Sisters"
				},
				{
					id = 2,
					type = "description",
					text = "Legend curated female backgrounds and enemies can be found and recruited throughout your adventure."
				}
			];

		case "mapconfig.legendgenderequality_high":
			return [
				{
					id = 1,
					type = "title",
					text = "Woman can do anything"
				},
				{
					id = 2,
					type = "description",
					text = "All commanders and most backgrounds will have a chance of being any gender"
				}
			];

		case "mapconfig.legendmagic":
			return [
				{
					id = 1,
					type = "title",
					text = "Runestones and Mysticism"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, magic is allowed in the world, this makes it possible to find rare wise women, rune stones, magic backgrounds and magic perks. \n\n Detail: If disabled, vala will not appear, runes stones will be 10x rarer. Seer, vala and warlock will lose their mystical perks"
				}
			];

		case "mapconfig.legendarmor":
			return [
				{
					id = 1,
					type = "title",
					text = "Armors are split into layers"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, armor is arranged in layers, hundreds of pieces combine into millions of visual combinations. \n\n Detail: Armor is made up of a base cloth layer, chain, plate, tabard, cloak, attachment and finally a rune layer.\n\nHelmet is made up of a base hood layer, helmet layer, top layer, vanity layer and finally a rune layer.\n\nEach layer can be upgraded individually, allowing flexible armor builds and aesthetics"
				}
			];

		case "mapconfig.legenddebug":
			return [
				{
					id = 1,
					type = "title",
					text = "Debug Map"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, the map will start completely revealed and all enemies and camps will be visible."
				}
			];

		case "mapconfig.legenditemscaling":
			return [
				{
					id = 1,
					type = "title",
					text = "Gear included in difficulty calculations"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, the value of your equipped items will increase the combat difficulty. \n\n Detail: 10,000 crowns worth of gear is equal to a new recruit. Only effects mainhand, offhand, body and head. \n\n This is in addition to other difficulty settings."
				}
			];

		case "mapconfig.legendlocationscaling":
			return [
				{
					id = 1,
					type = "title",
					text = "Remote areas are more dangerous"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, enemies will be stronger the further they spawn from civilization. \n\n Detail: Begins at 14 tiles from the nearest town, enemies spawned at 28 tiles will be twice as strong. \n\n This is in addition to other difficulty settings."
				}
			];

		case "mapconfig.legendcampunlock":
			return [
				{
					id = 1,
					type = "title",
					text = "Start with all camp activities enabled"
				},
				{
					id = 2,
					type = "description",
					text = "If disabled, you will gradually unlock camping activities by visiting towns. Useful for first playthroughs. \n\n Detail: skips the camp unlock events and ambition, you still need to buy upgrades. "
				}
			];

		case "mapconfig.legendrecruitscaling":
			return [
				{
					id = 1,
					type = "title",
					text = "Recruits improve with you"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, new recruits will gain levels based on the levels in your party and your renown in the world. \n\n  Details: The maximum level of recruits is increased by half the average level of mercs in your company, averaged with your reputation divided by 1,000. \n\n For example: if your company were all level 10, and your renown was 10,000, new recruits could gain up to 7 levels rounded down. \n\n This in addition to normal recruit level variance. "
				}
			];

		case "mapconfig.legendbleedkiller":
			return [
				{
					id = 1,
					type = "title",
					text = "Who dealt the bleed gets the kill"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, kills by bleeding out are granted to the actor who caused the bleed."
				}
			];

		case "mapconfig.legendallblueprints":
			return [
				{
					id = 1,
					type = "title",
					text = "Unlock all crafting recipes"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, all crafting recipes will be visible at the taxidermist and camp crafting. If disabled, vanilla behavior of having to discover the ingredients first will be enforced."
				}
			];

		case "mapconfig.legendrelationship":
			return [
				{
					id = 1,
					type = "title",
					text = "Mercenaries develop relationships"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, mercenaries will gradually form friendships based on morality and experiences. Affects combat, events and contracts. "
				}
			];

		case "mapconfig.legendworldeconomy":
			return [
				{
					id = 1,
					type = "title",
					text = "World Economy"
				},
				{
					id = 2,
					type = "description",
					text = "If enabled, Settlements will actively trade items and resources and can grow or decline in value \n\n  Details: The value of a settlement is now a dynamic value that grows and declines with caravan arrivals and departures, contracts fullfilled or failed, good or bad settlement events. \n\n The value of the settlement determines how valuable the caravans it creates are, as well as the strength of local militia. \n\n Very prosperous settlements will continue to grow and potentialy add new locations."
				}
			];

		case "mapconfig.legendtherian":
			return [
				{
					id = 1,
					type = "title",
					text = "Therianthropy"
				},
				{
					id = 2,
					type = "description",
					text = "An ancient infection plagues the lands of the north. Rumors abound of men turning into monsters and creatures of the dark. Beware the moon as it crosses its zenith."
				}
			];

		case "camp.commander":
		case "camp.rest":
		case "camp.repair":
		case "camp.barber":
		case "camp.crafting":
		case "camp.enchanter":
		case "camp.fletcher":
		case "camp.healer":
		case "camp.hunter":
		case "camp.repair":
		case "camp.rest":
		case "camp.scout":
		case "camp.training":
		case "camp.gatherer":
		case "camp.workshop":
		case "camp.painter": //PaintingTent
			return this.World.Camp.getBuildingByID(_elementId).getTooltip();

		case "camp-screen.repair.filterbro.button":
			return [
				{
					id = 1,
					type = "title",
					text = "Filter items by type"
				},
				{
					id = 2,
					type = "description",
					text = "Show only items that are currently equipped."
				}
			];

		case "camp-screen.repair.assignall.button":
			return [
				{
					id = 1,
					type = "title",
					text = "Assign All"
				},
				{
					id = 2,
					type = "description",
					text = "Add all equipment to the repair queue."
				}
			];

		case "camp-screen.repair.removeall.button":
			return [
				{
					id = 1,
					type = "title",
					text = "Remove all"
				},
				{
					id = 2,
					type = "description",
					text = "Remove all equipment from the repair queue."
				}
			];

		case "camp-screen.workshop.assignall.button":
			return [
				{
					id = 1,
					type = "title",
					text = "Remove all"
				},
				{
					id = 2,
					type = "description",
					text = "Add all equipment to the salvage queue."
				}
			];

		case "camp-screen.workshop.removeall.button":
			return [
				{
					id = 1,
					type = "title",
					text = "Remove all"
				},
				{
					id = 2,
					type = "description",
					text = "Remove all equipment from the salvage queue."
				}
			];

		case "workshop.Required":
			local tent = this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Workshop);
			local desc = "Number of tools that will be salvaged from selected equipment. " + tent.getConversionRate() + " points of item condition equals 1 tool. Once a tools condition reaches zero it will be destroyed.";
			local ret = [
				{
					id = 1,
					type = "title"
				},
				{
					id = 2,
					type = "description"
				}
			];
			return ret;

		case "workshop.Bros":
			local tent = this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Workshop);
			local repair = tent.getModifiers();
			local desc = "Number of people assigned to repair duty. The more assigned, the quicker equipment can be salvaged.";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Assigned Brothers"
				},
				{
					id = 2,
					type = "description",
					text = desc
				},
				{
					id = 3,
					type = "text",
					icon = "ui/icons/repair_item.png"
				}
			];
			local id = 4;

			foreach( bro in repair.Modifiers )
			{
				ret.push({
					id = id,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + bro[0] + " units/hour [/color] " + bro[1] + " (" + bro[2] + ")"
				});
				id = ++id;
			}

			return ret;

		case "workshop.Time":
			local desc = "Total number of hours required to salvage all the queued equipment. Assign more people to this task to decrease the amout of time required. Some backgrounds are quicker than others!";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Time Required"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];
			return ret;

		case "crafting.Bros":
			local tent = this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Crafting);
			local repair = tent.getModifiers();
			local desc = "Number of people assigned to crafting duty. The more assigned, the quicker items can be crafted.";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Assigned Brothers"
				},
				{
					id = 2,
					type = "description",
					text = desc
				},
				{
					id = 3,
					type = "text",
					icon = "ui/icons/repair_item.png"
				}
			];
			local id = 4;

			foreach( bro in repair.Modifiers )
			{
				ret.push({
					id = id,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + bro[0] + " units/hour [/color] " + bro[1] + " (" + bro[2] + ")"
				});
				id = ++id;
			}

			return ret;

		case "crafting.Time":
			local desc = "Total number of hours required to craft all the queued items. Assign more people to this task to decrease the amout of time required. Some backgrounds are quicker than others!";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Time Required"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];
			return ret;

		case "crafting.CraftForeverButton":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Continuously Craft"
				},
				{
					id = 2,
					type = "description",
					text = "Sets this item to be crafted repeatedly as long as there are enough ingredients."
				}
			]
			return ret;

		case "healer.Supplies":
			local desc = "Medicine on hand to heal injuries. Medicine can be purchased in towns or can foraged for while camping ";
			desc = desc + ("  You can carry " + this.World.Assets.getMaxMedicine() + " units at most.");
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Medicine"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];
			return ret;

		case "healer.Required":
			local tent = this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Healer);
			local desc = "Quantity of Medicine required to treat selected injuries.";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Required Medicine"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];
			return ret;

		case "healer.Bros":
			local tent = this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Healer);
			local repair = tent.getModifiers();
			local desc = "Number of people assigned to tent duty. The more assigned, the quicker injuries can be treated.";
			local ret = [
				{
					id = 1,
					type = "title"
				},
				{
					id = 2,
					type = "description",
					text = desc
				},
				{
					id = 3,
					type = "text",
					icon = "ui/icons/asset_medicine.png",
					text = "Total treatment modifier is [color=" + this.Const.UI.Color.PositiveValue + "]" + repair.Craft + " units per hour[/color]"
				}
			];
			return ret;

		case "healer.Time":
			local desc = "Total number of hours required to treat all the selected injuries. Assign more people to this task to decrease the amout of time required. Some backgrounds are better than others!";
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Time Required"
				},
				{
					id = 2,
					type = "description",
					text = desc
				}
			];
			return ret;

		case "camp-screen.main-dialog-module.CampButton":
			return [
				{
					id = 1,
					type = "title",
					text = "Camp"
				},
				{
					id = 2,
					type = "description",
					text = "Setup camp."
				}
			];

		case "dlc_4":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Warriors of the North"
				},
				{
					id = 2,
					type = "description",
					text = "The Warriors of the North DLC adds a new human faction of northern barbarians with their own fighting style and equipment, different starting scenarios for your company, new nordic and rus inspired equipment, as well as new contracts and events."
				}
			];

			if (this.Const.DLC.Wildmen == true)
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.PositiveValue + "]This DLC has been installed.[/color]";
			}
			else
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.NegativeValue + "]This DLC is missing. It\'s available for purchase on Steam and GOG![/color]";
			}

			ret.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "Open store page in browser"
			});
			return ret;

		case "dlc_6":
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Blazing Deserts"
				},
				{
					id = 2,
					type = "description",
					text = "The Blazing Deserts DLC adds a new desert region to the south inspired by medieval Arabic and Persian cultures, a new late game crisis involving a holy war, a retinue of non-combat followers with which to customize your company, alchemical contraptions and primitive firearms, new human and beastly opponents, new contracts and events, and more."
				}
			];

			if (this.Const.DLC.Desert == true)
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.PositiveValue + "]This DLC has been installed.[/color]";
			}
			else
			{
				ret[1].text += "\n\n[color=" + this.Const.UI.Color.NegativeValue + "]This DLC is missing. It\'s available for purchase on Steam and GOG![/color]";
			}

			ret.push({
				id = 1,
				type = "hint",
				icon = "ui/icons/mouse_left_button.png",
				text = "Open store page in browser"
			});
			return ret;
		}

		return null;
	}

};

