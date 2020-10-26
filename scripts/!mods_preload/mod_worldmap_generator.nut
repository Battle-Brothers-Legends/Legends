::mods_hookNewObject("mapgen/templates/world/worldmap_generator", function(o) {
    o.isWorldAcceptable = function (_rect)
	{
		local ocean = 0;
		local nonOcean = 0;

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
					ocean = ++ocean;
				}
				else
				{
					nonOcean = ++nonOcean;
				}
			}
		}
		local ratio = nonOcean * 1.0 / (ocean * 1.0);
		this.logInfo("Land Ocean ratio" + ratio + " >= " +  this.Const.World.Settings.MinLandToWaterRatio + " :: Land :" + nonOcean + " Ocean:" + ocean);
		return nonOcean * 1.0 / (ocean * 1.0) >= this.Const.World.Settings.MinLandToWaterRatio;
	}

	o.isDesertAcceptable = function ( _rect )
	{
		local desert = 0;

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Desert || tile.Type == this.Const.World.TerrainType.Oasis || tile.TacticalType == this.Const.World.TerrainTacticalType.DesertHills)
				{
					desert = ++desert;
				}
			}
		}

		this.logInfo("Desert tiles " + desert + " >= " +  this.Const.World.Settings.MinDesertTiles);
		return desert >= this.Const.World.Settings.MinDesertTiles;
	}

    // o.fill = function ( _rect, _properties)
	// {
	// 	this.Const.World.Buildings.reset();
	// 	this.m.Tiles = [];
	// 	this.m.Tiles.resize(this.Const.World.TerrainType.COUNT);

	// 	for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
	// 	{
	// 		if (this.Const.World.TerrainScript[i].len() != 0)
	// 		{
	// 			this.m.Tiles[i] = this.MapGen.get(this.Const.World.TerrainScript[i]);
	// 		}
	// 	}

	// 	this.__ping();

	// 	while (true)
	// 	{
	// 		this.buildLandAndSea(_rect);
	// 		this.__ping();

	// 		if (!this.isWorldAcceptable(_rect))
	// 		{
	// 			this.logInfo("World rejected. Creating new one...");
	// 			this.clearWorld(_rect);
	// 			continue;
	// 		}

	// 		this.__ping();
	// 		this.buildElevation(_rect);
	// 		this.__ping();
	// 		this.__ping();
	// 		this.defragmentTerrain(_rect);
	// 		this.__ping();

	// 		if (this.Const.DLC.Desert && !this.isDesertAcceptable(_rect))
	// 		{
	// 			this.logInfo("World rejected. Creating new one...");
	// 			this.clearWorld(_rect);
	// 			continue;
	// 		}

	// 		this.logInfo("World accepted.");
	// 		break;
	// 	}

	// 	this.__ping();
	// 	this.removeStraits(_rect);
	// 	this.__ping();
	// 	this.refineTerrain(_rect, null);
	// 	this.__ping();
	// 	this.buildSettlements(_rect, _properties);
	// 	this.__ping();
	// 	this.buildRoads(_rect, null);
	// 	this.__ping();
	// 	this.refineSettlements(_rect, null);
	// 	this.__ping();
	// 	this.guaranteeAllBuildingsInSettlements();
	// 	this.__ping();
	// 	this.buildAdditionalRoads(_rect, null);
	// 	this.__ping();
	// 	this.buildRoadSprites(_rect, null);
	// 	this.__ping();
	// 	this.buildLabels(_rect);
	// 	this.__ping();

	// 	if (this.Const.DLC.Desert)
	// 	{
	// 		this.buildAbandonedFortresses(_rect);
	// 	}

	// 	this.__ping();
	// }
	// {
	// 	this.Const.World.Buildings.reset();
	// 	this.m.Tiles = [];
	// 	this.m.Tiles.resize(this.Const.World.TerrainType.COUNT);

	// 	for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
	// 	{
	// 		if (this.Const.World.TerrainScript[i].len() != 0)
	// 		{
	// 			this.m.Tiles[i] = this.MapGen.get(this.Const.World.TerrainScript[i]);
	// 		}
	// 	}

	// 	this.__ping();
	// 	this.LoadingScreen.updateProgress("Building Land and Sea ...");
	// 	this.buildLandAndSea(_rect);
	// 	this.__ping();
    //     if (!this.isWorldAcceptable(_rect))
    //     {
    //         this.clearWorld(_rect);
    //         return false;
    //     }

	// 	this.__ping();
	// 	this.LoadingScreen.updateProgress("Building Terrain ...");
	// 	this.buildElevation(_rect);
	// 	this.__ping();

	// 	this.__ping();
	// 	this.defragmentTerrain(_rect);
	// 	this.__ping();

	// 	if (this.Const.DLC.Desert && !this.isDesertAcceptable(_rect))
	// 	{
	// 		//this.logInfo("World rejected. Creating new one...");
	// 		this.clearWorld(_rect);
	// 		return false;
	// 	}

	// 	this.removeStraits(_rect);
	// 	this.__ping();
	// 	this.refineTerrain(_rect, _properties);
	// 	this.__ping();
    //     if (!this.buildSettlements(_rect, _properties))
    //     {
	// 		this.clearWorld(_rect);
	// 		//this.World.clearScene();
    //         return false;
    //     }
	// 	this.__ping();
	// 	this.buildRoads(_rect, _properties);
	// 	this.__ping();
	// 	this.refineSettlements(_rect, _properties);
	// 	this.__ping();
	// 	this.guaranteeAllBuildingsInSettlements();
	// 	this.__ping();
	// 	if ( _properties.AllTradeLocations )
	// 	{
	// 		this.guaranteeAllLocations(_rect, _properties);
	// 		this.__ping();
	// 	}
	// 	this.buildAdditionalRoads(_rect, _properties);
	// 	this.__ping();
	// 	this.buildRoadSprites(_rect, _properties);
	// 	this.__ping();
	// 	this.buildLabels(_rect);
	// 	this.__ping();
	// 	if (this.Const.DLC.Desert)
	// 	{
	// 		this.buildAbandonedFortresses(_rect);
	// 	}
	// 	this.__ping();

    //     return true;
	// }

	o.refineSettlements = function ( _rect )
	{
		local _properties = this.World.State.m.CampaignSettings;

		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			s.updateProperties();
			s.build(_properties);
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				foreach( s in settlements )
				{
					local d = s.getTile().getDistanceTo(tile);

					if (d > 6)
					{
						continue;
					}

					tile.HeatFromSettlements = tile.HeatFromSettlements + (6 - d);
				}
			}
		}
	}

	o.addSettlement <- function (_rect, isLeft, settlementList, settlementSize, settlementTiles, additionalSpace, ignoreSide, fringe)
	{
		local tries = 0;

		while (tries++ < 3000)
		{
			local x;
			local y;

			if(!fringe) 
			{
				if (!ignoreSide)
				{
					if (isLeft)
					{
						x = this.Math.rand(5, _rect.W * 0.6);
					}
					else
					{
						x = this.Math.rand(_rect.W * 0.4, _rect.W - 6);
					}
				}
				else
				{
					x = this.Math.rand(5, _rect.W - 6);
				}
				y = this.Math.rand(_rect.H * 0.2, _rect.H * 0.95);
			}
			else {
				if (isLeft)
				{
					x = this.Math.rand(_rect.W * 0.60, _rect.W * 0.9);
				}
				else
				{
					x = this.Math.rand(_rect.W * 0.1, _rect.W * 0.4);
				}
				y = this.Math.rand(5, _rect.H * 0.95);
			}
			

			
			local tile = this.World.getTileSquare(x, y);

			if (settlementTiles.find(tile.ID) != null)
			{
				continue;
			}

			local next = false;
			local distance = 12 + additionalSpace;
			// if (tries > 3000) {
			// 	distance -= 4;
			// }
			// if (tries > 6000) {
			// 	distance -= 8;
			// }

			foreach( settlement in settlementTiles )
			{
				if (tile.getDistanceTo(settlement) < distance)
				{
					next = true;
					break;
				}
			}

			if (next)
			{
				continue;
			}

			local terrain = this.getTerrainInRegion(tile);

			if (terrain.Adjacent[this.Const.World.TerrainType.Ocean] >= 3 || terrain.Adjacent[this.Const.World.TerrainType.Shore] >= 3)
			{
				continue;
			}

			local candidates = [];

			foreach( settlement in settlementList )
			{
				if (settlement.isSuitable(terrain))
				{
					candidates.push(settlement);
				}
			}

			if (candidates.len() == 0)
			{
				continue;
			}

			local type = candidates[this.Math.rand(0, candidates.len() - 1)];

			if ((terrain.Region[this.Const.World.TerrainType.Ocean] >= 3 || terrain.Region[this.Const.World.TerrainType.Shore] >= 3) && !("IsCoastal" in type) && !("IsFlexible" in type))
			{
				continue;
			}

			if (!("IsCoastal" in type))
			{
				local skip = settlementTiles.len() != 0;
				local navSettings = this.World.getNavigator().createSettings();

				for( local i = settlementTiles.len() - 1; i >= 0; i = --i )
				{
					local settlement = settlementTiles[i];
					navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
					local path = this.World.getNavigator().findPath(tile, settlement, navSettings, 0);

					if (!path.isEmpty())
					{
						skip = false;
						break;
					}
				}

				if (skip)
				{
					continue;
				}
			}
			else if (settlementTiles.len() >= 1 && tries < 500)
			{
				local hasConnection = false;

				for( local i = settlementTiles.len() - 1; i >= 0; i = --i )
				{
					local settlement = settlementTiles[i];
					local navSettings = this.World.getNavigator().createSettings();
					navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
					local path = this.World.getNavigator().findPath(tile, settlement, navSettings, 0);

					if (!path.isEmpty())
					{
						hasConnection = true;
						break;
					}
				}

				if (!hasConnection)
				{
					continue;
				}
			}

			tile.clear();
			local entity = this.World.spawnLocation(type.Script, tile.Coords);
			entity.setSize(settlementSize);
			entity.setFringe(fringe);
			settlementTiles.push(tile);
			return settlementTiles;
		}
		return settlementTiles;
	}

    o.buildSettlements = function ( _rect )
	{

		local _properties = this.World.State.m.CampaignSettings;
		this.LoadingScreen.updateProgress("Building Settlements ...");
		this.logInfo("Building settlements...");
		local isLeft = this.Math.rand(0, 1);
		local settlementTiles = [];

		foreach( list in this.Const.World.Settlements.LegendsWorldMaster )
		{
			local num = Math.ceil(_properties.NumSettlements * list.Ratio);
			//Add at least one of each

			local additionalSpace = 0;
			if ("AdditionalSpace" in list)
			{
				additionalSpace = list.AdditionalSpace;
			}
			local fringe = false;
			if ("Fringe" in list)
			{
				fringe = list.Fringe;
			}

			foreach (s in list.Sizes)
			{
				for (local i = 0; i < s.MinAmount; i = ++i)
				{
					settlementTiles = this.addSettlement(_rect, isLeft, list.Types, s.Size, settlementTiles, additionalSpace, "IgnoreSide" in list, fringe);
					num = --num;
				}
			}

			while (num > 0)
			{
				local r = this.Math.rand(1, 10);
				local total = 0;
				foreach (s in list.Sizes)
				{
					total += s.Ratio;
					if (r > total)
					{
						continue;
					}
					settlementTiles = this.addSettlement(_rect, isLeft, list.Types, s.Size, settlementTiles, additionalSpace, "IgnoreSide" in list, fringe);
					break;
				}
				num = --num;
			}
		}

		this.logInfo("Created " + settlementTiles.len() + " settlements.");
		return settlementTiles.len() >= 19;
	}

	o.buildAdditionalRoads = function( _rect, _properties )
	{
		this.logInfo("Building additional roads...");
		local allSettlements = this.World.EntityManager.getSettlements();
		local settlements = [];
		foreach (s in allSettlements) {
			if(!s.isFringe()) {
				settlements.push(s);
			}
		}
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
		navSettings.RoadMult = 0.25;
		navSettings.StopAtRoad = false;

		for( local i = 0; i != settlements.len(); i = ++i )
		{
			local targets = [];
			local settlementTile = settlements[i].getTile();

			foreach( a in settlements[i].getAttachedLocations() )
			{
				if (!a.isConnected())
				{
					continue;
				}

				local tile = a.getTile();

				if (!tile.HasRoad)
				{
					targets.push(tile);
				}
			}

			foreach( locTile in targets )
			{
				local path = this.World.getNavigator().findPath(settlementTile, locTile, navSettings, 0);
				local roadTiles = [];
				roadTiles.push(settlementTile);

				while (path.getSize() >= 1)
				{
					local tile = this.World.getTile(path.getCurrent());
					roadTiles.push(tile);
					path.pop();
				}

				local prevTile;
				local abort = false;

				foreach( i, tile in roadTiles )
				{
					if (tile.Type == this.Const.World.TerrainType.Hills)
					{
						abort = true;
						break;
					}

					local dirA = prevTile != null ? tile.getDirectionTo(prevTile) : 0;
					local dirB = i < roadTiles.len() - 1 ? tile.getDirectionTo(roadTiles[i + 1]) : 0;

					if ((tile.RoadDirections & this.Const.DirectionBit[dirA]) == 0 || (tile.RoadDirections & this.Const.DirectionBit[dirB]) == 0)
					{
						local dir = tile.RoadDirections | this.Const.DirectionBit[dirA] | this.Const.DirectionBit[dirB];

						if (!this.Const.World.RoadBrushes.has(dir))
						{
							abort = true;
							break;
						}
					}

					prevTile = tile;
				}

				if (abort)
				{
					continue;
				}

				prevTile = null;

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
			}
		}
	}

	o.buildRoads = function( _rect, _properties )
	{
		this.logInfo("Building roads...");
		local allSettlements = this.World.EntityManager.getSettlements();
		local settlements = [];
		foreach (s in allSettlements) {
			if(!s.isFringe()) {
				settlements.push(s);
			}
		}
		this.logInfo("Connecting " + settlements.len() + " of " + allSettlements.len() + " settlements");
		local roadConnections = [];
		roadConnections.resize(settlements.len());

		for( local i = 0; i != settlements.len(); i = ++i )
		{
			roadConnections[i] = [];
			roadConnections[i].resize(settlements.len(), false);
		}

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

		for( local i = 0; i != settlements.len(); i = ++i )
		{
			local numConnections = 0;
			local tries = 0;

			while (numConnections < 2 && tries < 50)
			{
				tries += 1;
				local closest;
				local closestDist = 9000;
				local closestJ = i;

				for( local j = 0; j != settlements.len(); j = ++j )
				{
					if (i == j)
					{
					}
					else if (roadConnections[i][j] == true)
					{
					}
					else
					{
						local dist = settlements[i].getTile().getDistanceTo(settlements[j].getTile());

						if (dist < closestDist)
						{
							closest = settlements[j].getTile();
							closestDist = dist;
							closestJ = j;
						}
					}
				}

				if (closest != null)
				{
					local path = this.World.getNavigator().findPath(settlements[i].getTile(), closest, navSettings, 0);
					roadConnections[i][closestJ] = true;
					roadConnections[closestJ][i] = true;

					if (!path.isEmpty())
					{
						numConnections = ++numConnections;
					}

					local roadTiles = [];
					roadTiles.push(settlements[i].getTile());

					while (path.getSize() >= 1)
					{
						local tile = this.World.getTile(path.getCurrent());
						roadTiles.push(tile);
						path.pop();
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
				}
			}
		}
		this.removeAutobahnkreuze(_rect, _properties);
	}

	// o.guaranteeAllBuildingsInSettlements = function ()
	// {

	// 	local settlements = this.World.EntityManager.getSettlements();

	// 	if (this.Const.World.Buildings.Fletchers < 2)
	// 	{
	// 		local candidates = [];

	// 		foreach( s in settlements )
	// 		{
	// 			if (s.getSize() >= 2 && s.hasFreeBuildingSlot() && !s.hasBuilding("building.fletcher"))
	// 			{
	// 				candidates.push(s);
	// 			}
	// 		}

	// 		for( local i = this.Const.World.Buildings.Fletchers; i <= 2; i = ++i )
	// 		{
	// 			local r = this.Math.rand(0, candidates.len() - 1);
	// 			local s = candidates[r];
	// 			candidates.remove(r);
	// 			s.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));

	// 			if (candidates.len() == 0)
	// 			{
	// 				break;
	// 			}
	// 		}
	// 	}

	// 	if (this.Const.World.Buildings.Temples < 2)
	// 	{
	// 		local candidates = [];

	// 		foreach( s in settlements )
	// 		{
	// 			if (s.getSize() >= 2 && s.hasFreeBuildingSlot() && !s.hasBuilding("building.temple"))
	// 			{
	// 				candidates.push(s);
	// 			}
	// 		}

	// 		for( local i = this.Const.World.Buildings.Temples; i <= 2; i = ++i )
	// 		{
	// 			local r = this.Math.rand(0, candidates.len() - 1);
	// 			local s = candidates[r];
	// 			candidates.remove(r);
	// 			s.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));

	// 			if (candidates.len() == 0)
	// 			{
	// 				break;
	// 			}
	// 		}
	// 	}

	// 	if (this.Const.World.Buildings.Barbers < 2)
	// 	{
	// 		local candidates = [];

	// 		foreach( s in settlements )
	// 		{
	// 			if (s.getSize() >= 2 && !s.isMilitary() && s.hasFreeBuildingSlot() && !s.hasBuilding("building.barber"))
	// 			{
	// 				candidates.push(s);
	// 			}
	// 		}

	// 		for( local i = this.Const.World.Buildings.Barbers; i <= 2; i = ++i )
	// 		{
	// 			local r = this.Math.rand(0, candidates.len() - 1);
	// 			local s = candidates[r];
	// 			candidates.remove(r);
	// 			s.addBuilding(this.new("scripts/entity/world/settlements/buildings/barber_building"));

	// 			if (candidates.len() == 0)
	// 			{
	// 				break;
	// 			}
	// 		}
	// 	}

	// 	if (this.Const.World.Buildings.Kennels < 2)
	// 	{
	// 		local candidates = [];

	// 		foreach( s in settlements )
	// 		{
	// 			if (s.isMilitary() && s.hasFreeBuildingSlot() && !s.hasBuilding("building.kennel"))
	// 			{
	// 				candidates.push(s);
	// 			}
	// 		}

	// 		for( local i = this.Const.World.Buildings.Kennels; i <= 2; i = ++i )
	// 		{
	// 			local r = this.Math.rand(0, candidates.len() - 1);
	// 			local s = candidates[r];
	// 			candidates.remove(r);
	// 			s.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));

	// 			if (candidates.len() == 0)
	// 			{
	// 				break;
	// 			}
	// 		}
	// 	}

	// 	if (this.Const.DLC.Unhold && this.Const.World.Buildings.Taxidermists < 2)
	// 	{
	// 		local candidates = [];

	// 		foreach( s in settlements )
	// 		{
	// 			if (!s.isMilitary() && s.hasFreeBuildingSlot() && !s.hasBuilding("building.taxidermist"))
	// 			{
	// 				candidates.push(s);
	// 			}
	// 		}

	// 		for( local i = this.Const.World.Buildings.Taxidermists; i <= 2; i = ++i )
	// 		{
	// 			local r = this.Math.rand(0, candidates.len() - 1);
	// 			local s = candidates[r];
	// 			candidates.remove(r);
	// 			s.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));

	// 			if (candidates.len() == 0)
	// 			{
	// 				break;
	// 			}
	// 		}
	// 	}

	// 	if (this.Const.World.Buildings.Stables < 2)
	// 	{
	// 		local candidates = [];

	// 		foreach( s in settlements )
	// 		{
	// 			if (s.isMilitary() && s.hasFreeBuildingSlot() && !s.hasBuilding("building.stables"))
	// 			{
	// 				candidates.push(s);
	// 			}
	// 		}

	// 		for( local i = this.Const.World.Buildings.Stables; i <= 2; i = ++i )
	// 		{
	// 			local r = this.Math.rand(0, candidates.len() - 1);
	// 			local s = candidates[r];
	// 			candidates.remove(r);
	// 			s.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));

	// 			if (candidates.len() == 0)
	// 			{
	// 				break;
	// 			}
	// 		}
	// 	}

	// }

	local gasFn = o.buildAdditionalRoads;
	o.buildAdditionalRoads = function (_rect, _properties)
	{
		if (_properties.AllTradeLocations)
		{
			o.guaranteeAllLocations();
		}
		gasFn(_rect, _properties);

	}

	o.guaranteeAllLocations <- function()
	{
		local locs = {}
		locs["attached_location.amber_collector"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/amber_collector_location"
		}
		locs["attached_location.beekeeper"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/beekeeper_location"
		};
		locs["attached_location.brewery"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/brewery_location"
		};
		locs["attached_location.dye_maker"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/dye_maker_location"
		};
		locs["attached_location.fishing_huts"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/fishing_huts_location"
		};
		locs["attached_location.gatherers_hut"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/gatherers_hut_location"
		};
		locs["attached_location.gem_mine"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/gem_mine_location"
		};
		locs["attached_location.goat_herd"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/goat_herd_location"
		};
		locs["attached_location.gold_mine"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/gold_mine_location"
		};
		locs["attached_location.herbalists_grove"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/herbalists_grove_location"
		};
		locs["attached_location.hunters_cabin"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/hunters_cabin_location"
		};
		locs["attached_location.leather_tanner"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/leather_tanner_location"
		};
		locs["attached_location.lumber_camp"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/lumber_camp_location"
		};
		locs["attached_location.mushroom_grove"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/mushroom_grove_location"
		};
		locs["attached_location.orchard"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/orchard_location"
		};
		locs["attached_location.peat_pit"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/peat_pit_location"
		};
		locs["attached_location.pig_farm"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/pig_farm_location"
		};
		locs["attached_location.salt_mine"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/salt_mine_location"
		};
		locs["attached_location.surface_copper_vein"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/surface_copper_vein_location"
		};
		locs["attached_location.surface_iron_vein"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/surface_iron_vein_location"
		};
		locs["attached_location.trapper"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/trapper_location"
		};
		locs["attached_location.wheat_fields"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/wheat_fields_location"
		};
		locs["attached_location.winery"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/winery_location"
		};
		locs["attached_location.wool_spinner"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/wool_spinner_location"
		};
		locs["attached_location.workshop"] <- {
			Amount = 0,
			Script = "scripts/entity/world/attached_location/workshop_location"
		};

		local settlements = this.World.EntityManager.getSettlements();
		foreach( s in settlements )
		{
			foreach (a in s.getAttachedLocations())
			{
				if (a.getTypeID() in locs)
				{
					locs[a.getTypeID()].Amount += 1
				}
			}
		}

		foreach (k,v in locs)
		{

			if (v.Amount > 0)
			{
				continue;
			}

			local ALL = [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			];
			local tries = 0;
			while (tries++ < 1000)
			{
				local index = this.Math.rand(0, settlements.len() - 1)
				settlements[index].buildAttachedLocation(1, v.Script, ALL, [], 2, false, true, true);
				if (settlements[index].hasAttachedLocation(k)) {
					//this.logInfo("Added " + k)
					break;
				}
				tries = --tries;
			}
		}
	}

})