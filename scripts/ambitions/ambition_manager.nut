this.ambition_manager <- {
	m = {
		Ambitions = [],
		ActiveAmbition = null,
		Completed = 0,
		Done = 0,
		Selection = null,
		Thread = null,
		LastTime = 0.0,
		DelayUntil = 0.0,
		IsCancelAmbition = false
	},
	function hasActiveAmbition()
	{
		return this.m.ActiveAmbition != null;
	}

	function getActiveAmbition()
	{
		return this.m.ActiveAmbition;
	}

	function getSelection()
	{
		return this.m.Selection;
	}

	function getCompleted()
	{
		return this.m.Completed;
	}

	function getDone()
	{
		return this.m.Done;
	}

	function getAmbition( _id )
	{
		if (_id.len() == 0)
		{
			return null;
		}

		foreach( a in this.m.Ambitions )
		{
			if (a.getID() == _id)
			{
				return a;
			}
		}

		return null;
	}

	function resetTime( _resetDelay = false, _additionalHours = 0.0 )
	{
		this.m.LastTime = this.Time.getVirtualTimeF() - 5.0 * this.World.getTime().SecondsPerHour + _additionalHours * this.World.getTime().SecondsPerHour;

		if (_resetDelay)
		{
			this.m.DelayUntil = 0.0;
		}
	}

	function setDelay( _hours )
	{
		this.m.DelayUntil = this.Math.maxf(this.m.DelayUntil, this.Time.getVirtualTimeF() + _hours * this.World.getTime().SecondsPerHour);
	}

	function create()
	{
		local scriptFiles = this.IO.enumerateFiles("scripts/ambitions/ambitions/");

		foreach( scriptFile in scriptFiles )
		{
			this.m.Ambitions.push(this.new(scriptFile));
		}

		this.m.LastTime = this.Time.getVirtualTimeF();
	}

	function isAvailable()
	{
		if (this.World.State.getMenuStack().hasBacksteps() || this.LoadingScreen != null && (this.LoadingScreen.isAnimating() || this.LoadingScreen.isVisible()))
		{
			return;
		}

		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
			return false;
		}

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() < 3.0)
		{
			return false;
		}

		if (this.Time.getVirtualTimeF() < this.m.DelayUntil)
		{
			return false;
		}

		if (this.World.getTime().Days < 2)
		{
			return false;
		}

		if (this.m.Thread == null && this.m.Selection == null && this.Time.getVirtualTimeF() - this.m.LastTime < 1.0 * this.World.getTime().SecondsPerHour)
		{
			return false;
		}

		if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() == "contract.tutorial")
		{
			return false;
		}

		local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);

		foreach( party in parties )
		{
			if (!party.isAlliedWithPlayer())
			{
				return false;
			}
		}

		return true;
	}

	function update()
	{
		if (this.m.IsCancelAmbition)
		{
			this.cancelAmbition(false);
			return;
		}

		if (!this.isAvailable())
		{
			//this.logInfo("Ambition not available");
			return;
		}

		if (this.m.ActiveAmbition != null)
		{
			if (this.m.ActiveAmbition.isSuccess() && this.World.Events.canFireEvent(true)) //changed to true (ignores evaluating)
			{
				//this.logInfo("Ambition success");
				if (this.World.Events.fire("event.ambition_fulfilled"))
				{
					this.m.ActiveAmbition.clear();
					this.m.ActiveAmbition = null;
					this.m.Selection = null;
					this.m.Thread = null;
					this.World.TopbarAmbitionModule.setText(null);
					this.setDelay(0); //from 24
					++this.m.Completed;
					this.m.LastTime = this.Time.getVirtualTimeF();
				}
			}
			else
			{
				//this.logInfo("Ambition no success");
				this.m.LastTime = this.Time.getVirtualTimeF();
			}
		}
		else if (this.m.Selection == null)
		{
			if (this.m.Thread == null)
			{
				this.m.Thread = this.selectAmbitions();
			}

			if (resume this.m.Thread != false)
			{
				this.m.Thread = null;
			}
		}
		else if (this.m.Selection.len() != 0 && this.World.Events.canFireEvent())
		{
			if (this.World.Events.fire("event.choose_ambition"))
			{
				this.m.Selection = null;
				this.m.LastTime = this.Time.getVirtualTimeF();
			}
		}
	}

	function selectAmbitions()
	{
		// Function is a generator.
		local done = 0;

		for( local i = 0; i < this.m.Ambitions.len(); i = ++i )
		{
			this.m.Ambitions[i].update();

			if (this.m.Ambitions[i].isDone())
			{
				done = ++done;
			}
		}

		yield false;
		this.m.Done = done;

		for( local i = 0; i < this.m.Ambitions.len(); i = ++i )
		{
			this.m.Ambitions[i].update();
		}

		yield false;
		this.m.Ambitions.sort(this.onScoreCompare);
		local selection = [];

		for( local i = 0; i != 4; i = ++i )
		{
			if (i >= this.m.Ambitions.len())
			{
				break;
			}

			if (this.m.Ambitions[i].getScore() != 0)
			{
				selection.push(this.m.Ambitions[i]);
			}
			else
			{
				break;
			}
		}

		if (selection.len() == 0)
		{
			return true;
		}

		if (this.getAmbition("ambition.make_nobles_aware").isDone())
		{
			if (selection.len() >= 4)
			{
				selection.remove(selection.len() - 1);
			}

			selection.push(this.getAmbition("ambition.none"));
		}

		this.m.Selection = selection;
		return true;
	}

	function setAmbition( _ambition )
	{
		if (_ambition.getID() == "ambition.none")
		{
			this.setDelay(24 * 3);
		}
		else
		{
			this.m.ActiveAmbition = _ambition;
			this.m.ActiveAmbition.activate();
			this.setDelay(4);
			this.World.TopbarAmbitionModule.setText(_ambition.getUIText());
		}
	}

	function updateUI()
	{
		if (this.m.ActiveAmbition != null)
		{
			this.World.TopbarAmbitionModule.setText(this.m.ActiveAmbition.getUIText());
		}
		else
		{
			this.World.TopbarAmbitionModule.setText(null);
		}
	}

	function cancelAmbition( _delayed = true )
	{
		if (!this.hasActiveAmbition())
		{
			return;
		}

		if (_delayed)
		{
			this.m.IsCancelAmbition = true;
			return;
		}

		this.m.IsCancelAmbition = false;
		this.m.ActiveAmbition.fail();
		this.World.Events.fire("event.ambition_failed");
		this.m.ActiveAmbition.clear();
		this.World.TopbarAmbitionModule.setText(null);
		this.m.ActiveAmbition = null;
		this.setDelay(24);
	}

	function clear()
	{
		this.m.ActiveAmbition = null;
		this.m.Selection = null;
		this.m.Thread = null;

		foreach( i, a in this.m.Ambitions )
		{
			a.reset();
		}

		this.World.TopbarAmbitionModule.setText(null);
	}

	function onScoreCompare( _a1, _a2 )
	{
		if (_a1.getScore() > _a2.getScore())
		{
			return -1;
		}
		else if (_a1.getScore() < _a2.getScore())
		{
			return 1;
		}

		return 0;
	}

	function onPartyDestroyed( _party )
	{
		if (this.m.ActiveAmbition != null)
		{
			this.m.ActiveAmbition.onPartyDestroyed(_party);
			this.updateUI();
		}
	}

	function onLocationDestroyed( _location )
	{
		if (this.m.ActiveAmbition != null)
		{
			this.m.ActiveAmbition.onLocationDestroyed(_location);
			this.updateUI();
		}
	}

	function onLocationDiscovered( _location )
	{
		if (this.m.ActiveAmbition != null)
		{
			this.m.ActiveAmbition.onLocationDiscovered(_location);
			this.updateUI();
		}
	}

	function onSerialize( _out )
	{
		_out.writeU32(this.m.Ambitions.len());

		foreach( a in this.m.Ambitions )
		{
			_out.writeString(a.getID());
			a.onSerialize(_out);
		}

		if (this.m.ActiveAmbition != null)
		{
			_out.writeString(this.m.ActiveAmbition.getID());
		}
		else
		{
			_out.writeString("");
		}

		_out.writeF32(this.m.LastTime);
		_out.writeF32(this.m.DelayUntil);
		_out.writeU16(this.m.Completed);
		_out.writeU16(this.m.Done);
	}

	function onDeserialize( _in )
	{
		this.clear();
		local numAmbitions = _in.readU32();

		for( local i = 0; i < numAmbitions; i = ++i )
		{
			local a = this.getAmbition(_in.readString());

			if (a != null)
			{
				a.onDeserialize(_in);
			}
			else
			{
				_in.readF32();
				_in.readF32();
				_in.readBool();
			}
		}

		this.m.ActiveAmbition = this.getAmbition(_in.readString());
		this.m.LastTime = _in.readF32();
		this.m.DelayUntil = _in.readF32();
		this.m.Completed = _in.readU16();
		this.m.Done = _in.readU16();

		if (this.m.ActiveAmbition != null)
		{
			this.World.TopbarAmbitionModule.setText(this.m.ActiveAmbition.getUIText());
		}
		else
		{
			this.World.TopbarAmbitionModule.setText(null);
		}
	}

};

