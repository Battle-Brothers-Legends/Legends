this.party <- this.inherit("scripts/entity/world/world_entity", {
	m = {
		BaseMovementSpeed = 100.0,
		StashInventory = null,
		Destination = null,
		Path = null,
		LastFootprintTime = 0.0,
		LastFootprintType = 1,
		Footprints = this.Const.GenericFootprints,
		FootprintSizeOverride = 0.0,
		FootprintType = 0,
		IdleSoundsIndex = 0,
		OriginalStrength = 0.0,
		SpawnTime = 0.0,
		StunTime = -900.0,
		Loot = {
			Money = 0,
			Ammo = 0,
			Medicine = 0,
			ArmorParts = 0
		},
		Controller = null,
		LastUpdateTime = this.Time.getVirtualTimeF(),
		LastIdleSoundTime = 0.0,
		IsSlowerAtNight = true,
		IsPlayer = false,
		IsMirrored = false,
		IsLeavingFootprints = true,
		IsAlwaysAttackingPlayer = false
	},
	function getController()
	{
		return this.m.Controller;
	}

	function getPath()
	{
		return this.m.Path;
	}

	function getSpawnTime()
	{
		return this.m.SpawnTime;
	}

	function getOriginalStrength()
	{
		return this.m.OriginalStrength;
	}

	function getBaseMovementSpeed()
	{
		return this.m.BaseMovementSpeed;
	}

	function getFootprintsSize()
	{
		return this.Math.minf(1.0, this.Math.maxf(0.4, this.m.Troops.len() * 0.05));
	}

	function getFootprintType()
	{
		return this.m.FootprintType;
	}

	function setDestination( _dest )
	{
		this.m.Destination = _dest;
	}

	function getStashInventory()
	{
		return this.m.StashInventory;
	}
	
	function setOrigin( _origin )
	{
		this.getFlags().set("CaravanOrigin", _origin.getID());
	}

	function getOrigin()
	{
		return this.getFlags().has("CaravanOrigin") ? this.World.getEntityByID(this.getFlags().get("CaravanOrigin")) : null;
	}	

	function setPath( _path )
	{
		this.m.Path = _path;
	}

	function setMirrored( _m )
	{
		this.m.IsMirrored = _m;
	}

	function setFootprints( _f )
	{
		this.m.Footprints = _f;
	}

	function setIdleSoundsIndex( _s )
	{
		this.m.IdleSoundsIndex = _s;
	}

	function hasPath()
	{
		return this.m.Path != null;
	}

	function setOriginalStrength( _v )
	{
		this.m.OriginalStrength = _v;
	}

	function setMovementSpeed( _v )
	{
		this.m.BaseMovementSpeed = _v;
	}

	function setSlowerAtNight( _s )
	{
		this.m.IsSlowerAtNight = _s;
	}

	function setLeaveFootprints( _f )
	{
		this.m.IsLeavingFootprints = _f;
	}

	function setFootprintSizeOverride( _s )
	{
		this.m.FootprintSizeOverride = _s;
	}

	function setFootprintType( _t )
	{
		this.m.FootprintType = _t;
	}

	function isSlowerAtNight()
	{
		return this.m.IsSlowerAtNight;
	}

	function isParty()
	{
		return true;
	}

	function setAlwaysAttackPlayer( _f )
	{
		this.m.IsAlwaysAttackingPlayer = _f;
	}

	function isAlwaysAttackingPlayer()
	{
		return this.m.IsAlwaysAttackingPlayer;
	}

	function setCombatID( _v )
	{
		this.m.CombatID = _v;

		if (_v == 0)
		{
			this.getSprite("combat").Visible = false;
		}
		else
		{
			this.getSprite("combat").Visible = true;
		}
	}

	function getBanner()
	{
		if (this.getSprite("banner").HasBrush)
		{
			return this.getSprite("banner").getBrush().Name;
		}
		else
		{
			return "banner_noble_11";
		}
	}

	function setOrders( _o )
	{
	}

	function getOverlayImage()
	{
		return this.Const.Strategic.EntityUIOverlay.Default;
	}

	function stun( _seconds )
	{
		this.m.StunTime = this.Time.getVirtualTimeF() + _seconds;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (!this.isHiddenToPlayer() && this.m.Troops.len() != 0)
		{
			ret.extend(this.getTroopComposition());
		}
		else
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/orientation/player_01_orientation.png",
				text = "Unknown troops"
			});
		}

		local f = this.World.FactionManager.getFaction(this.getFaction());

		if (this.getFlags().has("CaravanOrigin") && f != null)
		{
			local town = this.World.getEntityByID(this.getFlags().get("CaravanOrigin"));

			if (town != null)
			{
				ret.push({
					id = 50,
					type = "hint",
					icon = f.getUIBanner(),
					text = "A caravan from " + town.getName()
				});
			}
		}

		if (this.m.Flags.get("IsMercenaries") == true)
		{
			ret.push({
				id = 50,
				type = "hint",
				icon = f.getUIBanner(),
				text = "Hired by " + f.getName()
			});
		}
		else if (f != null && !f.isAlwaysHidden())
		{
			ret.push({
				id = 50,
				type = "hint",
				icon = f.getUIBanner(),
				text = "From " + f.getName()
			});
		}

		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue() && this.World.Assets.m.IsBrigand && this.m.Flags.get("IsCaravan"))
		{
			local inv = this.getStashInventory().getItems();

			if (inv.len() == 0)
			{
				ret.push({
					id = 51,
					type = "text",
					text = "[u]Inventory is empty[/u]"
				});
			}
			else
			{
				local num = ::Math.min(inv.len(), ::Const.World.Common.WorldEconomy.AmountOfLeakedCaravanInventoryInfo);

				ret.push({
					id = 51,
					type = "text",
					text = "[u]Transporting:[/u]"
				});

				for (local i = 0; i < num; ++i)
				{
					ret.push({
						id = 52 + i,
						type = "text",
						icon = "ui/items/" + inv[i].getIcon(),
						text = inv[i].getName()
					});
				}

				if (inv.len() > ::Const.World.Common.WorldEconomy.AmountOfLeakedCaravanInventoryInfo)
				{
					ret.push({
						id = 53 + num,
						type = "text",
						text = "And " + (inv.len() - ::Const.World.Common.WorldEconomy.AmountOfLeakedCaravanInventoryInfo) + " more item(s)"
					});
				}
			}
		}

		if (this.Const.LegendMod.DebugMode)
		{
			ret.extend([
				{
					id = 6,
					type = "hint",
					text = "Resources: " + this.getResources()
				},
				{
					id = 6,
					type = "hint",
					text = "Goods: " + this.getInventory().len()
				}
			]);
		}

		return ret;
	}

	function create()
	{
		this.world_entity.create();
		this.m.IsAttackable = true;
		this.m.SpawnTime = this.Time.getVirtualTimeF();

		this.m.StashInventory = this.new("scripts/items/stash_container");
		this.m.StashInventory.setResizable(true);
		this.m.StashInventory.setID("caravan");

		if (!this.m.IsPlayer)
		{
			this.m.Controller = this.new("scripts/ai/world/world_controller");
			this.m.Controller.setEntity(this);
		}
	}

	function onUpdate()
	{
		this.world_entity.onUpdate();
		local delta = this.Math.maxf(0.0, this.Time.getVirtualTimeF() - this.m.LastUpdateTime);
		this.m.LastUpdateTime = this.Time.getVirtualTimeF();

		if (this.isInCombat())
		{
			this.setOrders("Fighting");
			return;
		}

		if (this.m.StunTime > this.Time.getVirtualTimeF())
		{
			return;
		}

		if (this.m.Controller != null)
		{
			this.m.Controller.think();
		}

		if (this.m.Flags.get("IsAlps"))
		{
			this.m.IsLeavingFootprints = false;

			if (this.World.getTime().IsDaytime)
			{
				this.m.VisibilityMult = 0.0;
				this.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
			}
			else
			{
				this.m.VisibilityMult = 1.0;
				this.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
			}
		}

		if (this.m.Path != null)
		{
			if (this.m.Path.isAtWaypoint(this.getPos()))
			{
				this.m.Path.pop();

				if (this.m.Path.isEmpty())
				{
					this.m.Path = null;
					this.m.Destination = null;
				}
			}

			if (this.m.Path != null)
			{
				this.m.Destination = this.World.tileToWorld(this.m.Path.getCurrent());
			}
		}

		if (this.m.Destination != null)
		{
			if (this.m.IsMirrored)
			{
				if (this.getSprite("bodyUp").HasBrush)
				{
					if (this.m.Destination.Y < this.getPos().Y)
					{
						this.getSprite("bodyUp").Visible = false;
						this.getSprite("body").Visible = true;
					}
					else
					{
						this.getSprite("bodyUp").setHorizontalFlipping(this.m.Destination.X < this.getPos().X);
						this.getSprite("bodyUp").Visible = true;
						this.getSprite("body").Visible = false;
					}
				}

				this.getSprite("body").setHorizontalFlipping(this.m.Destination.X < this.getPos().X);
			}

			local myTile = this.getTile();
			local speed = this.m.BaseMovementSpeed;

			local terrainTable = this.Const.World.TerrainTypeSpeedMult;
			if (this.getFaction() == this.Const.Faction.Player)
			{
				local tTable = [];
				tTable.resize(terrainTable.len(), 0);
				for (local i=0; i < terrainTable.len() ; ++i)
				{
					tTable[i] += this.Const.World.TerrainTypeSpeedMult[i];
				}
				local broTable = [];
				foreach( bro in this.World.getPlayerRoster().getAll() )
				{
					broTable = bro.getBackground().getModifiers().Terrain;
					if (broTable == null)
					{
						continue
					}
					for (local i=0; i < broTable.len() ; ++i)
					{
						tTable[i] += broTable[i];
					}
				}
				terrainTable = tTable;
			}

			speed = speed * (1.0 - this.Math.minf(0.5, this.m.Troops.len() * this.Const.World.MovementSettings.SlowDownPartyPerTroop));
			speed = speed * this.Const.World.MovementSettings.GlobalMult;
			if (!this.isIgnoringCollision())
			{
				if (myTile.HasRoad)
				{
					speed = speed * this.Math.maxf(terrainTable[myTile.Type] * this.Const.World.MovementSettings.RoadMult, 1.0);
				}
				else
				{
					speed = speed * terrainTable[myTile.Type];
				}

				if (this.m.IsPlayer)
				{
					speed = speed * this.World.Assets.getTerrainTypeSpeedMult(myTile.Type);
				}
			}

			if (this.m.IsSlowerAtNight && !this.World.isDaytime())
			{
				speed = speed * this.Const.World.MovementSettings.NighttimeMult;
			}

			if (myTile.HasRiver)
			{
				speed = speed * this.Const.World.MovementSettings.RiverMult;
			}

			if (this.getFaction() != this.Const.Faction.Player)
			{
				speed = speed * this.Const.World.MovementSettings.NotPlayerMult;
			}

			speed = speed * delta;

			if (this.m.IsLeavingFootprints && !myTile.IsOccupied)
			{
				if (this.Time.getVirtualTimeF() - this.m.LastFootprintTime >= 1.0)
				{
					local scale;

					if (this.m.FootprintSizeOverride == 0.0)
					{
						scale = this.Math.minf(1.0, this.Math.maxf(0.4, this.m.Troops.len() * 0.05));
					}
					else
					{
						scale = this.m.FootprintSizeOverride;
					}

					this.World.spawnFootprint(this.createVec(this.getPos().X - 5, this.getPos().Y - 15), this.m.Footprints[this.getDirection8To(this.m.Destination)] + "_0" + this.m.LastFootprintType, scale, this.m.FootprintSizeOverride != 0.0 ? 30.0 : 0.0, this.World.Assets.getFootprintVision(), this.m.FootprintType);
					this.m.LastFootprintTime = this.Time.getVirtualTimeF();
					this.m.LastFootprintType = this.m.LastFootprintType == 1 ? 2 : 1;
				}
			}

			if (!this.move(this.m.Destination, speed))
			{
				this.m.Destination = null;
			}
		}

		if (this.m.IdleSoundsIndex != 0 && this.m.LastIdleSound + 10.0 < this.Time.getRealTimeF() && this.Math.rand(1, 100) <= 5 && this.isVisibleToEntity(this.World.State.getPlayer(), 500))
		{
			this.m.LastIdleSound = this.Time.getRealTimeF();
			this.Sound.play(this.Const.SoundPartyAmbience[this.m.IdleSoundsIndex][this.Math.rand(0, this.Const.SoundPartyAmbience[this.m.IdleSoundsIndex].len() - 1)], this.Const.Sound.Volume.Ambience, this.getPos());
		}
	}

	function onCombatStarted()
	{
		this.world_entity.onCombatStarted();
		this.m.Path = null;
		this.m.Destination = null;
	}

	function onCombatLost()
	{
		this.World.EntityManager.onWorldEntityDestroyed(this, false);
		this.world_entity.onCombatLost();
	}

	function onInit()
	{
		this.world_entity.onInit();
		this.registerThinker();
		local label_name = this.addLabel("name");
		label_name.Visible = this.m.IsShowingName && this.Const.World.AI.VisualizeNameOfUnits;
		label_name.Offset = this.createVec(0, 0);
		label_name.Text = this.getName();

		if (!this.isPlayerControlled())
		{
			local label_orders = this.addLabel("orders");
			label_orders.Visible = this.Const.World.AI.VisualizeOrders;
			label_orders.Offset = this.createVec(0, -20);
		}

		if (this.Const.World.AI.VisionDebugMode)
		{
			this.getSprite("debug_vision").Visible = true;
		}

		this.addSprite("banner");
		this.addSprite("base");
		this.addSprite("body");
		this.addSprite("bodyUp");
		local combat = this.addSprite("combat");
		combat.setBrush("battle_animation");
		combat.Visible = false;
	}

	function onFinish()
	{
		this.world_entity.onFinish();
		this.unregisterThinker();
		local f = this.World.FactionManager.getFaction(this.getFaction());

		if (f != null)
		{
			f.removeUnit(this);
		}
	}

	function onDiscovered()
	{
		this.world_entity.onDiscovered();
		local playerRoster = this.World.getPlayerRoster().getAll();
		local lookout = 0;
		
		  if(!World.State.isPaused() && isAttackable() && getFaction() != 0 && !isAlliedWithPlayer() && getTile().getDistanceTo(World.State.getPlayer().getTile()) <= 12)
		  {
			foreach( bro in playerRoster )
			{
				if (bro.getCampAssignment() != this.Const.World.CampBuildings.Scout)
					{
						if (bro.getSkills().hasSkill("perk.lookout"))
							{
							lookout += 1;
							}
					}
			}
			if (lookout > 0)
			{
			World.State.setPause(true);
			}
		  }
	}

	function addToInventory( _i )
	{
		if (typeof _i == "string") this.world_entity.addToInventory(_i);
		else this.m.StashInventory.add(_i);
	}
	
	function clearInventory()
	{
		this.world_entity.clearInventory();
		this.m.StashInventory.clear();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.world_entity.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.m.Loot.Money, _lootTable);
		this.dropAmmo(this.m.Loot.Ammo, _lootTable);
		this.dropMedicine(this.m.Loot.Medicine, _lootTable);
		this.dropArmorParts(this.m.Loot.ArmorParts, _lootTable);

		_lootTable.extend(this.m.StashInventory.getItems());

		if (this.m.Flags.get("IsCaravan"))
		{
			this.World.Statistics.getFlags().increment("CaravansRaided");

			local faction = ::World.FactionManager.getFaction(this.getFaction());
			local faction_flags = faction.getFlags();
			local fcr = faction_flags.getAsInt("FactionsCaravansRaided");
			faction_flags.set("FactionsCaravansRaided", fcr + 1);
		}
	}

	function onSerialize( _out )
	{
		this.world_entity.onSerialize(_out);
		_out.writeF32(this.m.BaseMovementSpeed);
		_out.writeF32(this.m.OriginalStrength);
		_out.writeF32(this.m.SpawnTime);
		_out.writeF32(this.m.LastUpdateTime);
		_out.writeF32(this.m.LastFootprintTime);
		_out.writeU8(this.m.LastFootprintType);
		_out.writeF32(this.m.FootprintSizeOverride);
		_out.writeU16(this.m.FootprintType);

		if (this.m.Controller != null)
		{
			_out.writeI32(1);
			this.m.Controller.onSerialize(_out);
		}
		else
		{
			_out.writeI32(0);
		}

		_out.writeU16(this.m.Loot.Money);
		_out.writeU16(this.m.Loot.Ammo);
		_out.writeU16(this.m.Loot.Medicine);
		_out.writeU16(this.m.Loot.ArmorParts);
		_out.writeBool(this.m.IsMirrored);
		_out.writeBool(this.m.IsSlowerAtNight);
		_out.writeBool(this.m.IsLeavingFootprints);
		_out.writeBool(this.m.IsAlwaysAttackingPlayer);
		_out.writeBool(this.isVisibleInFogOfWar());
		_out.writeF32(this.m.StunTime);
		_out.writeU8(this.m.IdleSoundsIndex);

		this.m.StashInventory.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.world_entity.onDeserialize(_in);
		this.m.BaseMovementSpeed = _in.readF32();
		this.m.OriginalStrength = _in.readF32();
		this.m.SpawnTime = _in.readF32();
		this.m.LastUpdateTime = _in.readF32();
		this.m.LastFootprintTime = _in.readF32();
		this.m.LastFootprintType = _in.readU8();
		this.m.FootprintSizeOverride = _in.readF32();

		if (_in.getMetaData().getVersion() >= 62)
		{
			this.m.FootprintType = _in.readU16();
		}

		local controllerHash = _in.readI32();

		if (controllerHash != 0)
		{
			this.m.Controller.setEntity(this);
			this.m.Controller.onDeserialize(_in);
		}

		this.m.Loot.Money = _in.readU16();
		this.m.Loot.Ammo = _in.readU16();
		this.m.Loot.Medicine = _in.readU16();
		this.m.Loot.ArmorParts = _in.readU16();
		this.m.IsMirrored = _in.readBool();
		this.m.IsSlowerAtNight = _in.readBool();
		this.m.IsLeavingFootprints = _in.readBool();

		if (_in.getMetaData().getVersion() >= 53)
		{
			this.m.IsAlwaysAttackingPlayer = _in.readBool();
		}

		if (_in.getMetaData().getVersion() >= 57)
		{
			this.setVisibleInFogOfWar(_in.readBool());
		}

		this.m.StunTime = _in.readF32();

		if (_in.getMetaData().getVersion() >= 37)
		{
			this.m.IdleSoundsIndex = _in.readU8();
		}

		this.m.StashInventory.onDeserialize(_in);

		if (this.hasLabel("name"))
		{
			this.getLabel("name").Visible = this.m.IsShowingName && this.Const.World.AI.VisualizeNameOfUnits;
		}
	}

});

