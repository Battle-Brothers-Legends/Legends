this.workshop_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
        ToolsCreated = 0,
        PointsNeeded = 0,
        PointsSalvaged = 0,
		ItemsDestroyed = 0,
        Stash = null,
        Salvage = null,
        Capacity = 0,
        NumBros = 0
	},
    function create()
    {
        this.camp_building.create();
        this.m.BaseCraft = 10;
        this.m.Conversion = 15.0;
        this.m.ModName = "Salvage";
        this.m.ID = this.Const.World.CampBuildings.Workshop;
        this.m.Slot = "scrap";
        this.m.Name = "Workshop";
        this.m.Description = "Turn scrap into useable parts";
        this.m.BannerImage = "ui/buttons/banner_scrap.png";
		// this.m.UIImage = "ui/settlements/scrap_day_empty";
		// this.m.UIImageNight =  "ui/settlements/scrap_night_empty";
		// this.m.UIImageFull = "ui/settlements/scrap_day_full";
		// this.m.UIImageNightFull =  "ui/settlements/scrap_night_full";
		this.m.Sounds = [
			{
				File = "ambience/camp/camp_scrap_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
					{
				File = "ambience/camp/camp_scrap_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_scrap_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
    }

	function getTitle()
	{
		if (this.getUpgraded())
		{
			return this.m.Name + " *Upgraded*"
		}
		return this.m.Name +  " *Not Upgraded*"
	}

	function getDescription()
	{
		local desc = "";
		desc += "Repairing equipment takes supplies. Break down and reuse equipment in your stash to help repair existing gear. "
		desc += "Each brother assigned to the tent salvages an amount of durability each hour and converts it into tools. "
        desc += "Once an item reaches zero durability, it will be consumed and destroyed. Every 15 durability equals a tool."
		desc += "The more people assigned to the tent, the quicker items will be salvaged."
		desc += "\n\n"
		desc += "The salvage tent can be upgraded by purchasing a salvage cart from a settlement merchant. An upgraded tent has a 15% increase in salvage speed and every 10 durability equals a tool."
		return desc;
	}

	function getModifierToolip()
    {
		this.init();
		local mod = this.getModifiers();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There are [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Salvage.len() + "[/color] items in the salvage queue."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getRequiredTime() + "[/color] hours to salvage all items in the queue."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/asset_supplies.png",
				text = "Total salvage modifier is [color=" + this.Const.UI.Color.PositiveValue + "]" + mod.Craft + "[/color] units per hour."
			}
		];
		local id = 6;
		foreach (bro in mod.Modifiers)
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + bro[0] + "[/color] units/hour " + bro[1] + " (" + bro[2] + ")"
			})
			++id;
		}
		return ret;
	}

	function isHidden()
	{

		if (this.World.LegendsMod.Configs().LegendCampUnlockEnabled())
		{
			return false;
		}

		return !this.World.Flags.get("HasLegendCampScraping")
	}

	function getUpgraded()
	{
        return this.Stash.hasItem("tent.scrap_tent")
	}

	function getLevel()
	{
		local pro = "dude";
		if (this.getUpgraded())
		{
			pro = "tent";
		}

		local sub = "empty";

		if (this.getAssignedBros() > 0) {
			sub =  "full";
		}
		return pro + "_" + sub;
	}

    function init()
    {
        this.onInit();
        this.m.ToolsCreated = 0;
        this.m.PointsSalvaged = 0;
		this.m.ItemsDestroyed = 0;
        local mod = this.getModifiers();
        this.m.NumBros = mod.Assigned;
        this.m.PointsNeeded = 0;
        foreach (i, r in this.m.Salvage)
        {
            if (r == null)
            {
                continue;
            }

            this.m.PointsNeeded += r.Item.getRepair();
        }
    }

    function onInit()
    {
        local items = this.getListOfEquipment()
        this.m.Stash = items.Stash;
        this.m.Salvage = items.Items;
        local capacity =  this.m.Salvage.len() + this.m.Stash.len();
        this.m.Capacity = capacity;
        while (this.m.Stash.len() < capacity)
        {
            this.m.Stash.push(null);
        }
        while (this.m.Salvage.len() < capacity)
        {
            this.m.Salvage.push(null);
        }
    }

    function getConversionRate()
    {
        return this.m.Conversion;
    }

    function getStash()
    {
        return this.m.Stash;
    }

    function getRepairs()
    {
        return this.m.Salvage;
    }

    function getCapacity()
    {
        return this.m.Capacity;
    }

    function getResults()
    {
        if (this.m.ToolsCreated == 0)
        {
            return [];
        }

        return [{
				id = 11,
				icon = "ui/icons/asset_supplies.png",
				text = "You created [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Math.floor(this.m.ToolsCreated) + "[/color] units of tools and salvaged [color=" + this.Const.UI.Color.NegativeEventValue + "]" + this.m.ItemsDestroyed + "[/color] pieces of equipment."
			}];
    }

    function getModifiers()
    {
        local ret = this.camp_building.getModifiers();
        if (this.getUpgraded())
        {
            ret.Consumption = 1.0 / 10.0
        }
        return ret;
    }

    function getRequiredSupplies()
    {
        local points = 0;
        foreach (i, r in this.m.Salvage)
        {
            if (r == null)
            {
                continue;
            }

            points += r.Item.getRepair()
        }
        local modifiers = this.getModifiers();
        return this.Math.ceil(points * modifiers.Consumption);
    }

    function getRequiredTime()
    {
        local points = 0;
        if (this.m.Salvage == null)
        {
            return 0;
        }

        foreach (i, r in this.m.Salvage)
        {
            if (r == null)
            {
                continue;
            }

            points += r.Item.getRepair()
        }
        local modifiers = this.getModifiers();
		if (modifiers.Craft <= 0)
		{
			return 0;
		}
        return this.Math.ceil(points / modifiers.Craft);
    }

    function getAssignedBros()
    {
        local mod = this.getModifiers();
        return mod.Assigned;
    }

	function getResourceImage()
	{
		return "ui/buttons/icon_time.png";
	}

	function getResourceCount()
	{
		return this.getRequiredTime();
	}

	function getUpdateText()
	{
        if (this.m.PointsNeeded == 0)
        {
            return "No salvage queued";
        }

		local percent = (this.m.PointsSalvaged / this.m.PointsNeeded) * 100.0;
		if (percent >= 100)
		{
			return "Salvaged ... 100%";
		}

		local text = "Salvaged ... " + percent + "%";

        if (this.World.Assets.getArmorPartsF() == this.World.Assets.getMaxArmorParts())
        {
            return text + " (At max tools!)";
        }
        return text;
	}

    function update ()
    {
        if (this.World.Assets.getArmorPartsF() >= this.World.Assets.getMaxArmorParts())
        {
            return this.getUpdateText();
        }

        if (this.m.Salvage == null) //has a chance to error without reallye ffecting anything if u do salvage.len and its null
        {
            return this.getUpdateText();
        }

        if (this.m.Salvage.len() == 0)
        {
            return this.getUpdateText();
        }

        local modifiers = this.getModifiers();
        foreach (i, r in this.m.Salvage)
        {
            if (r == null)
            {
                continue;
            }

            if ( this.World.Assets.getArmorPartsF() >= this.World.Assets.getMaxArmorParts())
            {
                break;
            }

			if (modifiers.Craft <= 0)
            {
                break
            }

            local consumed = r.Item.getRepair()
            if (modifiers.Craft < consumed)
            {
                consumed = modifiers.Craft;
            }
            r.Item.setArmor(r.Item.getRepair() - consumed);
            modifiers.Craft -= consumed;
            this.m.PointsSalvaged += consumed;
			local created = consumed * modifiers.Consumption;
			this.m.ToolsCreated += created;
			this.World.Assets.addArmorPartsF(created);

            if (r.Item.getRepair() <= 0)
            {
                this.m.ItemsDestroyed += 1

                // Salvages runes
                local myItem = this.World.Assets.getStash().getItemByInstanceID(r.Item.getInstanceID()).item;
				if(myItem.getRuneVariant() != 0)
				{
					if (this.World.LegendsMod.Configs().LegendArmorsEnabled() && (myItem.getRuneVariant() == 21 || myItem.getRuneVariant() == 22 || myItem.getRuneVariant() == 23))
					{
						local rune;

						switch(myItem.getRuneVariant())
						{
						case 21:
							rune = this.new("scripts/items/legend_armor/runes/legend_rune_endurance");
							break;

						case 22:
							rune = this.new("scripts/items/legend_armor/runes/legend_rune_safety");
							break;

						case 23:
							rune = this.new("scripts/items/legend_armor/runes/legend_rune_resilience");
							break;
						}

						rune.setRuneVariant(myItem.getRuneVariant());
						rune.setRuneBonus1(myItem.getRuneBonus1());
						rune.setRuneBonus2(myItem.getRuneBonus2());
						rune.setRuneVariant(0);
						this.World.Assets.getStash().add(rune);
					}
					else
					{
						local rune = this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
						rune.setRuneVariant(myItem.getRuneVariant());
						rune.setRuneBonus1(myItem.getRuneBonus1());
						rune.setRuneBonus2(myItem.getRuneBonus2());
						rune.updateRuneSigilToken();
						this.World.Assets.getStash().add(rune);
					}
				}

				this.World.Assets.getStash().remove(r.Item);
				this.m.Salvage[i] = null;
            }
        }

        return this.getUpdateText();

    }


    function sortSalvageQueue( _f1, _f2 )
	{
		if (_f1.Item.isToBeSalvagedQ() > _f2.Item.isToBeSalvagedQ())
		{
			return 1;
		}
		else if (_f1.Item.isToBeSalvagedQ() < _f2.Item.isToBeSalvagedQ())
		{
			return -1;
		}
		else
		{
			return 0;
		}
	}

    function getListOfEquipment()
    {
        local items = [];
        local stash = [];
        local roster = this.World.getPlayerRoster().getAll()
        local stashItems = this.Stash.getItems();
        foreach( item in stashItems)
        {
            if (item == null)
            {
                continue;
            }

			if (item.isIndestructible())
			{
				continue;
			}

            if (item.getCondition() <= 0)
            {
                continue;
            }

            if (item.isToBeRepaired())
            {
				continue;
            }

            if (!item.canBeSalvaged())
            {
                continue
            }

            if (item.isToBeSalvaged())
            {
                items.push({
                    Bro = null,
                    Item = item
                });
            }
            else
            {
                stash.push({
                    Bro = null,
                    Item = item
                });
            }
        }
        items.sort(this.sortSalvageQueue);
        return {Items = items, Stash = stash};
    }

    function assignAll( _filter = 0 )
    {
        if (_filter == 0)
		{
			_filter = this.Const.Items.ItemFilter.All;
		}

        local index = 0
        foreach (i, s in this.m.Stash)
        {
            if (s == null)
            {
                continue
            }

            if (_filter == 99 && s.Bro != null)
            {
                continue;
            }
            else if ((s.Item.getItemType() & _filter) == 0)
            {
                continue;
            }

            for (index; index < this.m.Salvage.len(); index = ++index)
            {
                if (this.m.Salvage[index] == null)
                {
                    break;
                }
            }

            s.Item.setToBeSalvaged(true, index);
            if (index >= this.m.Salvage.len())
            {
                this.m.Salvage.push(s);
            }
            else
            {
                this.m.Salvage[index] = s;
            }
            s.Item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag)
            this.m.Stash[i] = null;
        }
    }

    function removeAll()
    {
        local index = 0;
        foreach (i, s in this.m.Salvage)
        {
            if (s == null)
            {
                continue
            }

            for (index; index < this.m.Salvage.len(); index = ++index)
            {
                if (this.m.Stash[index] == null)
                {
                    break;
                }
            }

            s.Item.setToBeSalvaged(false, 0);
            if (index >= this.m.Stash.len())
            {
                this.m.Stash.push(s);
            }
            else
            {
                this.m.Stash[index] = s;
            }
            s.Item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag)
            this.m.Salvage[i] = null;
        }
    }

	function swapItems( sourceItemOwner, sourceItemIdx, targetItemOwner, targetItemIdx )
	{
		if (targetItemOwner == null)
		{
			this.logError("onSwapItem #1");
			return false;
		}

        if (sourceItemOwner == targetItemOwner && sourceItemIdx == targetItemIdx)
        {
            return false
        }

        local sourceList = null;
        local targetList = null;
        local isRepair = false
		switch(sourceItemOwner)
		{
		case "camp-screen-workshop-dialog-module.stash":
            sourceList = this.m.Stash
            if (sourceItemOwner == targetItemOwner)
            {
                targetList = this.m.Stash;
            }
            else
            {
                targetList = this.m.Salvage;
                isRepair = true;
            }
            break;

		case "camp-screen-workshop-dialog-module.shop":
            sourceList = this.m.Salvage
            if (sourceItemOwner == targetItemOwner)
            {
                targetList = this.m.Salvage;
                isRepair = true
            }
            else
            {
                targetList = this.m.Stash;
            }
            break;
        }

        local sourceItem = sourceList[sourceItemIdx];

        if (sourceItem == null)
        {
            this.logError("onSwapItem(stash) #2");
            return false;
        }

        //We've picked a spot to drop it
        if (targetItemIdx != null)
        {
            //Make sure array is big enough for target spot
            while (targetItemIdx > targetList.len() - 1)
            {
                targetList.push(null)
            }
            sourceList[sourceItemIdx] = targetList[targetItemIdx];
            targetList[targetItemIdx] = sourceItem;
            sourceItem.Item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag)
            local index = 0
            if (isRepair)
            {
                index = targetItemIdx
            }
            sourceItem.Item.setToBeSalvaged(isRepair, index);
            return true
        }

        //didn't pick a spot to drop, find the first null spot
        foreach (i,r in targetList)
        {
            if (r != null)
            {
                continue
            }
            targetList[i] = sourceItem;
            sourceList[sourceItemIdx] = null;
            sourceItem.Item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag)
            local index = 0
            if (isRepair)
            {
                index = i
            }
            sourceItem.Item.setToBeSalvaged(isRepair, index);
            return true
        }

        //No null spot, push to the end
        targetList.push(sourceItem);
        sourceList[sourceItemIdx] = null;
        sourceItem.Item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag)
        local index = 0
        if (isRepair)
        {
            index = targetList.len() - 1
        }
        sourceItem.Item.setToBeSalvaged(isRepair, index);
        return true
	}

	function onClicked( _campScreen )
	{
        _campScreen.showWorkshopDialog();
        this.camp_building.onClicked(_campScreen);
	}

	function onSerialize( _out )
	{
		this.camp_building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.camp_building.onDeserialize(_in);
	}

});