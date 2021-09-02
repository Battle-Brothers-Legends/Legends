this.character_screen <- {
	m = {
		JSHandle = null,
		JSDataSourceHandle = null,
		InventoryMode = null,
		Visible = null,
		PopupDialogVisible = null,
		Animating = null,
		PerkTreesLoaded = null,
		InventoryFilter = this.Const.Items.ItemFilter.All,
		OnCloseButtonClickedListener = null,
		OnStartBattleButtonClickedListener = null
	},
	function isVisible()
	{
		return this.m.Visible != null && this.m.Visible == true;
	}

	function isAnimating()
	{
		return this.m.Animating != null && this.m.Animating == true || this.m.PopupDialogVisible != null && this.m.PopupDialogVisible == true;
	}

	function getInventoryMode()
	{
		return this.m.InventoryMode;
	}

	function setOnCloseButtonClickedListener( _listener )
	{
		this.m.OnCloseButtonClickedListener = _listener;
	}

	function setOnStartBattleButtonClickedListener( _listener )
	{
		this.m.OnStartBattleButtonClickedListener = _listener;
	}

	function clearEventListener()
	{
		this.m.OnCloseButtonClickedListener = null;
		this.m.OnStartBattleButtonClickedListener = null;
	}

	function create()
	{
		this.m.InventoryMode = this.Const.CharacterScreen.InventoryMode.Ground;
		this.m.Visible = false;
		this.m.PopupDialogVisible = false;
		this.m.Animating = false;
		this.m.PerkTreesLoaded = false;

		if (this.Tactical.isActive())
		{
			this.m.JSHandle = this.UI.connect("TacticalCharacterScreen", this);
		}
		else
		{
			this.m.JSHandle = this.UI.connect("WorldCharacterScreen", this);
		}

		this.m.JSDataSourceHandle = this.m.JSHandle.connectToModule("DataSource", this);
	}

	function destroy()
	{
		this.clearEventListener();
		this.m.JSDataSourceHandle = this.UI.disconnect(this.m.JSDataSourceHandle);
		this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
	}

	function show()
	{
		this.setRosterLimit(("State" in this.World) && this.World.State != null ? this.World.Assets.getBrothersMaxInCombat() : 12);

		if (this.m.JSHandle != null)
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("show", this.queryData());
		}
	}

	function hide()
	{
		if (this.m.JSHandle != null)
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("hide", null);
		}
	}

	function toggle()
	{
		if (!this.isAnimating())
		{
			if (this.isVisible())
			{
				this.hide();
			}
			else
			{
				this.show();
			}
		}
	}

	function switchToNextBrother()
	{
		this.Tooltip.hide();
		this.m.JSDataSourceHandle.asyncCall("switchToNextBrother", null);
	}

	function switchToPreviousBrother()
	{
		this.Tooltip.hide();
		this.m.JSDataSourceHandle.asyncCall("switchToPreviousBrother", null);
	}

	function toggleBrotherReserves()
	{
		this.Tooltip.hide();
		this.m.JSDataSourceHandle.asyncCall("toggleBrotherReserves", null);
	}

	function loadPerksTrees()
	{
		if (this.m.JSDataSourceHandle != null)
		{
			this.m.JSDataSourceHandle.asyncCall("loadPerkTrees", this.onQueryPerkTrees);
		}
	}

	function loadBrothersList()
	{
		if (this.m.JSDataSourceHandle != null)
		{
			this.m.JSDataSourceHandle.asyncCall("loadBrothersList", this.onQueryBrothersList());
		}
	}

	function loadStashList()
	{
		if (this.m.JSDataSourceHandle != null)
		{
			this.m.JSDataSourceHandle.asyncCall("loadStashList", this.onQueryStashList());
		}
	}

	function loadData()
	{
		if (this.m.JSDataSourceHandle != null)
		{
			this.m.JSDataSourceHandle.asyncCall("loadFromData", this.queryData());
		}
	}

	function setRosterLimit( _limit )
	{
		if (this.m.JSDataSourceHandle != null)
		{
			this.m.JSDataSourceHandle.asyncCall("setRosterLimit", _limit);
		}
	}

	function resetInventoryFilter()
	{
		this.m.InventoryFilter = this.Const.Items.ItemFilter.All;
	}

	function setStashMode()
	{
		this.m.InventoryMode = this.Const.CharacterScreen.InventoryMode.Stash;
		this.m.JSDataSourceHandle.asyncCall("setInventoryMode", "stash");
	}

	function setGroundMode()
	{
		this.m.InventoryMode = this.Const.CharacterScreen.InventoryMode.Ground;
		this.m.JSDataSourceHandle.asyncCall("setInventoryMode", "ground");
	}

	function setBattlePreparationMode()
	{
		this.m.InventoryMode = this.Const.CharacterScreen.InventoryMode.BattlePreparation;
		this.m.JSDataSourceHandle.asyncCall("setInventoryMode", "battle-preparation");
	}

	function isInStashMode()
	{
		return this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Stash;
	}

	function isInGroundMode()
	{
		return this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground;
	}

	function isInBattlePreparationMode()
	{
		return this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.BattlePreparation;
	}

	function onScreenConnected()
	{
	}

	function onScreenDisconnected()
	{
	}

	function onScreenShown()
	{
		this.m.Visible = true;
		this.m.Animating = false;
		this.m.PopupDialogVisible = false;
	}

	function onScreenHidden()
	{
		this.m.Visible = false;
		this.m.Animating = false;
		this.m.PopupDialogVisible = false;
	}

	function onScreenAnimating()
	{
		this.m.Animating = true;
	}

	function onCloseButtonClicked()
	{
		if (this.m.OnCloseButtonClickedListener != null)
		{
			this.m.OnCloseButtonClickedListener();
		}
	}

	function onStartBattleButtonClicked()
	{
		if (this.m.OnStartBattleButtonClickedListener != null)
		{
			this.m.OnStartBattleButtonClickedListener();
		}
	}

	function onPopupDialogIsVisible( _data )
	{
		this.m.PopupDialogVisible = _data[0];
	}

	function onSortButtonClicked()
	{
		if (this.Tactical.isActive())
		{
			this.getroottable().Stash.sort();
		}
		else
		{
			this.World.Assets.getStash().sort();
		}

		this.loadStashList();
	}

	function onFilterAll()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.All)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.All;
			this.loadStashList();
		}
	}

	function onFilterWeapons()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Weapons)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Weapons;
			this.loadStashList();
		}
	}

	function onFilterArmor()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Armor)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Armor;
			this.loadStashList();
		}
	}

	function onFilterMisc()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Misc)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Misc;
			this.loadStashList();
		}
	}

	function onFilterUsable()
	{
		if (this.m.InventoryFilter != this.Const.Items.ItemFilter.Usable)
		{
			this.m.InventoryFilter = this.Const.Items.ItemFilter.Usable;
			this.loadStashList();
		}
	}

	function onDismissCharacter( _data )
	{
		local bro = this.Tactical.getEntityByID(_data[0]);
		local payCompensation = _data[1];

		if (bro != null)
		{
			this.World.Statistics.getFlags().increment("BrosDismissed");

			if (bro.getSkills().hasSkillOfType(this.Const.SkillType.PermanentInjury) && (bro.getBackground().getID() != "background.slave" || this.World.Assets.getOrigin().getID() == "scenario.sato_escaped_slaves"))
			{
				this.World.Statistics.getFlags().increment("BrosWithPermanentInjuryDismissed");
			}

			if (payCompensation)
			{
				this.World.Assets.addMoney(-10 * this.Math.max(1, bro.getDaysWithCompany()));

				if (bro.getBackground().getID() == "background.slave")
				{
					local playerRoster = this.World.getPlayerRoster().getAll();

					foreach( other in playerRoster )
					{
						if (bro.getID() == other.getID())
						{
							continue;
						}

						if (other.getBackground().getID() == "background.slave")
						{
							other.improveMood(this.Const.MoodChange.SlaveCompensated, "Glad to see " + bro.getName() + " get reparations for his time");
						}
					}
				}
			}
			else if (bro.getBackground().getID() == "background.slave")
			{
			}
			else if (bro.getLevel() >= 11 && !this.World.Statistics.hasNews("dismiss_legend") && this.World.getPlayerRoster().getSize() > 1)
			{
				local news = this.World.Statistics.createNews();
				news.set("Name", bro.getName());
				this.World.Statistics.addNews("dismiss_legend", news);
			}
			else if (bro.getDaysWithCompany() >= 50 && !this.World.Statistics.hasNews("dismiss_veteran") && this.World.getPlayerRoster().getSize() > 1 && this.Math.rand(1, 100) <= 33)
			{
				local news = this.World.Statistics.createNews();
				news.set("Name", bro.getName());
				this.World.Statistics.addNews("dismiss_veteran", news);
			}
			else if (bro.getLevel() >= 3 && bro.getSkills().hasSkillOfType(this.Const.SkillType.PermanentInjury) && !this.World.Statistics.hasNews("dismiss_injured") && this.World.getPlayerRoster().getSize() > 1 && this.Math.rand(1, 100) <= 33)
			{
				local news = this.World.Statistics.createNews();
				news.set("Name", bro.getName());
				this.World.Statistics.addNews("dismiss_injured", news);
			}
			else if (bro.getDaysWithCompany() >= 7)
			{
				local playerRoster = this.World.getPlayerRoster().getAll();

				foreach( other in playerRoster )
				{
					if (bro.getID() == other.getID())
					{
						continue;
					}

					if (bro.getDaysWithCompany() >= 50)
					{
						other.worsenMood(this.Const.MoodChange.VeteranDismissed, "Dismissed " + bro.getName());
					}
					else
					{
						other.worsenMood(this.Const.MoodChange.BrotherDismissed, "Dismissed " + bro.getName());
					}
				}
			}
			bro.getItems().transferToStash(this.World.Assets.getStash());
			this.World.getPlayerRoster().remove(bro);
			if (this.World.State.getPlayer() != null)
			{
				this.World.State.getPlayer().calculateModifiers();
			}
			this.loadData();
			this.World.State.updateTopbarAssets();
		}
	}


	function onToggleReserveCharacter( _id )
	{
		local bro = this.Tactical.getEntityByID(_id);
		if (bro == null)
		{
			return this.UIDataHelper.convertEntityToUIData(bro, null);
		}
		bro.setInReserves(!bro.isInReserves());
		return this.UIDataHelper.convertEntityToUIData(bro, null);
	}

	function onDiceThrow()
	{
		this.Sound.play(this.Const.Sound.DiceThrow[this.Math.rand(0, this.Const.Sound.DiceThrow.len() - 1)], this.Const.Sound.Volume.Inventory);
	}

	function queryData()
	{
		local result = {
			brothers = this.onQueryBrothersList()
		};

		if (("Assets" in this.World) && this.World.Assets != null)
		{
			result.formationIndex <- this.World.Assets.getFormationIndex();
			result.formationName <- this.World.Assets.getFormationName();
			result.maxBrothers <- this.World.Assets.getBrothersMax();
		}

		if (this.m.InventoryMode != this.Const.CharacterScreen.InventoryMode.Ground)
		{
			result.stash <- this.onQueryStashList();
			result.stashSpaceUsed <- this.Stash.getNumberOfFilledSlots();
			result.stashSpaceMax <- this.Stash.getCapacity();
		}

		if (this.m.PerkTreesLoaded == false)
		{
			this.m.PerkTreesLoaded = true;
			result.perkTrees <- this.onQueryPerkTrees();
		}
		if ("stashSpaceUsed" in result)
		{
			this.logDebug("Generating stash list info :" + result.stashSpaceUsed + " : " + result.stashSpaceMax);
		}

		return result;
	}

	function onQueryBrothersList()
	{
		if (this.Tactical.isActive())
		{
			return this.tactical_onQueryBrothersList();
		}
		else
		{
			return this.strategic_onQueryBrothersList();
		}
	}

	function onQueryStashList()
	{
		return this.UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter);
	}

	function onQueryPerkTrees()
	{
		return this.UIDataHelper.convertPerksToUIData();
	}

	function onQueryPerkInformation( _data )
	{
		return this.general_onQueryPerkInformation(_data);
	}

	function onUnlockPerk( _data )
	{
		return this.general_onUnlockPerk(_data);
	}

	function onSwapInventoryItem( _data )
	{
		return this.general_onSwapInventoryItem(_data);
	}

	function onDestroyInventoryItem( _data )
	{
		if (this.Tactical.isActive())
		{
			if (this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground)
			{
				return this.tactical_onDestroyGroundItem(_data);
			}
			else
			{
				return this.general_onDestroyStashItem(_data);
			}
		}
		else
		{
			return this.general_onDestroyStashItem(_data);
		}
	}

	function onToggleInventoryItem( _data )
	{
		local result = {
			repair = false,
			salvage = false
		};

		local itemId = _data[0];
		local entityId = _data[1];

		if (this.Tactical.isActive())
		{
			return result;
		}

		local obj = null;
		local item = null;
		local index = 0;
		if (entityId != null)
		{
			obj = this.Tactical.getEntityByID(entityId).getItems().getItemByInstanceID(itemId);
			if (obj != null)
			{
				item = obj;
			}
		}
		else
		{
			obj = this.Stash.getItemByInstanceID(itemId);
			if (obj != null)
			{
				item = obj.item;
				index = obj.index;
			}
		}

		if (item == null)
		{
			return result;
		}

		if (item.isIndestructible() || entityId != null)
		{
			item.setToBeRepaired(!item.isToBeRepaired(), index);
			item.setToBeSalvaged(false, 0);
		}
		else if (!item.isToBeRepaired() && !item.isToBeSalvaged())
		{
			if (item.setToBeRepaired(true, index))
			{
				item.setToBeSalvaged(false, 0);
			}
			else if (item.canBeSalvaged())
			{
				item.setToBeSalvaged(true, index);
			}

		}
		else if (item.isToBeRepaired() && item.canBeSalvaged())
		{
			item.setToBeRepaired(false, 0);
			item.setToBeSalvaged(true, index);
		}
		else
		{
			item.setToBeRepaired(false, 0);
			item.setToBeSalvaged(false, 0);
		}

		return {
			repair = item.isToBeRepaired(),
			salvage = item.isToBeSalvaged()
		};
	}

	function onEquipInventoryItem( _data )
	{
		if (this.Tactical.isActive())
		{
			if (this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground)
			{
				return this.tactical_onEquipGroundItem(_data);
			}
			else
			{
				return this.general_onEquipStashItem(_data);
			}
		}
		else
		{
			return this.general_onEquipStashItem(_data);
		}
	}

	function onDropInventoryItemIntoBag( _data )
	{
		if (this.Tactical.isActive())
		{
			if (this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground)
			{
				return this.tactical_onDropGroundItemIntoBag(_data);
			}
			else
			{
				return this.general_onDropStashItemIntoBag(_data);
			}
		}
		else
		{
			return this.general_onDropStashItemIntoBag(_data);
		}
	}

	function onEquipBagItem( _data )
	{
		return this.general_onEquipBagItem(_data);
	}

	function onSwapBagItem( _data )
	{
		return this.general_onSwapBagItem(_data);
	}

	function onDropBagItemIntoInventory( _data )
	{
		if (this.Tactical.isActive())
		{
			if (this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground)
			{
				return this.tactical_onDropBagItemToGround(_data);
			}
			else
			{
				return this.general_onDropBagItemIntoStash(_data);
			}
		}
		else
		{
			return this.general_onDropBagItemIntoStash(_data);
		}
	}

	function onDropPaperdollItem( _data )
	{
		if (this.Tactical.isActive())
		{
			if (this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground)
			{
				return this.tactical_onDropItemToGround(_data);
			}
			else
			{
				return this.general_onDropItemIntoStash(_data);
			}
		}
		else
		{
			return this.general_onDropItemIntoStash(_data);
		}
	}

	function onDropPaperdollItemIntoBag( _data )
	{
		return this.general_onDropPaperdollItemIntoBag(_data);
	}

	function onUpdateNameAndTitle( _data )
	{
		return this.general_onUpdateNameAndTitle(_data);
	}

	function onCommitStatsIncreaseValues( _data )
	{
		return this.general_onCommitStatsIncreaseValues(_data);
	}

	function onUpdateRosterPosition( _data )
	{
		this.Tactical.getEntityByID(_data[0]).setPlaceInFormation(_data[1]);
	}

	function tactical_onQueryBrothersList()
	{
		local entities = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

		if (entities != null && entities.len() > 0)
		{
			local activeEntity = this.Tactical.TurnSequenceBar.getActiveEntity();
			local result = [];

			foreach( entity in entities )
			{
				if (entity.isSummoned())
				{
					continue;
				}
				result.push(this.UIDataHelper.convertEntityToUIData(entity, activeEntity));
			}

			return result;
		}

		return null;
	}

	function tactical_onDestroyGroundItem( _data )
	{
		local data = this.helper_queryGroundItemData(_data);

		if ("error" in data)
		{
			return data;
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.Equipped);
		data.sourceItem.pickup();

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), true, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, true, this.m.InventoryFilter);
		}
	}

	function tactical_onEquipGroundItem( _data )
	{
		local data = this.helper_queryGroundItemData(_data);

		if ("error" in data)
		{
			return data;
		}

		local targetItems = this.helper_queryEquipmentTargetItems(data.inventory, data.sourceItem);
		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem,
			targetItems.firstItem,
			targetItems.secondItem
		], false);

		if (allowed != null)
		{
			return allowed;
		}

		if (targetItems.firstItem != null)
		{
			if (!targetItems.firstItem.isInBag() && !data.inventory.unequip(targetItems.firstItem) || targetItems.firstItem.isInBag() && !data.inventory.removeFromBag(targetItems.firstItem))
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromTargetSlot);
			}

			if (targetItems.secondItem != null)
			{
				if (data.inventory.unequip(targetItems.secondItem) == false)
				{
					data.inventory.equip(targetItems.firstItem);
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromTargetSlot);
				}
			}
		}

		data.sourceItem.pickup();

		if (data.inventory.equip(data.sourceItem) == false)
		{
			data.sourceItem.drop(data.entity.getTile());

			if (targetItems != null && targetItems.firstItem != null)
			{
				data.inventory.equip(targetItems.firstItem);

				if (targetItems.secondItem != null)
				{
					data.inventory.equip(targetItems.secondItem);
				}
			}

			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToEquipGroundItem);
		}

		if (targetItems != null && targetItems.firstItem != null)
		{
			targetItems.firstItem.drop(data.entity.getTile());

			if (targetItems.secondItem != null)
			{
				targetItems.secondItem.drop(data.entity.getTile());
			}
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.Equipped);
		this.helper_payForAction(data.entity, [
			targetItems.firstItem,
			targetItems.secondItem,
			data.sourceItem
		]);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), true, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, true, this.m.InventoryFilter);
		}
	}

	function tactical_onDropGroundItemIntoBag( _data )
	{
		local data = this.helper_queryGroundItemData(_data);

		if ("error" in data)
		{
			return data;
		}

		local targetItem;

		if (data.targetItemIdx != null)
		{
			targetItem = data.inventory.getItemAtBagSlot(data.targetItemIdx);
		}

		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem,
			targetItem
		], true);

		if (allowed != null)
		{
			return allowed;
		}

		local targetItem;

		if (data.targetItemIdx != null)
		{
			if (targetItem != null)
			{
				if (data.inventory.removeFromBagSlot(data.targetItemIdx) == false)
				{
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutGroundItemIntoBag);
				}

				data.sourceItem.pickup();

				if (data.inventory.addToBag(data.sourceItem, data.targetItemIdx) == false)
				{
					data.sourceItem.drop(data.entity.getTile());
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutGroundItemIntoBag);
				}

				targetItem.drop(data.entity.getTile());
			}
			else
			{
				data.sourceItem.pickup();

				if (data.inventory.addToBag(data.sourceItem, data.targetItemIdx) == false)
				{
					data.sourceItem.drop(data.entity.getTile());
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutGroundItemIntoBag);
				}
			}
		}
		else if (data.inventory.hasEmptySlot(this.Const.ItemSlot.Bag) == true)
		{
			data.sourceItem.pickup();

			if (data.inventory.addToBag(data.sourceItem) == false)
			{
				data.sourceItem.drop(data.entity.getTile());
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutGroundItemIntoBag);
			}
		}
		else
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughBagSpace);
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
		this.helper_payForAction(data.entity, [
			data.sourceItem,
			targetItem
		]);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), true, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, true, this.m.InventoryFilter);
		}
	}

	function tactical_onDropBagItemToGround( _data )
	{
		local data = this.helper_queryBagItemDataToInventory(_data);

		if ("error" in data)
		{
			return data;
		}

		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem,
			data.targetItem
		], false);

		if (allowed != null)
		{
			return allowed;
		}

		local fatigueDifference = data.entity.getFatigueMax() - data.entity.getFatigue();
		data.sourceItem.drop(this.Tactical.TurnSequenceBar.getActiveEntity().getTile());

		if (data.targetItem != null)
		{
			data.targetItem.pickup();
			data.inventory.addToBag(data.targetItem, data.sourceItemIdx);
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.Equipped);

		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			data.entity.setFatigue(data.entity.getFatigueMax() - fatigueDifference);
		}

		this.helper_payForAction(data.entity, [
			data.sourceItem,
			data.targetItem
		]);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), true, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, true, this.m.InventoryFilter);
		}
	}

	function tactical_onDropItemToGround( _data )
	{
		local data = this.helper_queryEntityItemData(_data);

		if ("error" in data)
		{
			return data;
		}

		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem
		], false);

		if (allowed != null)
		{
			return allowed;
		}

		this.helper_dropItemToGround(data);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), true, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, true, this.m.InventoryFilter);
		}
	}

	function strategic_onQueryBrothersList()
	{
		local roster = this.World.Assets.getFormation();

		for( local i = 0; i != roster.len(); i = ++i )
		{
			if (roster[i] != null)
			{
				roster[i] = this.UIDataHelper.convertEntityToUIData(roster[i], null);
			}
		}

		return roster;
	}

	function general_onQueryPerkInformation( _data )
	{
		return this.UIDataHelper.convertPerkToUIData(_data[0], _data[1]);
	}

	function general_onUnlockPerk( _data )
	{
		local entity = this.Tactical.getEntityByID(_data[0]);
		if (entity == null || !entity.isPlayerControlled())
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindEntity);
		}

		if (!entity.unlockPerk(_data[1]))
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToUnlockPerk);
		}

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertEntityToUIData(entity, this.Tactical.TurnSequenceBar.getActiveEntity());
		}
		else
		{
			return this.UIDataHelper.convertEntityToUIData(entity, null);
		}
	}

	function general_onSwapInventoryItem( _data )
	{
		local data = this.helper_queryStashItemDataByIndex(_data[0], _data[1]);

		if ("error" in data)
		{
			return data;
		}

		if (data.stash.swap(data.sourceIndex, data.targetIndex))
		{
			data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
		}
		else
		{
			this.logError("general_onSwapInventoryItem(stash)");
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireStash);
		}

		return this.UIDataHelper.convertStashAndEntityToUIData(null, null, false, this.m.InventoryFilter);
	}

	function general_onDestroyStashItem( _data )
	{
		local data = this.helper_queryStashItemData(_data);

		if ("error" in data)
		{
			return data;
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.Equipped);
		data.stash.removeByIndex(data.sourceIndex);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), false, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, false, this.m.InventoryFilter);
		}
	}

	function general_onEquipStashItem( _data )
	{
		local data = this.helper_queryStashItemData(_data);

		if ("error" in data)
		{
			return data;
		}

		local targetItems = this.helper_queryEquipmentTargetItems(data.inventory, data.sourceItem);
		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem,
			targetItems.firstItem,
			targetItems.secondItem
		], false);

		if (allowed != null)
		{
			return allowed;
		}

		if (!this.Tactical.isActive() && data.sourceItem.isUsable())
		{
			if (data.sourceItem.onUse(data.inventory.getActor()))
			{
				data.stash.removeByIndex(data.sourceIndex);
				data.inventory.getActor().getSkills().update();
				return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, false, this.m.InventoryFilter);
			}
			else
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToEquipStashItem);
			}
		}

		if (!data.stash.isResizable() && data.stash.getNumberOfEmptySlots() < targetItems.slotsNeeded - 1)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughStashSpace);
		}

		if (targetItems.firstItem != null)
		{
			if (!targetItems.firstItem.isInBag() && !data.inventory.unequip(targetItems.firstItem) || targetItems.firstItem.isInBag() && !data.inventory.removeFromBag(targetItems.firstItem))
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromTargetSlot);
			}

			if (targetItems.secondItem != null)
			{
				if (data.inventory.unequip(targetItems.secondItem) == false)
				{
					data.inventory.equip(targetItems.firstItem);
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromTargetSlot);
				}
			}
		}

		if (data.stash.removeByIndex(data.sourceIndex) == null)
		{
			if (targetItems != null && targetItems.firstItem != null)
			{
				data.inventory.equip(targetItems.firstItem);

				if (targetItems.secondItem != null)
				{
					data.inventory.equip(targetItems.secondItem);
				}
			}
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
		}

		if (data.inventory.equip(data.sourceItem) == false)
		{
			data.stash.insert(data.sourceItem, data.sourceIndex);

			if (targetItems != null && targetItems.firstItem != null)
			{
				data.inventory.equip(targetItems.firstItem);

				if (targetItems.secondItem != null)
				{
					data.inventory.equip(targetItems.secondItem);
				}
			}
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToEquipBagItem);
		}

		if (targetItems != null && targetItems.firstItem != null)
		{
			local firstItemIdx = data.sourceIndex;

			if (data.swapItem == true)
			{
				data.stash.insert(targetItems.firstItem, data.sourceIndex);
			}
			else
			{
				firstItemIdx = data.stash.add(targetItems.firstItem);

				if (firstItemIdx == null)
				{
					data.inventory.unequip(data.sourceItem);
					data.stash.insert(data.sourceItem, data.sourceIndex);
					data.inventory.equip(targetItems.firstItem);

					if (targetItems.secondItem != null)
					{
						data.inventory.equip(targetItems.secondItem);
					}
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutItemIntoBag);
				}
			}

			local secondItemIdx = data.stash.add(targetItems.secondItem);

			if (targetItems.secondItem != null && secondItemIdx == null)
			{
				data.stash.removeByIndex(firstItemIdx);
				data.inventory.unequip(data.sourceItem);
				data.stash.insert(data.sourceItem, data.sourceIndex);
				data.inventory.equip(targetItems.firstItem);

				if (targetItems.secondItem != null)
				{
					data.inventory.equip(targetItems.secondItem);
				}
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutItemIntoBag);
			}
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.Equipped);
		this.helper_payForAction(data.entity, [
			data.sourceItem,
			targetItems.firstItem,
			targetItems.secondItem
		]);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), false, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, false, this.m.InventoryFilter);
		}
	}

	function general_onDropStashItemIntoBag( _data )
	{
		local data = this.helper_queryStashItemData(_data);

		if ("error" in data)
		{
			return data;
		}

		if (!this.Tactical.isActive() && data.sourceItem.isUsable() && data.targetItemIdx != null && data.inventory.getItemAtBagSlot(data.targetItemIdx) != null)
		{
			if (data.sourceItem.onUse(data.inventory.getActor(), data.inventory.getItemAtBagSlot(data.targetItemIdx)))
			{
				data.stash.removeByIndex(data.sourceIndex);
				data.inventory.getActor().getSkills().update();
				return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, false, this.m.InventoryFilter);
			}
			else
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToEquipStashItem);
			}
		}

		local targetItem;

		if (data.targetItemIdx != null)
		{
			targetItem = data.inventory.getItemAtBagSlot(data.targetItemIdx);
		}

		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem,
			targetItem
		], true);

		if (allowed != null)
		{
			return allowed;
		}

		if (data.targetItemIdx != null)
		{
			if (data.stash.removeByIndex(data.sourceIndex) == null)
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
			}

			if (targetItem != null)
			{
				if (data.inventory.removeFromBagSlot(data.targetItemIdx) == false)
				{
					data.stash.insert(data.sourceItem, data.sourceIndex);
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutStashItemIntoBag);
				}

				if (data.inventory.addToBag(data.sourceItem, data.targetItemIdx) == false)
				{
					data.inventory.addToBag(targetItem, data.targetItemIdx);
					data.stash.insert(data.sourceItem, data.sourceIndex);
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutStashItemIntoBag);
				}

				data.stash.insert(targetItem, data.sourceIndex);
			}
			else if (data.inventory.addToBag(data.sourceItem, data.targetItemIdx) == false)
			{
				data.stash.insert(data.sourceItem, data.sourceIndex);
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutStashItemIntoBag);
			}
		}
		else if (data.inventory.hasEmptySlot(this.Const.ItemSlot.Bag) == true)
		{
			if (data.stash.removeByIndex(data.sourceIndex) == null)
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
			}

			if (data.inventory.addToBag(data.sourceItem) == false)
			{
				data.stash.insert(data.sourceItem, data.sourceIndex);
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutStashItemIntoBag);
			}
		}
		else
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughBagSpace);
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
		this.helper_payForAction(data.entity, [
			data.sourceItem,
			targetItem
		]);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), false, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, false, this.m.InventoryFilter);
		}
	}

	function general_onEquipBagItem( _data )
	{
		local data = this.helper_queryEntityItemData(_data);

		if ("error" in data)
		{
			return data;
		}

		local targetItems = this.helper_queryEquipmentTargetItems(data.inventory, data.sourceItem);
		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem,
			targetItems.firstItem,
			targetItems.secondItem
		], false);

		if (allowed != null)
		{
			return allowed;
		}

		if (data.sourceItem.getSlotType() == this.Const.ItemSlot.Bag)
		{
			return false;
		}

		local fatigueDifference = data.entity.getFatigueMax() - data.entity.getFatigue();

		if (data.inventory.getNumberOfEmptySlots(this.Const.ItemSlot.Bag) < targetItems.slotsNeeded - 1)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughBagSpace);
		}

		if (targetItems.firstItem != null)
		{
			if (!targetItems.firstItem.isInBag() && !data.inventory.unequip(targetItems.firstItem) || targetItems.firstItem.isInBag() && !data.inventory.removeFromBag(targetItems.firstItem))
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromTargetSlot);
			}

			if (targetItems.secondItem != null)
			{
				if (data.inventory.unequip(targetItems.secondItem) == false)
				{
					data.inventory.equip(targetItems.firstItem);
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromTargetSlot);
				}
			}
		}


		if (data.targetItemIdx != null)
		{
			local sourceItemIdx = data.targetItemIdx;

			if (data.inventory.removeFromBagSlot(sourceItemIdx) == false)
			{
				if (targetItems != null && targetItems.firstItem != null)
				{
					data.inventory.equip(targetItems.firstItem);

					if (targetItems.secondItem != null)
					{
						data.inventory.equip(targetItems.secondItem);
					}
				}

				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromBag);
			}

			if (data.inventory.equip(data.sourceItem) == false)
			{
				data.inventory.addToBag(data.sourceItem, sourceItemIdx);

				if (targetItems != null && targetItems.firstItem != null)
				{
					data.inventory.equip(targetItems.firstItem);

					if (targetItems.secondItem != null)
					{
						data.inventory.equip(targetItems.secondItem);
					}
				}

				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToEquipBagItem);
			}

			if (targetItems != null && targetItems.firstItem != null)
			{
				if (data.inventory.addToBag(targetItems.firstItem, sourceItemIdx) == false)
				{
					data.inventory.unequip(data.sourceItem);
					data.inventory.addToBag(data.sourceItem);
					data.inventory.equip(targetItems.firstItem);

					if (targetItems.secondItem != null)
					{
						data.inventory.equip(targetItems.secondItem);
					}

					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutItemIntoBag);
				}

				if (targetItems.secondItem != null && data.inventory.addToBag(targetItems.secondItem) == false)
				{
					data.inventory.removeFromBag(targetItems.firstItem);
					data.inventory.unequip(data.sourceItem);
					data.inventory.addToBag(data.sourceItem);
					data.inventory.equip(targetItems.firstItem);

					if (targetItems.secondItem != null)
					{
						data.inventory.equip(targetItems.secondItem);
					}

					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutItemIntoBag);
				}
			}
		}
		else
		{
			if (data.inventory.removeFromBag(data.sourceItem) == false)
			{
				if (targetItems != null && targetItems.firstItem != null)
				{
					data.inventory.equip(targetItems.firstItem);

					if (targetItems.secondItem != null)
					{
						data.inventory.equip(targetItems.secondItem);
					}
				}

				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromBag);
			}

			if (data.inventory.equip(data.sourceItem) == false)
			{
				data.inventory.addToBag(data.sourceItem);

				if (targetItems != null && targetItems.firstItem != null)
				{
					data.inventory.equip(targetItems.firstItem);

					if (targetItems.secondItem != null)
					{
						data.inventory.equip(targetItems.secondItem);
					}
				}

				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToEquipBagItem);
			}

			if (targetItems != null && targetItems.firstItem != null)
			{
				if (data.inventory.addToBag(targetItems.firstItem) == false)
				{
					data.inventory.unequip(data.sourceItem);
					data.inventory.addToBag(data.sourceItem);
					data.inventory.equip(targetItems.firstItem);

					if (targetItems.secondItem != null)
					{
						data.inventory.equip(targetItems.secondItem);
					}

					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutItemIntoBag);
				}

				if (targetItems.secondItem != null && data.inventory.addToBag(targetItems.secondItem) == false)
				{
					data.inventory.removeFromBag(targetItems.firstItem);
					data.inventory.unequip(data.sourceItem);
					data.inventory.addToBag(data.sourceItem);
					data.inventory.equip(targetItems.firstItem);

					if (targetItems.secondItem != null)
					{
						data.inventory.equip(targetItems.secondItem);
					}

					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutItemIntoBag);
				}
			}
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.Equipped);

		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			data.entity.setFatigue(data.entity.getFatigueMax() - fatigueDifference);
		}

		this.helper_payForAction(data.entity, [
			data.sourceItem,
			targetItems.firstItem,
			targetItems.secondItem
		]);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), true, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, true, this.m.InventoryFilter);
		}
	}

	function general_onSwapBagItem( _data )
	{
		local data = this.helper_queryEntityBackpackItemData(_data);

		if ("error" in data)
		{
			return data;
		}

		if (data.inventory.removeFromBagSlot(data.sourceItemIdx) == false)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromBag);
		}

		if (data.targetItem != null)
		{
			if (data.inventory.removeFromBagSlot(data.targetItemIdx) == false)
			{
				data.inventory.addToBag(data.sourceItem, data.sourceItemIdx);
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromBag);
			}

			data.inventory.addToBag(data.sourceItem, data.targetItemIdx);
			data.inventory.addToBag(data.targetItem, data.sourceItemIdx);
		}
		else
		{
			data.inventory.addToBag(data.sourceItem, data.targetItemIdx);
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.Equipped);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), true, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, true, this.m.InventoryFilter);
		}
	}

	function general_onDropBagItemIntoStash( _data )
	{
		local data = this.helper_queryBagItemDataToInventory(_data);

		if ("error" in data)
		{
			return data;
		}

		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem
		], false);

		if (allowed != null)
		{
			return allowed;
		}

		if (data.inventory.removeFromBagSlot(data.sourceItemIdx) == false)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromBag);
		}

		local targetItem = data.stash.insert(data.sourceItem, data.targetItemIdx);

		if (targetItem != null)
		{
			data.inventory.addToBag(targetItem, data.sourceItemIdx);
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.Equipped);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), false, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, false, this.m.InventoryFilter);
		}
	}

	function general_onDropItemIntoStash( _data )
	{
		local data = this.helper_queryEntityItemData(_data, true);

		if ("error" in data)
		{
			return data;
		}

		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem
		], false);

		if (allowed != null)
		{
			return allowed;
		}

		local result = this.helper_dropItemIntoStash(data);

		if (result != null)
		{
			return result;
		}

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), false, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, false, this.m.InventoryFilter);
		}
	}

	function general_onDropPaperdollItemIntoBag( _data )
	{
		local data = this.helper_queryEntityItemData(_data, true);

		if ("error" in data)
		{
			return data;
		}

		local targetItem;

		if (data.targetItemIdx != null)
		{
			targetItem = data.inventory.getItemAtBagSlot(data.targetItemIdx);
		}

		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem,
			targetItem
		], true);

		if (allowed != null)
		{
			return allowed;
		}

		if (data.sourceItem.isInBag() == true)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.ItemAlreadyWithinBag);
		}

		local fatigueDifference = data.entity.getFatigueMax() - data.entity.getFatigue();

		if (data.targetItemIdx != null)
		{
			if (targetItem != null)
			{
				if (data.inventory.removeFromBagSlot(data.targetItemIdx) == false)
				{
					data.inventory.addToBag(targetItem, data.targetItemIdx);
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromBag);
				}

				data.inventory.unequip(data.sourceItem);

				if (data.inventory.equip(targetItem) == false)
				{
					data.inventory.unequip(targetItem);
					data.inventory.equip(data.sourceItem);
					data.inventory.addToBag(targetItem, data.targetItemIdx);
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToEquipBagItem);
				}

				data.inventory.addToBag(data.sourceItem, data.targetItemIdx);
			}
			else
			{
				data.inventory.unequip(data.sourceItem);
				data.inventory.addToBag(data.sourceItem, data.targetItemIdx);
			}
		}
		else if (data.inventory.hasEmptySlot(this.Const.ItemSlot.Bag) == true)
		{
			local result = this.helper_dropItemIntoBag(data, false);

			if (result != null)
			{
				return result.error;
			}
		}
		else
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughBagSpace);
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.Equipped);

		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			data.entity.setFatigue(data.entity.getFatigueMax() - fatigueDifference);
		}

		this.helper_payForAction(data.entity, [
			data.sourceItem,
			targetItem
		]);

		if (this.Tactical.isActive())
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), true, this.m.InventoryFilter);
		}
		else
		{
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, true, this.m.InventoryFilter);
		}
	}

	function general_onUpdateNameAndTitle( _data )
	{
		local entity = this.Tactical.getEntityByID(_data[0]);

		if (entity == null || !entity.isPlayerControlled())
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindEntity);
		}

		if (_data[1].len() >= 1)
		{
			entity.setName(_data[1]);
		}

		entity.setTitle(_data[2]);
		return this.UIDataHelper.convertEntityToUIData(entity, null);
	}

	function general_onCommitStatsIncreaseValues( _data )
	{
		local entity = this.Tactical.getEntityByID(_data[0]);

		if (entity == null || !entity.isPlayerControlled())
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindEntity);
		}

		local increaseValues = {
			hitpointsIncrease = _data[1][0],
			braveryIncrease = _data[1][1],
			maxFatigueIncrease = _data[1][2],
			initiativeIncrease = _data[1][3],
			meleeSkillIncrease = _data[1][4],
			rangeSkillIncrease = _data[1][5],
			meleeDefenseIncrease = _data[1][6],
			rangeDefenseIncrease = _data[1][7]
		};
		entity.setAttributeLevelUpValues(increaseValues);
		return this.UIDataHelper.convertEntityToUIData(entity, null);
	}

	function helper_queryEntityItemData( _data, _withStash = false )
	{
		local entity = this.Tactical.getEntityByID(_data[0]);

		if (entity == null || !entity.isPlayerControlled())
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindEntity);
		}

		local inventory = entity.getItems();

		if (inventory == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireInventory);
		}

		if (_withStash == true && this.Stash == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireStash);
		}

		local sourceItem = inventory.getItemByInstanceID(_data[1]);

		if (sourceItem == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindBagItem);
		}

		local stash = this.Stash;
		local targetItem;
		local targetItemIdx = _data.len() >= 3 && _data[2] != null ? _data[2] : null;

		if (this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground)
		{
			stash = entity.getTile() != null ? entity.getTile().Items : null;

			if (stash != null && targetItemIdx != null && targetItemIdx >= 0 && targetItemIdx < stash.len())
			{
				targetItem = stash[targetItemIdx];
			}
		}
		else
		{
			local item = stash.getItemAtIndex(targetItemIdx);

			if (item != null)
			{
				targetItem = item.item;
			}
		}

		return {
			entity = entity,
			stash = stash,
			inventory = inventory,
			sourceItem = sourceItem,
			targetItem = targetItem,
			targetItemIdx = targetItemIdx
		};
	}

	function helper_queryEntityBackpackItemData( _data )
	{
		local entity = this.Tactical.getEntityByID(_data[0]);

		if (entity == null || !entity.isPlayerControlled())
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindEntity);
		}

		local inventory = entity.getItems();

		if (inventory == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireInventory);
		}

		local sourceItemIdx = _data[1];
		local sourceItem = inventory.getItemAtBagSlot(sourceItemIdx);

		if (sourceItem == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindBagItem);
		}

		local targetItemIdx = _data[2];
		local targetItem = inventory.getItemAtBagSlot(targetItemIdx);
		return {
			entity = entity,
			inventory = inventory,
			sourceItem = sourceItem,
			sourceItemIdx = sourceItemIdx,
			targetItem = targetItem,
			targetItemIdx = targetItemIdx
		};
	}

	function helper_queryGroundItemData( _data )
	{
		local entity = this.Tactical.getEntityByID(_data[0]);

		if (entity == null || !entity.isPlayerControlled())
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindEntity);
		}

		local inventory = entity.getItems();

		if (inventory == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireInventory);
		}

		local items = entity.getTile() != null ? entity.getTile().Items : null;

		if (items == null || items.len() == 0)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireGroundItems);
		}

		local itemId = _data[1];
		local sourceItem;

		foreach( item in items )
		{
			if (item.getInstanceID() == itemId)
			{
				sourceItem = item;
				break;
			}
		}

		if (sourceItem == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindGroundItem);
		}

		local sourceItemIdx = _data.len() >= 3 && _data[2] != null ? _data[2] : null;
		local targetItemIdx = _data.len() >= 4 && _data[3] != null ? _data[3] : null;
		return {
			entity = entity,
			inventory = inventory,
			sourceItem = sourceItem,
			sourceItemIdx = sourceItemIdx,
			targetItemIdx = targetItemIdx
		};
	}

	function helper_queryStashItemData( _data )
	{
		local entity = this.Tactical.getEntityByID(_data[0]);

		if (entity == null || !entity.isPlayerControlled())
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindEntity);
		}

		local inventory = entity.getItems();

		if (inventory == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireInventory);
		}

		if (this.Stash == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireStash);
		}

		local stash = this.Stash;
		local sourceItem;
		local sourceItemIdx = _data.len() >= 3 && _data[2] != null ? _data[2] : null;
		local targetItemIdx = _data.len() >= 4 && _data[3] != null ? _data[3] : null;

		if (this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground)
		{
			stash = entity.getTile() != null ? entity.getTile().Items : null;

			if (stash != null && sourceItemIdx != null && sourceItemIdx >= 0 && sourceItemIdx < stash.len())
			{
				sourceItem = stash[sourceItemIdx];
			}
		}
		else
		{
			sourceItem = stash.getItemByInstanceID(_data[1]);

			if (sourceItem == null)
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindStashItem);
			}

			sourceItemIdx = sourceItem.index;
			sourceItem = sourceItem.item;
		}

		return {
			entity = entity,
			stash = stash,
			inventory = inventory,
			sourceItem = sourceItem,
			sourceIndex = sourceItemIdx,
			targetItemIdx = targetItemIdx,
			swapItem = sourceItemIdx != null
		};
	}

	function helper_queryBagItemDataToInventory( _data )
	{
		local entity = this.Tactical.getEntityByID(_data[0]);

		if (entity == null || !entity.isPlayerControlled())
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindEntity);
		}

		local inventory = entity.getItems();

		if (inventory == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireInventory);
		}

		local stash;
		local sourceItemIdx = _data.len() >= 3 && _data[2] != null ? _data[2] : null;
		local targetItemIdx = _data.len() >= 4 && _data[3] != null ? _data[3] : null;
		local sourceItem = inventory.getItemAtBagSlot(sourceItemIdx);
		local targetItem;

		if (this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground)
		{
			local ground = entity.getTile() != null ? entity.getTile().Items : null;

			if (ground != null && targetItemIdx != null && targetItemIdx >= 0 && targetItemIdx < ground.len())
			{
				targetItem = ground[targetItemIdx];
			}
		}
		else
		{
			if (this.Stash == null)
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireStash);
			}

			stash = this.Stash;
		}

		return {
			entity = entity,
			stash = stash,
			inventory = inventory,
			sourceItem = sourceItem,
			sourceItemIdx = sourceItemIdx,
			targetItem = targetItem,
			targetItemIdx = targetItemIdx,
			swapItem = sourceItemIdx != null
		};
	}

	function helper_queryStashItemDataByIndex( _sourceIndex, _targetIndex )
	{
		if (this.Stash == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireStash);
		}

		local sourceItem = this.Stash.getItemAtIndex(_sourceIndex);

		if (sourceItem == null)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToFindStashItem);
		}

		local targetItem;

		if (_targetIndex != null)
		{
			targetItem = this.Stash.getItemAtIndex(_targetIndex);
		}

		return {
			stash = this.Stash,
			sourceItem = sourceItem.item,
			sourceIndex = _sourceIndex,
			targetItem = targetItem,
			targetIndex = _targetIndex
		};
	}

	function helper_dropItemIntoBag( _data, _pay = true )
	{
		if (_data.inventory.unequip(_data.sourceItem) == false)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
		}

		if (_data.inventory.addToBag(_data.sourceItem) == false)
		{
			_data.inventory.equip(_data.sourceItem);
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutItemIntoBag);
		}

		_data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);

		if (_pay)
		{
			this.helper_payForAction(_data.entity, [
				_data.sourceItem
			]);
		}

		return null;
	}

	function helper_dropItemIntoStash( _data )
	{

		if (_data.targetItemIdx == null && _data.stash.hasEmptySlot() == false && !_data.stash.isResizable())
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughStashSpace);
		}

		local slotType = _data.sourceItem.getCurrentSlotType();

		if (slotType == this.Const.ItemSlot.None)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.ItemIsNotAssignedToAnySlot);
		}

		if (_data.sourceItem.getCurrentSlotType() == this.Const.ItemSlot.Bag)
		{
			if (_data.inventory.removeFromBag(_data.sourceItem) == false)
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromBag);
			}

			local result = _data.stash.add(_data.sourceItem);

			if (result == null)
			{
				_data.inventory.addToBag(_data.sourceItem);
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughStashSpace);
			}
		}
		else if (_data.targetItemIdx != null)
		{
			if (_data.targetItem != null)
			{
				if (_data.sourceItem.getSlotType() == this.Const.ItemSlot.Mainhand || _data.sourceItem.getSlotType() == this.Const.ItemSlot.Offhand)
				{
					if (_data.sourceItem.getSlotType() == this.Const.ItemSlot.Mainhand)
					{
						local sourceItemIsBlockingOffhand = _data.sourceItem.getBlockedSlotType() != null && _data.sourceItem.getBlockedSlotType() == this.Const.ItemSlot.Offhand;
						local targetItemIsBlockingOffhand = _data.targetItem.getBlockedSlotType() != null && _data.targetItem.getBlockedSlotType() == this.Const.ItemSlot.Offhand;

						if ((sourceItemIsBlockingOffhand == false && _data.inventory.getItemAtSlot(this.Const.ItemSlot.Offhand) != null) && _data.targetItem.getSlotType() == this.Const.ItemSlot.Mainhand && targetItemIsBlockingOffhand == true)
						{
							return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
						}

						if (_data.sourceItem.getSlotType() != _data.targetItem.getSlotType() && !(_data.sourceItem.getSlotType() == this.Const.ItemSlot.Mainhand && sourceItemIsBlockingOffhand && _data.targetItem.getSlotType() == this.Const.ItemSlot.Offhand))
						{
							return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
						}
					}
					else if (_data.targetItem.getSlotType() != this.Const.ItemSlot.Offhand)
					{
						return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
					}
				}
				else if (_data.sourceItem.getSlotType() != _data.targetItem.getSlotType())
				{
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
				}

				if (_data.inventory.unequip(_data.sourceItem) == false)
				{
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
				}

				local result = _data.stash.insert(_data.sourceItem, _data.targetItemIdx);

				if (result != null)
				{
					_data.inventory.equip(_data.targetItem);
				}
			}
			else
			{
				if (_data.inventory.unequip(_data.sourceItem) == false)
				{
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
				}

				_data.stash.insert(_data.sourceItem, _data.targetItemIdx);
			}
		}
		else
		{
			if (_data.inventory.unequip(_data.sourceItem) == false)
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
			}

			local result = _data.stash.add(_data.sourceItem);

			if (result == null)
			{
				_data.inventory.equip(_data.sourceItem);
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughStashSpace);
			}
		}

		_data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.PlacedInStash);
		this.helper_payForAction(_data.entity, [
			_data.sourceItem,
			_data.targetItem
		]);
		return null;
	}

	function helper_dropItemToGround( _data )
	{
		local fatigueDifference = _data.entity.getFatigueMax() - _data.entity.getFatigue();
		_data.sourceItem.drop(this.Tactical.TurnSequenceBar.getActiveEntity().getTile());
		_data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.PlacedOnGround);
		this.helper_payForAction(_data.entity, [
			_data.sourceItem
		]);
		_data.entity.setFatigue(_data.entity.getFatigueMax() - fatigueDifference);
	}

	function helper_isActionAllowed( _entity, _items, _putIntoBags )
	{
		if (this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground)
		{
			local activeEntity = this.Tactical.TurnSequenceBar.getActiveEntity();

			if (activeEntity != null && _entity != null && activeEntity.getID() != _entity.getID())
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.OnlyActiveEntityIsAllowedToChangeItems);
			}

			if (_entity.getItems().isActionAffordable(_items) == false)
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughActionPoints);
			}

			if (_items[0] != null && !_items[0].isChangeableInBattle(_entity))
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.ItemIsNotChangableInBattle);
			}
		}
		else if (_items[0] != null && !_items[0].isChangeableInBattle(_entity) && _putIntoBags == true)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.ItemIsNotChangableInBattle);
		}

		return null;
	}

	function helper_payForAction( _entity, _items )
	{
		if (this.m.InventoryMode == this.Const.CharacterScreen.InventoryMode.Ground)
		{
			if (_entity != null)
			{
				_entity.getItems().payForAction(_items);
			}
		}
	}

	function helper_queryEquipmentTargetItems( _inventory, _sourceItem )
	{
		local ret = {
			firstItem = null,
			secondItem = null,
			slotsNeeded = 0
		};
		local sourceSlotType = _sourceItem.getSlotType();

		if (sourceSlotType == this.Const.ItemSlot.Offhand && _inventory.hasBlockedSlot(this.Const.ItemSlot.Offhand) == true)
		{
			ret.firstItem = _inventory.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		}
		else if (sourceSlotType == this.Const.ItemSlot.Mainhand && _sourceItem.getBlockedSlotType() == this.Const.ItemSlot.Offhand)
		{
			ret.firstItem = _inventory.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			ret.secondItem = _inventory.getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (ret.firstItem == null)
			{
				ret.firstItem = ret.secondItem;
				ret.secondItem = null;
			}
		}
		else if (sourceSlotType == this.Const.ItemSlot.Bag)
		{
			if (_inventory.hasEmptySlot(this.Const.ItemSlot.Bag))
			{
				ret.firstItem = null;
			}
			else
			{
				ret.firstItem = _inventory.getItemAtBagSlot(0);
			}
		}
		else
		{
			ret.firstItem = _inventory.getItemAtSlot(sourceSlotType);
		}

		if (ret.firstItem != null)
		{
			++ret.slotsNeeded;
		}

		if (ret.secondItem != null)
		{
			++ret.slotsNeeded;
		}

		return ret;
	}

	function helper_convertErrorToUIData( _errorCode )
	{
		local errorString = "Undefined error.";

		switch(_errorCode)
		{
		case this.Const.CharacterScreen.ErrorCode.FailedToFindEntity:
			errorString = "Failed to find entity.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToAcquireInventory:
			errorString = "Failed to acquire inventory.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToAcquireStash:
			errorString = "Failed to acquire stash.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToAcquireGroundItems:
			errorString = "Failed to acquire ground items.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToFindGroundItem:
			errorString = "Failed to find ground item.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToFindBagItem:
			errorString = "Failed to find bag item.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToFindStashItem:
			errorString = "Failed to find stash item.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromBag:
			errorString = "Failed to remove item from bag.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromTargetSlot:
			errorString = "Failed to remove item from target slot.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot:
			errorString = "Failed to remove item from source slot.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToEquipBagItem:
			errorString = "Failed to equip bag item.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToEquipGroundItem:
			errorString = "Failed to equip ground item.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToEquipStashItem:
			errorString = "Failed to equip stash item.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToPutItemIntoBag:
			errorString = "Failed to put item into bag.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToPutGroundItemIntoBag:
			errorString = "Failed to put ground item into bag.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToPutStashItemIntoBag:
			errorString = "Failed to put stash item into bag.";
			break;

		case this.Const.CharacterScreen.ErrorCode.ItemAlreadyWithinBag:
			errorString = "Item already within bag.";
			break;

		case this.Const.CharacterScreen.ErrorCode.ItemIsNotChangableInBattle:
			errorString = "Item is not changable in battle.";
			break;

		case this.Const.CharacterScreen.ErrorCode.ItemIsNotAssignedToAnySlot:
			errorString = "Item is not assigned to any slot.";
			break;

		case this.Const.CharacterScreen.ErrorCode.NotEnoughActionPoints:
			errorString = "Not enough Action Points.";
			break;

		case this.Const.CharacterScreen.ErrorCode.NotEnoughBagSpace:
			errorString = "Not enough bag space.";
			break;

		case this.Const.CharacterScreen.ErrorCode.NotEnoughStashSpace:
			errorString = "Not enough stash space.";
			break;

		case this.Const.CharacterScreen.ErrorCode.OnlyActiveEntityIsAllowedToChangeItems:
			errorString = "Only the active entity is allowed to change items.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToUnlockPerk:
			errorString = "Failed to unlock perk.";
			break;
		}

		return {
			error = errorString,
			code = _errorCode
		};
	}

	function onFormationChanged( _data )
	{
		local index = _data[0];
		this.World.Assets.changeFormation(index);
		this.loadData();
	}

	function onFormationClear( _data )
	{
		this.World.Assets.clearFormation();
		this.loadData();
	}

	function removeUpgrade( _slot, _data)
	{
		local bro = this.Tactical.getEntityByID(_data[1]);
		local upgrade = bro.removeArmorUpgrade(_slot, _data[0]);
		if (upgrade != null && !upgrade.isDestroyedOnRemove())
		{
			this.World.Assets.getStash().add(upgrade);
			bro.getSkills().update();
			return this.UIDataHelper.convertStashAndEntityToUIData(bro, null, false, this.m.InventoryFilter);
		}
	}

	function onRemoveArmorUpgrade( _data )
	{
		return this.removeUpgrade(this.Const.ItemSlot.Body, _data);
	}

	function onRemoveHelmetUpgrade( _data )
	{
		return this.removeUpgrade(this.Const.ItemSlot.Head, _data);
	}

	function onUpdateFormationName( _data )
	{
		local name = _data[0];
		this.World.Assets.changeFormationName(name);
		return this.World.Assets.getFormationName();
	}

	function onAssignRider( _data )
	{
		local riderID = _data[0];
		local horseID = _data[1];

		local rider = this.Tactical.getEntityByID(_data[0]);
		local horse = this.Tactical.getEntityByID(_data[1]);

		if (rider == null && horse == null)
		{
			return this.onQueryBrothersList();
		}

		//assign a bro to a horse
		if (horse != null && rider != null)
		{
			horse.setRiderID(_data[0]);
			rider.setRiderID(_data[0]);
			return this.onQueryBrothersList();
		}

		//Removing bro from horse
		if (horse != null)
		{
			horse.setRiderID("");
		}

		//Removing horse from bro
		if (rider != null)
		{
			rider.setRiderID("");
		}

		return this.onQueryBrothersList()
	}

};

