this.unload_order <- this.inherit("scripts/ai/world/world_behavior", {
	m = {},
	function create()
	{
		this.world_behavior.create();
		this.m.ID = this.Const.World.AI.Behavior.ID.Unload;
	}

	function onExecute( _entity, _hasChanged )
	{
		foreach (settlement in this.World.getAllEntitiesAndOneLocationAtPos(_entity.getPos(), 1.0))
		{
			if (!settlement.isLocation() || !settlement.isLocationType(this.Const.World.LocationType.Settlement) || !settlement.isEnterable()) continue;

			local inv = _entity.getStashInventory().getItems();

			// yes world economy
			if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			{
				local origin = _entity.getOrigin();


				if (origin != null)
				{
					local investment = _entity.getFlags().getAsInt("CaravanInvestment");
					local profit = _entity.getFlags().getAsInt("CaravanProfit");
					
					// new functions
					origin.addWorldEconomyResources(investment + profit);

					local coords = settlement.getTile().Coords;
					local caravanHistoryData = ::Const.World.Common.WorldEconomy.Trade.createCaravanHistoryData(::Const.World.Common.WorldEconomy.Trade.CaravanHistoryType.Completed, origin.getID(), settlement.getID(), investment, profit, inv, [coords.X, coords.Y]);
					origin.updateCaravanSentHistory(caravanHistoryData);
					settlement.updateCaravanReceivedHistory(caravanHistoryData);

					// old functions
					//origin.setResources(origin.getResources() + totalPayment);
					//settlement.setResources(settlement.getResources() - totalPayment);

					this.logWarning("Unloading caravan with " + inv.len() + " items at " + settlement.getName() + ", the origin town " + origin.getName() + " receives their investment of " + investment + " resources along wiht a profit of " + profit + ", now have " + origin.getResources() + " resources in total");			

				}

				// unload all items to the marketplace
				foreach( item in inv )
				{
					settlement.addImportedProduce(item);
					this.logWarning("Moving \'" + item.getName() + "\' to " + settlement.getName() +  "\'s marketplace");
				}

				local storage = settlement.getImportedGoodsInventory().getItems();
				local marketplace = settlement.getBuilding("building.marketplace");
				// if there already too many items in storage, the excess one will be pushed to the marketplace immediately 
				// in order to keep the storage at a certain size
				// this also lets the settlement to continue shipping these items to another place :)
				if (marketplace != null && storage.len() > ::Const.World.Common.WorldEconomy.Trade.ImportedGoodsInventorySizeMax)
				{
					local different = storage.len() - ::Const.World.Common.WorldEconomy.Trade.ImportedGoodsInventorySizeMax;
					local newStorage = [];

					foreach (i, item in storage )
					{
						if (i >= different) newStorage.push(item);
						else marketplace.getStash().add(item);
					}

					settlement.getImportedGoodsInventory().assign(newStorage);
				}
			}
			// no world economy
			else
			{
				foreach( item in _entity.getInventory() )
				{
					settlement.addImportedProduce(item);
				}
			}

			_entity.clearInventory();
			break;
		}

		this.getController().popOrder();
		return true;
	}

});

