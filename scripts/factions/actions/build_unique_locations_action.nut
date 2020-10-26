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
		BuildKrakenCult = true,
		BuildIcyCave = true,
		BuildHuntingGround = true,
		BuildSunkenLibrary = true,
		BuildHolySite1 = true,
		BuildHolySite2 = true,
		BuildHolySite3 = true
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

			if (!this.Const.DLC.Unhold || v.getTypeID() == "location.ancient_statue")
			{
				this.m.BuildAncientStatue = false;
			}

			if (!this.Const.DLC.Unhold || v.getTypeID() == "location.unhold_graveyard")
			{
				this.m.BuildUnholdGraveyard = false;
			}

			if (!this.Const.DLC.Unhold || v.getTypeID() == "location.fountain_of_youth")
			{
				this.m.BuildFountainOfYouth = false;
			}

			if (!this.Const.DLC.Unhold || v.getTypeID() == "location.ancient_temple")
			{
				this.m.BuildAncientTemple = false;
			}

			if (!this.Const.DLC.Unhold || v.getTypeID() == "location.witch_hut")
			{
				this.m.BuildWitchHut = false;
			}

			if (!this.Const.DLC.Unhold || v.getTypeID() == "location.land_ship")
			{
				this.m.BuildLandShip = false;
			}

			if (!this.Const.DLC.Unhold || v.getTypeID() == "location.ancient_watchtower")
			{
				this.m.BuildAncientWatchTower = false;
			}

			if (!this.Const.DLC.Unhold || v.getTypeID() == "location.waterwheel")
			{
				this.m.BuildWaterWheel = false;
			}

			if (!this.Const.DLC.Unhold || v.getTypeID() == "location.kraken_cult")
			{
				this.m.BuildKrakenCult = false;
			}

			if (!this.Const.DLC.Wildmen || v.getTypeID() == "location.icy_cave_location")
			{
				this.m.BuildIcyCave = false;
			}

			if (!this.Const.DLC.Wildmen || v.getTypeID() == "location.tundra_elk_location")
			{
				this.m.BuildHuntingGround = false;
			}

			if (!this.Const.DLC.Desert || v.getTypeID() == "location.sunken_library")
			{
				this.m.BuildSunkenLibrary = false;
			}

			if (!this.Const.DLC.Desert || v.getTypeID() == "location.holy_site.meteorite")
			{
				this.m.BuildHolySite1 = false;
			}

			if (!this.Const.DLC.Desert || v.getTypeID() == "location.holy_site.oracle")
			{
				this.m.BuildHolySite2 = false;
			}

			if (!this.Const.DLC.Desert || v.getTypeID() == "location.holy_site.vulcano")
			{
				this.m.BuildHolySite3 = false;
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
				i == this.Const.World.TerrainType.Hills || i == this.Const.World.TerrainType.Steppe || i == this.Const.World.TerrainType.Tundra || i;

				if (this.Const.World.TerrainType.Plains)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 45, 1000, 1001, distanceToOthers, distanceToOthers);

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

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 30, 1000, 1001, distanceToOthers, distanceToOthers);

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
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Desert,
				this.Const.World.TerrainType.Oasis,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.AutumnForest
			], 25, 1000, 1001, distanceToOthers, distanceToOthers);

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
				if (i == this.Const.World.TerrainType.Forest || i == this.Const.World.TerrainType.LeaveForest || i == this.Const.World.TerrainType.AutumnForest)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 40, 1000, 1001, distanceToOthers, distanceToOthers);

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

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 15, 25, 1001, distanceToOthers, distanceToOthers);

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
				if (i == this.Const.World.TerrainType.Plains)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 15, 30, 1001, distanceToOthers, distanceToOthers);

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

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 25, 1000, 1001, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/kraken_cult_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildIcyCave)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Snow || i == this.Const.World.TerrainType.SnowyForest)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 10, 35, 1001, distanceToOthers - 5, distanceToOthers - 5);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/icy_cave_location", tile.Coords);
			}

			if (camp != null)
			{
				this.World.Flags.set("IjirokStage", 0);
				tile.TacticalType = this.Const.World.TerrainTacticalType.Snow;
				camp.onSpawned();
			}
		}
		else if (this.m.BuildHuntingGround)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Tundra)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 15, 99, 1001, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/tundra_elk_location", tile.Coords);
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

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 25, 60, 1001, distanceToOthers, distanceToOthers, null, this.Const.DLC.Desert ? 0.15 : 0.0);

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
			], 20, 35, 1001, distanceToOthers, distanceToOthers);

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
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.Desert
			], 25, 40, 1001, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/ancient_temple_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildSunkenLibrary)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Desert)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 18, 50, 1001, distanceToOthers, distanceToOthers);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/sunken_library_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildHolySite1)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Steppe || i == this.Const.World.TerrainType.Plains)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 8, 25, 1001, 8, 8, null, 0.1, 0.35);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/meteorite_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildHolySite2)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Desert || i == this.Const.World.TerrainType.Steppe)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 8, 25, 1001, 8, 8);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/oracle_location", tile.Coords);
			}

			if (camp != null)
			{
				camp.onSpawned();
			}
		}
		else if (this.m.BuildHolySite3)
		{
			local disallowedTerrain = [];

			for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
			{
				if (i == this.Const.World.TerrainType.Desert)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}
			}

			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, disallowedTerrain, 8, 25, 1001, 8, 8, null, 0.1);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/vulcano_location", tile.Coords);
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

