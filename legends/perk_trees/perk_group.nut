this.perk_group <- ::inherit("scripts/config/legend_dummy_bb_class", {
	m = {
		ID = "perk_group.not_initialized",
		Name = "Not Initialized Perk Group",
		FlavorTexts = ["Uninitialized perk group"],
		SelfMultiplier = 1.0,
		Multipliers = [],
		Tree = [ [], [], [], [], [], [], [], [], [], [], [] ] // length 11
	},
	function create()
	{
	}

	function init( _id, _name, _flavorText, _tree, _selfMultiplier = null, _multipliers = null )
	{
		::MSU.requireString(_id);

		this.m.ID = _id;
		this.setName(_name);
		this.setFlavorText(_flavorText);

		if (_selfMultiplier != null) this.setSelfMultiplier(_selfMultiplier);
		if (_multipliers != null) this.setMultipliers(_multipliers);

		::Const.Perks.PerkGroup.LookupMap[_id] <- this;

		return this;
	}

	function getID()
	{
		return this.m.ID;
	}

	function getName()
	{
		return this.m.Name;
	}

	function setName( _name )
	{
		::MSU.requireString(_name);
		this.m.Name = _name;
	}

	function getFlavorTexts()
	{
		return this.m.FlavorTexts;
	}

	function setFlavorTexts( _flavorTexts )
	{
		::MSU.requireArray(_flavorTexts);
		foreach (text in _flavorTexts)
		{
			::MSU.requireString(text);
		}
		this.m.FlavorTexts = _flavorTexts;
	}

	function addFlavorText( _flavorText )
	{
		switch (typeof _flavorText)
		{
			case "string":
				this.m.FlavorTexts.push(_flavorText);
				break;

			case "array":
				foreach (text in _flavorText)
				{
					::MSU.requireString(text);
				}
				this.m.FlavorTexts.extend(_flavorText);
				break;

			default:
				throw ::MSU.Exception.InvalidType(_flavorText);
		}
	}

	function getSelfMultiplier()
	{
		return this.m.SelfMultiplier;
	}

	function setSelfMultiplier( _multiplier )
	{
		::MSU.requireOneFromTypes(["integer", "float"], _multiplier);
		this.m.SelfMultiplier = _multiplier;
	}

	function getTree()
	{
		return this.m.Tree;
	}

	function setTree( _tree )
	{
		::MSU.requireArray(_tree);
		if (_tree.len() < 7)
		{
			::logError("The length of _tree must be 7");
			::MSU.Exception.InvalidValue(_tree);
		}
		foreach (row in _tree)
		{
			::MSU.requireArray(row);
			foreach (perk in row)
			{
				if (::Const.Perks.findById(perk) == null) throw ::MSU.Exception.InvalidValue(perk);
			}
		}

		this.m.Tree = _tree;
	}

	function getMultipliers( _type = null )
	{
		switch (_type)
		{
			case "perk":
				return this.m.Multipliers.filter(@(idx, multiplier) ::Const.Perks.SpecialPerk.findById(multiplier[1]) != null);

			case "perk_group":
				return this.m.Multipliers.filter(@(idx, multiplier) ::Const.Perks.PerkGroup.findById(multiplier[1]) != null);

			case null:
				return this.m.Multipliers;

			default:
				throw ::MSU.Exception.InvalidValue(_type);
		}
	}

	function setMultipliers( _multipliers )
	{
		::MSU.requireArray(_multipliers);
		foreach (multiplier in _multipliers)
		{
			this.__validateMultiplier(multiplier);
		}
		this.m.Multipliers = _multipliers;
	}

	function addMultiplier( _multiplier )
	{
		this.__validateMultiplier(_multiplier);
		foreach (multiplier in this.m.Multipliers)
		{
			if (multiplier[1] == _multiplier[1])
			{
				::logError(format("The perk group %s already contains a multiplier of %s for %s", this.getID(), multiplier[0], multiplier[1]));
				return;
			}
		}

		this.m.Multipliers.push(_multiplier);
	}

	function removeMultiplier( _item )
	{
		if (::Const.Perks.findById(_item) == null || ::Const.Perks.PerkGroup.findById(_item) == null)
		{
			::logError("_item must be a valid perk or perk group ID.");
			throw ::MSU.Exception.InvalidValue(_multiplier);
		}

		foreach (i, multiplier in this.m.Multipliers)
		{
			if (multiplier[1] == _item) return this.m.Multipliers.remove(i);
		}
	}

	function __validateMultiplier( _multiplier )
	{
		::MSU.requireArray(_multiplier);

		if (_multiplier.len() != 2)
		{
			::logError("Each multiplier must be a length 2 array.");
			throw ::MSU.Exception.InvalidValue(_multiplier);
		}

		::MSU.requireOneFromTypes(["integer", "float"], _multiplier[0]);
		::MSU.requireString(_multiplier[1]);

		if (::Const.Perks.findById(_multiplier[1]) == null || ::Const.Perks.PerkGroup.findById(_multiplier[1]) == null)
		{
			::logError("The secomd element in a multiplier must be a valid perk or perk group ID.");
			throw ::MSU.Exception.InvalidValue(_multiplier);
		}
	}

	function findPerk( _perk )
	{
		foreach (row in this.m.Tree)
		{
			foreach (perk in row)
			{
				if (perk == _perk) return row;
			}
		}
	}

	function addPerk( _perk, _tier )
	{
		if (::Const.Perks.findById(_perk) == null) throw ::MSU.Exception.InvalidValue(_perk);

		local row = this.findPerk(_perk);
		if (row != null)
		{
			::logWarning("Perk " + _perk + " already exists in perk group " + this.getID() + " at tier " + (row + 1);
			return;
		}

		this.m.Tree[_tier-1].push(_perk);
	}

	function removePerk( _perk )
	{
		foreach (row in this.m.Tree)
		{
			foreach (i, perk in row)
			{
				if (perk == _perk) return row.remove(i);
			}
		}
	}

	function getRandomPerk( _tier = null, _exclude = null )
	{
		local perks = [];
		if (_tier != null)
		{
			foreach (perk in this.m.Tree[tier-1])
			{
				if (_exclude == null || _exclude.find(perk) == null) perks.push(perk);
			}
		}
		else
		{
			foreach (row in this.m.Tree)
			{
				foreach (perk in row)
				{
					if (_exclude == null || _exclude.find(perk) == null) perks.push(perk);
				}
			}
		}

		return ::MSU.Array.rand(perks);
	}
});
