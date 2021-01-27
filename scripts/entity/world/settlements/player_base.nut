this.player_base <- this.inherit("scripts/entity/world/settlement", {
	//custom player base settlement type. spawns custom storage building, modified marketplace that allows for both selling of trash and food and for storing items
	m = {},
	function create()
	{
		this.settlement.create();
		this.m.isPlayerBase <- true;
		this.m.Name = "Fortress"
		this.defineName();
		this.m.DraftList = [
			"farmhand_background",
			"farmhand_background",
			"houndmaster_background",
			"mason_background",
			"messenger_background",
			"militia_background",
			"militia_background",
			"miller_background",
			"adventurous_noble_background",
			"bastard_background",
			"deserter_background",
			"deserter_background",
			"retired_soldier_background",
			"retired_soldier_background"
		];
		this.m.UIDescription = "Your stronghold";
		this.m.Description = "Your stronghold";
		this.m.UIBackgroundCenter = "ui/settlements/stronghold_01";
		this.m.UIBackgroundLeft = "ui/settlements/bg_houses_01_left";
		this.m.UIBackgroundRight = "ui/settlements/bg_houses_01_right";
		this.m.UIRampPathway = "ui/settlements/ramp_01_planks";
		this.m.UISprite = "ui/settlement_sprites/stronghold_01.png";
		this.m.Sprite = "world_stronghold_01";
		this.m.Lighting = "world_stronghold_01_light";
		this.m.Rumors = this.Const.Strings.RumorsFarmingSettlement;
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.IsMilitary = true;
		this.m.Size = 1;
		this.m.HousesType = 3;
		this.m.HousesMin = 1;
		this.m.HousesMax = 2;
		this.m.AttachedLocationsMax = 3;
		this.m.LocationType = this.Const.World.LocationType.Settlement;
		this.m.ShopSeed = this.Time.getRealTime() + this.Math.rand();
		this.m.RosterSeed = this.Time.getRealTime() + this.Math.rand();
		this.m.Modifiers = this.new("scripts/entity/world/settlement_modifiers");
		this.m.IsAttackable = false;
		this.m.IsDestructible = false;
		this.m.IsShowingStrength = false;
		this.m.IsScalingDefenders = false;
		this.m.IsShowingLabel = true;
		this.m.VisibilityMult = 2.0;
		this.m.IsVisited = true;
		this.m.Banner = this.World.Assets.getBannerID();
		this.m.IsShowingBanner = true;
		this.m.Buildings.resize(6, null);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/storage_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"), 5);
	}
	
	
	
	function defineName()
	{
		//dynamic name to add distinction for size
		local name_by_size = ["fort", "castle", "stronghold"]
		local company_name = this.World.Assets.getName();
		local final_name = "";
		if (company_name.slice(company_name.len()-1, company_name.len()) == "s")
		{
			company_name = company_name.slice(0, company_name.len()-1);
		}
		final_name += company_name + "'s " + name_by_size[this.m.Size -1];
		this.logDebug("Name is now: " +final_name);
		this.m.Name = final_name;
	}
	function isEnterable()
	{
		return true;
	}
	
	function onEnter()
	{
		//updates buildings, shops, quests
		this.addSituation(this.new("scripts/entity/world/settlements/situations/mod_well_supplied_situation"), 9999);
		this.m.Buildings.resize(6, null);
		this.location.onEnter();
		this.m.CurrentBuilding = null;
		this.updateShop();
		this.Math.seedRandom(this.Time.getRealTime());
		this.updateQuests();
		this.rebuildAttachedLocations()
		//jank way to update sprite
		if (this.m.Buildings[5] != null)
		{
			if (this.m.Buildings[5].m.UIImage.slice(0, 5) != "small")
			{
				this.m.Buildings[5].m.UIImage = "small_" + this.m.Buildings[5].m.UIImage
				this.m.Buildings[5].m.UIImageNight = "small_" + this.m.Buildings[5].m.UIImageNight
			}
		}
		//TEMPORARY
		foreach (faction in this.World.FactionManager.getFactions())
		{
			if(faction && (faction.m.Type == this.Const.FactionType.OrientalCityState || faction.m.Type == this.Const.FactionType.NobleHouse))
			{
				for (local idx = 0; idx < faction.m.Settlements.len(); idx++)
				{
					if (faction.m.Settlements[idx].getName() == this.getName())
					{
						faction.m.Settlements.remove(idx)
						idx--
					}
				}
			}
		}
		this.logInfo(this.m.Factions.len())
		while(this.m.Factions.len() > 1)
		{
			foreach (idx, faction in this.m.Factions)
			{
				local fac = this.World.FactionManager.getFaction(faction)
				if( fac && fac.m.Type != this.Const.FactionType.Player)
				{
					this.m.Factions.remove(idx)
				}
			}
		}
		//END TEMPORARY
		return true;
	}
	
	function isIn (_key)
	{
		if (_key in this.m){return true}
		local delegate = this.getdelegate()
		while (delegate != null)
		{
			if (_key in delegate.m){return true}
			else {delegate = delegate.getdelegate()}
		}
		return false;
	}
	
	function onLeave()
	{
	}
	function updateQuests()
	{
		//adds/removes quests when entering town. Takes care of conflicing quests.
		local current_buildings = 0;
		local current_locations = 0;
		local free_building_slots = this.getSize() + 3
		
		foreach (building in this.m.Buildings){
			if (building != null){
				current_buildings++
			}
		}
		foreach (location in this.m.AttachedLocations){
			if (location != null){
				current_locations++
			}
		}
		
		local fac = this.World.FactionManager.getFaction(this.m.Factions[0]);
		local contracts = this.World.FactionManager.getFaction(this.m.Factions[0]).getContracts();
		local add_building = null;
		local remove_building = null;
		local add_location = null;
		local remove_location = null;
		local build_road = null;
		local remove_base = null;
		local find_waterskin = null;
		local free_mercenaries = null;
		local special_actions = null;
		local find_trainer = null;
		local send_gifts = null;
		
		
		//vars for every quest, allows to plug it in later to remove it
		foreach(contract in contracts)
		{
			if (contract.m.Type == "contract.add_playerbase_building_contract")
			{
				add_building = contract;
			}
			if (contract.m.Type == "contract.remove_playerbase_building_contract")
			{
				remove_building = contract;
			}
			if (contract.m.Type == "contract.add_playerbase_location_contract")
			{
				add_location = contract;
			}
			if (contract.m.Type == "contract.remove_playerbase_location_contract")
			{
				remove_location = null;
			}
			if (contract.m.Type == "contract.build_road_contract")
			{
				build_road = contract;
			}
			if (contract.m.Type == "contract.remove_playerbase_contract")
			{
				remove_base = contract;
			}
			if (contract.m.Type == "contract.find_waterskin_recipe_contract")
			{
				find_waterskin = contract;
			}
			if (contract.m.Type == "contract.free_mercenaries_contract")
			{
				free_mercenaries = contract;
			}
			if (contract.m.Type == "contract.special_actions_contract")
			{
				special_actions = contract;
			}
			if (contract.m.Type == "contract.free_trainer_contract")
			{
				find_trainer = contract;
			}
		}	
		

		if (current_buildings < free_building_slots)
		{

			if (remove_building){this.World.Contracts.removeContract(remove_building)}
			if (!add_building)
			{
				local contract = this.new("scripts/contracts/contracts/add_playerbase_building_contract");
				contract.setEmployerID(fac.getRandomCharacter().getID());
				contract.setFaction(fac.getID())
				this.World.Contracts.addContract(contract);
			}
		}
		else
		{
			if (add_building){this.World.Contracts.removeContract(add_building)}
			if (!remove_building)
			{
				local contract = this.new("scripts/contracts/contracts/remove_playerbase_building_contract");
				contract.setEmployerID(fac.getRandomCharacter().getID());
				contract.setFaction(fac.getID())
				this.World.Contracts.addContract(contract);
			}
		}
		
		if (current_locations < this.m.AttachedLocationsMax && this.m.Size > 1)
		{

			if (remove_location){this.World.Contracts.removeContract(remove_location)}
			if (!add_location)
			{
				local contract = this.new("scripts/contracts/contracts/add_playerbase_location_contract");
				contract.setEmployerID(fac.getRandomCharacter().getID());
				contract.setFaction(fac.getID())
				this.World.Contracts.addContract(contract);
			}
		}
		if (this.m.Size >1)
		{
			if (!build_road && !this.m.Flags.get("AllRoadsBuilt"))
			{
				local contract = this.new("scripts/contracts/contracts/build_road_contract");
				contract.setEmployerID(fac.getRandomCharacter().getID());
				contract.setFaction(fac.getID())
				this.World.Contracts.addContract(contract);
			}
		}
		else { if (remove_base){this.World.Contracts.removeContract(remove_base)}}
		
		if (this.m.Size == 3 && !find_waterskin && !this.m.Flags.get("Waterskin"))
		{
			local contract = this.new("scripts/contracts/contracts/find_waterskin_recipe_contract");
			contract.setEmployerID(fac.getRandomCharacter().getID());
			contract.setFaction(fac.getID())
			this.World.Contracts.addContract(contract);
		}
		
		if (this.m.Size == 3 && !free_mercenaries && !this.m.Flags.get("Mercenaries"))
		{
			local contract = this.new("scripts/contracts/contracts/free_mercenaries_contract");
			contract.setEmployerID(fac.getRandomCharacter().getID());
			contract.setFaction(fac.getID())
			this.World.Contracts.addContract(contract);
		}
		if (this.m.Size == 3 && !find_trainer && !this.m.Flags.get("Teacher"))
		{
			local contract = this.new("scripts/contracts/contracts/free_trainer_contract");
			contract.setEmployerID(fac.getRandomCharacter().getID());
			contract.setFaction(fac.getID())
			this.World.Contracts.addContract(contract);
		}
		
		if (!special_actions) //FIX THIS
		{
			local contract = this.new("scripts/contracts/contracts/special_actions_contract");
			contract.setEmployerID(fac.getRandomCharacter().getID());
			contract.setFaction(fac.getID())
			this.World.Contracts.addContract(contract);
		}
	}
	
	function clearContracts()
	{
		local contracts = this.World.FactionManager.getFaction(this.m.Factions[0]).getContracts();
		foreach (contract in contracts)
		{
			this.World.Contracts.removeContract(contract)
		}
	}
	
	function updateShop( _force = false )
	{
		//modified vanilla function to allow storage_building to generate free items.
		if (this.m.LastShopUpdate == 0.0){
			this.m.LastShopUpdate = this.Time.getVirtualTimeF() - 3 * this.World.getTime().SecondsPerDay
		}
		local daysPassed = (this.Time.getVirtualTimeF() - this.m.LastShopUpdate) / this.World.getTime().SecondsPerDay;

		if (!_force && this.m.LastShopUpdate != 0 && daysPassed < 3)
		{
			this.updateImportedProduce();
			return;
		}

		if (this.m.ShopSeed != 0)
		{
			this.Math.seedRandom(this.m.ShopSeed);
		}

		this.m.ShopSeed = this.Math.floor(this.Time.getRealTime() + this.Math.rand());
		this.m.LastShopUpdate = this.Time.getVirtualTimeF();

		foreach( building in this.m.Buildings )
		{
			if (building != null)
			{
				if(building.m.ID == "building.storage_building"){
					building.onUpdateShopList(daysPassed);
				}
				else{
					building.onUpdateShopList();
				}

				if (building.getStash() != null)
				{
					foreach( s in this.m.Situations )
					{
						s.onUpdateShop(building.getStash());
					}
				}
			}
		}

		this.updateImportedProduce();
	}
	
	
	function updateTown(){
		//updates town after upgrading and loading the game. Necessary to update the sprites, names etc.
		local normalSprites = ["world_stronghold_01", "world_stronghold_02", "world_stronghold_03"]
		local barbarianSprites = ["world_wildmen_01", "world_wildmen_02", "world_wildmen_03"]
		local barbarianSpritesSnow = ["world_wildmen_01_snow", "world_wildmen_02_snow", "world_wildmen_03_snow"]
		local nomadSprites = ["world_nomad_camp_02", "world_nomad_camp_03", "world_nomad_camp_04"]
		local sprites;
		sprites = normalSprites
		this.m.troopSprites <- "figure_mercenary_01";
		if (this.m.Flags.get("BarbarianSprites"))
		{
			local isOnSnow = this.getTile().Type == this.Const.World.TerrainType.Snow;
			for( local i = 0; i != 6; i = ++i )
			{
				if (this.getTile().hasNextTile(i) && this.getTile().getNextTile(i).Type == this.Const.World.TerrainType.Snow)
				{
					isOnSnow = true;
					break;
				}
			}
			isOnSnow ? sprites = barbarianSpritesSnow : sprites = barbarianSprites
			this.m.troopSprites <- "figure_wildman_01";
		}
		else if (this.m.Flags.get("NomadSprites"))
		{
			this.m.troopSprites <- "figure_nomad_03";
			sprites = nomadSprites
		}
		if (this.getSize() == 1){
			this.m.AttachedLocationsMax = 3
			this.m.UIBackgroundCenter = "ui/settlements/stronghold_01";
			this.m.Sprite = sprites[0]
			this.m.Lighting = "world_stronghold_01_light";
			this.m.UIDescription = "Your fort";
			this.m.Description = "Your fort";

		}
		else if (this.getSize() == 2){
			this.m.AttachedLocationsMax = 5
			this.m.UIBackgroundCenter = "ui/settlements/stronghold_02";
			this.m.Sprite = sprites[1]
			this.m.Lighting = "world_stronghold_02_light";
			this.m.UIDescription = "Your castle";
			this.m.Description = "Your castle";

		}
		else{
			this.m.AttachedLocationsMax = 9
			this.m.UIBackgroundCenter = "ui/settlements/stronghold_03";
			this.m.Sprite = sprites[2]
			this.m.Lighting = "world_stronghold_03_light";
			this.m.UIDescription = "Your stronghold";
			this.m.Description = "Your stronghold";

		}
		this.addSituation(this.new("scripts/entity/world/settlements/situations/mod_well_supplied_situation"), 9999);
		//need to update building size since it's changed to 9 during serialisation
		this.m.Buildings.resize(6, null);
		this.getSprite("body").setBrush(this.m.Sprite);
		if (this.m.Flags.get("BarbarianSprites")||this.m.Flags.get("NomadSprites")){
			this.getSprite("body").Scale = 1.25;
		}
		this.getLabel("name").Text = this.getName();
		this.getLabel("name").Visible = true;
		local light = this.getSprite("lighting");
		this.setSpriteColorization("lighting", false);
		if (this.m.Lighting != "");
		{
			light.setBrush(this.m.Lighting);
		}
		light.IgnoreAmbientColor = true;
		light.Alpha = 0;
		
	}
	
	
	
	function addBuilding( _building, _slot = null )
	{
		//modded vanilla function
		_building.setSettlement(this);

		if (_slot != null)
		{
			this.m.Buildings[_slot] = _building;
		}
		else
		{
			local candidates = [];

			for( local i = 0; i < this.m.Buildings.len(); i = ++i )
			{
				if (this.m.Buildings[i] == null)
				{
					this.m.Buildings[i] = _building;
					break;
				}
			}
		}

	}
	
	function onBuild()
	{

	}

	
	function updateRoster( _force = false )
	{
	}
	
	function getPriceMult()
	{
		return 1.3;
	}

	function hasContract( _id )
	{
		return true;
	}
	
	function addImportedProduce( _p )
	{
		//bigger caravan gainz
		if (this.m.ProduceImported.len() >= 9)
		{
			this.m.ProduceImported.remove(0);
		}

		this.m.ProduceImported.push(_p);
	}
	
	function buildAttachedLocation( _num, _script, _terrain, _nearbyTerrain, _additionalDistance = 0, _mustBeNearRoad = false, _clearTile = true )
	{
		//vanilla has a small chance to spawn the location dead, removed that
		_num = this.Math.min(_num, this.m.AttachedLocationsMax - this.m.AttachedLocations.len());

		if (_num <= 0)
		{
			return;
		}

		local tries = 0;
		local myTile = this.getTile();

		while (_num > 0 && tries++ < 1000)
		{
			local x = this.Math.rand(myTile.SquareCoords.X - 2 - _additionalDistance, myTile.SquareCoords.X + 2 + _additionalDistance);
			local y = this.Math.rand(myTile.SquareCoords.Y - 2 - _additionalDistance, myTile.SquareCoords.Y + 2 + _additionalDistance);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			local tile = this.World.getTileSquare(x, y);

			if (tile.IsOccupied)
			{
				continue;
			}

			if (_mustBeNearRoad && tile.HasRoad)
			{
				continue;
			}
			
			if (tile.HasRoad)
			{
				continue;
			}

			if (tile.getDistanceTo(myTile) == 1 && _additionalDistance >= 0 || tile.getDistanceTo(myTile) < _additionalDistance)
			{
				continue;
			}

			local terrainFits = false;

			foreach( t in _terrain )
			{
				if (t == tile.Type)
				{
					if (_nearbyTerrain.len() == 0 && !_mustBeNearRoad)
					{
						terrainFits = true;
					}
					else
					{
						for( local i = 0; i < 6; i = ++i )
						{
							if (!tile.hasNextTile(i))
							{
							}
							else
							{
								local next = tile.getNextTile(i);

								if (_mustBeNearRoad && !next.HasRoad)
								{
								}
								else
								{
									if (_nearbyTerrain.len() != 0)
									{
										foreach( n in _nearbyTerrain )
										{
											if (next.Type == n)
											{
												terrainFits = true;
												break;
											}
										}
									}
									else
									{
										terrainFits = true;
									}

									if (terrainFits)
									{
										break;
									}
								}
							}
						}
					}

					if (terrainFits)
					{
						break;
					}
				}
			}

			if (!terrainFits)
			{
				continue;
			}

			if (tile.getDistanceTo(myTile) > 2)
			{
				local navSettings = this.World.getNavigator().createSettings();
				navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
				local path = this.World.getNavigator().findPath(myTile, tile, navSettings, 0);

				if (path.isEmpty())
				{
					continue;
				}
			}

			if (_clearTile)
			{
				tile.clearAllBut(this.Const.World.DetailType.Shore);
			}
			else
			{
				tile.clear(this.Const.World.DetailType.NotCompatibleWithRoad);
			}

			local entity = this.World.spawnLocation(_script, tile.Coords);
			entity.setSettlement(this);

			if (entity.onBuild())
			{
				this.m.AttachedLocations.push(entity);
				_num = --_num;
				tries = 0;
				entity.setActive(true);
			}
			else
			{
				entity.die();
				continue;
			}
		}

		this.updateProduce();
	}
	
	function buildHouses()
	{
		//add houses while upgrading
		local tile = this.getTile();
		local candidates = [];
		local poorCandidates = [];

		for( local i = 0; i < 6; i = ++i )
		{
			if (!tile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = tile.getNextTile(i);

				if (nextTile.IsOccupied)
				{
				}
				else if (nextTile.Type == this.Const.World.TerrainType.Oasis || nextTile.Type == this.Const.World.TerrainType.Plains || nextTile.Type == this.Const.World.TerrainType.Tundra || nextTile.Type == this.Const.World.TerrainType.Steppe || nextTile.Type == this.Const.World.TerrainType.Snow)
				{
					candidates.push(nextTile);
				}
				else if (nextTile.Type == this.Const.World.TerrainType.Desert || nextTile.Type == this.Const.World.TerrainType.Hills || nextTile.Type == this.Const.World.TerrainType.Forest || nextTile.Type == this.Const.World.TerrainType.SnowyForest || nextTile.Type == this.Const.World.TerrainType.LeaveForest || nextTile.Type == this.Const.World.TerrainType.AutumnForest || nextTile.Type == this.Const.World.TerrainType.Swamp)
				{
					poorCandidates.push(nextTile);
				}
			}
		}

		local houses = 2

		for( local c; houses != 0; houses = --houses )
		{
			local c = candidates.len() != 0 ? candidates : poorCandidates;
			if (c.len() == 0)
			{
				break;
			}
			local i = this.Math.rand(0, c.len() - 1);
			local v = this.Math.rand(1, 2);
			this.m.HousesTiles.push({
				X = c[i].SquareCoords.X,
				Y = c[i].SquareCoords.Y,
				V = v
			});
			c[i].clear();
			c[i].IsOccupied = true;
			local d;
			if (this.m.Flags.get("BarbarianSprites"))
			{
				local isOnSnow = this.getTile().Type == this.Const.World.TerrainType.Snow;
				for( local i = 0; i != 6; i = ++i )
				{
					if (this.getTile().hasNextTile(i) && this.getTile().getNextTile(i).Type == this.Const.World.TerrainType.Snow)
					{
						isOnSnow = true;
						break;
					}
				}
				local detail = isOnSnow? "world_wildmen_01_snow":"world_wildmen_01"
				d = c[i].spawnDetail(detail, this.Const.World.ZLevel.Object - 3, this.Const.World.DetailType.Houses);
			}
			else if (this.m.Flags.get("NomadSprites"))
			{
				d = c[i].spawnDetail("world_nomad_camp_02", this.Const.World.ZLevel.Object - 3, this.Const.World.DetailType.Houses);
			}
			else
			{
				d = c[i].spawnDetail("world_houses_0" + this.m.HousesType + "_0" + v, this.Const.World.ZLevel.Object - 3, this.Const.World.DetailType.Houses);
			}
			d.Scale = 0.85;
			c.remove(i);
		}
	}
	
	function updateImportedProduce()
	{
		//needs to select storage building instead of marketplace
		if (this.m.ProduceImported.len() == 0)
		{
			return;
		}
		local marketplace;

		foreach( building in this.m.Buildings )
		{
			if (building != null && building.getID() == "building.storage_building")
			{
				marketplace = building;
				break;
			}
		}
		if (marketplace == null)
		{
			return;
		}
		foreach( p in this.m.ProduceImported )
		{
			local item = this.new("scripts/items/" + p);
			marketplace.getStash().add(item);
		}

		marketplace.getStash().sort();
		this.m.ProduceImported = [];
	}
	
	function onAttachedLocationsChanged()
	{
		foreach( a in this.m.AttachedLocations )
		{
			if (!a.isActive())
			{
				if (!this.m.Flags.get(a.m.ID))
				{
					this.m.Flags.set(a.m.ID, this.Time.getVirtualTimeF())
				}
			}
		}

	}
	
	function rebuildAttachedLocations()
	{
		foreach( a in this.m.AttachedLocations )
		{
			if (!a.isActive())
			{
				if (this.m.Flags.get(a.m.ID) && ((this.m.Flags.get(a.m.ID) + 7 * this.World.getTime().SecondsPerDay) <  this.Time.getVirtualTimeF()))
				{
					a.setActive(true);
					this.m.Flags.remove(a.m.ID)
				}
			}
		}
	}
	
	function getRoadCost(_settlement)
	{
		//display cost before building
		local roadCost = [
			0,
			0,
			10,
			50,
			60,
			40,
			40,
			40,
			40,
			0,
			1,
			50,
			30,
			30,
			10,
			10,
			0,
			10,
			10
		];
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = roadCost;
		navSettings.RoadMult = 0.15;
		navSettings.StopAtRoad = false;
		local closest = _settlement.getTile();

		if (closest != null)
		{
			local path = this.World.getNavigator().findPath(this.getTile(), closest, navSettings, 0);

			if (path.isEmpty())
			{
				return false;
			}

			local roadTiles = [];
			roadTiles.push(this.getTile());

			while (path.getSize() >= 1)
			{
				local tile = this.World.getTile(path.getCurrent());
				roadTiles.push(tile);
				path.pop();
			}
			
			local countroads = 0;
			foreach(tile in roadTiles){
				if (tile.HasRoad){
					countroads++
				}
			
			}
			return roadTiles.len() - countroads
		}
	}
	
	function buildRoad(_settlement)
	{
		//actually build the road
		local roadCost = [
			0,
			0,
			10,
			50,
			80,
			40,
			40,
			40,
			40,
			0,
			1,
			50,
			30,
			30,
			10,
			10,
			0,
			10
		];
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = roadCost;
		navSettings.RoadMult = 0.15;
		navSettings.StopAtRoad = false;
		local closest = _settlement.getTile();
		
		if (closest != null)
		{
			local path = this.World.getNavigator().findPath(this.getTile(), closest, navSettings, 0);

			if (path.isEmpty())
			{
				return false;
			}

			local roadTiles = [];
			roadTiles.push(this.getTile());

			while (path.getSize() >= 1)
			{
				local tile = this.World.getTile(path.getCurrent());
				roadTiles.push(tile);
				path.pop();
			}
			
			local countroads = 0;
			foreach(tile in roadTiles){
				if (tile.HasRoad){
					countroads++
				}
			
			}


			local prevTile;
			foreach( i, tile in roadTiles )
			{
				local dirA = prevTile != null ? tile.getDirectionTo(prevTile) : 0;
				local dirB = i < roadTiles.len() - 1 ? tile.getDirectionTo(roadTiles[i + 1]) : 0;

				if ((tile.RoadDirections & this.Const.DirectionBit[dirA]) == 0 || (tile.RoadDirections & this.Const.DirectionBit[dirB]) == 0)
				{
					tile.RoadDirections = tile.RoadDirections | this.Const.DirectionBit[dirA] | this.Const.DirectionBit[dirB];
				}

				prevTile = tile;
			} 
			foreach(tile in roadTiles)
			{
				tile.spawnDetail(this.Const.World.RoadBrushes.get(tile.RoadDirections), this.Const.World.ZLevel.Road, this.Const.World.DetailType.Road, false);
			}
			
			//add road connections to each other
			this.updateProperties()
			local connectedSettlements = []
			foreach (settlementID in this.m.ConnectedToByRoads)
			{
				local settlement = null
				foreach (settlement in this.World.EntityManager.getSettlements())
				{
					if(settlement.getID() == settlementID)
					{
						settlement.m.ConnectedToByRoads.push(this.getID())
					}
				}
			}
			return true;
			
		}
		else{return false}
	}
	
	//changed coastal, might be whack as deep sea is not necessarily accessible
	function updateProperties()
	{
		local myTile = this.getTile();
		local mapSize = this.World.getMapSize();
		this.m.ConnectedTo = [];
		this.m.ConnectedToByRoads = [];
		local settlements = this.World.EntityManager.getSettlements();
		local navSettings = this.World.getNavigator().createSettings();

		foreach( s in settlements )
		{
			if (s.getID() == this.getID())
			{
				continue;
			}

			navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
			local path = this.World.getNavigator().findPath(myTile, s.getTile(), navSettings, 0);

			if (!path.isEmpty())
			{
				this.m.ConnectedTo.push(s.getID());
			}
		}

		if (!this.isIsolated())
		{
			foreach( s in settlements )
			{
				if (s.getID() == this.getID())
				{
					continue;
				}

				navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
				navSettings.RoadOnly = true;
				local path = this.World.getNavigator().findPath(myTile, s.getTile(), navSettings, 0);

				if (!path.isEmpty())
				{
					this.m.ConnectedToByRoads.push(s.getID());
				}
			}
		}

		this.m.IsCoastal = this.checkForCoastal()

		if (this.m.IsCoastal)
		{
			if (this.m.DeepOceanTile == null)
			{
				this.m.DeepOceanTile = this.findAccessibleOceanEdge(0, mapSize.X, 0, 1);
			}

			if (this.m.DeepOceanTile == null)
			{
				this.m.DeepOceanTile = this.findAccessibleOceanEdge(0, 1, 0, mapSize.Y);
			}

			if (this.m.DeepOceanTile == null)
			{
				this.m.DeepOceanTile = this.findAccessibleOceanEdge(mapSize.X - 1, mapSize.X, 0, mapSize.Y);
			}

			if (this.m.DeepOceanTile == null)
			{
				this.m.DeepOceanTile = this.findAccessibleOceanEdge(0, mapSize.X, mapSize.Y - 1, mapSize.Y);
			}
		}
	}
	
	function checkForCoastal()
	{
		local isCoastal = false;
		local recursiveCheck;
		recursiveCheck = function (_tile, _index = 0)
		{	
			if(_tile.Type == this.Const.World.TerrainType.Ocean || _tile.Type == this.Const.World.TerrainType.Shore){
				isCoastal = true;
				return;
			}
			if(_index == 2) return 
			for( local i = 0; i < 6; i = ++i )
			{
				if (!_tile.hasNextTile(i))
				{
				}
				else
				{
					local next = _tile.getNextTile(i);
					if(next.Type == this.Const.World.TerrainType.Ocean || next.Type == this.Const.World.TerrainType.Shore){
						isCoastal = true;
						return;
					}
					recursiveCheck(next, _index+1)
				}
			}
		}
		recursiveCheck(this.getPlayerBase().getTile())
		return isCoastal
	}
	
	//disables lights when alt location
	function onUpdate()
	{
		local lighting = this.getSprite("lighting");

		if (!this.m.IsActive)
		{
			lighting.Alpha = 0;
			return;
		}

		if (lighting.IsFadingDone)
		{
			if (lighting.Alpha == 0 && this.World.getTime().TimeOfDay >= 4 && this.World.getTime().TimeOfDay <= 7)
			{
				local insideScreen = this.World.getCamera().isInsideScreen(this.getPos(), 0);

				if (insideScreen)
				{
					lighting.fadeIn(5000);
				}
				else
				{
					lighting.Alpha = 255;
				}

				foreach( h in this.m.HousesTiles )
				{
					//disable lights on houses
					if (!this.m.Flags.get("BarbarianSprites") && !this.m.Flags.get("NomadSprites"))
					{
						local tile = this.World.getTileSquare(h.X, h.Y);
						local d = tile.spawnDetail("world_houses_0" + this.m.HousesType + "_0" + h.V + "_light", this.Const.World.ZLevel.Object - 4, this.Const.World.DetailType.Lighting, false, insideScreen);
						d.IgnoreAmbientColor = true;
						d.Scale = 0.85;
					}
				}
			}
			else if (lighting.Alpha != 0 && this.World.getTime().TimeOfDay >= 0 && this.World.getTime().TimeOfDay <= 3)
			{
				local insideScreen = this.World.getCamera().isInsideScreen(this.getPos(), 0);

				if (insideScreen)
				{
					lighting.fadeOut(4000);
				}
				else
				{
					lighting.Alpha = 0;
				}

				foreach( h in this.m.HousesTiles )
				{
					local tile = this.World.getTileSquare(h.X, h.Y);

					if (insideScreen)
					{
						tile.clearAndFade(this.Const.World.DetailType.Lighting);
					}
					else
					{
						tile.clear(this.Const.World.DetailType.Lighting);
					}
				}
			}
		}
	}
	
	
	function onSerialize( _out )
	{
		this.settlement.onSerialize(_out);
		_out.writeU8(this.m.Size)
		
	}
	
	function onDeserialize( _in )
	{
		this.settlement.onDeserialize(_in);
		this.m.Size  = _in.readU8();
		this.updateTown()
	}
	

	

});

