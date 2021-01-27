this.defeat_assailant_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		//spawns the enemy when you build/upgrade the base. Uses a scripted fight to set the location. Sets nobles to enemy
		noble_enemy = null,
		Target = null, 
		Destination = null
	},
	function create()
	{
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.TempFlags = this.new("scripts/tools/tag_collection");
		this.createStates();
		this.createScreens();
		this.m.Type = "contract.defeat_assailant_contract";
		this.m.Name = "Defeat the enemy army";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 1500.0;
	}

	function onImportIntro()
	{
		#this.importSettlementIntro();
	}

	function start()
	{
		//looks for closest settlement. Nobles and southern nobles have multiple options, so loop through and select the closest one
		
		
		this.m.Flags.set("MapSeed", this.Time.getRealTime());
		local player_faction = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0]
		local player_base = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0].m.Settlements[0];
		
		local party_difficulty =  300  +  (200 * player_base.m.Size)
		this.m.Destination = this.WeakTableRef(player_base);
		local tile = player_base.getTile();
		local nearest_goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(tile);
		local nearest_orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(tile);
		local nearest_nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local nearest_barbarians = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians) != null ? this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).getNearestSettlement(tile) : null;
		local nearest_oriental_nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState) != null ? this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState) : null;
		
		local nearest_noble = null
		local nearest_oriental_noble = null
		
		if (nearest_nobles != null)
		{
			foreach ( noble in nearest_nobles)
			{
				if (noble != this.World.FactionManager.m.Factions[this.World.FactionManager.m.Factions.len()-1])
				{
					if (nearest_noble == null || noble.getNearestSettlement(tile).getTile().getDistanceTo(tile) < nearest_noble.getNearestSettlement(tile).getTile().getDistanceTo(tile))
					{
						nearest_noble = noble
					}
				}
			
			}
			nearest_noble = nearest_noble.getNearestSettlement(tile);
		}

		if (nearest_oriental_nobles != null)
		{
			foreach ( noble in nearest_oriental_nobles)
			{

				if (nearest_oriental_noble == null || noble.getSettlements()[0].getTile().getDistanceTo(tile) < nearest_oriental_noble.getSettlements()[0].getTile().getDistanceTo(tile))
				{
					nearest_oriental_noble = noble
				}
			}
			nearest_oriental_noble = nearest_oriental_noble.getSettlements()[0];
		}
		
		//some kinda bug makes distance be 0 sometimes, need to figure it out but until then set to 9999 if 0
		local goblins_dist = nearest_goblins != null ? nearest_goblins.getTile().getDistanceTo(tile): 9000;
		local goblins_dist = goblins_dist == 0 ? 9999:goblins_dist
		local orcs_dist = nearest_orcs != null ? nearest_orcs.getTile().getDistanceTo(tile): 9000;
		local orcs_dist = orcs_dist == 0 ? 9999:orcs_dist
		local barbarians_dist = nearest_barbarians != null ? nearest_barbarians.getTile().getDistanceTo(tile): 9000;
		local barbarians_dist = barbarians_dist == 0 ? 9999:barbarians_dist
		local nobles_dist = nearest_noble != null ? nearest_noble.getTile().getDistanceTo(tile): 9000;
		local nobles_dist = nobles_dist == 0 ? 9999:nobles_dist
		local oriental_nobles_dist = nearest_oriental_noble != null ? nearest_oriental_noble.getTile().getDistanceTo(tile): 9000;
		local oriental_nobles_dist = oriental_nobles_dist == 0 ? 9999:oriental_nobles_dist
		
		local party;
		local origin;
		
		if (goblins_dist <= orcs_dist && goblins_dist <= barbarians_dist && goblins_dist <= nobles_dist && goblins_dist <= oriental_nobles_dist)
		{
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).stronghold_spawnEntity(nearest_goblins.getTile(), "Goblin Raiders", false, this.Const.World.Spawn.GoblinRaiders, party_difficulty);
			party.setDescription("A warband of goblins.");
			party.setFootprintType(this.Const.World.FootprintsType.Goblins);
			origin = nearest_goblins;
		}
		else if (barbarians_dist <= goblins_dist && barbarians_dist <= orcs_dist && barbarians_dist <= nobles_dist && barbarians_dist <= oriental_nobles_dist)
		{
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Barbarians).stronghold_spawnEntity(nearest_barbarians.getTile(), "Barbarians", false, this.Const.World.Spawn.Barbarians, party_difficulty);
			party.setDescription("A warband of barbarian tribals.");
			party.setFootprintType(this.Const.World.FootprintsType.Barbarians);
			origin = nearest_barbarians;
		}
		else if (nobles_dist <= goblins_dist && nobles_dist <= orcs_dist && nobles_dist <= barbarians_dist && nobles_dist <= oriental_nobles_dist)
		{
			party = nearest_noble.getFactionOfType(this.Const.FactionType.NobleHouse).stronghold_spawnEntity(nearest_noble.getTile(), "Noble Army", false, this.Const.World.Spawn.Noble, party_difficulty);
			party.setDescription("An army of noble soldiers.");
			party.setFootprintType(this.Const.World.FootprintsType.Nobles);
			origin = nearest_noble;
			this.m.Flags.set("EnemyNobleHouse", origin.getFactionOfType(this.Const.FactionType.NobleHouse).getID());
			
		}
		else if (oriental_nobles_dist <= goblins_dist && oriental_nobles_dist <= orcs_dist && oriental_nobles_dist <= barbarians_dist && oriental_nobles_dist <= nobles_dist)
		{
			party = nearest_oriental_noble.getFactionOfType(this.Const.FactionType.OrientalCityState).stronghold_spawnEntity(nearest_oriental_noble.getTile(), "Oriental noble Army", false, this.Const.World.Spawn.Southern, party_difficulty);
			party.setDescription("An army of oriental noble soldiers.");
			party.setFootprintType(this.Const.World.FootprintsType.Nobles);
			origin = nearest_oriental_noble;
			this.m.Flags.set("EnemyNobleHouse", origin.getFactionOfType(this.Const.FactionType.OrientalCityState).getID())
		}
		else
		{
			party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).stronghold_spawnEntity(nearest_orcs.getTile(), "Orc Marauders", false, this.Const.World.Spawn.OrcRaiders, party_difficulty);
			party.setDescription("A warband of orcs.");
			party.setFootprintType(this.Const.World.FootprintsType.Orcs);
			origin = nearest_orcs;
		}

			
		//spawn the party, assign AI controller, give the order to intercept the player. switches contract state to running straight away, no offer here
		party.getLoot().ArmorParts = this.Math.rand(10, 30);
		party.getLoot().Medicine = this.Math.rand(1, 3);
		party.getLoot().Ammo = this.Math.rand(0, 30);
		party.getLoot().Money = this.Math.rand(200, 300);
		party.getSprite("banner").setBrush(origin.getBanner());
		party.getSprite("selection").Visible = true
		party.setMovementSpeed(70);
		party.setAttackableByAI(false);
		party.setVisibleInFogOfWar(true);
		party.setImportant(true);
		party.setDiscovered(true);
		this.m.Target = this.WeakTableRef(party);
		party.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local destroy = this.new("scripts/ai/world/orders/destroy_order_alt");
		destroy.setTargetTile(tile);
		destroy.setTargetID(player_base.getID());
		destroy.setTime(120.0);
		c.addOrder(destroy);
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(despawn);
		this.m.IsStarted = true;
		this.World.Contracts.setActiveContract(this);
		this.setState("Running")

	}
	
	function getBanner()
	{
		return "ui/banners/factions/banner_06s"
	}
	
	function onDestinationAttacked(_dest, _isPlayerAttacking)
	{
		//sets noble to enemy, also makes sure mercs join
		if (this.m.Flags.get("EnemyNobleHouse"))
		{
			this.World.FactionManager.getFaction(this.m.Flags.get("EnemyNobleHouse")).setIsTemporaryEnemy(true)
			local entities = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 3.0);
			foreach(entity in entities)
			{
				if (entity.getDescription() == "A band of mercenaries defending the stronghold.")
				{
					local noble = this.World.FactionManager.getFaction(this.m.Flags.get("EnemyNobleHouse"))
					local player_faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player)
					noble.removeAlly(player_faction.getID());
					player_faction.removeAlly(noble.getID());

				}
			}
		}
		local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
		p.CombatID = "HoldChokepoint";
		p.Music = this.Const.Music.NobleTracks;
		local isPlayerInitiated = false;
		//special location if fighting at stronghold
		if (this.isPlayerAt(this.m.Home))
		{
			isPlayerInitiated = false;
			p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineForward;
			p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
			p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
			p.LocationTemplate.OwnedByFaction = this.Const.Faction.Player;
			p.LocationTemplate.Template[0] = "tactical.mod_fortress_defense";
			p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.WallsAndPalisade;
			p.LocationTemplate.ShiftX = -10;
		}

		this.World.Contracts.startScriptedCombat(p, isPlayerInitiated, true, true);
		
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Running",
			function start()
			{

			}
			function update()
			{
				if (!this.Contract.m.Flags.get("Sprite_Set") && this.Contract.m.Home.getSize() == 1)
				{
					this.Contract.setScreen("Select_Sprites")
					this.World.Contracts.showActiveContract();
				}
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull())
				{
						this.Contract.m.Flags.set("combat_won", true);
						this.Contract.setState("After_Battle");
				}
				else if (this.Contract.m.Origin == null || this.Contract.m.Origin.isNull() || !this.Contract.m.Origin.isAlive())
				{
					this.Contract.setState("After_Battle");
				}
					
				else if (this.Contract.isPlayerAt(this.Contract.m.Target))
				{
					this.Contract.onDestinationAttacked(this.Contract.m.Target, false);
				}
			}
			
			
			function onCombatVictory( _combatID )
			{
				this.Contract.m.Flags.set("combat_won", true);
			}			
			
		
			function end()
			{
			}

		});
		this.m.States.push({
			ID = "After_Battle",
			function start()
			{
				if (this.Contract.m.Flags.get("combat_won"))
				{
					this.Contract.setScreen("Victory");
				}
				else{
					this.Contract.setScreen("Failure");
				}
				this.World.Contracts.showActiveContract();
					
			}
			function update()
			{
			}		
			function end()
			{
			}

		});
		

	}

	function createScreens()
	{
		this.m.Screens.push({
		
			ID = "Select_Sprites",
			Title = "Select faction",
			Text = "How would you like the appearance of your base to be?",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Noble (default).",
					function getResult()
					{
						this.Contract.m.Flags.set("Sprite_Set", true)
					}

				},
				{
					Text = "Barbarian",
					function getResult()
					{
						this.getPlayerBase().m.Flags.set("BarbarianSprites", true)
						this.Contract.m.Flags.set("Sprite_Set", true)
						this.getPlayerBase().updateTown()
					}

				},
				{
					Text = "Nomad",
					function getResult()
					{
						this.getPlayerBase().m.Flags.set("NomadSprites", true)
						this.Contract.m.Flags.set("Sprite_Set", true)
						this.getPlayerBase().updateTown()

					}

				},
			],
			ShowObjectives = false,
			ShowPayment = false,
			ShowEmployer = false,
			ShowDifficulty = false,
			function start()
			{
			}
		});
		this.m.Screens.push({
		
			ID = "Victory",
			Title = "Victory!",
			Text = "You have defeated the enemies. Your fortress is now secure and you have placed yourself among the lords of these lands.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Excellent.",
					function getResult()
					{
						this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player).updateAlliancesPlayerFaction()
						/*
						if (this.getPlayerBase().getSize() == 1)
						{
							return "Select_Sprites"
						}*/
						this.World.Contracts.finishActiveContract();
						return 0;

					}

				},
			],
			ShowObjectives = false,
			ShowPayment = false,
			ShowEmployer = false,
			ShowDifficulty = false,
			function start()
			{
			}
		});
		
		this.m.Screens.push({
			ID = "Failure",
			Title = "Failure!",
			Text = "{You ran from the battle. Your fortress has been wiped from the map. You are a failure!}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "This was unwise.",
					function getResult()
					{
						this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player).updateAlliancesPlayerFaction()
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				},
			],
			function start()
			{
			}

		});
	}
	
	function onPrepareVariables( _vars )
	{
	}

	function onHomeSet()
	{
	}
	
	function onCancel()
	{
		intentionalError;
		
	}
	
	function onClear()
	{
		if (this.m.IsActive)
		{
			this.World.FactionManager.getFaction(this.getFaction()).setActive(true);
			if(!this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0].m.Settlements.len() == 0){
				this.m.Home.getSprite("selection").Visible = false;
			}

		}

	}

	function onIsValid()
	{
		return true;
	}
	function cancel()
	{
		this.onCancel();
	}

	function onSerialize( _out )
	{
		_out.writeI32(0);

		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}
		if (this.m.Target != null && !this.m.Target.isNull())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		_in.readI32();
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
			this.m.Target.getSprite("selection").Visible = true
			this.m.Target.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
		}
		this.contract.onDeserialize(_in);

	}

});

