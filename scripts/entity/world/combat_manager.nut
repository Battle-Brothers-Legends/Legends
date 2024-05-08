this.combat_manager <- {
	m = {
		Combats = [],
		LastCombatTick = 0.0,
		NextCombatID = 1
	},
	function clear()
	{
		this.m.Combats = [];
		this.m.LastCombatTick = 0.0;
		this.m.NextCombatID = 1;
	}

	function startCombat( _p1, _p2 )
	{
		local p1 = typeof _p1 == "instance" ? _p1.get() : _p1;
		local p2 = typeof _p2 == "instance" ? _p2.get() : _p2;

		if (!p1.isAttackable() || !p2.isAttackable())
		{
			this.logError("Entity cannot be attacked!");
			return;
		}

		if (p1.isInCombat() && p2.isInCombat())
		{
			return;
		}

		p1.onBeforeCombatStarted();
		p2.onBeforeCombatStarted();

		if (!p1.isAlive() || !p2.isAlive())
		{
			return;
		}

		if (p1.getTroops().len() == 0 || p2.getTroops().len() == 0)
		{
			return;
		}

		if (!p1.isInCombat() && p2.isInCombat())
		{
			foreach( combat in this.m.Combats )
			{
				if (combat.ID == p2.getCombatID())
				{
					this.joinCombat(combat, p1);
					return;
				}
			}
		}
		else if (p1.isInCombat() && !p2.isInCombat())
		{
			foreach( combat in this.m.Combats )
			{
				if (combat.ID == p1.getCombatID())
				{
					this.joinCombat(combat, p2);
					return;
				}
			}
		}

		local stats = {
			Dead = 0,
			Loot = []
		};
		local combat = {
			ID = this.m.NextCombatID++,
			IsResolved = false,
			Stats = stats,
			Combatants = [],
			Factions = []
		};
		local numFactions = 32;
		if (p1.getFaction() >= numFactions) {
			numFactions = p1.getFaction() + 1;
		}
		if (p2.getFaction() >= numFactions) {
			numFactions = p2.getFaction() + 1;
		}

		combat.Factions.resize(numFactions);

		for( local f = 0; f != numFactions; f = ++f )
		{
			combat.Factions[f] = [];
		}

		this.joinCombat(combat, p1);
		this.joinCombat(combat, p2);
		this.m.Combats.push(combat);
	}

	function joinCombat( _combat, _party )
	{
		if (_party == null)
		{
			return;
		}

		local troops = _party.getTroops();

		foreach( t in troops )
		{
			t.Initiative <- this.Math.rand(1, 100);
			_combat.Combatants.push(t);
		}

		_combat.Combatants.sort(this.onInitiativeCompare);
		_party.setCombatID(_combat.ID);
		
		_combat.Factions[_party.getFaction()].push(this.WeakTableRef(_party));
		_party.onCombatStarted();
	}

	function update()
	{
		if (this.World.getSpeedMult() == 0.0)
		{
			return;
		}

		if (this.m.LastCombatTick + this.Const.World.CombatSettings.CombatTickTime / this.World.getSpeedMult() < this.Time.getVirtualTimeF())
		{
			this.m.LastCombatTick = this.Time.getVirtualTimeF();
			local garbage = [];

			foreach( combat in this.m.Combats )
			{
				if (!combat.IsResolved)
				{
					this.tickCombat(combat);
				}

				if (combat.IsResolved)
				{
					garbage.push(combat.ID);
				}

				for( local i = 0; i != combat.Factions.len(); i = ++i )
				{
					foreach( party in combat.Factions[i] )
					{
						if (party.isNull() || !party.isAlive())
						{
							if (garbage.find(combat.ID) == null)
							{
								garbage.push(combat.ID);
							}

							continue;
						}

						party.updateStrength();
					}
				}
			}

			foreach( g in garbage )
			{
				for( local i = 0; i != this.m.Combats.len(); i = ++i )
				{
					if (g == this.m.Combats[i].ID)
					{
						local isLooting = false;

						do
						{
							for( local f = 0; f != this.m.Combats[i].Factions.len(); f = ++f )
							{
								for( local p = 0; p != this.m.Combats[i].Factions[f].len(); p = ++p )
								{
									if (this.m.Combats[i].Factions[f][p].isNull() || !this.m.Combats[i].Factions[f][p].isAlive())
									{
									}
									else
									{
										this.m.Combats[i].Factions[f][p].setCombatID(0);

										if (this.m.Combats[i].Factions[f][p].isLooting() && this.m.Combats[i].Stats.Loot.len() != 0)
										{
											isLooting = true;
											this.m.Combats[i].Factions[f][p].addToInventory(this.m.Combats[i].Stats.Loot[0]);
											this.m.Combats[i].Stats.Loot.remove(0);
										}
									}
								}
							}
						}
						while (isLooting && this.m.Combats[i].Stats.Loot.len() != 0);

						local site;

						for( local f = 0; f != this.m.Combats[i].Factions.len(); f = ++f )
						{
							for( local p = 0; p != this.m.Combats[i].Factions[f].len(); p = ++p )
							{
								if (this.m.Combats[i].Factions[f][p].isNull() || !this.m.Combats[i].Factions[f][p].isAlive())
								{
								}
								else
								{
									this.m.Combats[i].Factions[f][p].onCombatWon();

									if (site == null)
									{
										site = this.m.Combats[i].Factions[f][p].getTile();
									}
								}
							}
						}

						if (site != null)
						{
							this.spawnBattleField(site);
						}

						this.m.Combats.remove(i);
						break;
					}
				}
			}
		}
	}

	function tickCombat( _combat )
	{
		local attackOccured = false;

		for( local i = 0; i < _combat.Combatants.len(); i = ++i )
		{
			local combatant = _combat.Combatants[i];

			if (combatant.Party == null || combatant.Party.isNull())
			{
				continue;
			}

			local potentialOpponentFactions = [];

			for( local f = 0; f < _combat.Factions.len(); f = ++f )
			{
				local lFaction = _combat.Factions[f];
				if (lFaction == null || lFaction.len() == 0)
				{
					continue
				}

				if (combatant.Party.getFaction() != f && !this.World.FactionManager.isAllied(combatant.Party.getFaction(), f))
				{
					potentialOpponentFactions.push(f);
				}
			}

			if (potentialOpponentFactions.len() == 0)
			{
				continue;
			}

			local opponentFaction = potentialOpponentFactions[this.Math.rand(0, potentialOpponentFactions.len() - 1)];
			local opponentParty = _combat.Factions[opponentFaction][this.Math.rand(0, _combat.Factions[opponentFaction].len() - 1)];

			if (opponentParty == null || opponentParty.isNull() || opponentParty.getTroops().len() == 0)
			{
				continue;
			}

			local opponentIndex = this.Math.rand(0, opponentParty.getTroops().len() - 1);
			local opponent = opponentParty.getTroops()[opponentIndex];
			attackOccured = true;
			opponent.Strength -= this.Math.max(1, this.Math.rand(1, combatant.Strength) * this.Const.World.CombatSettings.CombatStrengthMult);

			if (opponent.Strength <= 0)
			{
				++_combat.Stats.Dead;
				opponentParty.getTroops().remove(opponentIndex);
				opponentIndex = _combat.Combatants.find(opponent);
				_combat.Combatants.remove(opponentIndex);

				if (opponentIndex < i)
				{
					i = --i;
				}

				if (opponentParty.getTroops().len() == 0)
				{
					_combat.Stats.Loot.extend(opponentParty.getInventory());
					local partyIndex = _combat.Factions[opponentParty.getFaction()].find(opponentParty);
					opponentParty.setCombatID(0);
					_combat.Factions[opponentParty.getFaction()].remove(partyIndex);
					opponentParty.onCombatLost();
				}
			}

		}

		if (!attackOccured)
		{
			_combat.IsResolved = true;
		}
	}

	function abortCombatWithParty( _p )
	{
		if (_p.getCombatID() == 0)
		{
			return;
		}

		foreach( i, combat in this.m.Combats )
		{
			if (combat.ID == _p.getCombatID())
			{
				local numParties = 0;

				for( local f = 0; f != combat.Factions.len(); f = ++f )
				{
					for( local p = 0; p != combat.Factions[f].len(); p = ++p )
					{
						if (combat.Factions[f][p].isNull() || !combat.Factions[f][p].isAlive())
						{
						}
						else
						{
							numParties = ++numParties;
							combat.Factions[f][p].setCombatID(0);
						}
					}
				}

				this.m.Combats.remove(i);
				break;
			}
		}
	}

	function abortAll()
	{
		foreach( i, combat in this.m.Combats )
		{
			local numParties = 0;

			for( local f = 0; f != combat.Factions.len(); f = ++f )
			{
				for( local p = 0; p != combat.Factions[f].len(); p = ++p )
				{
					combat.Factions[f][p].setCombatID(0);
				}
			}
		}

		this.m.Combats = [];
	}

	function spawnBattleField( _site )
	{
		local battlefield;

		if (!_site.IsOccupied)
		{
			battlefield = this.World.spawnLocation("scripts/entity/world/locations/battlefield_location", _site.Coords);
		}
		else
		{
			for( local i = 0; i != 6; i = ++i )
			{
				if (!_site.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = _site.getNextTile(i);

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

	function onInitiativeCompare( _a, _b )
	{
		if (_a.Initiative > _b.Initiative)
		{
			return -1;
		}
		else if (_a.Initiative < _b.Initiative)
		{
			return 1;
		}

		return 0;
	}

	function create()
	{
	}

	function onSerialize( _out )
	{
		_out.writeI32(this.m.NextCombatID);
		_out.writeU16(this.m.Combats.len());

		foreach( c in this.m.Combats )
		{
			_out.writeI32(c.ID);
			_out.writeBool(c.IsResolved);
			_out.writeI32(c.Stats.Dead);
			_out.writeU16(c.Stats.Loot.len());

			foreach( l in c.Stats.Loot )
			{
				_out.writeString(l);
			}

			local parties = [];

			for( local f = 0; f != c.Factions.len(); f = ++f )
			{
				local faction = c.Factions[f];
				if (faction == null || faction.len() == 0){
					continue;
				}

				for( local p = 0; p != faction.len(); p = ++p )
				{
					if (c.Factions[f][p] != null && !c.Factions[f][p].isNull() && c.Factions[f][p].isAlive())
					{
						parties.push(c.Factions[f][p].getID());
					}
				}
			}

			_out.writeU16(parties.len());

			foreach( p in parties )
			{
				_out.writeU32(p);
			}
		}
	}

	function onDeserialize(_in)
	{
		this.clear();
		this.m.NextCombatID = _in.readI32();
		local numCombats = _in.readU16();

		for( local i = 0; i < numCombats; i = ++i )
		{
			local stats = {
				Dead = 0,
				Loot = []
			};
			local combat = {
				ID = 0,
				IsResolved = false,
				Stats = stats,
				Combatants = [],
				Factions = []
			};
			combat.Factions.resize(32);

			for( local f = 0; f != 32; f = ++f )
			{
				combat.Factions[f] = [];
			}

			combat.ID = _in.readI32();
			combat.IsResolved = _in.readBool();
			combat.Stats.Dead = _in.readI32();
			local numLoot = _in.readU16();

			for( local i = 0; i != numLoot; i = ++i )
			{
				combat.Stats.Loot.push(_in.readString());
			}

			local numParties = _in.readU16();

			for( local p = 0; p < numParties; p = ++p )
			{
				local party = this.World.getEntityByID(_in.readU32());
				if (party.getFaction() >= combat.len()) {
					combat.Factions.resize(party.getFaction() + 1);
					for( local f = party.getFaction(); f != party.getFaction() + 1; f = ++f )
					{
						combat.Factions[f] = [];
					}
				}
				this.joinCombat(combat, party);
			}

			this.m.Combats.push(combat);
		}
	}

};

