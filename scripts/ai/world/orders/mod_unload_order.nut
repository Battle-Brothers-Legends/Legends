this.mod_unload_order <- this.inherit("scripts/ai/world/world_behavior", {
	//unloads items from the regular caravan
	//somehow the town is not found as an entity at its tile, and this is one of the enigma functions so I have to work around it by explicity assigning the base
	m = {},
	function create()
	{
		this.world_behavior.create();
		this.m.ID = this.Const.World.AI.Behavior.ID.Unload;
	}

	function onExecute( _entity, _hasChanged )
	{
		local settlement = this.getPlayerBase()
		if(settlement)
		{
			local items = settlement.getBuilding("building.storage_building").getStash().getItems()
			local food = [];
			foreach( i, item in items )
			{
				if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
				{
					food.push(item);
				}
			}
			//removes old food from storage
			foreach (item in food)
			{
				settlement.getBuilding("building.storage_building").getStash().remove(item)
			}

			foreach( item in _entity.getInventory() )
			{
				settlement.addImportedProduce(item);
				_entity.clearInventory();
			}
		}


		this.getController().popOrder();
		return true;
	}

});

