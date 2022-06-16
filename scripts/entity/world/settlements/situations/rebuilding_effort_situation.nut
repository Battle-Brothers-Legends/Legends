this.rebuilding_effort_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {
		Target = ""
	},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.rebuilding_effort";
		this.m.Name = "Rebuilding Effort";
		this.m.Description = "In an effort to rebuild a nearby site, building materials are in high demand and low supply.";
		this.m.Icon = "ui/settlement_status/settlement_effect_15.png";
		this.m.Rumors = [
			"Finally they\'re starting to rebuild around %settlement%. That place was in ruins for long enough.",
			"I heard they\'re bringing in wood to %settlement% with wagons now. The new Burgomeister is surely trying to fix things up over there."
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 5;
	}

	function getDescription()
	{
		if (this.m.Target != "")
		{
			return "In an effort to rebuild the nearby " + this.m.Target.tolower() + ", building materials are in high demand and low supply.";
		}
		else
		{
			return this.m.Description;
		}
	}

	function isValid()
	{
		if (this.m.Target == "")
		{
			return false;
		}

		return this.situation.isValid();
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		local candidates = [];

		foreach( a in _settlement.getAttachedLocations() )
		{
			if (a.isActive())
			{
				continue;
			}

			candidates.push(a);
		}

		if (candidates.len() != 0)
		{
			this.m.Target = candidates[this.Math.rand(0, candidates.len() - 1)].getRealName();
		}

		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.05);
		}
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuildingPriceMult *= 1.35;
		_modifiers.BuildingRarityMult *= 0.5;
	}

	function onRemoved( _settlement )
	{
		if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getID() == "contract.raze_attached_location")
		{
			return;
		}

		local candidates = [];

		foreach( a in _settlement.getAttachedLocations() )
		{
			if (a.isActive())
			{
				continue;
			}

			candidates.push(a);
		}

		if (candidates.len() != 0)
		{
			local a = candidates[this.Math.rand(0, candidates.len() - 1)];
			a.setActive(true);
		}
	}

	function onSerialize( _out )
	{
		this.situation.onSerialize(_out);
		_out.writeString(this.m.Target);
	}

	function onDeserialize( _in )
	{
		this.situation.onDeserialize(_in);
		this.m.Target = _in.readString();
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if (this.m.IsSouthern)
		{
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");

		}
		else
		{
			_draftList.push("lumberjack_background");
			_draftList.push("lumberjack_background");
			_draftList.push("mason_background");
			_draftList.push("mason_background");
			_draftList.push("daytaler_background");
			_draftList.push("daytaler_background");
			_draftList.push("daytaler_background");

			_draftList.push("legend_inventor_background");

			if (_gender)
			{
				_draftList.push("female_daytaler_background");
			}
		}

		_draftList.push("legend_blacksmith_background");
		_draftList.push("legend_blacksmith_background");
		_draftList.push("legend_blacksmith_background");

	}


});

