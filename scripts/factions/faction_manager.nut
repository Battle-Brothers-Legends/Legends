this.faction_manager <- {
	m = {
		Factions = [],
		NextFactionToUpdate = 0,
		LastRelationUpdateDay = 0,
		GreaterEvil = {
			Type = 0,
			LastType = 0,
			TypesUsed = 0,
			Phase = 0,
			NextPhaseTime = 0.0,
			Strength = 0.0,
			LastUpdate = 0,
			IsExtraLate = false
		}
	},
	function getGreaterEvilType()
	{
		return this.m.GreaterEvil.Type;
	}

	function getGreaterEvilPhase()
	{
		return this.m.GreaterEvil.Phase;
	}

	function getGreaterEvilStrength()
	{
		return this.m.GreaterEvil.Strength;
	}

	function getGreaterEvil()
	{
		return this.m.GreaterEvil;
	}

	function getFaction( _i )
	{
		return this.m.Factions[_i];
	}

	function isGreaterEvil()
	{
		return this.m.GreaterEvil.Phase == this.Const.World.GreaterEvilPhase.Live;
	}

	function isCivilWar()
	{
		return this.m.GreaterEvil.Type == 1 && this.m.GreaterEvil.Phase == this.Const.World.GreaterEvilPhase.Live;
	}

	function isGreenskinInvasion()
	{
		return this.m.GreaterEvil.Type == 2 && this.m.GreaterEvil.Phase == this.Const.World.GreaterEvilPhase.Live;
	}

	function isUndeadScourge()
	{
		return this.m.GreaterEvil.Type == 3 && this.m.GreaterEvil.Phase == this.Const.World.GreaterEvilPhase.Live;
	}

	function addGreaterEvilStrength( _strength )
	{
		if (this.m.GreaterEvil.Phase == 0)
		{
			return;
		}

		this.m.GreaterEvil.Strength += _strength;
	}

	function getFactionOfType( _t )
	{
		foreach( f in this.m.Factions )
		{
			if (f != null && f.getType() == _t)
			{
				return f;
			}
		}

		return null;
	}

	function getFactionsOfType( _t )
	{
		local result = [];

		foreach( f in this.m.Factions )
		{
			if (f != null && f.getType() == _t)
			{
				result.push(f);
			}
		}

		return result;
	}

	function getFactions( _sort = false )
	{
		if (!_sort)
		{
			return this.m.Factions;
		}
		else
		{
			local f = clone this.m.Factions;
			f.sort(this.onFactionCompare);
			return f;
		}
	}

	function isAllied( _f1, _f2 )
	{
		if (this.m.Factions[_f1] == null && this.m.Factions[_f2] != null)
		{
			local tmp = _f1;
			_f1 = _f2;
			_f2 = tmp;
		}

		return this.m.Factions[_f1] == null || this.m.Factions[_f1].isAlliedWith(_f2);
	}

	function isAlliedWithPlayer( _f )
	{
		return this.m.Factions[_f] == null || this.m.Factions[_f].isAlliedWith(1);
	}

	function getAlliedFactions( _f )
	{
		if (this.m.Factions[_f] != null)
		{
			return this.m.Factions[_f].getAllies();
		}
		else
		{
			local allies = [
				1,
				2
			];

			foreach( i, f in this.m.Factions )
			{
				if (f != null && f.isAlliedWith(_f))
				{
					allies.push(i);
				}
			}

			return allies;
		}
	}

	function create()
	{
		this.clear();
	}

	function update()
	{
		if (this.m.LastRelationUpdateDay != this.World.getTime().Days)
		{
			this.m.LastRelationUpdateDay = this.World.getTime().Days;

			foreach( f in this.m.Factions )
			{
				if (f != null)
				{
					f.normalizeRelation();
				}
			}
		}

		if (++this.m.NextFactionToUpdate >= this.m.Factions.len())
		{
			this.m.NextFactionToUpdate = 0;
		}

		if (this.m.Factions[this.m.NextFactionToUpdate] != null)
		{
			this.m.Factions[this.m.NextFactionToUpdate].update();
		}

		this.updateGreaterEvil();
	}

	function runSimulation()
	{
		this.logInfo("Running simulation for " + this.Const.Factions.CyclesOnNewCampaign + " cycles...");
		local bandits = this.getFactionOfType(this.Const.FactionType.Bandits);
		local orcs = this.getFactionOfType(this.Const.FactionType.Orcs);
		local goblins = this.getFactionOfType(this.Const.FactionType.Goblins);
		local undead = this.getFactionOfType(this.Const.FactionType.Undead);
		local zombies = this.getFactionOfType(this.Const.FactionType.Zombies);
		local beasts = this.getFactionOfType(this.Const.FactionType.Beasts);

		for( local i = 0; i < this.Const.Factions.CyclesOnNewCampaign; i = ++i )
		{
			if (i % 100 == 0){
				this.logInfo("Cylce number " + i)
			}
			bandits.update(true);
			goblins.update(true);
			orcs.update(true);
			undead.update(true);
			zombies.update(true);
			beasts.update(true);
		}
	}

	function clear()
	{
		this.m.Factions = [];
		this.m.Factions.push(null);
		this.m.Factions.push(null);
		this.m.Factions.push(null);
	}

	function createFactions( _settings )
	{
		this.createGenericEnemy();
		this.createSettlements();
		local nobles = this.createNobleHouses(_settings.NumFactions);
		this.assignSettlementsToNobleHouses(nobles);
		this.uncoverSettlements( _settings.FOW );
		this.createBandits();
		this.createOrcs();
		this.createGoblins();
		this.createUndead();
		this.createZombies();
		this.createAlliances();

		foreach( f in this.m.Factions )
		{
			if (f != null)
			{
				f.onUpdateRoster();
			}
		}
	}

	function uncoverSettlements( _fow )
	{
		foreach( s in this.World.EntityManager.getSettlements() )
		{
			s.setDiscovered(true);
			if (s.getOwner() != null || s.getSize() >= 2)
			{
				local vis = 2100;
				if (_fow)
				{
					vis = 0;
				}
				this.World.uncoverFogOfWar(s.getTile().Pos, vis);
			}
		}
	}

	function createGenericEnemy()
	{
		local f = this.new("scripts/factions/beast_faction");
		f.setID(this.m.Factions.len());
		f.setName("Enemy");
		f.setDiscovered(true);
		f.addTrait(this.Const.FactionTrait.Beasts);
		this.m.Factions.push(f);
	}

	function createBandits()
	{
		local f = this.new("scripts/factions/bandit_faction");
		f.setID(this.m.Factions.len());
		f.setName("Bandits");
		f.setDiscovered(true);
		f.addTrait(this.Const.FactionTrait.Bandit);
		this.m.Factions.push(f);
	}

	function createOrcs()
	{
		local f = this.new("scripts/factions/orc_faction");
		f.setID(this.m.Factions.len());
		f.setName("Orcs");
		f.setDiscovered(true);
		f.addTrait(this.Const.FactionTrait.Orc);
		this.m.Factions.push(f);
	}

	function createGoblins()
	{
		local f = this.new("scripts/factions/goblin_faction");
		f.setID(this.m.Factions.len());
		f.setName("Goblins");
		f.setDiscovered(true);
		f.addTrait(this.Const.FactionTrait.Goblin);
		this.m.Factions.push(f);
	}

	function createUndead()
	{
		local f = this.new("scripts/factions/undead_faction");
		f.setID(this.m.Factions.len());
		f.setName("Undead");
		f.setDiscovered(true);
		f.addTrait(this.Const.FactionTrait.Undead);
		this.m.Factions.push(f);
	}

	function createZombies()
	{
		local f = this.new("scripts/factions/zombies_faction");
		f.setID(this.m.Factions.len());
		f.setName("Necromancers");
		f.setDiscovered(true);
		f.addTrait(this.Const.FactionTrait.Zombies);
		this.m.Factions.push(f);
	}

	function createNobleHouses( _num )
	{
		local banners = [];
		local names = [];
		local nobleHouses = [];

		local houses = this.Const.GetFactionArchetypesList();
		for (local i = 0; i < _num; i = ++i)
		{
			local index = houses.remove(this.Math.rand(0, houses.len() - 1));
			local a = this.Const.FactionArchetypes[index[0]][index[1]];
			local f = this.new("scripts/factions/noble_faction");
			local banner;

			do
			{
				banner = this.Math.rand(1, 10);
			}
			while (banners.find(banner) != null);

			banners.push(banner);
			local name;

			do
			{
				name = this.Const.Strings.NobleHouseNames[this.Math.rand(0, this.Const.Strings.NobleHouseNames.len() - 1)];
			}
			while (names.find(name) != null);

			names.push(name);
			f.setID(this.m.Factions.len());
			f.setName(name);
			f.setMotto("\"" + a.Mottos[this.Math.rand(0, a.Mottos.len() - 1)] + "\"");
			f.setDescription(a.Description);
			f.setBanner(banner);
			f.setDiscovered(true);

			foreach( t in a.Traits )
			{
				f.addTrait(t);
			}

			this.m.Factions.push(f);
			nobleHouses.push(f);
		}

		return nobleHouses;
	}

	function assignSettlementsToNobleHouses( _nobleHouses )
	{
		local settlements = this.World.EntityManager.getSettlements();
		local military = [];
		local civilian = [];

		foreach( s in settlements )
		{
			if (s.isMilitary())
			{
				military.push(s);
			}
			else
			{
				civilian.push(s);
			}
		}

		military.sort(this.onSizeCompare);

		foreach( i, n in _nobleHouses )
		{
			if (military.len() == 0)
			{
				break;
			}

			n.addSettlement(military[0]);
			military.remove(0);
			local other;

			do
			{
				other = this.Math.rand(0, _nobleHouses.len() - 1);
			}
			while (other == i);

			local description = n.getDescription();
			local vars = [
				[
					"noblehousename",
					n.getNameOnly()
				],
				[
					"regionname",
					"(REGION NAME TODO)"
				],
				[
					"factionfortressname",
					n.getSettlements()[0].getName()
				],
				[
					"othernoblehouse",
					_nobleHouses[other].getNameOnly()
				]
			];
			n.setDescription(this.buildTextFromTemplate(description, vars));
		}

		military.extend(civilian);

		foreach( s in military )
		{
			local best;
			local bestAvgDist = 9000.0;

			foreach( i, n in _nobleHouses )
			{
				local locales = n.getSettlements();
				local avgDist = 0.0;

				foreach( l in locales )
				{
					avgDist = avgDist + l.getTile().getDistanceTo(s.getTile());
				}

				avgDist = avgDist / locales.len();
				avgDist = avgDist + locales.len();

				if (avgDist < bestAvgDist)
				{
					bestAvgDist = avgDist;
					best = n;
				}
			}

			if (best != null)
			{
				best.addSettlement(s);
			}
		}
	}

	function createSettlements()
	{
		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			if (s.isMilitary())
			{
				continue;
			}

			local f = this.new("scripts/factions/settlement_faction");
			f.setID(this.m.Factions.len());
			f.setName(s.getName());
			f.setDescription(s.getDescription());
			f.setBanner(11);
			f.setDiscovered(true);
			this.m.Factions.push(f);
			f.addTrait(this.Const.FactionTrait.Settlement);
			f.addSettlement(s, false);
		}
	}

	function createAlliances()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else
			{
				for( local j = 0; j < this.m.Factions.len(); j = ++j )
				{
					if ((j == 1 || j == 2) && (this.m.Factions[i].getType() == this.Const.FactionType.Settlement || this.m.Factions[i].getType() == this.Const.FactionType.NobleHouse))
					{
						this.m.Factions[i].addAlly(j);
					}
					else if (this.m.Factions[j] == null)
					{
						continue;
					}
					else if (i == j || this.m.Factions[i].getType() == this.m.Factions[j].getType())
					{
						this.m.Factions[i].addAlly(j);
					}
					else if (this.m.Factions[i].getType() == this.Const.FactionType.NobleHouse && this.m.Factions[j].getType() == this.Const.FactionType.Settlement)
					{
						this.m.Factions[i].addAlly(j);
					}
					else if (this.m.Factions[i].getType() == this.Const.FactionType.Settlement && this.m.Factions[j].getType() == this.Const.FactionType.NobleHouse)
					{
						this.m.Factions[i].addAlly(j);
					}
					else if (this.m.Factions[i].getType() == this.Const.FactionType.Undead && this.m.Factions[j].getType() == this.Const.FactionType.Zombies)
					{
						this.m.Factions[i].addAlly(j);
					}
					else if (this.m.Factions[i].getType() == this.Const.FactionType.Zombies && this.m.Factions[j].getType() == this.Const.FactionType.Undead)
					{
						this.m.Factions[i].addAlly(j);
					}
				}

				this.m.Factions[i].updatePlayerRelation();
			}
		}
	}

	function breakNobleHouseAlliances()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null || this.m.Factions[i].getType() != this.Const.FactionType.NobleHouse)
			{
			}
			else
			{
				for( local j = 0; j < this.m.Factions.len(); j = ++j )
				{
					if (i == j || this.m.Factions[j] == null || this.m.Factions[i].getSettlements().len() == 0)
					{
					}
					else if (this.m.Factions[j].getType() == this.Const.FactionType.NobleHouse)
					{
						this.m.Factions[i].removeAlly(j);
					}
					else if (this.m.Factions[j].getType() == this.Const.FactionType.Settlement && this.m.Factions[j].getSettlements().len() != 0 && this.m.Factions[j].getSettlements()[0].getOwner() != null && this.m.Factions[j].getSettlements()[0].getOwner().getID() != i)
					{
						this.m.Factions[i].removeAlly(j);
					}
				}
			}
		}

		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null || this.m.Factions[i].getType() != this.Const.FactionType.Settlement || this.m.Factions[i].getSettlements().len() == 0)
			{
			}
			else
			{
				local nobleOwner = this.m.Factions[i].getSettlements()[0].getOwner();
				this.m.Factions[i].cloneAlliesFrom(nobleOwner);
			}
		}
	}

	function makeEveryoneFriendlyToPlayer()
	{
		for( local i = 0; i < this.m.Factions.len(); i = ++i )
		{
			if (this.m.Factions[i] == null)
			{
			}
			else if (this.m.Factions[i].getType() == this.Const.FactionType.Settlement || this.m.Factions[i].getType() == this.Const.FactionType.NobleHouse)
			{
				if (this.m.Factions[i].getPlayerRelation() < 30)
				{
					this.m.Factions[i].setPlayerRelation(30.0);
				}
			}
		}
	}

	function onCombatFinished()
	{
		foreach( f in this.m.Factions )
		{
			if (f != null)
			{
				f.setIsTemporaryEnemy(false);
			}
		}
	}

	function onFactionCompare( _f1, _f2 )
	{
		if (_f1 == null && _f2 == null)
		{
			return 0;
		}
		else if (_f1 == null && _f2 != null)
		{
			return -1;
		}
		else if (_f1 != null && _f2 == null)
		{
			return 1;
		}

		if (_f1.getType() == _f2.getType())
		{
			return 0;
		}
		else if (_f1.getType() < _f2.getType())
		{
			return -1;
		}
		else
		{
			return 1;
		}
	}

	function onSizeCompare( _s1, _s2 )
	{
		if (_s1.getSize() > _s2.getSize())
		{
			return -1;
		}
		else if (_s1.getSize() < _s2.getSize())
		{
			return 1;
		}

		return 0;
	}

	function updateGreaterEvil()
	{
		local GE = this.m.GreaterEvil;

		if (GE.Type == this.Const.World.GreaterEvilType.None)
		{
			return;
		}

		if (GE.NextPhaseTime == 0.0)
		{
			if (GE.IsExtraLate)
			{
				GE.NextPhaseTime = this.Time.getVirtualTimeF() + this.Math.rand(100, 120) * this.World.getTime().SecondsPerDay;
			}
			else
			{
				GE.NextPhaseTime = this.Time.getVirtualTimeF() + this.Math.rand(55, 65) * this.World.getTime().SecondsPerDay;
			}

			if (this.World.Assets.isIronman())
			{
				GE.NextPhaseTime += 5.0 * this.World.getTime().SecondsPerDay;
			}
		}
		else if (GE.NextPhaseTime <= this.Time.getVirtualTimeF())
		{
			if (GE.Phase == this.Const.World.GreaterEvilPhase.NotSet && this.World.State.getPlayer().getStrength() >= 210)
			{
				this.logInfo("STARTING GREATER EVIL - WARNING PHASE!");
				GE.Phase = this.Const.World.GreaterEvilPhase.Warning;
				GE.NextPhaseTime = this.Time.getVirtualTimeF() + 20 * this.World.getTime().SecondsPerDay;

				if (GE.Type == 0)
				{
					local possibilities = [];

					if ((GE.TypesUsed & this.Const.World.GreaterEvilTypeBit.CivilWar) == 0 && this.isNoblesFeuding())
					{
						possibilities.push(this.Const.World.GreaterEvilType.CivilWar);
					}

					if ((GE.TypesUsed & this.Const.World.GreaterEvilTypeBit.Greenskins) == 0)
					{
						possibilities.push(this.Const.World.GreaterEvilType.Greenskins);
					}

					if ((GE.TypesUsed & this.Const.World.GreaterEvilTypeBit.Undead) == 0)
					{
						possibilities.push(this.Const.World.GreaterEvilType.Undead);
					}

					if (possibilities.len() != 0)
					{
						GE.Type = possibilities[this.Math.rand(0, possibilities.len() - 1)];
					}
					else
					{
						while (true)
						{
							if (this.isNoblesFeuding())
							{
								GE.Type = this.Math.rand(this.Const.World.GreaterEvilType.Random + 1, this.Const.World.GreaterEvilType.len() - 1);
							}
							else
							{
								GE.Type = this.Math.rand(this.Const.World.GreaterEvilType.Random + 2, this.Const.World.GreaterEvilType.len() - 1);
							}

							if (GE.Type != GE.LastType)
							{
								break;
							}
						}
					}
				}
			}
			else if (GE.Phase == this.Const.World.GreaterEvilPhase.Warning && this.World.State.getPlayer().getStrength() >= 210)
			{
				this.logInfo("STARTING GREATER EVIL - LIVE PHASE!");
				GE.Phase = this.Const.World.GreaterEvilPhase.Live;
				GE.Strength = this.Const.Factions.GreaterEvilStartStrength;
				this.World.Statistics.clearNews();

				if (GE.Type == this.Const.World.GreaterEvilType.CivilWar)
				{
					this.World.Statistics.addNews("crisis_civilwar_start", this.World.Statistics.createNews());
					GE.Strength -= 10.0;
					this.breakNobleHouseAlliances();
				}
				else if (GE.Type == this.Const.World.GreaterEvilType.Greenskins)
				{
					this.World.Statistics.addNews("crisis_greenskins_start", this.World.Statistics.createNews());
					this.getFactionOfType(this.Const.FactionType.Orcs).addAlly(this.getFactionOfType(this.Const.FactionType.Goblins).getID());
					this.getFactionOfType(this.Const.FactionType.Goblins).addAlly(this.getFactionOfType(this.Const.FactionType.Orcs).getID());
				}
				else if (GE.Type == this.Const.World.GreaterEvilType.Undead)
				{
					this.World.Statistics.addNews("crisis_undead_start", this.World.Statistics.createNews());
				}
			}
			else if (GE.Phase == this.Const.World.GreaterEvilPhase.Live)
			{
				if (GE.Type == 0)
				{
					GE.Phase = 0;
					return;
				}

				if (GE.LastUpdate != this.World.getTime().Days)
				{
					GE.Strength += this.Const.Factions.GreaterEvilDailyStrength;
					GE.LastUpdate = this.World.getTime().Days;
				}

				if ((GE.Strength <= 0 || GE.Type == this.Const.World.GreaterEvilType.CivilWar && !this.isNoblesFeuding()) && this.World.Contracts.getActiveContract() == null)
				{
					this.World.Statistics.clearNews();

					if (GE.Type == this.Const.World.GreaterEvilType.CivilWar)
					{
						GE.TypesUsed = GE.TypesUsed | this.Const.World.GreaterEvilTypeBit.CivilWar;
						this.World.Statistics.addNews("crisis_civilwar_end", this.World.Statistics.createNews());
					}
					else if (GE.Type == this.Const.World.GreaterEvilType.Greenskins)
					{
						GE.TypesUsed = GE.TypesUsed | this.Const.World.GreaterEvilTypeBit.Greenskins;
						this.World.Statistics.addNews("crisis_greenskins_end", this.World.Statistics.createNews());
						this.getFactionOfType(this.Const.FactionType.Orcs).removeAlly(this.getFactionOfType(this.Const.FactionType.Goblins).getID());
						this.getFactionOfType(this.Const.FactionType.Goblins).removeAlly(this.getFactionOfType(this.Const.FactionType.Orcs).getID());
					}
					else if (GE.Type == this.Const.World.GreaterEvilType.Undead)
					{
						GE.TypesUsed = GE.TypesUsed | this.Const.World.GreaterEvilTypeBit.Undead;
						this.World.Statistics.addNews("crisis_undead_end", this.World.Statistics.createNews());
					}

					this.World.Combat.abortAll();
					GE.LastType = GE.Type;
					GE.Type = this.Const.World.GreaterEvilType.Random;
					GE.Phase = this.Const.World.GreaterEvilPhase.NotSet;
					GE.NextPhaseTime = this.Time.getVirtualTimeF() + this.Math.rand(25, 35) * this.World.getTime().SecondsPerDay;
					this.World.Statistics.getFlags().increment("GreaterEvilsDefeated");
				}
			}
		}
	}

	function isNoblesFeuding()
	{
		local feuding = 0;
		local nobles = this.getFactionsOfType(this.Const.FactionType.NobleHouse);

		foreach( n in nobles )
		{
			if (n.getSettlements().len() >= 2)
			{
				feuding = ++feuding;
			}
		}

		return feuding >= 2;
	}

	function onSerialize( _out )
	{
		local numFactions = 0;

		foreach( f in this.m.Factions )
		{
			if (f == null)
			{
				continue;
			}

			numFactions = ++numFactions;
		}

		_out.writeU8(numFactions);

		foreach( f in this.m.Factions )
		{
			if (f == null)
			{
				continue;
			}

			_out.writeI32(f.ClassNameHash);
		}

		foreach( f in this.m.Factions )
		{
			if (f == null)
			{
				continue;
			}

			f.onSerialize(_out);
		}

		_out.writeU32(this.m.LastRelationUpdateDay);
		_out.writeU8(this.m.GreaterEvil.Type);
		_out.writeU8(this.m.GreaterEvil.LastType);
		_out.writeU32(this.m.GreaterEvil.TypesUsed);
		_out.writeU8(this.m.GreaterEvil.Phase);
		_out.writeF32(this.m.GreaterEvil.NextPhaseTime);
		_out.writeF32(this.m.GreaterEvil.Strength);
		_out.writeF32(this.m.GreaterEvil.LastUpdate);
		_out.writeBool(this.m.GreaterEvil.IsExtraLate);
	}

	function onDeserialize( _in )
	{
		this.clear();
		local numFactions = _in.readU8();

		for( local i = 0; i != numFactions; i = ++i )
		{
			local f = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
			this.m.Factions.push(f);
		}

		foreach( f in this.m.Factions )
		{
			if (f == null)
			{
				continue;
			}

			f.onDeserialize(_in);
		}

		this.m.LastRelationUpdateDay = _in.readU32();
		this.m.GreaterEvil.Type = _in.readU8();
		this.m.GreaterEvil.LastType = _in.readU8();

		if (_in.getMetaData().getVersion() >= 17)
		{
			this.m.GreaterEvil.TypesUsed = _in.readU32();
		}

		this.m.GreaterEvil.Phase = _in.readU8();
		this.m.GreaterEvil.NextPhaseTime = _in.readF32();
		this.m.GreaterEvil.Strength = _in.readF32();
		this.m.GreaterEvil.LastUpdate = _in.readU32();

		if (_in.getMetaData().getVersion() >= 23)
		{
			this.m.GreaterEvil.IsExtraLate = _in.readBool();
		}
	}

};
