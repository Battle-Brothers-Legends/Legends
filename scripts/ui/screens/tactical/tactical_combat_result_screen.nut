this.tactical_combat_result_screen <- {
	m = {
		JSHandle = null,
		Visible = null,
		Animating = null,
		OnConnectedListener = null,
		OnDisconnectedListener = null,
		OnLeaveButtonPressedListener = null,
		OnQueryCombatInformationListener = null
	},
	function isVisible()
	{
		return this.m.Visible != null && this.m.Visible == true;
	}

	function isAnimating()
	{
		return this.m.Animating != null && this.m.Animating == true;
	}

	function setOnConnectedListener( _listener )
	{
		this.m.OnConnectedListener = _listener;
	}

	function setOnDisconnectedListener( _listener )
	{
		this.m.OnDisconnectedListener = _listener;
	}

	function setOnLeavePressedListener( _listener )
	{
		this.m.OnLeaveButtonPressedListener = _listener;
	}

	function setOnQueryCombatInformationListener( _listener )
	{
		this.m.OnQueryCombatInformationListener = _listener;
	}

	function clearEventListener()
	{
		this.m.OnConnectedListener = null;
		this.m.OnDisconnectedListener = null;
		this.m.OnLeaveButtonPressedListener = null;
		this.m.OnQueryCombatInformationListener = null;
	}

	function create()
	{
		this.m.Visible = false;
		this.m.Animating = false;
		this.m.JSHandle = this.UI.connect("TacticalCombatResultScreen", this);
	}

	function destroy()
	{
		this.clearEventListener();
		this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
	}

	function show()
	{
		if (this.m.JSHandle != null && !this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("show", this.queryData());
		}
	}

	function hide()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("hide", null);
		}
	}

	function loadCombatInformation()
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("loadCombatInformation", null);
		}
	}

	function loadItemLists()
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("loadItemLists", null);
		}
	}

	function loadStashList()
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("loadStashList", null);
		}
	}

	function loadFoundLootList()
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("loadFoundLootList", null);
		}
	}

	function onScreenConnected()
	{
		if (this.m.OnConnectedListener != null)
		{
			this.m.OnConnectedListener();
		}
	}

	function onScreenDisconnected()
	{
		if (this.m.OnDisconnectedListener != null)
		{
			this.m.OnDisconnectedListener();
		}
	}

	function onScreenShown()
	{
		this.m.Visible = true;
		this.m.Animating = false;
	}

	function onScreenHidden()
	{
		this.m.Visible = false;
		this.m.Animating = false;
	}

	function onScreenAnimating()
	{
		this.m.Animating = true;
	}

	function onLeaveButtonPressed()
	{
		if (this.m.OnLeaveButtonPressedListener != null)
		{
			this.m.OnLeaveButtonPressedListener();
		}
	}

	function onLootAllItemsButtonPressed()
	{
		if (this.Tactical.CombatResultLoot.isEmpty())
		{
			return this.Const.UI.convertErrorToUIData(this.Const.UI.Error.FoundLootListIsEmpty);
		}

		if (!this.Stash.hasEmptySlot())
		{
			return this.Const.UI.convertErrorToUIData(this.Const.UI.Error.NotEnoughStashSpace);
		}

		local foundLootItems = this.Tactical.CombatResultLoot.getItems();
		local stashItems = this.Stash.getItems();
		local lastStashIdx = 0;
		local soundPlayed = false;
		local freeSlotFound = false;
		local foundLootLen = foundLootItems.len();

		for( local i = 0; i < foundLootItems.len(); i = ++i )
		{
			if (foundLootItems[i] != null)
			{
				for( local j = lastStashIdx; j < stashItems.len(); j = ++j )
				{
					if (stashItems[j] == null)
					{
						freeSlotFound = true;
						stashItems[j] = foundLootItems[i];
						foundLootItems[i] = null;
						lastStashIdx = j + 1;
						stashItems[j].onAddedToStash(this.Stash.getID());

						if (!soundPlayed)
						{
							soundPlayed = true;
							stashItems[j].playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
						}

						break;
					}
				}
			}
		}

		this.Tactical.CombatResultLoot.shrink();

		if (freeSlotFound == false)
		{
			return this.Const.UI.convertErrorToUIData(this.Const.UI.Error.NotEnoughStashSpace);
		}
		else
		{
			return {
				stash = this.UIDataHelper.convertStashToUIData(true),
				foundLoot = this.UIDataHelper.convertCombatResultLootToUIData()
			};
		}
	}

	function queryData()
	{
		return {
			combatInformation = this.onQueryCombatInformation(),
			statistics = this.onQueryStatistics(),
			stash = this.onQueryItemList("tactical-combat-result-screen.stash"),
			foundLoot = this.onQueryItemList("tactical-combat-result-screen.found-loot")
		};
	}

	function onQueryCombatInformation()
	{
		if (this.m.OnQueryCombatInformationListener != null)
		{
			return this.m.OnQueryCombatInformationListener();
		}

		return null;
	}

	function onQueryStatistics()
	{
		return this.UIDataHelper.convertCombatResultRosterToUIData();
	}

	function onQueryItemList( _data )
	{
		switch(_data)
		{
		case "tactical-combat-result-screen.stash":
			return this.UIDataHelper.convertStashToUIData(true);

		case "tactical-combat-result-screen.found-loot":
			return this.UIDataHelper.convertCombatResultLootToUIData();
		}

		return null;
	}

	function onSwapItem( _data )
	{
		local sourceItemIdx = _data[0];
		local sourceItemOwner = _data[1];
		local targetItemIdx = _data[2];
		local targetItemOwner = _data[3];

		if (targetItemOwner == null)
		{
			this.logError("onSwapItem #1");
			return null;
		}

		switch(sourceItemOwner)
		{
		case "tactical-combat-result-screen.stash":
			local sourceItem = this.Stash.getItemAtIndex(sourceItemIdx);

			if (sourceItem == null)
			{
				this.logError("onSwapItem(stash) #2");
				return null;
			}

			if (targetItemIdx != null)
			{
				if (sourceItemOwner == targetItemOwner)
				{
					if (this.Stash.swap(sourceItemIdx, targetItemIdx))
					{
						sourceItem.item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
					}
					else
					{
						this.logError("onSwapItem(stash) #3");
						return null;
					}
				}
				else
				{
					local targetItem = this.Tactical.CombatResultLoot.insert(sourceItem.item, targetItemIdx);
					this.Stash.insert(targetItem, sourceItemIdx);
					sourceItem.item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
				}
			}
			else if (sourceItemOwner == targetItemOwner)
			{
				if (!this.Stash.isLastTakenSlot(sourceItemIdx))
				{
					local firstEmptySlotIdx = this.Stash.getFirstEmptySlot();

					if (firstEmptySlotIdx != null)
					{
						if (this.Stash.swap(sourceItemIdx, firstEmptySlotIdx))
						{
							sourceItem.item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
						}
						else
						{
							this.logError("onSwapItem(stash) #4");
							return null;
						}
					}
				}
			}
			else
			{
				local removedItem = this.Stash.removeByIndex(sourceItemIdx);

				if (removedItem != null)
				{
					this.Tactical.CombatResultLoot.add(removedItem);
					sourceItem.item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
				}
			}

			return {
				stash = this.UIDataHelper.convertStashToUIData(true),
				foundLoot = this.UIDataHelper.convertCombatResultLootToUIData()
			};

		case "tactical-combat-result-screen.found-loot":
			local sourceItem = this.Tactical.CombatResultLoot.getItemAtIndex(sourceItemIdx);

			if (sourceItem == null)
			{
				this.logError("onSwapItem(found loot) #2");
				return null;
			}

			if (targetItemIdx != null)
			{
				if (sourceItemOwner == targetItemOwner)
				{
					if (this.Tactical.CombatResultLoot.swap(sourceItemIdx, targetItemIdx))
					{
						sourceItem.item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
					}
					else
					{
						this.logError("onSwapItem(found loot) #3");
						return null;
					}
				}
				else
				{
					local targetItem = this.Stash.insert(sourceItem.item, targetItemIdx);

					if (targetItem != null)
					{
						this.Tactical.CombatResultLoot.insert(targetItem, sourceItemIdx);
					}
					else
					{
						this.Tactical.CombatResultLoot.removeByIndex(sourceItemIdx);
					}

					sourceItem.item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
				}
			}
			else if (sourceItemOwner != targetItemOwner)
			{
				if (this.Stash.hasEmptySlot())
				{
					local removedItem = this.Tactical.CombatResultLoot.removeByIndex(sourceItemIdx);

					if (removedItem != null)
					{
						this.Stash.add(removedItem);
						sourceItem.item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
					}
				}
				else
				{
					return this.Const.UI.convertErrorToUIData(this.Const.UI.Error.NotEnoughStashSpace);
				}
			}

			return {
				stash = this.UIDataHelper.convertStashToUIData(true),
				foundLoot = this.UIDataHelper.convertCombatResultLootToUIData()
			};
		}

		return null;
	}

	function onDestroyItem( _data )
	{
		local sourceItemIdx = _data[0];
		local sourceItemOwner = _data[1];

		switch(sourceItemOwner)
		{
		case "tactical-combat-result-screen.stash":
			local sourceItem = this.Stash.removeByIndex(sourceItemIdx);

			if (sourceItem != null)
			{
				return {
					stash = this.UIDataHelper.convertStashToUIData(true)
				};
			}

			break;

		case "tactical-combat-result-screen.found-loot":
			local sourceItem = this.Tactical.CombatResultLoot.removeByIndex(sourceItemIdx);

			if (sourceItem != null)
			{
				return {
					foundLoot = this.UIDataHelper.convertCombatResultLootToUIData()
				};
			}

			break;
		}

		return null;
	}

	function getStashChangeData()
	{
		local ret = {
			popup = false,
			deletedNum = 0
		};
		local capacity = this.Stash.getCapacity();
		local current = this.World.State.getPlayer().calculateStashModifier(false);

		if (capacity > current)
		{
			for (local i = current - 1 ; i < capacity - 1; i = ++i)
			{
				if (this.Stash.getItemAtIndex(i).item != null)
				{
					ret.deletedNum++;
				}
			}
			ret.popup = ret.deletedNum != 0; 
		}

		return ret;
	}

};

