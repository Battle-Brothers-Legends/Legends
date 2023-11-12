this.contract_manager <- {
	m = {
		Open = [],
		Active = null,
		LastShown = null,
		NextContractID = 1,
		LastUpdateTime = 0,
		ContractsDone = 0,
		ContractsFinished = 0,
		ContractsCancelled = 0,
		IsEventVisible = false
	},
	function getActiveContract()
	{
		return this.m.Active;
	}

	function getOpenContracts()
	{
		return this.m.Open;
	}

	function generateContractID()
	{
		return this.m.NextContractID++;
	}

	function getContractsDone()
	{
		return this.m.ContractsDone;
	}

	function getContractsFinished()
	{
		return this.m.ContractsFinished;
	}

	function getContractsCancelled()
	{
		return this.m.ContractsCancelled;
	}

	function create()
	{
	}

	function update( _force = false )
	{
		if (!_force && this.World.State.getMenuStack().hasBacksteps())
		{
			return;
		}

		if (!_force && ("State" in this.Tactical) && this.Tactical.State != null)
		{
			return;
		}

		if (this.m.LastUpdateTime + 1.0 < this.Time.getVirtualTimeF())
		{
			this.m.LastUpdateTime = this.Time.getVirtualTimeF();
			local garbage = [];

			foreach( i, c in this.m.Open )
			{
				if (!c.isValid() || c.isTimedOut())
				{
					//this.logInfo("contract removed: " + this.m.Open[i].getID());
					this.World.FactionManager.getFaction(c.getFaction()).removeContract(c);
					c.clear();
					garbage.push(i);
				}
			}

			garbage.reverse();

			foreach( i in garbage )
			{
				this.m.Open.remove(i);
			}

			garbage.clear();
		}

		if (this.m.Active != null)
		{
			this.m.Active.update();
		}
	}

	function clear()
	{
		this.m.Open = [];
		this.m.Active = null;
		this.m.LastShown = null;
		this.m.NextContractID = 1;
		this.m.LastUpdateTime = 0;
		this.m.IsEventVisible = false;
		this.World.State.getWorldScreen().clearContract();
	}

	function clearAllContracts()
	{
		foreach( c in this.m.Open )
		{
			this.World.FactionManager.getFaction(c.getFaction()).removeContract(c);
			c.clear();
		}

		this.m.Open = [];
	}

	function addContract( _contract, _isNewContract = true )
	{
		if (!_contract.isValid())
		{
			return;
		}

		if (_isNewContract)
		{
			_contract.m.ID = this.generateContractID();
			_contract.m.TimeOut += this.World.getTime().SecondsPerDay * (this.Math.rand(0, 200) - 100) * 0.01;

			_contract.formatDescription();
		}

		//this.logDebug("contract added: " + _contract.getName());

		if (_contract.getFaction() != 0)
		{
			this.World.FactionManager.getFaction(_contract.getFaction()).addContract(_contract);

			if (_isNewContract)
			{
				local faction = ::World.FactionManager.getFaction(_contract.getFaction());
				this.World.FactionManager.getFaction(_contract.getFaction()).setLastContractTime(this.Time.getVirtualTimeF() + ::Const.LegendMod.ContractCooldown.getLastContractTimeDelay(faction));
			}
		}

		this.m.Open.push(_contract);
	}

	function removeContract( _contract )
	{
		if (this.m.Active == _contract)
		{
			this.m.Active.cancel();
			this.finishActiveContract(true);
			++this.m.ContractsCancelled;
			return;
		}

		this.World.FactionManager.getFaction(_contract.getFaction()).removeContract(_contract);
		_contract.onClear();
		local i = this.m.Open.find(_contract);

		if (i != null)
		{
			this.m.Open.remove(i);
		}

		if (this.m.LastShown == _contract)
		{
			this.m.LastShown = null;
		}

		if (this.World.State.getCurrentTown() != null)
		{
			this.World.State.getTownScreen().updateContracts();
		}
	}

	function hasContractWithSituation( _situationID )
	{
		if (this.m.Active != null && this.m.Active.getSituationID() == _situationID)
		{
			return true;
		}

		foreach( c in this.m.Open )
		{
			if (c.getSituationID() == _situationID)
			{
				return true;
			}
		}

		return false;
	}

	function setActiveContract( _contract, _alreadyStarted = false )
	{
		if (this.m.Active != null)
		{
			return;
		}

		if (!_alreadyStarted)
		{
			local faction = ::World.FactionManager.getFaction(_contract.getFaction());
			::Const.LegendMod.ContractCooldown.updateStreak(faction);
		}

		this.logInfo("contract activated: " + _contract.getName() + " (id: " + _contract.getID() + ")");

		foreach( i, c in this.m.Open )
		{
			if (c == _contract)
			{
				this.m.Open.remove(i);
				break;
			}
		}

		this.m.Active = _contract;
		_contract.setActive(true);
		this.World.State.getWorldScreen().updateContract(this.m.Active);
		this.World.State.getTownScreen().updateContracts();

		if (!_alreadyStarted)
		{
			this.Sound.play("sounds/scribble.wav");
		}
	}

	function updateActiveContract()
	{
		if (this.m.Active == null)
		{
			return;
		}

		this.World.State.getWorldScreen().updateContract(this.m.Active);
	}

	function finishActiveContract( _isCancelled = false )
	{
		if (this.m.Active == null)
		{
			return;
		}

		if (!_isCancelled)
		{
			if (this.World.FactionManager.getFaction(this.m.Active.getFaction()).getType() == this.Const.FactionType.NobleHouse)
			{
				this.updateAchievement("MeddlingWithNobility", 1, 1);
			}
			else if (this.World.FactionManager.getFaction(this.m.Active.getFaction()).getType() == this.Const.FactionType.Settlement && this.m.Active.getType() != "contract.tutorial")
			{
				this.updateAchievement("BloodMoney", 1, 1);
			}

			if (this.m.Active.getType() == "contract.escort_caravan")
			{
				this.World.Statistics.getFlags().increment("EscortCaravanContractsDone");
			}

			if (this.World.FactionManager.getFaction(this.m.Active.getFaction()).getType() == this.Const.FactionType.OrientalCityState)
			{
				this.World.Statistics.getFlags().increment("CityStateContractsDone");
			}
		}
		else
		{
			this.updateAchievement("BrokenPromises", 1, 1);
		}

		this.World.FactionManager.getFaction(this.m.Active.getFaction()).removeContract(this.m.Active);
		this.World.Assets.getOrigin().onContractFinished(this.m.Active.getType(), _isCancelled);
		this.m.Active.clear();
		this.m.Active = null;
		this.m.LastShown = null;
		++this.m.ContractsDone;

		if (!_isCancelled)
		{
			++this.m.ContractsFinished;
		}

		this.World.State.getWorldScreen().clearContract();
		this.World.State.updateTopbarAssets();
		this.World.Ambitions.updateUI();
	}

	function showContractByID( _id )
	{
		local c;

		if (this.m.Active != null && this.m.Active.getID() == _id)
		{
			c = this.m.Active;
		}
		else if (this.m.LastShown != null && this.m.LastShown.getID() == _id)
		{
			c = this.m.LastShown;
		}
		else
		{
			foreach( contract in this.m.Open )
			{
				if (contract.getID() == _id)
				{
					c = contract;
					break;
				}
			}
		}

		if (c != null)
		{
			this.showContract(c);
		}
	}

	function showActiveContract()
	{
		if (this.m.Active != null)
		{
			this.showContract(this.m.Active);
		}
	}

	function showContract( _c )
	{
		//this.logInfo("showing contract: " + _c.getName() + " (id: " + _c.getID() + ")");
		this.m.LastShown = _c;

		if (!_c.isStarted())
		{
			_c.start();
		}

		this.m.IsEventVisible = true;

		if (this.World.State.getCurrentTown() == null)
		{
			this.World.State.showEventScreen(_c, true, true);
		}
		else
		{
			this.World.State.showEventScreenFromTown(_c, true, false);
		}
	}

	function processInput( _option )
	{
		if (this.m.LastShown != null)
		{
			if (!this.m.LastShown.processInput(_option))
			{
				if (this.m.IsEventVisible)
				{
					this.m.IsEventVisible = false;
					this.World.State.getMenuStack().pop(true);
				}
			}
			else
			{
				this.m.IsEventVisible = true;
				this.World.State.getEventScreen().show(this.m.LastShown);
			}
		}
	}

	function showCombatDialog( _isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true )
	{
		this.m.IsEventVisible = false;
		this.World.State.getMenuStack().pop(true);
		this.World.State.showCombatDialog(_isPlayerInitiated, _isCombatantsVisible, _allowFormationPicking);
	}

	function startScriptedCombat( _properties = null, _isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true )
	{
		this.m.IsEventVisible = false;
		this.World.State.getMenuStack().pop(true);
		this.World.State.startScriptedCombat(_properties, _isPlayerInitiated, _isCombatantsVisible, _allowFormationPicking);
	}

	function onActorKilled( _actor, _killer, _combatID )
	{
		if (this.m.Active != null)
		{
			this.m.Active.onActorKilled(_actor, _killer, _combatID);
		}
	}

	function onActorRetreated( _actor, _combatID )
	{
		if (this.m.Active != null)
		{
			this.m.Active.onActorRetreated(_actor, _combatID);
		}
	}

	function onRetreatedFromCombat( _combatID )
	{
		if (this.m.Active != null)
		{
			this.m.Active.onRetreatedFromCombat(_combatID);
		}
	}

	function onCombatVictory( _combatID )
	{
		if (this.m.Active != null)
		{
			this.m.Active.onCombatVictory(_combatID);
		}
	}

	function onPartyDestroyed( _party )
	{
		if (this.m.Active != null)
		{
			this.m.Active.onPartyDestroyed(_party);
		}
	}

	function onLocationDestroyed( _party )
	{
		if (this.m.Active != null)
		{
			this.m.Active.onLocationDestroyed(_party);
		}
	}

	function onSerialize( _out )
	{
		_out.writeU16(this.m.Open.len());

		foreach( c in this.m.Open )
		{
			_out.writeI32(c.ClassNameHash);
			c.onSerialize(_out);
		}

		if (this.m.Active != null)
		{
			_out.writeBool(true);
			_out.writeI32(this.m.Active.ClassNameHash);
			this.m.Active.onSerialize(_out);
		}
		else
		{
			_out.writeBool(false);
		}

		if (this.m.LastShown != null)
		{
			_out.writeI32(this.m.LastShown.getID());
		}
		else
		{
			_out.writeI32(0);
		}

		_out.writeI32(this.m.NextContractID);
		_out.writeF32(this.m.LastUpdateTime);
		_out.writeU32(this.m.ContractsDone);
		_out.writeU32(this.m.ContractsFinished);
		_out.writeU32(this.m.ContractsCancelled);
	}

	function onDeserialize( _in )
	{
		this.clear();
		local numOpenContracts = _in.readU16();

		for( local i = 0; i < numOpenContracts; i = ++i )
		{
			local contract = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
			contract.onDeserialize(_in);
			this.addContract(contract, false);
		}

		local hasActive = _in.readBool();

		if (hasActive)
		{
			local active = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
			active.onDeserialize(_in);
			this.setActiveContract(active, true);
		}

		local lastShown = _in.readI32();

		if (lastShown != 0)
		{
			foreach( c in this.m.Open )
			{
				if (c.getID() == lastShown)
				{
					this.m.LastShown = c;
					break;
				}
			}
		}

		this.m.NextContractID = _in.readI32();
		this.m.LastUpdateTime = _in.readF32();
		this.m.ContractsDone = _in.readU32();
		this.m.ContractsFinished = _in.readU32();
		this.m.ContractsCancelled = _in.readU32();
	}




function getContractByID( _id ){
	if(this.m.Active != null && this.m.Active.getID() == _id) return this.m.Active;

	foreach(contract in this.m.Open)
	{
		if(contract.getID() == _id)
		{
			return contract;
		}
	}

	return null;
}

};
