::mods_hookExactClass("states/world_state", function(o)
{
	o.m.CampScreen <- null;
	o.m.Campaign <- "";
	o.m.CommanderDied <- null;
	o.m.Camp <- null;
	o.m.IDToRef <- array(27, -1);
	o.m.DistantVisionBonus <- false;
	o.m.AppropriateTimeToRecalc <- 1; //Leonion's fix

	o.getBrothersInReserves <- function ()
	{
		local count = 0;
		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			if (bro.isInReserves())
			{
				count++;
			}
		}
		return count;
	}

	o.getBrothersInFrontline <- function ()
	{
		return this.World.getPlayerRoster().getSize() - this.getBrothersInReserves();
	}

	o.getCampScreen <- function ()
	{
		return this.m.CampScreen;
	}

	o.setPause = function ( _f )
	{
		if (_f != this.m.IsGamePaused)
		{
			this.m.IsGamePaused = _f;

			if (!_f)
			{
				if (this.World.Camp.isCamping())
				{
					this.World.TopbarDayTimeModule.showMessage("ENCAMPED", []);
				}
				else
				{
					this.World.TopbarDayTimeModule.hideMessage();
				}
			}
			else
			{
				if (this.World.Camp.isCamping())
				{
					local updates = ["(Press Spacebar)"];
					updates.extend(this.World.Camp.getLastCampingUpdateText());
					this.World.TopbarDayTimeModule.showMessage("ENCAMPED\n(PAUSED)", updates);
				}
				else
				{
					this.World.TopbarDayTimeModule.showMessage("PAUSED", ["(Press Spacebar)"]);
				}
			}
		}

		if (_f || this.m.IsGameAutoPaused)
		{
			this.m.LastWorldSpeedMult = this.World.getSpeedMult() != 0 ? this.World.getSpeedMult() : this.m.LastWorldSpeedMult;
			this.World.setSpeedMult(0.0);
			this.m.IsAIPaused = true;
		}
		else
		{
			this.World.setSpeedMult(this.m.LastWorldSpeedMult != 0 ? this.m.LastWorldSpeedMult : 1.0);
			this.m.IsAIPaused = false;
		}

		if (("TopbarDayTimeModule" in this.World) && this.World.TopbarDayTimeModule != null)
		{
			if (this.m.IsGamePaused)
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(0);
			}
			else if (this.World.getSpeedMult() == 1.0)
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(1);
			}
			else if (this.World.getSpeedMult() == 4.0)
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(3);
			}
			else if (this.World.getSpeedMult() == 8.0)
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(4);
			}
			else
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(2);
			}
		}
	}

	o.commanderDied <- function ()
	{
		return this.m.CommanderDied;
	}

	o.setCommanderDied <- function ( _v )
	{
		this.m.CommanderDied = _v
	}

	local onInit = o.onInit;
	o.onInit = function()
	{
		this.m.CommanderDied = false;
		this.m.Camp = this.new("scripts/states/world/camp_manager");
		this.World.Camp <- this.WeakTableRef(this.m.Camp);
		onInit();
	}

	local onInitUI = o.onInitUI;
	o.onInitUI = function()
	{
		this.m.CampScreen <- this.new("scripts/ui/screens/world/camp_screen");
		this.m.CampScreen.setOnBrothersPressedListener(this.camp_screen_main_dialog_module_onBrothersButtonClicked.bindenv(this));
		this.m.CampScreen.setOnCommanderPressedListener(this.camp_screen_main_dialog_module_onCommanderButtonClicked.bindenv(this));
		this.m.CampScreen.setOnTentPressedListener(this.camp_screen_main_dialog_module_onTentButtonClicked.bindenv(this));
		this.m.CampScreen.setOnModuleClosedListener(this.town_screen_main_dialog_module_onLeaveButtonClicked.bindenv(this));
		this.m.CampScreen.setOnCampListener(this.onCamp.bindenv(this));
		onInitUI();
	}

	local onDestroyUI = o.onDestroyUI;
	o.onDestroyUI = function ()
	{
		onDestroyUI();
		this.m.CampScreen.destroy();
		this.m.CampScreen = null;
	}

	local onFinish = o.onFinish;
	o.onFinish = function()
	{
		this.m.Camp.destroy();
		this.m.Camp = null;
		this.World.Camp = null;
		onFinish();
	}

	local onShow = o.onShow;
	o.onShow = function ()
	{
		onShow();
		::World.setPlayerPos(this.getPlayer().getPos());
        ::World.setPlayerVisionRadius(this.getPlayer().getVisionRadius());
	}

	o.onUpdate = function ()
	{
		if (!this.m.IsGameOver && (this.World.getPlayerRoster().getSize() == 0 || !this.World.Assets.getOrigin().onCombatFinished()))
		{
			this.showGameFinishScreen(false);
			return;
		}

		this.Root.setBackgroundTaskCallback(this.onProcessInThread.bindenv(this));

		if (this.Time.getFrame() == this.m.AutoUnpauseFrame)
		{
			this.m.AutoUnpauseFrame = 0;
			this.setAutoPause(false);

			if (this.Settings.getGameplaySettings().AutoPauseAfterCity)
			{
				this.setPause(true);
			}
		}

		if (this.World.Camp.isCamping())
		{
			this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.CampMult;

			if (!this.isPaused())
			{
				this.World.setSpeedMult(this.Const.World.SpeedSettings.CampMult);
				this.m.Camp.update(this);
			}
		}

		if (!this.isPaused())
		{
			this.m.IsRunningUpdatesWhilePaused = false;
			this.World.Contracts.update();
			this.m.Assets.update(this);
		}
		else if (this.m.IsTriggeringContractUpdatesOnce && !this.m.MenuStack.hasBacksteps() && !(this.LoadingScreen.isAnimating() || this.LoadingScreen.isVisible()))
		{
			this.m.IsTriggeringContractUpdatesOnce = false;
			this.World.Contracts.update(true);
			this.m.Events.update();
		}

		if (this.m.MenuStack.hasBacksteps())
		{
			this.resetCameraState();
		}
		else
		{
			this.updateCameraScrolling();
			this.updateCursorAndTooltip();

			if (this.Settings.getTempGameplaySettings().CameraLocked)
			{
				this.World.getCamera().setPos(this.World.State.getPlayer().getPos());
			}
		}

		this.World.getCamera().update();
		this.World.update();
		this.updateScene();
		this.updateDayTime();

		if (this.m.AIEngageCallback != null)
		{
			this.m.AIEngageCallback();
			this.m.AIEngageCallback = null;
		}
		else if (this.m.AutoEnterLocation != null && !this.m.AutoEnterLocation.isNull())
		{
			if (this.m.Player.getTile().isSameTileAs(this.m.AutoEnterLocation.getTile()) && this.m.Player.getDistanceTo(this.m.AutoEnterLocation.get()) <= this.Const.World.CombatSettings.CombatPlayerDistance)
			{
				this.enterLocation(this.m.AutoEnterLocation.get());
			}
		}
		else if (this.m.AutoAttack != null && !this.m.AutoAttack.isNull() && this.m.AutoAttack.isAlive() && !this.m.AutoAttack.isHiddenToPlayer())
		{
			if (this.m.Player.getDistanceTo(this.m.AutoAttack.get()) <= this.Const.World.CombatSettings.CombatPlayerDistance)
			{
				if (this.m.AutoAttack.isAlliedWithPlayer() && this.World.Contracts.getActiveContract() == null)
				{
					local f = this.World.FactionManager.getFaction(this.m.AutoAttack.getFaction());
					f.addPlayerRelation(-f.getPlayerRelation(), "Attacked them");
					this.m.AutoAttack.updatePlayerRelation();
					this.World.Assets.addMoralReputation(-2);
				}

				if (this.m.AutoAttack.onEnteringCombatWithPlayer())
				{
					this.showCombatDialog();
				}

				this.m.AutoAttack = null;
				this.m.Player.setPath(null);
				this.m.Player.setDestination(null);
			}
			else if (this.getVecDistance(this.m.AutoAttack.getPos(), this.m.Player.getPos()) <= this.Const.World.MovementSettings.PlayerDirectMoveRadius)
			{
				this.m.Player.setPath(null);
				this.m.Player.setDestination(this.m.AutoAttack.getPos());
			}
			else if (!this.m.Player.hasPath() || this.Time.getVirtualTimeF() - this.m.LastAutoAttackPath >= 0.1)
			{
				local navSettings = this.World.getNavigator().createSettings();
				navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
				navSettings.RoadMult = 1.0 / this.Const.World.MovementSettings.RoadMult;
				local path = this.World.getNavigator().findPath(this.m.Player.getTile(), this.m.AutoAttack.getTile(), navSettings, 0);

				if (!path.isEmpty())
				{
					this.m.Player.setPath(path);
				}
				else
				{
					this.m.Player.setPath(null);
				}

				this.m.LastAutoAttackPath = this.Time.getVirtualTimeF();
			}
		}
		else if (!this.m.IsGamePaused && !this.m.IsGameAutoPaused)
		{
			this.m.Events.update();
			this.m.Ambitions.update();

			if (this.Time.getRealTimeF() - this.m.LastMusicUpdate > 60.0)
			{
				this.setWorldmapMusic(true);
			}
		}

		if (this.m.LastEnteredTown == null && (this.m.LastPlayerTile == null || this.m.LastIsDaytime != this.World.getTime().IsDaytime || this.m.LastPlayerTile.ID != this.m.Player.getTile().ID))
		{
			this.m.LastPlayerTile = this.m.Player.getTile();
			this.m.LastIsDaytime = this.World.getTime().IsDaytime;
			this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrain, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
			this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceOutsideSettlement, this.Const.Sound.AmbienceOutsideDelay);
		}

		local zoom_banner = this.m.Player.getSprite("zoom_banner");

		if (zoom_banner.IsFadingDone)
		{
			if (this.World.getCamera().Zoom >= 4.0)
			{
				if (zoom_banner.Alpha == 0)
				{
					zoom_banner.fadeIn(300);
				}
			}
			else if (this.World.getCamera().Zoom < 4.0)
			{
				if (zoom_banner.Alpha != 0)
				{
					zoom_banner.fadeOut(300);
				}
			}
		}

		this.m.IsUpdatedOnce = true;
	}

	o.onMouseInput = function ( _mouse )
	{
		if (this.isInLoadingScreen())
		{
			return true;
		}

		if (this.isInDevScreen())
		{
			return true;
		}

		local mouseMoved = _mouse.getID() == 6;

		if (mouseMoved)
		{
			this.Cursor.setPosition(_mouse.getX(), _mouse.getY());
		}

		if (this.m.MenuStack.hasBacksteps())
		{
			return false;
		}

		if (_mouse.getID() == 7)
		{
			if (_mouse.getState() == 3)
			{
				this.World.getCamera().zoomBy(-this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.3);
				return true;
			}
			else if (_mouse.getState() == 4)
			{
				this.World.getCamera().zoomBy(this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.3);
				return true;
			}
		}

		if (mouseMoved)
		{
			this.updateCursorAndTooltip();
		}

		this.updateCamera(_mouse);
		local isEscorting = this.m.EscortedEntity != null && !this.m.EscortedEntity.isNull();

		if (_mouse.getState() == 1 && !this.isInCameraMovementMode())
		{
			if (!this.m.WasInCameraMovementMode)
			{
				local dest = this.World.getCamera().screenToWorld(_mouse.getX(), _mouse.getY());
				local destTile = this.World.worldToTile(dest);
				local forceAttack = this.m.IsForcingAttack && this.World.Contracts.getActiveContract() == null;
				this.m.AutoEnterLocation = null;
				this.m.AutoAttack = null;
				this.m.LastAutoAttackPath = 0.0;

				if (!this.World.Camp.isCamping())
				{
					local entities = this.World.getAllEntitiesAndOneLocationAtPos(this.World.getCamera().screenToWorld(_mouse.getX(), _mouse.getY()), 1.0);

					foreach( entity in entities )
					{
						if (entity.getID() == this.m.Player.getID())
						{
							continue;
						}

						if (entity.isParty())
						{
							if (!isEscorting && entity.isAttackable() && entity.getVisibilityMult() != 0 && !entity.isHiddenToPlayer() && (!entity.isAlliedWith(this.m.Player) || forceAttack))
							{
								if (this.m.Player.getDistanceTo(entity) <= this.Const.World.CombatSettings.CombatPlayerDistance)
								{
									if (forceAttack && entity.isAlliedWith(this.m.Player))
									{
										local f = this.World.FactionManager.getFaction(entity.getFaction());
										f.addPlayerRelation(-f.getPlayerRelation(), "Attacked them");
										entity.updatePlayerRelation();
										this.World.Assets.addMoralReputation(-3);
									}

									if (entity.onEnteringCombatWithPlayer())
									{
										this.showCombatDialog();
									}

									return true;
								}
								else
								{
									this.m.AutoAttack = this.WeakTableRef(entity);
									return true;
								}
							}
						}
						else if (entity.isEnterable() || entity.isAttackable() || !entity.isVisited() || entity.getOnEnterCallback() != null)
						{
							if (entity.getTile().isSameTileAs(this.m.Player.getTile()) && this.m.Player.getDistanceTo(entity) <= this.Const.World.CombatSettings.CombatPlayerDistance)
							{
								if (!isEscorting || entity.isAlliedWithPlayer())
								{
									this.enterLocation(entity);
									return true;
								}
							}
							else if (!isEscorting)
							{
								this.m.AutoEnterLocation = this.WeakTableRef(entity);

								if (entity.isEnterable() && entity.isAlliedWithPlayer())
								{
									this.m.WorldTownScreen.getMainDialogModule().preload(entity);
								}
							}
						}
					}
				}

				if (this.m.EscortedEntity != null && !this.m.EscortedEntity.isNull())
				{
					return false;
				}

				if (this.getVecDistance(dest, this.m.Player.getPos()) <= this.Const.World.MovementSettings.PlayerDirectMoveRadius || this.World.isValidTile(destTile.X, destTile.Y) && !this.World.getTile(destTile).IsDiscovered)
				{
					if (this.World.Camp.isCamping())
					{
						if (this.isPaused())
						{
							return false;
						}
						this.onCamp();
						return true;
					}

					this.m.Player.setPath(null);
					this.m.Player.setDestination(dest);
				}
				else if (this.World.isValidTile(destTile.X, destTile.Y))
				{
					if (this.World.Camp.isCamping())
					{
						if (this.isPaused())
						{
							return false;
						}
						this.onCamp();
						return true;
					}

					local navSettings = this.World.getNavigator().createSettings();
					navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
					navSettings.RoadMult = 1.0 / this.Const.World.MovementSettings.RoadMult;
					local path = this.World.getNavigator().findPath(this.m.Player.getTile(), this.World.getTile(destTile), navSettings, 0);

					if (!path.isEmpty())
					{
						this.m.Player.setPath(path);
					}
					else
					{
						this.m.Player.setPath(null);
					}
				}
			}
		}

		return false;
	}

	o.startNewCampaign = function ()
	{
		this.setAutoPause(true);
		this.Time.setVirtualTime(0);
		this.m.IsRunningUpdatesWhilePaused = true;
		this.setPause(true);
		this.Math.seedRandomString(this.m.CampaignSettings.Seed);
		this.Const.World.settingsUpdate();
		local worldmap = this.MapGen.get("world.worldmap_generator");
		local minX = worldmap.getMinX();
		local minY = worldmap.getMinY();
		this.World.resizeScene(minX, minY);
		this.logInfo("Generating world with following settings...");
		foreach (k,v in this.Const.World.Settings)
		{
			this.logInfo(k + " : " + v);
		}
		worldmap.fill({
			X = 0,
			Y = 0,
			W = minX,
			H = minY
		}, this.m.CampaignSettings);
		this.m.Assets.init();
		this.m.Camp.init();
		//this.LoadingScreen.updateProgress("Creating Factions ...");
		this.World.FactionManager.createFactions(this.m.CampaignSettings);
		this.World.EntityManager.buildRoadAmbushSpots();
		this.Math.seedRandomString(this.m.CampaignSettings.Seed);

		if (this.m.CampaignSettings != null)
		{
			this.m.Assets.setCampaignSettings(this.m.CampaignSettings);
			this.m.CampaignSettings.StartingScenario.onSpawnPlayer();
			this.m.CampaignSettings.StartingScenario.onInit();
			this.World.uncoverFogOfWar(this.getPlayer().getTile().Pos, 900.0);
		}

		this.World.FactionManager.uncoverSettlements(this.m.CampaignSettings.ExplorationMode);
		this.World.FactionManager.runSimulation();
		this.m.CampaignSettings = null;
		this.setupWeather();
		this.Math.seedRandom(this.Time.getRealTime());

		this.World.Flags.set("IsUnholdCampaign", true);
		this.World.Flags.set("IsWildmenCampaign", true);
		this.World.Flags.set("IsDesertCampaign", true);


		this.World.setFogOfWar(!::Legends.Mod.ModSettings.getSetting("DebugMap").getValue());
		this.World.Crafting.resetAllBlueprints();
	}

	o.showIntroductionScreen <- function ( _tag = null )
	{
		this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
		this.World.Contracts.update(true);
	}

	o.setNewCampaignSettings = function ( _settings )
	{
		foreach(k,v in _settings)
		{
			this.logInfo(k + " = " + v);
		}
		this.m.CampaignSettings = _settings;
	}

	o.getLocalCombatProperties = function ( _pos, _ignoreNoEnemies = false )
	{
		local raw_parties = this.World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance);
		local parties = [];
		local properties = this.Const.Tactical.CombatInfo.getClone();
		local tile = this.World.getTile(this.World.worldToTile(_pos));
		local isAtUniqueLocation = false;
		properties.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
		properties.Tile = tile;
		properties.InCombatAlready = false;
		properties.IsAttackingLocation = false;
		local factions = [];
		factions.resize(48, 0); // handled by MSU

		foreach( party in raw_parties )
		{
			if (!party.isAlive() || party.isPlayerControlled())
			{
				continue;
			}

			if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
			{
				continue;
			}

			if (party.isLocation() && party.isLocationType(this.Const.World.LocationType.Unique))
			{
				isAtUniqueLocation = true;
				break;
			}

			if (party.isInCombat())
			{
				raw_parties = this.World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance * 2.0);
				break;
			}
		}

		foreach( party in raw_parties )
		{
			if (!party.isAlive() || party.isPlayerControlled())
			{
				continue;
			}

			if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
			{
				continue;
			}

			if (isAtUniqueLocation && (!party.isLocation() || !party.isLocationType(this.Const.World.LocationType.Unique)))
			{
				continue;
			}

			if (!_ignoreNoEnemies)
			{
				local hasOpponent = false;

				foreach( other in raw_parties )
				{
					if (other.isAlive() && !party.isAlliedWith(other))
					{
						hasOpponent = true;
						break;
					}
				}

				if (hasOpponent)
				{
					parties.push(party);
				}
			}
			else
			{
				parties.push(party);
			}
		}

		foreach( party in parties )
		{
			if (party.isInCombat())
			{
				properties.InCombatAlready = true;
			}

			if (party.isLocation())
			{
				properties.IsAttackingLocation = true;
				properties.CombatID = "LocationBattle";
				properties.LocationTemplate = party.getCombatLocation();
				properties.LocationTemplate.OwnedByFaction = party.getFaction();
			}

			this.World.Combat.abortCombatWithParty(party);
			party.onBeforeCombatStarted();
			local troops = party.getTroops();

			foreach( t in troops )
			{
				if (t.Script != "")
				{
					t.Faction <- party.getFaction();
					t.Party <- this.WeakTableRef(party);
					properties.Entities.push(t);

					if (!this.World.FactionManager.isAlliedWithPlayer(party.getFaction()))
					{
						++factions[party.getFaction()];
					}
				}
			}

			if (troops.len() != 0)
			{
				party.onCombatStarted();
				properties.Parties.push(party);
				this.m.PartiesInCombat.push(party);

				if (party.isAlliedWithPlayer())
				{
					properties.AllyBanners.push(party.getBanner());
				}
				else
				{
					properties.EnemyBanners.push(party.getBanner());
				}
			}
		}

		local highest_faction = 0;
		local best = 0;

		foreach( i, f in factions )
		{
			if (f > best)
			{
				best = f;
				highest_faction = i;
			}
		}

		if (this.World.FactionManager.getFaction(highest_faction) != null)
		{
			properties.Music = this.World.FactionManager.getFaction(highest_faction).getCombatMusic();
		}

		return properties;
	}

	o.onCombatFinished = function ()
	{
		this.logDebug("World::onCombatFinished");
		this.World.FactionManager.onCombatFinished();
		this.World.Statistics.getFlags().increment("LastCombatID", 1);
		this.Time.setVirtualTime(this.m.CombatStartTime);
		this.Math.seedRandom(this.Time.getRealTime());
		this.m.CombatStartTime = 0;
		this.m.CombatSeed = 0;
		this.World.Statistics.getFlags().set("LastCombatSavedCaravan", false);

		if (!this.World.Statistics.getFlags().get("LastCombatWasArena"))
		{
			local nonLocationBattle = true;

			foreach( party in this.m.PartiesInCombat )
			{
				if (party.isLocation() && !party.isAlliedWithPlayer())
				{
					nonLocationBattle = false;
				}

				if (party.isAlive() && party.getTroops().len() == 0)
				{
					party.onCombatLost();
				}
				else if (party.isAlive() && party.isAlliedWithPlayer() && party.getFlags().get("IsCaravan") && this.m.EscortedEntity == null)
				{
					this.World.Statistics.getFlags().set("LastCombatSavedCaravan", true);

					if (this.World.Statistics.getFlags().has("LastCombatSavedCaravanProduce") && typeof this.World.Statistics.getFlags().get("LastCombatSavedCaravanProduce") != "string")
					{
						this.World.Statistics.getFlags().remove("LastCombatSavedCaravanProduce");
					}

					if (party.getStashInventory().getItems().len() != 0)
					{
						local prefix = "scripts/items/";
						local script = this.IO.scriptFilenameByHash(::MSU.Array.rand(party.getStashInventory().getItems()).ClassNameHash);
						this.World.Statistics.getFlags().set("LastCombatSavedCaravanProduce", script.slice(prefix.len()));
					}
					else if (party.getInventory().len() != 0)
					{
						this.World.Statistics.getFlags().set("LastCombatSavedCaravanProduce", ::MSU.Array.rand(party.getInventory()));
					}
				}
			}

			this.m.PartiesInCombat = [];

			if (nonLocationBattle)
			{
				local playerTile = this.getPlayer().getTile();
				local battlefield;

				if (!playerTile.IsOccupied)
				{
					battlefield = this.World.spawnLocation("scripts/entity/world/locations/battlefield_location", playerTile.Coords);
				}
				else
				{
					for( local i = 0; i != 6; i = ++i )
					{
						if (!playerTile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = playerTile.getNextTile(i);

							if (!nextTile.IsOccupied)
							{
								battlefield = this.World.spawnLocation("scripts/entity/world/locations/battlefield_location", nextTile.Coords);
								break;
							}
						}
					}
				}

				if (battlefield != null)
				{
					battlefield.setSize(2);
				}
			}
		}

		if (this.World.getPlayerRoster().getSize() == 0 || !this.World.Assets.getOrigin().onCombatFinished() || this.commanderDied())
		{
			if (this.World.Assets.isIronman())
			{
				this.autosave();
			}

			this.show();
			this.showGameFinishScreen(false);
			return;
		}

		local playerRoster = this.World.getPlayerRoster().getAll();

		foreach( bro in playerRoster )
		{
			bro.onCombatFinished();
		}

		this.Stash.setLocked(false);
		this.Sound.stopAmbience();
		this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrain, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
		this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceOutsideSettlement, this.Const.Sound.AmbienceOutsideDelay);

		if (this.Settings.getGameplaySettings().RestoreEquipment)
		{
			this.World.Assets.restoreEquipment();
		}

		this.World.Assets.consumeItems();
		this.World.Assets.refillAmmo();
		this.World.Assets.updateAchievements();
		this.World.Assets.checkAmbitionItems();
		this.updateTopbarAssets();
		this.World.State.getPlayer().updateStrength();
		this.World.Events.updateBattleTime();
		this.World.Ambitions.resetTime();
		this.stunPartiesNearPlayer();
		this.setWorldmapMusic(true);

		if (this.World.Assets.isIronman())
		{
			this.autosave();
		}

		this.show();
		this.setAutoPause(false);
		this.setPause(true);
		this.m.IsTriggeringContractUpdatesOnce = true;
	}

	o.onCamp = function ()
	{
		if (!this.isCampingAllowed())
		{
			return;
		}

		this.World.Camp.onCamp();

		if (this.World.Camp.isCamping())
		{
			this.m.Player.setDestination(null);
			this.m.Player.setPath(null);
			this.m.AutoEnterLocation = null;
			this.m.AutoAttack = null;
		}

		if (this.World.Camp.isCamping())
		{
			this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.CampMult;
			this.World.TopbarDayTimeModule.enableNormalTimeButton(false);

			if (!this.isPaused())
			{
				this.World.setSpeedMult(this.Const.World.SpeedSettings.CampMult);
				this.World.TopbarDayTimeModule.updateTimeButtons(2);
			}
			else
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(0);
			}
			this.setPause(false);
		}
		else
		{
			this.m.LastWorldSpeedMult = 1.0;
			this.World.TopbarDayTimeModule.enableNormalTimeButton(true);

			if (!this.isPaused())
			{
				this.World.setSpeedMult(1.0);
				this.World.TopbarDayTimeModule.updateTimeButtons(1);
			}
			else
			{
				this.World.TopbarDayTimeModule.updateTimeButtons(0);
			}
			this.setPause(true);
		}
	}

	o.setNormalTime = function ()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			if (!this.World.Camp.isCamping() && this.m.EscortedEntity == null)
			{
				this.m.LastWorldSpeedMult = 1.0;
			}

			this.setPause(false);
		}
	}

	o.setFastTime = function ()
	{
		if (!this.m.MenuStack.hasBacksteps())
		{
			if (!this.World.Camp.isCamping() && this.m.EscortedEntity == null)
			{
				this.m.LastWorldSpeedMult = this.Const.World.SpeedSettings.FastMult;
			}

			this.setPause(false);
		}
	}

	o.showCombatDialog = function ( _isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true, _properties = null, _pos = null )
	{
		local entities = [];
		local allyBanners = [];
		local enemyBanners = [];
		local hasOpponents = false;
		local listEntities = _isCombatantsVisible && (_isPlayerInitiated || this.World.Assets.getOrigin().getID() == "scenario.rangers" || this.Const.World.TerrainTypeLineBattle[this.m.Player.getTile().Type] && this.World.getTime().IsDaytime);

		if (_pos == null)
		{
			_pos = this.m.Player.getPos();
		}

		if (_properties != null)
		{
			allyBanners = _properties.AllyBanners;
			enemyBanners = _properties.EnemyBanners;
		}

		if (allyBanners.len() == 0)
		{
			allyBanners.push(this.World.Assets.getBanner());
		}

		if (!_isPlayerInitiated && this.World.Camp.isCamping())
		{
			_allowFormationPicking = false;
		}

		if (!_isPlayerInitiated && !this.Const.World.TerrainTypeLineBattle[this.m.Player.getTile().Type])
		{
			_allowFormationPicking = false;
		}

		local champions = [];
		local entityTypes = [];
		entityTypes.resize(this.Const.EntityType.len(), 0);

		if (_properties != null)
		{
			_properties.IsPlayerInitiated = _isPlayerInitiated;
		}

		if (_properties == null)
		{
			local parties = this.World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance);
			local isAtUniqueLocation = false;

			if (parties.len() <= 1)
			{
				this.m.EngageCombatPos = null;
				return;
			}

			foreach( party in parties )
			{
				if (!party.isAlive() || party.isPlayerControlled())
				{
					continue;
				}

				if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
				{
					continue;
				}

				if (party.isLocation() && party.isShowingDefenders() && party.getCombatLocation().Template[0] != null && party.getCombatLocation().Fortification != 0 && !party.getCombatLocation().ForceLineBattle)
				{
					entities.push({
						Name = "Fortifications",
						Icon = "palisade_01_orientation",
						Overlay = null
					});
				}

				if (party.isLocation() && party.isLocationType(this.Const.World.LocationType.Unique))
				{
					isAtUniqueLocation = true;
					break;
				}

				if (party.isInCombat())
				{
					parties = this.World.getAllEntitiesAtPos(_pos, this.Const.World.CombatSettings.CombatPlayerDistance * 2.0);
					break;
				}
			}

			foreach( party in parties )
			{
				if (!party.isAlive() || party.isPlayerControlled())
				{
					continue;
				}

				if (!party.isAttackable() || party.getFaction() == 0 || party.getVisibilityMult() == 0)
				{
					continue;
				}

				if (isAtUniqueLocation && (!party.isLocation() || !party.isLocationType(this.Const.World.LocationType.Unique)))
				{
					continue;
				}

				if (party.isAlliedWithPlayer())
				{
					if (party.getTroops().len() != 0 && allyBanners.find(party.getBanner()) == null)
					{
						allyBanners.push(party.getBanner());
					}

					continue;
				}
				else
				{
					hasOpponents = true;

					if (!party.isLocation() || party.isShowingDefenders())
					{
						if (party.getTroops().len() != 0 && enemyBanners.find(party.getBanner()) == null)
						{
							enemyBanners.push(party.getBanner());
						}
					}
				}

				if (party.isLocation() && !party.isShowingDefenders())
				{
					entityTypes.resize(this.Const.EntityType.len(), 0);
					break;
				}

				party.onBeforeCombatStarted();
				local troops = party.getTroops();

				foreach( t in troops )
				{
					if (t.Script.len() != "")
					{
						if (t.Variant != 0)
						{
							champions.push(t);
						}
						else
						{
							++entityTypes[t.ID];
						}
					}
				}
			}
		}
		else
		{
			foreach( t in _properties.Entities )
			{
				if (!hasOpponents && (!this.World.FactionManager.isAlliedWithPlayer(t.Faction) || _properties.TemporaryEnemies.find(t.Faction) != null))
				{
					hasOpponents = true;
				}

				if (t.Variant != 0)
				{
					champions.push(t);
				}
				else
				{
					++entityTypes[t.ID];
				}
			}
		}

		foreach( c in champions )
		{
			entities.push({
				Name = c.Name,
				Icon = this.Const.EntityIcon[c.ID],
				Overlay = "icons/miniboss.png"
			});
		}

		for( local i = 0; i < entityTypes.len(); i = ++i )
		{
			if (entityTypes[i] > 0)
			{
				if (entityTypes[i] == 1)
				{
					local start = this.isFirstCharacter(this.Const.Strings.EntityName[i], [
						"A",
						"E",
						"I",
						"O",
						"U"
					]) ? "An " : "A ";
					entities.push({
						Name = start + this.removeFromBeginningOfText("The ", this.Const.Strings.EntityName[i]),
						Icon = this.Const.EntityIcon[i],
						Overlay = null
					});
				}
				else if (::Legends.Mod.ModSettings.getSetting("ExactEngageNumbers").getValue())
				{
					entities.push({
						Name = entityTypes[i] + " " + this.Const.Strings.EntityNamePlural[i],
						Icon = this.Const.EntityIcon[i],
						Overlay = null
					});
				}
				else
				{
					entities.push({
						Name =  getEngageNumberNames(entityTypes[i]) + " " + this.Const.Strings.EntityNamePlural[i],
						Icon = this.Const.EntityIcon[i],
						Overlay = null
					});
				}
			}
		}

		if (!hasOpponents)
		{
			this.m.EngageCombatPos = null;
			return;
		}

		local text = "";

		if (!listEntities || entities.len() == 0)
		{
			entities = [];
			allyBanners = [];
			enemyBanners = [];

			if (!_isPlayerInitiated)
			{
				text = "You can\'t make out who is attacking you in time.<br/>You have to defend yourself!";
			}
			else
			{
				text = "You can\'t make out who you\'ll be facing. Attack at your own peril and be prepared to retreat if need be!";
			}
		}

		local tile = this.World.getTile(this.World.worldToTile(_pos));
		local image = this.Const.World.TerrainTacticalImage[tile.TacticalType];

		if (!this.World.getTime().IsDaytime)
		{
			image = image + "_night";
		}

		image = image + ".png";
		this.setAutoPause(true);
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.m.EngageCombatPos = _pos;
		this.m.EngageByPlayer = _isPlayerInitiated;
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		this.m.CombatDialog.show(entities, allyBanners, enemyBanners, _isPlayerInitiated || this.m.EscortedEntity != null, _allowFormationPicking, text, image, this.m.EscortedEntity != null ? "Flee!" : "Fall back!");
		this.m.MenuStack.push(function ()
		{
			this.m.EngageCombatPos = null;
			this.m.CombatDialog.hide();
			this.m.WorldScreen.show();
			this.stunPartiesNearPlayer(_isPlayerInitiated);
			this.setAutoPause(false);
		}, function ()
		{
			return !this.m.CombatDialog.isAnimating();
		}, _isPlayerInitiated);
	}

	o.getEngageNumberNames <- function ( _entityType)
	{
		foreach (key, value in this.Const.Strings.EngageEnemyNumbers)
		{
			if (_entityType >= value[0] && _entityType <= value[1])
			{
				return this.Const.Strings.EngageEnemyNumbersNames[key];
			}
		}
	}

	o.showCampScreen <- function ()
	{
		if (!this.isCampingAllowed())
		{
			return;
		}

		if (this.World.Camp.isCamping())
		{
			this.onCamp();
			return
		}
		//this.Music.setTrackList(this.m.LastEnteredTown.getMusic(), this.Const.Music.CrossFadeTime);
		this.setPause(true);
		this.setAutoPause(true);
		this.Tooltip.hide();
		this.m.WorldScreen.hide();
		//this.m.WorldTownScreen.setTown(this.m.LastEnteredTown);
		this.m.CampScreen.show();
		this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
		this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrainInSettlement, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
		//this.Sound.setAmbience(1, this.m.LastEnteredTown.getSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceInSettlement, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
		this.m.MenuStack.push(function ()
		{
			this.Sound.setAmbience(0, this.getSurroundingAmbienceSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceTerrain, this.World.getTime().IsDaytime ? this.Const.Sound.AmbienceMinDelay : this.Const.Sound.AmbienceMinDelayAtNight);
			this.Sound.setAmbience(1, this.getSurroundingLocationSounds(), this.Const.Sound.Volume.Ambience * this.Const.Sound.Volume.AmbienceOutsideSettlement, this.Const.Sound.AmbienceOutsideDelay);
			this.World.getCamera().zoomTo(this.m.CustomZoom, 4.0);
			// this.World.Assets.consumeItems();
			// this.World.Assets.refillAmmo();
			// this.World.Assets.updateAchievements();
			// this.World.Assets.checkAmbitionItems();
			// this.World.Ambitions.resetTime(false, 2.0);
			// this.updateTopbarAssets();
			// this.World.State.getPlayer().updateStrength();
			this.m.CampScreen.clear();
			this.m.CampScreen.hide();
			this.m.WorldScreen.show();
			this.Music.setTrackList(this.World.FactionManager.isGreaterEvil() ? this.Const.Music.WorldmapTracksGreaterEvil : this.Const.Music.WorldmapTracks, this.Const.Music.CrossFadeTime);

			if (this.World.Assets.isIronman())
			{
				this.autosave();
			}

			this.Cursor.setCursor(this.Const.UI.Cursor.Hand);
			this.setAutoPause(false);
			this.setPause(true);
		}, function ()
		{
			return !this.m.CampScreen.isAnimating();
		});
	}

	o.camp_screen_main_dialog_module_onBrothersButtonClicked <- function ()
	{
		this.showCharacterScreenFromCamp();
	}

	o.camp_screen_main_dialog_module_onCommanderButtonClicked <- function ()
	{
		this.showCommanderScreenFromCamp();
	}

	o.camp_screen_main_dialog_module_onTentButtonClicked <- function ( _id )
	{
		this.showTentScreenFromCamp( _id );
	}

	o.isInDevScreen <- function ()
	{
		if (this.m.WorldScreen != null && this.m.WorldScreen.devConsoleVisible())
		{
			return true;
		}

		return false;
	}

	o.showCharacterScreenFromCamp <- function ()
	{
		this.World.Assets.updateFormation();
		this.m.CampScreen.hideAllDialogs();
		this.m.CharacterScreen.show();
		this.m.MenuStack.push(function ()
		{
			this.m.CharacterScreen.hide();
			this.m.CampScreen.showLastActiveDialog();
		}, function ()
		{
			return !this.m.CharacterScreen.isAnimating();
		});
	}

	o.showCommanderScreenFromCamp <- function ()
	{
		this.m.CampScreen.hideAllDialogs();
		this.m.CampScreen.showCommanderDialog();
		this.m.MenuStack.push(function ()
		{
			this.m.CampScreen.showLastReturnDialog();
		}, function ()
		{
			return !this.m.CampScreen.isAnimating();
		});
	}

	o.showTentScreenFromCamp <- function ( _id )
	{
		this.m.CampScreen.hideAllDialogs();
		this.m.CampScreen.showTentBuildingDialog( _id );
		this.m.MenuStack.push(function ()
		{
			this.m.CampScreen.showLastReturnDialog();
		}, function ()
		{
			return !this.m.CampScreen.isAnimating();
		});
	}

	o.helper_handleDeveloperKeyInput = function ( _key )
	{
		if (_key.getState() != 0)
		{
			return false;
		}

		if (this.m.MenuStack.hasBacksteps())
		{
			return false;
		}

		switch(_key.getKey())
		{
		case 3:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(3.0);
			this.logDebug("World Speed set to x3.0");
			return true;

		case 4:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(4.0);
			this.logDebug("World Speed set to x4.0");
			return true;

		case 5:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(5.0);
			this.logDebug("World Speed set to x5.0");
			return true;

		case 6:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(6.0);
			this.logDebug("World Speed set to x6.0");
			return true;

		case 7:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(7.0);
			this.logDebug("World Speed set to x7.0");
			return true;

		case 8:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(8.0);
			this.logDebug("World Speed set to x8.0");
			return true;

		case 9:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.getCurrentTown() != null)
			{
				break;
			}

			this.World.setSpeedMult(9.0);
			this.logDebug("World Speed set to x9.0");
			return true;

		case 11:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.m.Player.setAttackable(!this.m.Player.isAttackable());

			if (this.m.Player.isAttackable())
			{
				this.logDebug("Player can now be attacked.");
			}
			else
			{
				this.logDebug("Player can NOT be attacked.");
			}

			return true;

		case 18:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.World.Assets.setConsumingAssets(!this.World.Assets.isConsumingAssets());

			if (this.World.Assets.isConsumingAssets())
			{
				this.logDebug("Player is consuming assets.");
			}
			else
			{
				this.logDebug("Player is NOT consuming assets.");
			}

			return true;

		case 16:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.World.setFogOfWar(!this.World.isUsingFogOfWar());

			if (this.World.isUsingFogOfWar())
			{
				this.logDebug("Fog Of War activated.");
			}
			else
			{
				this.logDebug("Fog Of War deactivated.");
			}

			return true;

		case 17:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.m.LastTileHovered == null)
			{
				break;
			}

			this.logInfo("distance: " + this.m.LastTileHovered.getDistanceTo(this.getPlayer().getTile()));
			this.logInfo("y: " + this.m.LastTileHovered.SquareCoords.Y);
			this.logInfo("type: " + this.m.LastTileHovered.Type);
			return true;

		case 21:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.m.LastEntityHovered != null && this.m.LastEntityHovered.isLocation())
			{
				local e = this.m.LastEntityHovered;
				e.setActive(false);
				e.getTile().spawnDetail(e.m.Sprite + "_ruins", this.Const.World.ZLevel.Object - 3, 0);
				e.die();
				return true;
			}

			break;

		case 22:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			if (this.m.LastEntityHovered != null && this.m.LastEntityHovered.isLocation())
			{
				local e = this.m.LastEntityHovered;
				local tile = e.getTile();
				local name = e.getName();
				local sprite = e.m.Sprite;
				e.setActive(false);
				e.getTile().spawnDetail(e.m.Sprite + "_ruins", this.Const.World.ZLevel.Object - 3, 0, false);
				e.fadeOutAndDie();
				return true;
			}

			break;

		case 25:
			// if (!this.m.IsDeveloperModeEnabled)
			// {
			// 	break;
			// }

			if (this.m.LastTileHovered != null)
			{
				local faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits);
				local party = faction.spawnEntity(this.m.LastTileHovered, "TEST GROUP", false, this.Const.World.Spawn.BanditRoamers, 200);
				party.getSprite("banner").setBrush("banner_orcs_04");
				party.setDescription("A band of menacing orcs, greenskinned and towering any man.");
				local c = party.getController();
				local ambush = this.new("scripts/ai/world/orders/ambush_order");
				c.addOrder(ambush);
				return true;
			}

			break;

		case 23:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.World.Assets.addMoney(10000);
			this.updateTopbarAssets();
			break;

		case 24:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			local playerRoster = this.World.getPlayerRoster().getAll();

			foreach( bro in playerRoster )
			{
				bro.addXP(1000, false);
				bro.updateLevel();
			}

			break;

		case 27:
			if (!this.m.IsDeveloperModeEnabled)
			{
				break;
			}

			this.World.Assets.addBusinessReputation(500);
			break;

		case 81:
			if (!this.m.IsDeveloperModeEnabled)
			{
			}
			else
			{
				if (this.Tooltip.getDelay() < 1000)
				{
					this.Tooltip.setDelay(900000);
				}
				else
				{
					this.Tooltip.setDelay(150);
				}

				break;
			}
		}

		return false;
	}

	o.helper_handleContextualKeyInput = function ( _key )
	{
		if (this.isInLoadingScreen())
		{
			return true;
		}

		if (this.m.IsDeveloperModeEnabled && this.helper_handleDeveloperKeyInput(_key))
		{
			return true;
		}

		//if (this.isInDevScreen())
		//{
		//	switch(_key.getKey())
		//	{
		//	case 41:
		//		this.m.WorldScreen.hideDevConsole();
		//		break;
		//	}

		// 	return true;
		// }

		if (this.isInCharacterScreen() && _key.getState() == 0)
		{
			switch(_key.getKey())
			{
			case 11:
			case 48:
				this.m.CharacterScreen.switchToPreviousBrother();
				break;

			case 38:
			case 14:
			case 50:
				this.m.CharacterScreen.switchToNextBrother();
				break;

			case 19:
			case 13:
			case 41:
				this.toggleCharacterScreen();
				break;


			case 29:
				this.m.CharacterScreen.toggleBrotherReserves();
				break;
			}

			return true;
		}

		if (this.m.CampfireScreen != null && this.m.CampfireScreen.isVisible() && _key.getState() == 0)
		{
			switch(_key.getKey())
			{
			case 41:
			case 26:
				this.m.CampfireScreen.onModuleClosed();
				break;
			}
		}
		else if (_key.getState() == 0)
		{
			switch(_key.getKey())
			{
			case 41:
				if (this.m.WorldMenuScreen.isAnimating())
				{
					return false;
				}

				if (this.toggleMenuScreen())
				{
					return true;
				}

				break;

			case 13:
			case 19:
				if (!this.m.MenuStack.hasBacksteps() || this.m.CharacterScreen.isVisible() || this.m.WorldTownScreen.isVisible() && !this.m.EventScreen.isVisible())
				{
					if (!this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
					{
						this.toggleCharacterScreen();
					}

					return true;
				}

				break;

			case 28:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onRelationsButtonClicked();
				}
				else if (this.m.RelationsScreen.isVisible())
				{
					this.m.RelationsScreen.onClose();
				}

				break;

			case 25:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onObituaryButtonClicked();
				}
				else if (this.m.ObituaryScreen.isVisible())
				{
					this.m.ObituaryScreen.onClose();
				}

				break;

			case 30:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.showCampScreen();
					// if (this.isCampingAllowed())
					// {
					// 	this.onCamp();
					// }
				}

				break;

			//case 32:
			//	if (!this.m.MenuStack.hasBacksteps())
			//	{
			//		this.m.WorldScreen.showDevConsole();
			//		return true;
			//	}
			//	break;

			case 26:
				if (!this.m.MenuStack.hasBacksteps() && !this.m.EventScreen.isVisible() && !this.m.EventScreen.isAnimating())
				{
					this.topbar_options_module_onPerksButtonClicked();
				}

				break;

			case 42:
			case 40:
			case 10:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setPause(!this.isPaused());
					return true;
				}

				break;

			case 1:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setNormalTime();
					break;
				}

			case 2:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.setFastTime();
					break;
				}

			case 16:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.m.WorldScreen.getTopbarOptionsModule().onTrackingButtonPressed();
					return true;
				}

				break;

			case 34:
				if (!this.m.MenuStack.hasBacksteps())
				{
					this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
				}

				break;

			case 75:
				if (!this.m.MenuStack.hasBacksteps() && !this.World.Assets.isIronman())
				{
					this.saveCampaign("quicksave");
				}

				break;

			case 79:
				if (!this.m.MenuStack.hasBacksteps() && !this.World.Assets.isIronman() && this.World.canLoad("quicksave"))
				{
					this.loadCampaign("quicksave");
				}

				break;

			case 14:
				if ((_key.getModifier() & 2) != 0 && this.m.IsAllowingDeveloperMode)
				{
					this.m.IsDeveloperModeEnabled = !this.m.IsDeveloperModeEnabled;

					if (this.m.IsDeveloperModeEnabled)
					{
						this.logDebug("*** DEVELOPER MODE ENABLED ***");
					}
					else
					{
						this.logDebug("*** DEVELOPER MODE DISABLED ***");
					}
				}

				break;

			case 1:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(0);
				return true;

			case 2:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(1);
				return true;

			case 3:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(2);
				return true;

			case 4:
				if (!this.m.EventScreen.isVisible() || this.m.EventScreen.isAnimating())
				{
					break;
				}

				this.m.EventScreen.onButtonPressed(3);
				return true;

			case 95:
				this.m.IsForcingAttack = false;
				return true;
			}
		}

		if (_key.getState() == 1 && !this.m.MenuStack.hasBacksteps())
		{
			switch(_key.getKey())
			{
			case 11:
			case 27:
			case 48:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(-1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66), 0);
					return true;
				}

				break;

			case 14:
			case 50:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66), 0);
					return true;
				}

				break;

			case 33:
			case 36:
			case 49:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(0, 1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66));
					return true;
				}

				break;

			case 29:
			case 51:
				if (_key.getModifier() != 2)
				{
					if (this.Settings.getTempGameplaySettings().CameraLocked)
					{
						this.m.WorldScreen.getTopbarOptionsModule().onCameraLockButtonPressed();
					}

					this.World.getCamera().move(0, -1500.0 * this.Time.getDelta() * this.Math.maxf(1.0, this.World.getCamera().Zoom * 0.66));
					return true;
				}

				break;

			case 67:
			case 46:
				this.World.getCamera().zoomBy(-this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.15);
				break;

			case 68:
			case 47:
				this.World.getCamera().zoomBy(this.Time.getDelta() * this.Math.max(60, this.Time.getFPS()) * 0.15);
				break;

			case 96:
			case 39:
				this.World.getCamera().Zoom = 1.0;
				this.World.getCamera().setPos(this.World.State.getPlayer().getPos());
				break;

			case 95:
				if (this.m.MenuStack.hasBacksteps())
				{
				}
				else
				{
					this.m.IsForcingAttack = true;
					return true;
				}
			}
		}
	}

	o.getRefFromID <- function ( _id )
	{
		if (_id == -1) return null;

		if (_id > this.m.IDToRef.len() - 1) return null;

		local val = this.m.IDToRef[_id];
		if (val == -1) {
			return null
		}
		return val;
	}

	o.removeCompanyID <- function ( _id )
	{
		this.m.IDToRef[_id] = -1;
	}

	o.addNewID <- function ( _actor ) //return the id we gave and also put wtr into id slot
	{
		for ( local i = 0; i < 27; i++ )
		{
			if (this.m.IDToRef[i] == -1)
			{
				this.m.IDToRef[i] = this.WeakTableRef(_actor);
				return i;
			}
		}
	}

	o.setDistantVisionBonus <- function ( _bonus )
	{
		this.m.DistantVisionBonus = _bonus;
	}

	o.getDistantVisionBonus <- function ()
	{
		return this.m.DistantVisionBonus;
	}

	local onBeforeSerialize = o.onBeforeSerialize;
	o.onBeforeSerialize = function ( _out )
	{
		local meta = _out.getMetaData();
		meta.setString("legendsVersion", ::Legends.Version);
		onBeforeSerialize( _out );
	}

	local onBeforeDeserialize = o.onBeforeDeserialize;
	o.onBeforeDeserialize = function ( _in )
	{
		onBeforeDeserialize( _in );
		this.logInfo("Legends version in save: " + _in.getMetaData().getString("legendsVersion"));
		this.logInfo("Current Legends version: " + ::Legends.Version);
	}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		onSerialize( _out );
		this.World.Camp.onSerialize(_out);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
		if (this.m.EscortedEntity == null)
		{
			this.World.State.setCampingAllowed(true);
			this.World.State.setEscortedEntity(null);
			this.World.State.getPlayer().setVisible(true);
			this.World.Assets.setUseProvisions(true);
		}

		if (_in.getMetaData().getVersion() >= 52)
		{
			this.World.Camp.clear();
			this.World.Camp.onDeserialize(_in);
		}
		this.World.State.m.AppropriateTimeToRecalc = 1;	//Leonion's fix
		this.World.State.getPlayer().calculateModifiers(); //Leonion's fix
	}
});
