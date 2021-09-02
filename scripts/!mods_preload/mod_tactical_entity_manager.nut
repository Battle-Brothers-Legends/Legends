this.getroottable().Const.LegendMod.hookTacticalEntityManager <- function()
{
	::mods_hookNewObject("entity/tactical/tactical_entity_manager", function(o) 
	{
	 	o.spawn = function ( _properties )
		{
			if (this.World.State.getCombatSeed() != 0)
			{
				this.Math.seedRandom(this.World.State.getCombatSeed());
			}

			this.Time.setRound(0);
			this.World.Assets.updateFormation();
			local all_players = _properties.IsUsingSetPlayers ? _properties.Players : this.World.getPlayerRoster().getAll();
			local players = [];

			foreach( e in _properties.TemporaryEnemies )
			{
				if (e > 2)
				{
					this.World.FactionManager.getFaction(e).setIsTemporaryEnemy(true);
				}
			}
			// local riderMap = {}
			local hasSheildsUpPerk = false;

			foreach( p in all_players )
			{
				if (p.getPlaceInFormation() > 26)
				{
					continue;
				}

				if (p.getSkills().hasSkill("perk.legend_shields_up"))
				{
					hasSheildsUpPerk = true;
				}

				if (_properties.IsPlayerInitiated && p.isInReserves() && all_players.len() > 1)
				{
					continue;
				}

				// if (p.getRiderID() != "")
				// {
				// 	local key = "" + p.getRiderID();
				// 	if (!(key in riderMap))
				// 	{
				// 		riderMap[key] <- [null, null] //horse, rider
				// 	}
				// 	local pair = riderMap[key]
				// 	if (p.isStabled())
				// 	{
				// 		pair[0] = p
				// 	}
				// 	else
				// 	{
				// 		pair[1] = p
				// 	}
				// 	continue
				// }

				players.push(p);
				local items = p.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag);

				foreach( item in items )
				{
					if ("setLoaded" in item)
					{
						item.setLoaded(false);
					}
				}
			}

			// foreach(k, v in riderMap)
			// {
			// 	local p
			// 	if (v[0] != null && v[1] != null)
			// 	{
			// 		p = this.World.getPlayerRoster().create("scripts/entity/tactical/legends_player_horserider");
			// 		p.setHorse(v[0]);
			// 		p.setRider(v[1]);
			// 		p.setScenarioValues();
			// 	}
			// 	else if (v[0] != null)
			// 	{
			// 		p = v[0];
			// 	}
			// 	else
			// 	{
			// 		p = v[1];
			// 	}

			// 	players.push(p);
			// 	local items = p.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag);

			// 	foreach( item in items )
			// 	{
			// 		if ("setLoaded" in item)
			// 		{
			// 			item.setLoaded(false);
			// 		}
			// 	}

			// }

			if (this.World.State.isUsingGuests() && this.World.getGuestRoster().getSize() != 0)
			{
				players.extend(this.World.getGuestRoster().getAll());
			}

			if (_properties.BeforeDeploymentCallback != null)
			{
				_properties.BeforeDeploymentCallback();
			}

			local isPlayerInitiated = _properties.IsPlayerInitiated;

			if (_properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.Auto)
			{
				if (this.World.State.getEscortedEntity() != null && !this.World.State.getEscortedEntity().isNull())
				{
					_properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
				}
				else if (_properties.LocationTemplate != null && _properties.LocationTemplate.Fortification != this.Const.Tactical.FortificationType.None && !_properties.LocationTemplate.ForceLineBattle)
				{
					_properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
				}
				else if ((this.Const.World.TerrainTypeLineBattle[_properties.Tile.Type] || _properties.IsAttackingLocation || isPlayerInitiated) && !_properties.InCombatAlready)
				{
					_properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
				}
				else if (!_properties.InCombatAlready)
				{
					_properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
				}
				else
				{
					_properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
				}
			}

			_properties.Entities.sort(this.onFactionCompare);
			local ai_entities = [];

			foreach( e in _properties.Entities )
			{
				if (ai_entities.len() == 0 || ai_entities[ai_entities.len() - 1].Faction != e.Faction)
				{
					local f = {
						Faction = e.Faction,
						IsAlliedWithPlayer = this.World.FactionManager.isAlliedWithPlayer(e.Faction),
						IsOwningLocation = false,
						DeploymentType = _properties.EnemyDeploymentType,
						Entities = []
					};
					ai_entities.push(f);

					if (_properties.LocationTemplate != null && this.World.FactionManager.isAllied(f.Faction, _properties.LocationTemplate.OwnedByFaction))
					{
						f.IsOwningLocation = true;
					}

					if (f.DeploymentType == this.Const.Tactical.DeploymentType.Auto)
					{
						if (this.World.State.getEscortedEntity() != null && !this.World.State.getEscortedEntity().isNull())
						{
							f.DeploymentType = this.Const.Tactical.DeploymentType.Line;
						}
						else if (f.IsAlliedWithPlayer && !_properties.InCombatAlready)
						{
							f.DeploymentType = _properties.PlayerDeploymentType;
						}
						else if (_properties.LocationTemplate != null && _properties.LocationTemplate.Fortification != this.Const.Tactical.FortificationType.None && !this.World.FactionManager.isAllied(f.Faction, _properties.LocationTemplate.OwnedByFaction) && !_properties.LocationTemplate.ForceLineBattle)
						{
							f.DeploymentType = this.Const.Tactical.DeploymentType.LineBack;
						}
						else if (_properties.LocationTemplate != null && _properties.LocationTemplate.Fortification != this.Const.Tactical.FortificationType.None && this.World.FactionManager.isAllied(f.Faction, _properties.LocationTemplate.OwnedByFaction) && !_properties.LocationTemplate.ForceLineBattle)
						{
							f.DeploymentType = this.Const.Tactical.DeploymentType.Camp;
						}
						else if (_properties.LocationTemplate != null && (_properties.LocationTemplate.Fortification == this.Const.Tactical.FortificationType.None || _properties.LocationTemplate.ForceLineBattle))
						{
							f.DeploymentType = this.Const.Tactical.DeploymentType.Line;
						}
						else if (this.Const.World.TerrainTypeLineBattle[_properties.Tile.Type] || _properties.IsAttackingLocation || isPlayerInitiated || _properties.InCombatAlready)
						{
							f.DeploymentType = this.Const.Tactical.DeploymentType.Line;
						}
						else
						{
							f.DeploymentType = this.Const.Tactical.DeploymentType.Circle;
						}
					}
				}

				ai_entities[ai_entities.len() - 1].Entities.push(e);
			}

			ai_entities.sort(function ( _a, _b )
			{
				if (_a.IsOwningLocation && !_b.IsOwningLocation)
				{
					return -1;
				}
				else if (!_a.IsOwningLocation && _b.IsOwningLocation)
				{
					return 1;
				}

				return 0;
			});
			local hasCampDeployment = false;

			foreach( ai in ai_entities )
			{
				if (ai.DeploymentType == this.Const.Tactical.DeploymentType.Camp)
				{
					hasCampDeployment = true;
					break;
				}
			}

			local shiftX = _properties.LocationTemplate != null ? _properties.LocationTemplate.ShiftX : 0;
			local shiftY = _properties.LocationTemplate != null ? _properties.LocationTemplate.ShiftY : 0;

			switch(_properties.PlayerDeploymentType)
			{
			case this.Const.Tactical.DeploymentType.Line:
				this.placePlayersInFormation(players);
				break;

			case this.Const.Tactical.DeploymentType.LineBack:
				if (_properties.InCombatAlready)
				{
					this.placePlayersInFormation(players, -10);
				}
				else
				{
					this.placePlayersInFormation(players, -10 + shiftX);
				}

				break;

			case this.Const.Tactical.DeploymentType.LineForward:
				this.placePlayersInFormation(players, 8 + shiftX);
				break;

			case this.Const.Tactical.DeploymentType.Arena:
				this.placePlayersInFormation(players, -4, -3);
				break;

			case this.Const.Tactical.DeploymentType.Center:
				this.placePlayersAtCenter(players);
				break;

			case this.Const.Tactical.DeploymentType.Edge:
				this.placePlayersAtBorder(players);
				break;

			case this.Const.Tactical.DeploymentType.Random:
			case this.Const.Tactical.DeploymentType.Circle:
				this.placePlayersInCircle(players);
				break;

			case this.Const.Tactical.DeploymentType.Custom:
				if (_properties.PlayerDeploymentCallback != null)
				{
					_properties.PlayerDeploymentCallback();
				}

				break;
			}

			local factionsNotAlliedWithPlayer = hasCampDeployment || _properties.InCombatAlready && ai_entities.len() <= 2 ? 1 : 0;
			local lastFaction = 99;

			foreach( i, f in ai_entities )
			{
				if ((!f.IsAlliedWithPlayer || _properties.InCombatAlready) && f.DeploymentType != this.Const.Tactical.DeploymentType.Camp && (lastFaction == 99 || !this.World.FactionManager.isAllied(lastFaction, f.Faction)))
				{
					factionsNotAlliedWithPlayer = ++factionsNotAlliedWithPlayer;
				}

				if (factionsNotAlliedWithPlayer > 3)
				{
					continue;
				}

				local n = f.IsAlliedWithPlayer && !_properties.InCombatAlready ? 0 : factionsNotAlliedWithPlayer;
				lastFaction = f.Faction;

				switch(f.DeploymentType)
				{
				case this.Const.Tactical.DeploymentType.Line:
					if (_properties.InCombatAlready)
					{
						if (n == 1)
						{
							this.spawnEntitiesInFormation(f.Entities, n, -5, 0);
						}
						else
						{
							this.spawnEntitiesInFormation(f.Entities, n, 0, 7);
						}
					}
					else
					{
						this.spawnEntitiesInFormation(f.Entities, n);
					}

					break;

				case this.Const.Tactical.DeploymentType.Camp:
					this.spawnEntitiesAtCamp(f.Entities, shiftX, shiftY);
					break;

				case this.Const.Tactical.DeploymentType.LineBack:
					if (f.IsAlliedWithPlayer && _properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.LineForward)
					{
						this.spawnEntitiesInFormation(f.Entities, n, 8 + shiftX);
					}
					else if (!f.IsAlliedWithPlayer && _properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.LineForward)
					{
						this.spawnEntitiesInFormation(f.Entities, n, -10 - shiftX);
					}
					else
					{
						this.spawnEntitiesInFormation(f.Entities, n, -10 + shiftX);
					}

					break;

				case this.Const.Tactical.DeploymentType.Arena:
					this.spawnEntitiesInFormation(f.Entities, n, 3, -3);
					break;

				case this.Const.Tactical.DeploymentType.Center:
					this.spawnEntitiesAtCenter(f.Entities);
					break;

				case this.Const.Tactical.DeploymentType.Random:
					this.spawnEntitiesRandomly(f.Entities);
					break;

				case this.Const.Tactical.DeploymentType.Circle:
					this.spawnEntitiesInCircle(f.Entities);
					break;
				}
			}

			if (_properties.EnemyDeploymentCallback != null)
			{
				_properties.EnemyDeploymentCallback();
			}

			this.m.IsLineVSLine = _properties.PlayerDeploymentType == this.Const.Tactical.DeploymentType.Line && _properties.EnemyDeploymentType == this.Const.Tactical.DeploymentType.Line;

			if (!this.Tactical.State.isScenarioMode() && !_properties.IsPlayerInitiated && !_properties.InCombatAlready)
			{
				foreach( i, s in this.m.Strategies )
				{
					if (!this.World.FactionManager.isAllied(this.Const.Faction.Player, i))
					{
						s.setIsAttackingOnWorldmap(true);
					}
				}
			}

			if(this.m.IsLineVSLine && !this.Tactical.State.isScenarioMode())
			{
				local friendlyRanged = false, enemyRanged = false;
					for( local i = this.Const.Faction.Player; i != this.m.Instances.len(); i = ++i )
						{
						if(this.m.Instances[i].len() == 0) continue; // most factions are empty
							local friendly = i == this.Const.Faction.Player || this.World.FactionManager.isAlliedWithPlayer(i);
							if(!(friendly ? friendlyRanged : enemyRanged))
							{
							foreach(e in this.m.Instances[i])
								{
								if(e.isArmedWithRangedWeapon())
									{
									if(friendly) friendlyRanged = true;
									else enemyRanged = true;
									break;
									}
								}
							}
						}

				if(friendlyRanged || enemyRanged)
				{
					for( local i = this.Const.Faction.Player; i != this.m.Instances.len(); i = ++i )
					{
						if(this.m.Instances[i].len() == 0) continue; // most factions are empty
						local faction = this.World.FactionManager.getFaction(i);
						local factionType = faction != null ? faction.getType() : this.Const.FactionType.Player;
						if(factionType == this.Const.FactionType.Zombies || factionType == this.Const.FactionType.Orcs)
						{
							continue; // zombies are too dumb. orcs are too confident
						}
						else if(factionType == this.Const.FactionType.Bandits)
						{
							local hasLeader = false; // bandits are too undisciplined unless there's a leader
							foreach(e in this.m.Instances[i])
							if(e.getType() == this.Const.EntityType.BanditLeader)
							{
								hasLeader = true; 
								break;
							}
							if(!hasLeader) continue;
						}
					}
				}
			}

			if (_properties.AfterDeploymentCallback != null)
			{
				_properties.AfterDeploymentCallback();
			}

			if (_properties.IsAutoAssigningBases)
			{
				this.assignBases();
			}

			this.makeEnemiesKnownToAI(_properties.InCombatAlready);

			if (this.World.Assets.getOrigin().getID() == "scenario.manhunters")
			{
				local roster = this.World.getPlayerRoster().getAll();
				local slaves = 0;
				local nonSlaves = 0;

				foreach( bro in roster )
				{
					if (!bro.isPlacedOnMap())
					{
						continue;
					}

					if (bro.getBackground().getID() == "background.slave")
					{
						slaves = ++slaves;
					}
					else
					{
						nonSlaves = ++nonSlaves;
					}
				}

				if (slaves <= nonSlaves)
				{
					foreach( bro in roster )
					{
						if (!bro.isPlacedOnMap())
						{
							continue;
						}

						if (bro.getBackground().getID() != "background.slave")
						{
							bro.worsenMood(this.Const.MoodChange.TooFewSlavesInBattle, "Too few indebted in battle");
						}
					}
				}
			}

			foreach( player in this.m.Instances[this.Const.Faction.Player] )
			{
				player.onCombatStart();
			}

			this.Math.seedRandom(this.Time.getRealTime());
		}

		o.placePlayersInFormation = function ( _players, _offsetX = 0, _offsetY = 0 )
		{
			for( local x = 11 + _offsetX; x <= 14 + _offsetX; x = ++x )
			{
				for( local y = 10; y <= 20 + _offsetY; y = ++y )
				{
					this.Tactical.getTile(x, y - x / 2).removeObject();
				}
			}

			local positions = [];
			positions.resize(27 ,0);

			foreach( e in _players )
			{
				local p = e.getPlaceInFormation();
				if (positions[p] == 1)
				{
					p += 9;
				}
				else
				{
					positions[p] = 1;
				}

				local x = 13 - p / 9 + _offsetX;
				local y = 30 - (11 + p - p / 9 * 9) + _offsetY;
				local tile = this.Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty)
				{
					tile.removeObject();
				}

				if (this.isTileIsolated(tile))
				{
					local avg = 0;

					for( local x = 0; x < 6; x = ++x )
					{
						if (tile.hasNextTile(x))
						{
							avg = avg + tile.getNextTile(x).Level;
						}
					}

					tile.Level = avg / 6;
				}

				this.Tactical.addEntityToMap(e, tile.Coords.X, tile.Coords.Y);

				if (!this.World.getTime().IsDaytime && e.getBaseProperties().IsAffectedByNight)
				{
					e.getSkills().add(this.new("scripts/skills/special/night_effect"));
				}

				if (this.Tactical.getWeather().IsRaining && e.getBaseProperties().IsAffectedByRain)
				{
					e.getSkills().add(this.new("scripts/skills/special/legend_rain_effect"));
				}


			}
		}

	    o.isTileIsolated = function( _tile )
		{
			local isCompletelyIsolated = true;

			for( local i = 0; i != 6; i = ++i )
			{
				if (!_tile.hasNextTile(i))
				{
	                continue
				}

	            if (_tile.getNextTile(i).IsEmpty && this.Math.abs(_tile.Level - _tile.getNextTile(i).Level) <= 1)
				{
					isCompletelyIsolated = false;
					break;
				}
			}

			if (isCompletelyIsolated)
			{
				return true;
			}

			local size = this.Tactical.getMapSize();

			if (_tile.Level == 0 && this.Tactical.getTileSquare(0, 0).Level == 3 && this.Tactical.getTileSquare(size.X - 1, size.Y - 1).Level == 3 && this.Tactical.getTileSquare(0, size.Y - 1).Level == 3 && this.Tactical.getTileSquare(size.X - 1, 0).Level == 3)
			{
				return false;
			}

			local allFactions = [];
			allFactions.resize(128, 0); //Yuck, we have this dynamic throughout the code, but not sure how to get that dynamic here

			for( local i = 0; i != 128; i = ++i )
			{
				allFactions[i] = i;
			}

			local navigator = this.Tactical.getNavigator();
			local settings = navigator.createSettings();
			settings.ActionPointCosts = this.Const.SameMovementAPCost;
			settings.FatigueCosts = this.Const.PathfinderMovementFatigueCost;
			settings.AllowZoneOfControlPassing = true;
			settings.AlliedFactions = allFactions;

			if (!navigator.findPath(_tile, this.Tactical.getTileSquare(0, 0), settings, 1) && !navigator.findPath(_tile, this.Tactical.getTileSquare(size.X - 1, size.Y - 1), settings, 1) && !navigator.findPath(_tile, this.Tactical.getTileSquare(0, size.Y - 1), settings, 1) && !navigator.findPath(_tile, this.Tactical.getTileSquare(size.X - 1, 0), settings, 1))
			{
				return true;
			}

			return false;
		}

		local resurrect = o.resurrect;
		o.resurrect = function ( _info, _delay = 0 )
		{
			if (_info.Type == "")
			{
				return;
			}
			resurrect(_info, _delay);
		}
	});
	delete this.Const.LegendMod.hookTacticalEntityManager;
}