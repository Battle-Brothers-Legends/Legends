
this.camp_trader_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		Title = "Trader",
		Description = "Ill gotten goods",
		Shop = null,
		InventoryFilter = this.Const.Items.ItemFilter.All
	},
	function setShop( _s )
	{
		this.m.Shop = _s;
	}

	function getShop()
	{
		return this.m.Shop;
	}
	function create()
	{
		this.m.ID = "ShopDialogModule";
		this.ui_module.create();
	}

	function getTent()
	{
		return this.World.Camp.getBuildingByID(this.Const.World.CampBuildings.Trader);
	}
	function loadStashList()
	{
		local result = {
			Stash = this.UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter)
		};
		this.m.JSHandle.asyncCall("loadFromData", result);
	}
	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
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
	function onShow()
	{
		this.getTent().onInit();
		return this.queryLoad();
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

	function queryShopInformation()
	{
		local result = {
			Title = this.m.Shop.getName(),
			SubTitle = this.m.Shop.getDescription(),
			Assets = this.m.Parent.queryAssetsInformation(),
			Shop = [],
			Stash = [],
			StashSpaceUsed = this.Stash.getNumberOfFilledSlots(),
			StashSpaceMax = this.Stash.getCapacity(),
			IsRepairOffered = this.m.Shop.isRepairOffered()
		};
		this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), result.Shop, this.Const.UI.ItemOwner.Shop);
		this.UIDataHelper.convertItemsToUIData(this.World.Assets.getStash().getItems(), result.Stash, this.Const.UI.ItemOwner.Stash, this.m.InventoryFilter);
		return result;
	}

	function onRepairItem( _itemIndex )
	{
		if (!this.m.Shop.isRepairOffered())
		{
			return null;
		}

		local item = this.Stash.getItemAtIndex(_itemIndex).item;

		if (item.getConditionMax() <= 1 || item.getRepair() >= item.getRepairMax())
		{
			return null;
		}

		local price = (item.getRepairMax() - item.getRepair()) * this.Const.World.Assets.CostToRepairPerPoint;
		local value = item.getRawValue() * (1.0 - item.getRepair() / item.getRepairMax()) * 0.2 * this.World.State.getCurrentTown().getPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()];
		price = this.Math.max(price, value);

		if (this.World.Assets.getMoney() < price)
		{
			return null;
		}

		this.World.Assets.addMoney(-price);
		item.setCondition(item.getRepairMax());
		item.setToBeRepaired(false, 0);
		this.Sound.play("sounds/ambience/buildings/blacksmith_hammering_0" + this.Math.rand(0, 6) + ".wav", 1.0);
		local result = {
			Item = this.UIDataHelper.convertItemToUIData(item, true, this.Const.UI.ItemOwner.Stash),
			Assets = this.m.Parent.queryAssetsInformation()
		};
		this.World.Statistics.getFlags().increment("ItemsRepaired");
		return result;
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

		local shopStash = this.m.Shop.getStash();
		local currentMoney = this.World.Assets.getMoney();

		switch(sourceItemOwner)
		{
		case "world-town-screen-shop-dialog-module.stash":
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
					this.logError("onSwapItem(stash) #3.1");
					return null;
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
					this.World.Assets.addMoney(removedItem.getSellPrice());
					removedItem.addSettlementToTradeHistory(this.m.Shop.getSettlement());
					shopStash.add(removedItem);
					removedItem.setSold(true);
				}
			}

			local result = {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation(),
				Shop = [],
				Stash = [],
				StashSpaceUsed = this.Stash.getNumberOfFilledSlots(),
				StashSpaceMax = this.Stash.getCapacity(),
				IsRepairOffered = this.m.Shop.isRepairOffered()
			};
			this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), result.Shop, this.Const.UI.ItemOwner.Shop);
			result.Stash = this.UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter);

			return result;

		case "world-town-screen-shop-dialog-module.shop":
			local sourceItem = shopStash.getItemAtIndex(sourceItemIdx);

			if (sourceItem == null)
			{
				this.logError("onSwapItem(found loot) #2");
				return null;
			}

			if (currentMoney < sourceItem.item.getBuyPrice())
			{
				return {
					Result = this.Const.UI.Error.NotEnoughMoney
				};
			}

			if (targetItemIdx != null)
			{
				if (sourceItemOwner == targetItemOwner)
				{
					return null;
				}
				else
				{
					local targetItem = this.Stash.getItemAtIndex(targetItemIdx);

					if (targetItem != null && targetItem.item == null)
					{
						this.World.Assets.addMoney(-sourceItem.item.getBuyPrice());
						this.Stash.insert(sourceItem.item, targetItemIdx);
						shopStash.removeByIndex(sourceItemIdx);
						sourceItem.item.setBought(true);
					}
					else if (this.Stash.hasEmptySlot())
					{
						this.World.Assets.addMoney(-sourceItem.item.getBuyPrice());
						this.Stash.add(sourceItem.item);
						shopStash.removeByIndex(sourceItemIdx);
						sourceItem.item.setBought(true);
					}
					else
					{
						return {
							Result = this.Const.UI.Error.NotEnoughStashSpace
						};
					}
				}
			}
			else if (sourceItemOwner != targetItemOwner)
			{
				if (this.Stash.hasEmptySlot())
				{
					this.World.Assets.addMoney(-sourceItem.item.getBuyPrice());
					this.Stash.add(sourceItem.item);
					shopStash.removeByIndex(sourceItemIdx);
					sourceItem.item.setBought(true);
				}
				else
				{
					return {
						Result = this.Const.UI.Error.NotEnoughStashSpace
					};
				}
			}

			local result = {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation(),
				Shop = [],
				Stash = [],
				StashSpaceUsed = this.Stash.getNumberOfFilledSlots(),
				StashSpaceMax = this.Stash.getCapacity(),
				IsRepairOffered = this.m.Shop.isRepairOffered()
			};
			this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), result.Shop, this.Const.UI.ItemOwner.Shop);
			result.Stash = this.UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter);
			return result;
		}

		return null;
	}



	function onSwap ( _data )
	{
		this.getTent().onSwap( _data[0], _data[1] );
		this.loadQueueList();
	}

	function onRemove ( _idx)
	{
		local res = this.getTent().onRemove( _idx );
		local result = this.queryLoad()
		this.m.JSHandle.asyncCall("loadFromData", result);
	}


	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
	}


});
