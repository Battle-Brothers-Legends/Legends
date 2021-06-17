this.logInfo("-------------INITIALISING ITEM TABLES --------------------")

this.Const.ItemTables <- 
{
	Tables = 
	{
	},

	ItemScripts = this.IO.enumerateFiles("scripts/items/")

	function updateFiles()
	{
		this.ItemScripts = this.IO.enumerateFiles("scripts/items/")
	}

	function addTable(_entityType)
	{
		local table = {};

		table.ItemSlots <- array(this.Const.ItemSlot.len()-3);
		Tables[_entityType] <- clone table;
	}
	function convertEntityType(_entityType)
	{
		if (typeof _entityType == "string"){
			if (!(_entityType in this.Const.EntityType))
			{
				this.logError(_entityType + " is not a valid EntityType!")
				return
			}
			_entityType = this.Const.EntityType[_entityType]
		}
		return _entityType
	}

	function convertItemSlot(_itemslot)
	{
		if (typeof _itemslot == "string"){
			if (!(_itemslot in this.Const.ItemSlot))
			{
				this.logError(_entityType + " is not a valid ItemSlot!")
				return
			}
			_itemslot = this.Const.ItemSlot[_itemslot]
		}
		return _itemslot
	}

	//_entityType = Const.EntityType
	//_itemslot = Const.ItemSlot
	//_item = either string/table, or array of strings/tables
	function pushItems(_entityType, _itemslot, _items)
	{
		if (!(_entityType in this.Tables))
		{
			//this.logInfo("Adding Table for entitytype " + _entityType + "\n");
			addTable(_entityType);
		}
		local table = Tables[_entityType];
		if (table.ItemSlots[_itemslot] == null)
		{
			table.ItemSlots[_itemslot] = {
				NeedsValidation = false,
				isValid = function() {return true},
				onChosen = null,
				Total = 0,
				Items = []
			};
		};
		
		if (typeof _items == "string") _items = [_items] //oh no

		//expands the passed _items array. Tries to turn a jumbled mess into a list of individual items as tables.
		local itemsToPush = []
		expandItems(_items, itemsToPush)

		foreach(item in itemsToPush)
		{
			//error checking
			if (ItemScripts.find(item.Script) == null)
			{
				if (!("LegendMod" in this.Const) || (!(item.Script in this.Const.LegendMod.Armors) && !(item.Script in this.Const.LegendMod.Helmets)))
				{
					this.logError("Item with script " + item.Script + " is not a valid item\n");
					continue;
				}
			}
			
			pushItem(table.ItemSlots[_itemslot], item);
		}
	}

	function expandItems(_items, itemsArray)
	{
		foreach (item in _items)
		{
			//just string
			if(typeof item == "string"){
				item = {Script = item, Weight = 1}
				itemsArray.push(item)
			}
			//array of strings
			else if (typeof item == "array"){
				foreach (i in item){
					local newItem = {Script = i, Weight = 1}
					itemsArray.push(newItem)
				}
			}
			// individual item table
			else if (typeof item == "table" && (!("Scripts" in item))){
				if (!("Script" in item)){
					this.logError("Item does not have a script\n");
					continue
				}
				if(!("Weight" in item)) item.Weight <- 1
				itemsArray.push(item)
			}
			// grouped item table
			else if (typeof item == "table" && "Scripts" in item){
				if ("Weights" in item && item.Weights.len() != item.Scripts.len()){
					this.logError("Length of Weights is not equal to length of Scripts in passed table!")
					continue
				}
				for (local i = 0; i < item.Scripts.len(); i++) 
				{
				    local newItem = {Script = item.Scripts[i]}
				    newItem.Weight <- "Weights" in item ? item.Weights[i] : 1;
				    if ("isValid" in item) newItem.isValid <- item.isValid;
				    if ("onChosen" in item) newItem.onChosen <- item.onChosen;
				    itemsArray.push(newItem)
				}
			}
			//failure
			else{
				this.logError("Item with type " + typeof item + " is not valid formatting!\n")
				continue;
			}

		}
	}

	function pushItem(_table, _item)
	{
		
		if ("isValid" in _item && _item.isValid != null) _table.NeedsValidation = true;

		//check for existing item to override
		local itemReplaced = false;
		for (local i = 0; i < _table.Items.len(); i++) {
		   if(_table.Items[i].Script == _item.Script){
		   		this.logInfo("Overriding existing item with script " + _item.Script)
				_table.Total -= _table.Items[i].Weight
				_table.Items[i] = _item;
				itemReplaced = true;
		   }
		}
		if(!itemReplaced) _table.Items.push(_item);
		
		_table.Total += _item.Weight;
	}

	//optional isValid function for the itemslot, ie only add a throwing weapon if random < 30
	function setItemSlotIsValid(_entityType, _itemslot, _isValidFunction){
        if (typeof _isValidFunction != "function"){
            this.logError("isValidFunction is not a function!")
            return
        }
        this.Tables[_entityType].ItemSlots[_itemslot].isValid = _isValidFunction
    }

	function setItemSlotOnChosen(_entityType, _itemslot, _onChosenFunction){
        if (typeof _onChosenFunction != "function"){
            this.logError("onChosenFunction is not a function!")
            return
        }
        this.Tables[_entityType].ItemSlots[_itemslot].onChosen = _onChosenFunction
    }

	function rollItem(_actor, _itemslot, _doOnChosen = true)
	{
		local itemslotTable = Tables[_actor.m.Type].ItemSlots[_itemslot];
		if (itemslotTable == null) return null;
		//if there's only a % to add an item from that category

		//If actor key ("skip" + _itemslot) is true, this itemslot isn't rolled
		local skipslot = "skip" + _itemslot;
		if(skipslot in _actor && _actor[skipslot] == true) return;

		if (!itemslotTable.isValid()) return

		local items = [];
		local total = 0;
		if (itemslotTable.NeedsValidation)
		{

			foreach (item in itemslotTable.Items)
			{
				if (!("isValid" in item) || item.isValid.call(_actor, item))
				{
					items.push(item);
					total += item.Weight;
				}
			}
		}
		else
		{
			items = itemslotTable.Items;
			total = itemslotTable.Total;
		}
		//local pick = rand() % total + 1;  //Equivalent to below
		local pick = this.Math.rand(1, total); 

		foreach(item in items)
		{
			//print("cycling through: " + item.Script + "\n");
			if(pick <= item.Weight)
			{
				local chosenItem = this.new(item.Script)
				if (_doOnChosen && itemslotTable.onChosen != null) 
				{
					//print("onchosen: " + item.onChosen + "\n");
					itemslotTable.onChosen.call(_actor, chosenItem);
				}
				
				if (_doOnChosen && "onChosen" in item) 
				{
					//print("onchosen: " + item.onChosen + "\n");
					item.onChosen.call(_actor, chosenItem);
				}
				//print("returning: " + item.Script + "\n");
				return (chosenItem);
			}
			pick -= item.Weight;
		}
		return null;
	}

	//switch based on legends
	function equipActor(_actor){
		local logActor = _actor.getName();
		if ("LegendMod" in this.Const) equipLegendsActor(_actor)
		else equipVanillaActor(_actor)
	}

	function equipVanillaActor(_actor)
	{
		if (!(_actor.m.Type in Tables)){
			this.logInfo("No items found for actor " + _actor.getName() + " Vanilla");
			return
		}

		local itemSlotTable = Tables[_actor.m.Type].ItemSlots
		//iterate through the game itemslots
		foreach(itemSlot in this.Const.ItemSlot){
			if (!(itemSlot in itemSlotTable) || itemSlotTable[itemSlot] == null) continue

			if (itemSlotTable[itemSlot].Items.len() == 0){
				this.logInfo("No items in slot "  + itemSlot + " for actor " + _actor.getName() )
				continue
			}
			local item = this.rollItem(_actor, itemSlot)

			if (itemSlot == this.Const.ItemSlot.Bag){
				_actor.m.Items.addToBag(item)
			}
			else {
			    _actor.m.Items.equip(item)
			}
		}
	}

	//return an array of [weight, script, [optional]] to be used by the legends picking functions
	function returnItemsForLegends(_actor, _itemslot)
	{
		if (!(_actor.m.Type in Tables)){
			this.logInfo("No items found for actor " + _actor.getName() + " Legends");
			return []
		}
		if (!(_itemslot in Tables[_actor.m.Type].ItemSlots)){
			this.logInfo("No items found for actor " + _actor.getName() + " Legends at slot " + _itemslot);
			return []
		}

		local ret = [];
		local itemSlot = Tables[_actor.m.Type].ItemSlots[_itemslot]
		local validated = !itemSlot.NeedsValidation
		foreach (item in itemSlot.Items)
		{
			if (validated || (!("isValid" in item) || item.isValid.call(_actor, item)))
			{
				//this.logInfo("Pushing [" + item.Weight + ", " + split(item.Script, "/")[split(item.Script, "/").len()-1] + "] for " + _actor.getName());
				local toPush = [item.Weight, split(item.Script, "/")[split(item.Script, "/").len()-1]]
				//eg add variant entry
				if ("onChosen" in item) toPush = item.onChosen.call(_actor, toPush)
				ret.push(toPush);
			}
		}
		return ret;
	}

	function equipLegendsActor(_actor)
	{
		if (!(_actor.m.Type in Tables)){
			this.logInfo("No items found for actor " + _actor.getName() + " Legends");
			return
		}

		local typeTable = Tables[_actor.m.Type]
		for (local itemSlot = 0; itemSlot < typeTable.ItemSlots.len(); itemSlot++) 
		{
		    if (typeTable.ItemSlots[itemSlot] == null || typeTable.ItemSlots[itemSlot].Items.len() == 0)
		    {
		    	continue;
		    }
		    if (itemSlot == this.Const.ItemSlot.Body){
		    	_actor.m.Items.equip(this.Const.World.Common.pickArmor(this.returnItemsForLegends(_actor, itemSlot)));
		    }
		    else if (itemSlot == this.Const.ItemSlot.Head){
		    	_actor.m.Items.equip(this.Const.World.Common.pickHelmet(this.returnItemsForLegends(_actor, itemSlot)));
		    }
		    else if (itemSlot == this.Const.ItemSlot.Bag){
		    	local item = this.rollItem(_actor, itemSlot);
		        _actor.m.Items.equip(item);
		    }
		    else {
		    	local item = this.rollItem(_actor, itemSlot);
		        _actor.m.Items.equip(item);
		    }
		}
	}
}
::pushItems <- function(_entityType, _itemslot, _item){
	_entityType = this.Const.ItemTables.convertEntityType(_entityType)
	_itemslot = this.Const.ItemTables.convertItemSlot(_itemslot)
	if (_entityType == null || _itemslot == null){
		this.logError("At least one parameter invalid, returning")
		return
	}
	this.Const.ItemTables.pushItems(_entityType, _itemslot, _item)
}
::setItemSlotIsValid <- function(_entityType, _itemslot, _isValidFunction){
	_entityType = this.Const.ItemTables.convertEntityType(_entityType)
	_itemslot = this.Const.ItemTables.convertItemSlot(_itemslot)
	if (_entityType == null || _itemslot == null){
		this.logError("At least one parameter invalid, returning")
		return
	}
	this.Const.ItemTables.setItemSlotIsValid(_entityType, _itemslot, _isValidFunction)
}
::setItemSlotOnChosen <- function(_entityType, _itemslot, _onChosenFunction){
	_entityType = this.Const.ItemTables.convertEntityType(_entityType)
	_itemslot = this.Const.ItemTables.convertItemSlot(_itemslot)
	if (_entityType == null || _itemslot == null){
		this.logError("At least one parameter invalid, returning")
		return
	}
	this.Const.ItemTables.setItemSlotOnChosen(_entityType, _itemslot, _onChosenFunction)
}
//::equipActor <- this.Const.ItemTables.equipActor;
