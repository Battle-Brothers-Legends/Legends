this.build_unique_locations_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		BuildBlackMonolith = true,
		BuildGoblinCity = true,
		BuildAncientStatue = true,
		BuildUnholdGraveyard = true,
		BuildFountainOfYouth = true,
		BuildAncientTemple = true,
		BuildWitchHut = true,
		BuildLandShip = true,
		BuildAncientWatchTower = true,
		BuildWaterWheel = true,
		BuildKrakenCult = true
	},
	function create()
	{
		this.m.ID = "build_unique_locations_action";
		this.m.IsRunOnNewCampaign = true;
		this.faction_action.create();
	}

	function updateBuildings()
	{
		local locations = this.World.EntityManager.getLocations();

		foreach( v in locations )
		{
			if (v.getTypeID() == "location.black_monolith")
			{
				this.m.BuildBlackMonolith = false;
			}
			else if (v.getTypeID() == "location.goblin_city")
			{
				this.m.BuildGoblinCity = false;
			}
			else if (!this.Const.DLC.Unhold || v.getTypeID() == "location.ancient_statue")
			{
				this.m.BuildAncientStatue = false;
			}
			else if (!this.Const.DLC.Unhold || v.getTypeID() == "location.unhold_graveyard")
			{
				this.m.BuildUnholdGraveyard = false;
			}
			else if (!this.Const.DLC.Unhold || v.getTypeID() == "location.fountain_of_youth")
			{
				this.m.BuildFountainOfYouth = false;
			}
			else if (!this.Const.DLC.Unhold || v.getTypeID() == "location.ancient_temple")
			{
				this.m.BuildAncientTemple = false;
			}
			else if (!this.Const.DLC.Unhold || v.getTypeID() == "location.witch_hut")
			{
				this.m.BuildWitchHut = false;
			}
			else if (!this.Const.DLC.Unhold || v.getTypeID() == "location.land_ship")
			{
				this.m.BuildLandShip = false;
			}
			else if (!this.Const.DLC.Unhold || v.getTypeID() == "location.ancient_watchtower")
			{
				this.m.BuildAncientWatchTower = false;
			}
			else if (!this.Const.DLC.Unhold || v.getTypeID() == "location.waterwheel")
			{
				this.m.BuildWaterWheel = false;
			}
			else if (!this.Const.DLC.Unhold || v.getTypeID() == "location.kraken_cult")
			{
				this.m.BuildKrakenCult = false;
			}
		}
	}

	function onUpdate( _faction )
	{
		if (!this.m.IsRunOnNewCampaign || this.World.getTime().Days > 1)
		{
			return;
		}

		this.updateBuildings();
		this.m.Score = 10000;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local camp;
		local distanceToOthers = 15;

		if (this.m.BuildBlackMonolith)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Hills || i == this.Const.World.TerrainType.Steppe || i == this.Const.World.TerrainType.Highlands)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 45, 1000, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/black_monolith_location", tile.Coords);
			}

			if (camp != null)
			{
				tile.TacticalType = this.Const.World.TerrainTacticalType.Quarry;
				camp.onSpawned();
			}
		}
		else if (this.m.BuildGoblinCity)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Hills || i == this.Const.World.TerrainType.Mountains)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 30, 1000, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/unique_goblin_city_location", tile.Coords);
			}

			if (camp != null)
			{
				local goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins);
				local banner = this.getAppropriateBanner(camp, goblins.getSettlements(), 15, this.Const.GoblinBanners);
				camp.onSpawned();
				camp.setBanner(banner);
				goblins.addSettlement(camp, false);
			}
		}
		else if (this.m.BuildUnholdGraveyard)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, [
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.AutumnForest
			], 25, 1000, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/unhold_graveyard_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildFountainOfYouth)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Forest || i == this.Const.World.TerrainType.LeaveForest)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 40, 1000, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/fountain_of_youth_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildWitchHut)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Forest || i == this.Const.World.TerrainType.LeaveForest || i == this.Const.World.TerrainType.AutumnForest)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 15, 25, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/witch_hut_location", tile.Coords);
			}

			if (camp != null)
			{
				tile.TacticalType = this.Const.World.TerrainTacticalType.Plains;
				camp.onSpawned();
			}
		}
		else if (this.m.BuildWaterWheel)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Plains || i == this.Const.World.TerrainType.Steppe)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 15, 30, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/waterwheel_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildKrakenCult)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Swamp)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 25, 1000, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/kraken_cult_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildAncientWatchTower)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Mountains || i == this.Const.World.TerrainType.Hills)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 25, 60, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/ancient_watchtower_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildLandShip)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, [
				this.Const.World.TerrainType.Mountains
			], 15, 30, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/land_ship_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildAncientStatue)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, [
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.Forest
			], 20, 35, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/ancient_statue_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildAncientTemple)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, [
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.SnowyForest
			], 25, 40, 1000, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/ancient_temple_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else
		{
			this.logInfo("Done placing all unique locations.");
			this.m.CooldownUntil = 1000000000.0;
			this.m.IsRunOnNewCampaign = false;
		}
	}

});

