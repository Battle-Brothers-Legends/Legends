::Legends.Class.PerkGroup <- class
{
	ID = null;
	Name = null;
	Descriptions = null;
	SelfMultiplier = null;
	PerkGroupMultipliers = null;
	SpecialPerkMultipliers = null;
	Tree = null;

	constructor( _id, _name, _descriptions, _selfMultiplier = null )
	{
		::MSU.requireString(_id, _name);

		if (_selfMultiplier == null) _selfMultiplier = 1.0;

		this.ID = _id;
		this.Name = _name;
		this.setDescriptions(_descriptions);
		this.setSelfMultiplier(_selfMultiplier);
	}

	function getID()
	{
		return this.ID;
	}

	function getName()
	{
		return this.Name;
	}

	function setName( _name )
	{
		::MSU.requireString(_name);
		this.Name = _name;
	}

	function getDescriptions()
	{
		return this.Descriptions;
	}

	function setDescriptions( _descriptions )
	{
		::MSU.requireArray(_descriptions);
		foreach (desc in _descriptions)
		{
			::MSU.requireString(desc);
		}
		this.Descriptions = _descriptions;
	}

	function getSelfMultiplier()
	{
		return this.SelfMultiplier;
	}

	function setSelfMultiplier( _multiplier )
	{
		::MSU.requireOneFromTypes(["integer", "float"], _multiplier);
		this.SelfMultiplier = _multiplier;
	}

	function getTree()
	{
		return this.Tree;
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
				this.__validatePerk(perk);
			}
		}

		this.Tree = _tree;
	}

	function getPerkGroupMultipliers()
	{
		return this.PerkGroupMultipliers;
	}

	function setPerkGroupMultipliers( _multipliers )
	{
		::MSU.requireArray(_multipliers);
		foreach (entry in _multipliers)
		{
			::MSU.requireArray(entry);
			if (entry.len() != 2)
			{
				::logError("Each entry in _multipliers must be a length 2 array");
				throw ::MSU.Exception.InvalidValue(entry);
			}
			::MSU.requireOneFromTypes(["integer", "float"], entry[0]);
			::MSU.requireInstanceOf(::Legends.Class.PerkGroup, entry[1]);
		}

		this.PerkGroupMultipliers = _multipliers;
	}

	function getSpecialPerkMultipliers()
	{
		return this.SpecialPerkMultipliers;
	}

	function setSpecialPerkMultipliers( _multipliers )
	{
		::MSU.requireArray(_multipliers);
		foreach (entry in _multipliers)
		{
			::MSU.requireArray(entry);
			if (entry.len() != 2)
			{
				::logError("Each entry in _multipliers must be a length 2 array");
				throw ::MSU.Exception.InvalidValue(entry);
			}
			::MSU.requireOneFromTypes(["integer", "float"], entry[0]);
			this.__validatePerk(entry[1]);
		}

		this.SpecialPerkMultipliers = _multipliers;
	}

	function findPerk( _perk )
	{
		foreach (row in this.Tree)
		{
			foreach (perk in row)
			{
				if (perk == _perk) return row;
			}
		}
		return null;
	}

	function addPerk( _perk, _tier )
	{
		::MSU.requireInteger(_tier);
		if (_tier < 1 || _tier > this.Tree.len())
		{
			::logError("The value of _tier must be between 1 and the length of the perk tree inclusive.");
			::MSU.Exception.InvalidValue(_tier);
		}

		this.__validatePerk(_perk);

		local row = this.findPerk(_perk);
		if (row != null)
		{
			::logWarning("Perk " + _perk + " already exists in perk group " + this.getID() + " at tier " + (row + 1);
			return false;
		}

		this.Tree[_tier-1].push(_perk);
	}

	function removePerk( _perk )
	{
		foreach (row in this.Tree)
		{
			foreach (i, perk in row)
			{
				if (perk == _perk) return row.remove(i);
			}
		}
	}

	function getRandomPerk( _exclude = null )
	{
		local tree = this.Tree;
		if (_exclude != null)
		{
			tree = array(this.Tree.len());
			foreach (i, row in this.Tree)
			{
				tree[i] = [];
				foreach (perk in row)
				{
					if (_exclude.find(perk) == null) tree[i].push(perk);
				}
			}
		}

		return ::MSU.Array.rand(::MSU.Array.rand(tree));
	}

	function __validatePerk( _perk )
	{
		::MSU.requireInteger(_perk);
		if (_perk < 0 || _perk > ::Const.Perks.PerkDefs.len())
		{
			::logError("The PerDef " + _perk + " does not exist in the ::Const.Perks.PerkDefs table");
			::MSU.Exception.InvalidValue(_perk);
		}
	}
}
