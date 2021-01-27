::mods_registerMod("mod_stronghold", 0.27);
::mods_registerJS("mod_stronghold.js");
::mods_registerCSS("mod_stronghold.css");
::mods_queue("mod_stronghold", null, function()
{	

	
	::mods_hookNewObject("states/world/asset_manager", function (o)
	{
		//set in player_base.nut, revoked in defeat_assailant and remove playerbase contracts
		//convenience function to check if player base is built and retrieve it
		o.getPlayerBase <- function ()
		{
			local player_faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player)
			if (player_faction)
			{
				local player_settlements = player_faction.getSettlements()
				if (player_settlements.len() > 0)
				{
					return player_settlements[0]
				}
			}
			return false
		}
	
		
		//don't consume food if wheat fields attached
		while (!("consumeFood" in o)) o = o[o.SuperName];
		local consumeFood = o.consumeFood;		
		o.consumeFood = function()
		{
			local player_base = this.getPlayerBase()
			if (player_base && player_base.hasAttachedLocation("attached_location.wheat_fields") && this.World.State.getPlayer().getTile().getDistanceTo(player_base.getTile()) < 25)
			{
				return
			}
			//else: vanilla function 
			consumeFood()
		}
		
		while (!("update" in o)) o = o[o.SuperName];
		local update = o.update;		
		o.update = function(_worldState)
		{			
			//set movementspeed and vision radius if watchtower location
			if (this.World.getTime().Hours != this.m.LastHourUpdated)
			{
				//check for ranger start and lookout follower
				local player_base = this.getPlayerBase()
				if (player_base && player_base.hasAttachedLocation("attached_location.stone_watchtower") && this.World.State.getPlayer().getTile().getDistanceTo(player_base.getTile()) < 25)
				{
					if (this.World.Assets.getOrigin().getID() == "scenario.rangers")
					{
						this.World.State.getPlayer().m.BaseMovementSpeed = 120
					}
					else
					{
						this.World.State.getPlayer().m.BaseMovementSpeed = 111
					}
					
					if (this.World.Retinue.hasFollower("follower.lookout"))
					{
						this.World.State.getPlayer().m.VisionRadius = 750
					}
					else
					{
						this.World.State.getPlayer().m.VisionRadius = 625
					}
					
				}
				//if not in radius
				else
				{
					if (this.World.Assets.getOrigin().getID() == "scenario.rangers")
					{
						this.World.State.getPlayer().m.BaseMovementSpeed = 111
					}
					else
					{
						this.World.State.getPlayer().m.BaseMovementSpeed = 105
					}
					
					if (this.World.Retinue.hasFollower("follower.lookout"))
					{
						this.World.State.getPlayer().m.VisionRadius = 625
					}
					else
					{
						this.World.State.getPlayer().m.VisionRadius = 500
					}
				}
				//same for herbalist grove
				if (player_base && player_base.hasAttachedLocation("attached_location.herbalist_grove") && this.World.State.getPlayer().getTile().getDistanceTo(player_base.getTile()) < 25)
				{
					this.m.HitpointsPerHourMult = 1.2
				}
				else
				{
					this.m.HitpointsPerHourMult = 1.0
				}
			}
			//then run vanilla updte
			update(_worldState)
		}
			
	});
		
		
	::mods_hookClass("items/item", function ( o )
	{
		// sets buy/sell price to 0 when using stronghold marketplace
		while (!("getBuyPrice" in o)) o = o[o.SuperName];
		local getBuyPrice = o.getBuyPrice;		
		o.getBuyPrice = function()
		{
			if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().m.CurrentBuilding != null && this.World.State.getCurrentTown().m.CurrentBuilding.m.ID == "building.storage_building")
			{				
				return 0.0;
			}
			else
			{
				return getBuyPrice();
			}
		}
		
		while (!("getSellPrice" in o)) o = o[o.SuperName];
		local getSellPrice = o.getSellPrice;		
		o.getSellPrice = function()
		{
			if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().m.CurrentBuilding != null && this.World.State.getCurrentTown().m.CurrentBuilding.m.ID == "building.storage_building")
			{				
				return 0.0;
			}
			else
			{
				return getSellPrice();
			}
		}
	}, false, true);
	
	::mods_hookClass("items/supplies/food_item", function ( o )
	{
		// sets buy/sell price to 0 when using stronghold marketplace
		while (!("getBuyPrice" in o)) o = o[o.SuperName];
		local getBuyPrice = o.getBuyPrice;		
		o.getBuyPrice = function()
		{
			if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().m.CurrentBuilding != null && this.World.State.getCurrentTown().m.CurrentBuilding.m.ID == "building.storage_building")
			{				
				return 0.0;
			}
			else
			{
				return getBuyPrice();
			}
		}
		
		while (!("getSellPrice" in o)) o = o[o.SuperName];
		local getSellPrice = o.getSellPrice;		
		o.getSellPrice = function()
		{
			if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null && this.World.State.getCurrentTown().m.CurrentBuilding != null && this.World.State.getCurrentTown().m.CurrentBuilding.m.ID == "building.storage_building")
			{				
				return 0.0;
			}
			else
			{
				return getSellPrice();
			}
		}
	}, false, true);
	


	::mods_hookNewObject("ui/screens/world/modules/world_campfire_screen/campfire_main_dialog_module", function ( o )
	{
		//function to build/upgrade stronghold via retinue menu. Checks for a few things (quest active, already built, already fully upgraded, tile occupied)
		local build_cost = 20 * this.Const.World.StrongholdPriceMult
		local upgrade_cost = 20 * this.Const.World.StrongholdPriceMult
		while (!("onCartClicked" in o)) o = o[o.SuperName];
		local onCartClicked = o.onCartClicked;
		o.onCartClicked = function()
		{
			onCartClicked();
			if (this.World.Retinue.getInventoryUpgrades() >= this.Const.World.InventoryUpgradeCosts.len())
			{
				local tile = this.World.State.getPlayer().getTile();
				if(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player).len() == 0){
					if (this.World.Assets.getMoney() >= build_cost){
						if (tile.IsOccupied)
						{
							this.showDialogPopup("Build a stronghold", "Tile is occupied, cannot build a stronghold here!", null, null, true);
						}
						else if(this.World.Contracts.getActiveContract() != null)
						{
							this.showDialogPopup("Build a stronghold", "You can't have an active contract when building a stronghold!", null, null, true);
						}
						else{
							this.showDialogPopup("Build a stronghold", "You can pay " + build_cost +" crowns to build a stronghold at this location. \n CAREFUL: You can only have one stronghold. You can remove this stronghold as long as you don't upgrade it. \n CAREFUL: The closest nobles or enemies will attempt to destroy your base. Defend it!", this.onPurchasePlayerBase.bindenv(this), null);
						}

					}
					else{
						this.showDialogPopup("Build a stronghold", "Gather " + build_cost + " crowns to build a stronghold!", null, null, true);
					}
				}
				else
				{
					if(this.getPlayerBase()){
						if(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0].m.Settlements[0].getSize() == 3){
								this.showDialogPopup("Stronghold", "You already have a fully upgraded stronghold!", null, null, true);
							}
						else if(this.World.Contracts.getActiveContract() != null)
							{
								this.showDialogPopup("Upgrade your stronghold", "You can't have an active contract when upgrading a stronghold!", null, null, true);
							}
						else{
							if(this.World.Assets.getMoney() < upgrade_cost){
								this.showDialogPopup("Upgrade your stronghold", "You need " + upgrade_cost + " crowns to upgrade your stronghold!", null, null, true);
							}
							else{
								this.showDialogPopup("Upgrade your stronghold", "You can pay " + upgrade_cost + " crowns to upgrade your stronghold. \n This will add a building slot and increase the value of your trades. \n CAREFUL: You can only remove a stronghold that's not been upgraded. \n CAREFUL: The closest nobles or enemies will attempt to destroy your base. Defend it!", this.onUpgradePlayerBase.bindenv(this), null);
							}
						}
					}
					else{
						if (this.World.Assets.getMoney() >= build_cost){
							if (tile.IsOccupied)
							{
								this.showDialogPopup("Build a stronghold", "Tile is occupied, cannot build a stronghold here!", null, null, true);
							}
							else if(this.World.Contracts.getActiveContract() != null)
							{
								this.showDialogPopup("Build a stronghold", "You can't have an active contract when building a stronghold!", null, null, true);
							}
							else{
								this.showDialogPopup("Build a stronghold", "You can pay " + build_cost + " crowns to build a stronghold at this location. \n CAREFUL: You can only have one stronghold. You can remove this stronghold as long as you don't upgrade it. \n CAREFUL: The closest nobles or enemies will attempt to destroy your base. Defend it!", this.onPurchasePlayerBase.bindenv(this), null);
							}
						}
						else{
							this.showDialogPopup("Build a stronghold", "Gather " + build_cost + " crowns to build a stronghold!", null, null, true);
						}
					}

				}
				
			}
		};
		
		o.onPurchasePlayerBase <- function()
		{
			//called from retinue menu
			this.World.Assets.addMoney(-build_cost);
			local tile = this.World.State.getPlayer().getTile();
			local player_faction;
			//create new faction if it doesn't exist already
			if (this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player).len() == 0)
			{
				player_faction = this.new("scripts/factions/player_base_faction");
				player_faction.setID(this.World.FactionManager.m.Factions.len());
				player_faction.setName("The " + this.World.Assets.getName());
				player_faction.setMotto("\"" + "Soldiers Live" + "\"");
				player_faction.setDescription("The only way to leave the company is feet first.");
				player_faction.setBanner(this.World.Assets.getBannerID());
				player_faction.setDiscovered(true);
				player_faction.m.PlayerRelation = 100;		
				player_faction.updatePlayerRelation()
				this.World.FactionManager.m.Factions.push(player_faction);
				player_faction.onUpdateRoster();
			}
			else
			{
				player_faction = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0];
			}
			
			local player_base = this.World.spawnLocation("scripts/entity/world/settlements/player_base", tile.Coords);
			player_base.updateProperties()
			player_faction.addSettlement(player_base);
			player_base.updateTown();
			tile.IsOccupied = true;
			tile.TacticalType = this.Const.World.TerrainTacticalType.Urban;
			//spawn assailant quest
			local contract = this.new("scripts/contracts/contracts/defeat_assailant_contract");
			contract.setEmployerID(player_faction.getRandomCharacter().getID());
			contract.setFaction(player_faction.getID());
			contract.setHome(player_base);
			contract.setOrigin(player_base);
			this.World.Contracts.addContract(contract);
			contract.start();
		};
		
		o.onUpgradePlayerBase <- function()
		{
			this.World.Assets.addMoney(-upgrade_cost);
			local player_faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player)
			local player_base = this.getPlayerBase()
			//upgrade looks and situation
			player_base.m.Size = player_base.m.Size +1;
			player_base.buildHouses()
			player_base.defineName();
			player_base.updateTown();
			
			if (player_faction.m.Deck.len() < 2)
			{
				local order = ["scripts/factions/actions/stronghold_guard_base_action", "scripts/factions/actions/stronghold_send_caravan_action"];
				player_faction.addTrait(order);
			}
			//spawn new guards to reflect the change in size
			local actionToFire = player_faction.m.Deck[0]
			actionToFire.execute(player_faction);
			
			//spawn assailant quest
			local contract = this.new("scripts/contracts/contracts/defeat_assailant_contract");
			contract.setEmployerID(player_faction.getRandomCharacter().getID());
			contract.setFaction(player_faction.getID());
			contract.setHome(player_base);
			contract.setOrigin(player_base);
			this.World.Contracts.addContract(contract);
			contract.start();
		};
	});
	

	::mods_hookNewObject("entity/world/settlements/buildings/port_building", function ( o )
	{
		//adapts UI for port building
		while (!("getUITravelRoster" in o)) o = o[o.SuperName];
		local getUITravelRoster = o.getUITravelRoster;
		o.getUITravelRoster = function()
		{
			local data = {
			Title = "Harbor",
			SubTitle = "A harbor that allows you to book passage by ship to other parts of the continent",
			HeaderImage = null,
			Roster = []
			};
			local settlements = this.World.EntityManager.getSettlements();

			foreach( s in settlements )
			{
				if (!s.isCoastal())
				{
					continue;
				}

				if (s.getID() == this.m.Settlement.getID())
				{
					continue;
				}

				if (!s.isAlliedWithPlayer() || !this.m.Settlement.getOwner().isAlliedWith(s.getFaction()))
				{
					continue;
				}

				local dest = {
					ID = s.getID(),
					EntryID = data.Roster.len(),
					ListName = "Sail to " + s.getName(),
					Name = s.getName(),
					Cost = this.getCostTo(s),
					ImagePath = s.getImagePath(),
					ListImagePath = s.getImagePath(),
					FactionImagePath = s.getOwner().getUIBannerSmall(),
					BackgroundText = s.getDescription() + "<br><br>" + this.getRandomDescription(s.getName())
				};
				data.Roster.push(dest);
			}

			return data;
		}
		
		while (!("isHidden" in o)) o = o[o.SuperName];
		local isHidden = o.isHidden;
		o.isHidden = function()
		{
			if (this.getPlayerBase() && ("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() == this.getPlayerBase())
			{
				return false
			}
			else
			{
				return isHidden()
			}
		}
	});

	::mods_hookClass("entity/world/location", function ( o )
	{
		//point is to not reduce named item chance based on the  stronghold. first rolls normal onspawned, then adds nameds based on difference of distance. Math is probably off
		
		while (!("onSpawned" in o)) o = o[o.SuperName];
		local onSpawned = o.onSpawned;
		o.onSpawned = function()
		{
			
			onSpawned()
			if (this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player).len() != 0 && this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0].m.Settlements.len() > 0)
			{
				local loot = this.m.Loot.getItems();
				local named_count = 0;
				foreach( item in loot )
				{
					if (item.isItemType(this.Const.Items.ItemType.Named))
					{
						named_count++
					}
				}
				if (named_count > 1){
					return
				}
				
				local player_base = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0].m.Settlements[0]
				local player_base_tile = player_base.getTile();
				local location_tile = this.getTile();
				local location_dist = 9999;
				local closest_settlement;
				
				foreach( sett in this.World.EntityManager.getSettlements() )
				{
					local d =  location_tile.getDistanceTo(sett.getTile());
					if (d < location_dist)
					{
						location_dist = d;
						closest_settlement = sett
					}
					
				}
				if (closest_settlement != player_base){
					return;
				}
				local nearest_dist = 9000;
				foreach( s in this.World.EntityManager.getSettlements() )
				{
					if (s != player_base)
					{
						local d =  player_base_tile.getDistanceTo(s.getTile());
						if (d < nearest_dist)
						{
							nearest_dist = d;
						}
					}
				}
				local distance_modifier = location_dist > nearest_dist ? location_dist - nearest_dist : nearest_dist - location_dist;
				
				if (!this.isLocationType(this.Const.World.LocationType.Unique))
				{
					for( local chance = (this.m.Resources + distance_modifier * 4) / 5.0 - 37.0; named_count < 2;  )
					{
						local r = this.Math.rand(1, 100);

						if (r <= chance)
						{
							chance = chance - r;
							named_count++;
							local type = this.Math.rand(20, 100);

							if (type <= 40)
							{
								local weapons = clone this.Const.Items.NamedWeapons;

								if (this.m.NamedWeaponsList != null && this.m.NamedWeaponsList.len() != 0)
								{
									weapons.extend(this.m.NamedWeaponsList);
									weapons.extend(this.m.NamedWeaponsList);
								}

								this.m.Loot.add(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
							}
							else if (type <= 60)
							{
								local shields = clone this.Const.Items.NamedShields;

								if (this.m.NamedShieldsList != null && this.m.NamedShieldsList.len() != 0)
								{
									shields.extend(this.m.NamedShieldsList);
									shields.extend(this.m.NamedShieldsList);
								}

								this.m.Loot.add(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
							}
							else if (type <= 80)
							{
								local helmets = clone this.Const.Items.NamedHelmets;

								if (this.m.NamedHelmetsList != null && this.m.NamedHelmetsList.len() != 0)
								{
									helmets.extend(this.m.NamedHelmetsList);
									helmets.extend(this.m.NamedHelmetsList);
								}

								this.m.Loot.add(this.new("scripts/items/" + helmets[this.Math.rand(0, helmets.len() - 1)]));
							}
							else if (type <= 100)
							{
								local armor = clone this.Const.Items.NamedArmors;

								if (this.m.NamedArmorsList != null && this.m.NamedArmorsList.len() != 0)
								{
									armor.extend(this.m.NamedArmorsList);
									armor.extend(this.m.NamedArmorsList);
								}

								this.m.Loot.add(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
							}
						}
						else
						{
							break;
						}
					}
				}
				
			}
		}
	});
	
	local stronghold_assignTroops = function ( _party, _partyList, _resources, _weightMode = 1)
	{
		
		//this function circumvents the max party sizes. initially had it used universally, now only during  specific calls
		local max_resources = _resources
		local selected_party;
		while (_resources > 15)
		{
			selected_party = this.Const.World.Common.assignTroops( _party, _partyList, _resources, _weightMode = 1)
			foreach (t in _party.m.Troops)
			{
				_resources -= t.Cost
			}
		}

		_party.updateStrength();
		return selected_party;
		
	}
		
	
	::mods_hookClass("factions/faction", function ( o )
	{
		o.stronghold_spawnEntity <- function( _tile, _name, _uniqueName, _template, _resources )
		{
			//same as vanilla
			local party = this.World.spawnEntity("scripts/entity/world/party", _tile.Coords);
			party.setFaction(this.getID());

			if (_uniqueName)
			{
				_name = this.getUniqueName(_name);
			}

			party.setName(_name);
			local t;

			if (_template != null)
			{
				//except for this line, allowing more than unit cap
				t = stronghold_assignTroops(party, _template, _resources);
			}

			party.getSprite("base").setBrush(this.m.Base);

			if (t != null)
			{
				party.getSprite("body").setBrush(t.Body);
			}

			if (this.m.BannerPrefix != "")
			{
				party.getSprite("banner").setBrush(this.m.BannerPrefix + (this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner));
			}

			this.addUnit(party);
			return party;
		}
		
		
	})
	
	::mods_hookNewObject("factions/actions/send_caravan_action", function ( o )
	{
		//sends caravans to player base if relation is above 70, gives higher chance to be chosen
		while (!("onUpdate" in o)) o = o[o.SuperName];
		local onUpdate = o.onUpdate;
		o.onUpdate = function(_faction)
		{
			//run vanilla if no base
			if (!this.getPlayerBase())
			{
				return onUpdate(_faction)
			}
			
			if (!this.World.getTime().IsDaytime)
			{
				return;
			}

			if (_faction.isEnemyNearby())
			{
				return;
			}

			if (_faction.getUnits().len() >= 1)
			{
				return;
			}

			local mySettlements = _faction.getSettlements();
			local allSettlements = this.World.EntityManager.getSettlements();
			local destinations;

			if (!this.World.FactionManager.isGreaterEvil())
			{
				destinations = allSettlements;
			}
			else
			{
				destinations = [];

				foreach( s in allSettlements )
				{
					if (s.getOwner() == null || s.getOwner().isAlliedWith(_faction.getID()))
					{
						//changes here: if playerbase, only send caravan if friendly, then add higher chance if not buffed already
						if(this.getPlayerBase() && this.getPlayerBase().getName() == s.getName())
						{
							if (_faction.m.PlayerRelation >= 70 || (mySettlements[0].getOwner() != null && mySettlements[0].getOwner().m.PlayerRelation >= 70))
							{
								destinations.push(s);
								destinations.push(s);
								local exists = false;
								foreach( situation in this.getPlayerBase().m.Situations )
								{
									if (situation.getID() == "situation.mod_well_supplied_ai")
									{
										exists = true
									}
								}
								if (!exists)
								{
									destinations.push(s);
									destinations.push(s);
									destinations.push(s);
									destinations.push(s);
								}
							}
						}
						else
						{
							destinations.push(s);
						}
					}
				}
			}

			local settlements = this.getRandomConnectedSettlements(2, mySettlements, destinations, true);

			if (settlements.len() < 2)
			{
				return;
			}

			this.m.Start = settlements[0];
			this.m.Dest = settlements[1];
			this.m.Score = 5;
		}
		
		//slight change to call modded unload order instead of vanilla
		//need to change the whole function, this is, pretty cumbersome
		while (!("onExecute" in o)) o = o[o.SuperName];
		local onExecute = o.onExecute;
		o.onExecute = function(_faction)
		{
			local party;
			local playerBase = this.getPlayerBase()
			//increase strength of caravan if sent to player base
			if (playerBase && this.m.Dest.getName() == playerBase.getName())
			{
				this.m.Start.m.Resources *= 3
			}
			if (_faction.hasTrait(this.Const.FactionTrait.OrientalCityState))
			{
				party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Caravan", false, this.Const.World.Spawn.CaravanSouthern, this.m.Start.getResources() * 0.6);
			}
			else
			{
				party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Caravan", false, this.Const.World.Spawn.Caravan, this.m.Start.getResources() * 0.5);
			}

			party.getSprite("banner").Visible = false;
			party.getSprite("base").Visible = false;
			party.setMirrored(true);
			party.setDescription("A trading caravan from " + this.m.Start.getName() + " that is transporting all manner of goods between settlements.");
			party.setFootprintType(this.Const.World.FootprintsType.Caravan);
			party.getFlags().set("IsCaravan", true);
			party.getFlags().set("IsRandomlySpawned", true);

			if (this.World.Assets.m.IsBrigand && this.m.Start.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 70)
			{
				party.setVisibleInFogOfWar(true);
				party.setImportant(true);
				party.setDiscovered(true);
			}

			if (this.m.Start.getProduce().len() != 0)
			{
				local e = 3;

				for( local j = 0; j != e; j = ++j )
				{
					party.addToInventory(this.m.Start.getProduce()[this.Math.rand(0, this.m.Start.getProduce().len() - 1)]);
				}
			}

			party.getLoot().Money = this.Math.rand(0, 100);

			if (this.Math.rand(1, 100) <= 50)
			{
				party.getLoot().ArmorParts = this.Math.rand(0, 10);
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				party.getLoot().Medicine = this.Math.rand(0, 10);
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				party.getLoot().Ammo = this.Math.rand(0, 25);
			}

			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				party.addToInventory("supplies/bread_item");
			}
			else if (r == 2)
			{
				party.addToInventory("supplies/roots_and_berries_item");
			}
			else if (r == 3)
			{
				party.addToInventory("supplies/dried_fruits_item");
			}
			else if (r == 4)
			{
				party.addToInventory("supplies/ground_grains_item");
			}

			local c = party.getController();
			c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
			c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
			local move = this.new("scripts/ai/world/orders/move_order");
			move.setDestination(this.m.Dest.getTile());
			move.setRoadsOnly(true);
			//changes here
			local unload;
			if (playerBase && this.m.Dest.getName() == playerBase.getName())
			{
				unload = this.new("scripts/ai/world/orders/mod_unload_ai_order");
				party.setDescription("A trading caravan from " + this.m.Start.getName() + " that is resupplying your base.");
				
			}
			else
			{
				unload = this.new("scripts/ai/world/orders/unload_order");
			}
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(move);
			c.addOrder(unload);
			c.addOrder(despawn);
		}
	});
	
	
	::mods_hookNewObject("factions/actions/patrol_roads_action", function ( o )
	{
		//adds stronghold as possible patrol option if friendly with the faction
		while (!("onUpdate" in o)) o = o[o.SuperName];
		local onUpdate = o.onUpdate;
		o.onUpdate = function(_faction)
		{
			local playerBase = this.getPlayerBase()
			if (!playerBase || !(_faction.m.PlayerRelation >= 70)){
				return onUpdate(_faction)
			}
			
			
			if (!this.World.getTime().IsDaytime)
			{
				return;
			}

			local settlements = clone _faction.getSettlements();
			
			//change here
			if (playerBase && _faction.m.PlayerRelation >= 70){
				settlements.push(playerBase)
			}

			if (settlements.len() < 3)
			{
				return;
			}

			if (!_faction.isReadyToSpawnUnit())
			{
				return;
			}

			local settlements = this.getRandomConnectedSettlements(3, settlements);

			if (settlements.len() < 3)
			{
				return;
			}

			this.m.Settlements = settlements;
			this.m.Score = 10;
			
		}
		
		//needed for patrol to not start at player base. This whole thing is pretty jank, need to hook whole functions for small changes, would probably be better to separate entirely.
		while (!("onExecute" in o)) o = o[o.SuperName];
		local onExecute = o.onExecute;
		o.onExecute = function(_faction)
		{
			local waypoints = [];

			for( local i = 0; i != 3; i = ++i )
			{
				local idx = this.Math.rand(0, this.m.Settlements.len() - 1);
				local wp = this.m.Settlements[idx];
				this.m.Settlements.remove(idx);
				waypoints.push(wp);
			}
			//change here
			if (this.getPlayerBase() && waypoints[0].getName() == this.getPlayerBase().getName())
			{
				local temp = waypoints.remove(0)
				waypoint.insert(1, temp)
			}
			local party = this.getFaction().spawnEntity(waypoints[0].getTile(), waypoints[0].getName() + " Company", true, this.Const.World.Spawn.Noble, this.Math.rand(120, 250) * this.getReputationToDifficultyLightMult());
			party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + _faction.getBannerString());
			party.setDescription("Professional soldiers in service to local lords.");
			party.setFootprintType(this.Const.World.FootprintsType.Nobles);
			party.getFlags().set("IsRandomlySpawned", true);
			party.getLoot().Money = this.Math.rand(50, 200);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 5);
			party.getLoot().Ammo = this.Math.rand(0, 30);
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				party.addToInventory("supplies/bread_item");
			}
			else if (r == 2)
			{
				party.addToInventory("supplies/roots_and_berries_item");
			}
			else if (r == 3)
			{
				party.addToInventory("supplies/dried_fruits_item");
			}
			else if (r == 4)
			{
				party.addToInventory("supplies/ground_grains_item");
			}

			local c = party.getController();
			local move1 = this.new("scripts/ai/world/orders/move_order");
			move1.setRoadsOnly(true);
			move1.setDestination(waypoints[1].getTile());
			local wait1 = this.new("scripts/ai/world/orders/wait_order");
			wait1.setTime(20.0);
			local move2 = this.new("scripts/ai/world/orders/move_order");
			move2.setRoadsOnly(true);
			move2.setDestination(waypoints[2].getTile());
			local wait2 = this.new("scripts/ai/world/orders/wait_order");
			wait2.setTime(20.0);
			local move3 = this.new("scripts/ai/world/orders/move_order");
			move3.setRoadsOnly(true);
			move3.setDestination(waypoints[0].getTile());
			local despawn = this.new("scripts/ai/world/orders/despawn_order");
			c.addOrder(move1);
			c.addOrder(wait1);
			c.addOrder(move2);
			c.addOrder(wait2);
			c.addOrder(move3);
			c.addOrder(despawn);
			this.m.Cooldown = this.World.FactionManager.isGreaterEvil() ? 200.0 : 400.0;
			return true;
		}	
	})
});
