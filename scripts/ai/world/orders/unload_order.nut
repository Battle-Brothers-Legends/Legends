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

			// yes world economy
			if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			{
				local origin = _entity.getOrigin();
				local inv = _entity.getStashInventory().getItems();
				local tradegoods = 0.0; 
				local profit = 0; 
				foreach (item in inv)
				{
					if (item.isItemType(this.Const.Items.ItemType.TradeGood))
					{
						tradegoods += item.getResourceValue();
					}
					else
					{
					
						if (item.getValue())
						{
						profit += item.getValue() * 0.01;
						}
					}
							
				}

				tradegoods = this.Math.floor(tradegoods)
				profit = this.Math.floor(profit)

				if (origin != null)
				{
					local totalPayment = tradegoods + profit;
					
					origin.setResources(origin.getResources() + totalPayment);
					settlement.setResources(settlement.getResources() + tradegoods);
					this.logInfo("Unloading caravan with " + inv.len() + " items at " + settlement.getName() +  " who now have " + settlement.getResources() + " after paying " + totalPayment + " to the origin town "  + origin.getName() + " who now have" + origin.getResources());			
				}
				
				if (inv.len() != 0)
				{
					// number of items be sent to the marketplace
					local num = this.Math.min(settlement.getSize() + 1, inv.len());

					for (local i = 0; i < num; i = ++i)
					{
						// this will prevent adding the same item over and over
						local produce = inv.remove(this.Math.rand(0, inv.len() - 1));
						this.logInfo("Importing \'" + produce.getName() + "\' to " + settlement.getName() +  "\'s marketplace");	
						settlement.addImportedProduce(produce);
					}
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

