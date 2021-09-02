this.getroottable().Const.LegendMod.hookItemContainer <- function()
{
	::mods_hookNewObject("items/item_container", function(o) 
	{
	    o.drop <- function( item )
		{
	        if (!this.m.Actor.isPlacedOnMap())
	        {
	            return;
	        }

	        local _tile = this.m.Actor.getTile();
	        item.m.IsDroppedAsLoot = true;
	        item.drop(_tile);
			_tile.IsContainingItemsFlipped = true;
		}

	    local equip = o.equip
	    o.equip = function (_item)
	    {
	        if (_item == null)
	        {
	            return false;
	        }
	        return equip(_item);
	    }

	    o.unequipNoUpdate <- function (_item)
		{
			if (_item == null || _item == -1)
			{
				return;
			}

			if (_item.getCurrentSlotType() == this.Const.ItemSlot.None || _item.getCurrentSlotType() == this.Const.ItemSlot.Bag)
			{
				this.logWarning("Attempted to unequip item " + _item.getName() + ", but is not equipped");
				return false;
			}

			for( local i = 0; i < this.m.Items[_item.getSlotType()].len(); i = ++i )
			{
				if (this.m.Items[_item.getSlotType()][i] == _item)
				{
					// _item.onUnequip();
					// _item.setContainer(null);
					// _item.setCurrentSlotType(this.Const.ItemSlot.None);
					this.m.Items[_item.getSlotType()][i] = null;

					if (_item.getBlockedSlotType() != null)
					{
						for( local i = 0; i < this.m.Items[_item.getBlockedSlotType()].len(); i = ++i )
						{
							if (this.m.Items[_item.getBlockedSlotType()][i] == -1)
							{
								this.m.Items[_item.getBlockedSlotType()][i] = null;
								break;
							}
						}
					}
					return true;
				}
			}

			return false;
		}

	    o.transferToList <- function( _stash )
		{
			for( local i = 0; i < this.Const.ItemSlot.COUNT; i = ++i )
			{
				for( local j = 0; j < this.m.Items[i].len(); j = ++j )
				{
					if (this.m.Items[i][j] == null || this.m.Items[i][j] == -1)
					{
	                    continue
					}

	                local item = this.m.Items[i][j];
	                if (item.isEquipped())
	                {
	                    this.unequip(item);
	                }
	                else
	                {
	                    this.removeFromBag(item);
	                }
	                _stash.push(item);
	                // this.logInfo("Transferred " + item.m.Name + " : " + item.getInstanceID())
	                // local res = this.Stash.getItemByInstanceID(item.getInstanceID());
	                // if (res == null) {
	                //     this.logInfo("saveFormation::could not find item for " + item.getInstanceID());
	                //     continue
	                // }
	                //toTransfer.push(item);
				}
			}

	        // this.logInfo("TRANSFERED TO STASH COMPLETE. STASH SIZe = " + _stash.m.Items.len())

			// foreach( item in toTransfer )
			// {
			// 	if (_stash.add(item) == null)
			// 	{
	        //         this.logInfo("STASH ADD ITEM IS NULL")
			// 		break;
			// 	}


			// }
		}
	});
	delete this.Const.LegendMod.hookItemContainer;
}