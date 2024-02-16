this.crafting_manager <- {
	m = {
		Blueprints = []
	},
	function getBlueprint( _id )
	{
		if (_id.len() == 0)
		{
			return null;
		}

		foreach( b in this.m.Blueprints )
		{
			if (b.getID() == _id)
			{
				return b;
			}
		}

		return null;
	}

	function getQualifiedBlueprints()
	{
		local ret = [];

		foreach( b in this.m.Blueprints )
		{
			if (b.isQualified())
			{
				ret.push(b);
			}
		}

		return ret;
	}

	function getQualifiedBlueprintsForUI( _filter )
	{
		local ret = [];

		foreach( b in this.m.Blueprints )
		{
			if ((b.getItemType() & _filter) == 0)
			{
				continue;
			}

			if (b.isQualified())
			{
				ret.push(b.getUIData());
			}
		}

		ret.sort(this.onSortBlueprints);
		return ret;
	}

	function getQualifiedEnchanterBlueprintsForUI()
	{
		local ret = [];

		foreach( b in this.m.Blueprints )
		{
			if (b.isQualifiedEnchant())
			{
				ret.push(b.getUIData());
			}
		}

		ret.sort(this.onSortBlueprints);
		return ret;
	}

	function create()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		local scriptFiles = this.IO.enumerateFiles("scripts/crafting/blueprints/");

		foreach( scriptFile in scriptFiles )
		{
			local blueprint = this.new(scriptFile);

			if (blueprint.isValid())
			{
				this.m.Blueprints.push(blueprint);
			}
		}
	}

	function deleteAllBlueprints()
	{
		foreach ( bp in this.m.Blueprints )
		{
			bp = null;
		}
		this.m.Blueprints = [];
	}

	function resetAllBlueprints()
	{
		this.deleteAllBlueprints();
		this.create();
	}

	function clear()
	{
		foreach( b in this.m.Blueprints )
		{
			b.reset();
		}
	}

	function onSerialize( _out )
	{
		_out.writeU16(this.m.Blueprints.len());

		foreach( b in this.m.Blueprints )
		{
			_out.writeString(b.getID());
			b.onSerialize(_out);
		}
	}

	function onDeserialize( _in )
	{
		this.clear();
		local num = _in.readU16();

		for( local i = 0; i < num; ++i )
		{
			local blueprint = this.getBlueprint(_in.readString());

			if (blueprint != null)
			{
				blueprint.onDeserialize(_in);
			}
			else
			{
				_in.readU32();
			}
		}
	}

	function onSortBlueprints( _b1, _b2 )
	{
		if (_b1.IsCraftable && !_b2.IsCraftable)
		{
			return -1;
		}
		else if (!_b1.IsCraftable && _b2.IsCraftable)
		{
			return 1;
		}
		else if (_b1.Type > _b2.Type)
		{
			return 1;
		}
		else if (_b1.Type < _b2.Type)
		{
			return -1;
		}
		else if (_b1.Name > _b2.Name)
		{
			return 1;
		}
		else if (_b1.Name < _b2.Name)
		{
			return -1;
		}
		else
		{
			return 0;
		}
	}

};

