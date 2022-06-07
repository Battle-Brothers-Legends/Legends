// Base (abstract) class - never instantiated on its own
this.perk_tree <- ::inherit("scripts/config/legend_dummy_bb_class", {
	m = {
		IDMap = {},
		Tree = [],
		PerkDefsTree = {}
	}

	function init()
	{
	}

	function build()
	{
		this.__build(this.m.PerkDefsTree);
	}

	function rebuild()
	{
	}

	function __build( _perkDefsTree )
	{
		::MSU.requireArray(_perkDefsTree);

		this.clear():

		foreach (row in _perkDefsTree)
		{
			::MSU.requireArray(row);
			foreach (perk in row)
			{
				this.addPerk(perk);
			}
		}
	}

	function toPerkDefsTree()
	{
		local ret = array(this.Tree.len());
		foreach (i, row in this.Tree)
		{
			ret[i] = [];
			foreach (perkDefObject in row)
			{
				ret[i].push(::Const.Perks.PerkDefs[perkDefObject.Const]);
			}
		}
		return ret;
	}

	function getTree()
	{
		return this.Tree;
	}

	function merge( _other )
	{
		_other = _other.toPerkDefsTree();
		local perkDefsTree = this.toPerkDefsTree();
		foreach (i, row in _other)
		{
			foreach (perk in row)
			{
				if (perkDefsTree[i].find(perk) == null) perkDefsTree[i].push(perk);
			}
		}
		this.__build(perkDefsTree);
	}

	function clear()
	{
		this.IDMap.clear();
		this.Tree.clear();
	}

	function __getPerkDef( _perk )
	{
		switch (typeof _perk)
		{
			case "integer":
				return ::Const.Perks.PerkDefObjects[_perk].ID in this.IDMap;

			case "string":
				return _perk in this.IDMap;

			default:
				throw ::MSU.Exception.InvalidType(_perk);
		}
	}

	function hasPerk( _perk )
	{
		switch (typeof _perk)
		{
			case "integer":
				return ::Const.Perks.PerkDefObjects[_perk].ID in this.IDMap;

			case "string":
				return _perk in this.IDMap;

			default:
				throw ::MSU.Exception.InvalidType(_perk);
		}
	}

	function getPerk( _perk )
	{

	}

	function addPerk( _perk, _tier = 1, _isRefundable = true )
	{
		if (this.hasPerk(_perk)) return;

		local perkDefObject;
		switch (typeof _perk)
		{
			case "integer":
				perkDefObject = clone ::Const.Perks.PerkDefObjects[_perk];
				break;

			case "string":
				perkDefObject = clone ::Const.Perks.findById(_perk);
				break;

			default:
				throw ::MSU.Exception.InvalidType(_perk);
		}

		perkDefObject.Row <- _tier - 1;
		perkDefObject.Unlocks <- _tier - 1;
		perkDefObject.IsRefundable <- _isRefundable;
		for (local i = this.Tree.len(); i < tier; i++)
		{
			this.Tree.push([]);
		}
		this.Tree[_tier - 1].push(perkDefObject);
		this.IDMap[perkDefObject.ID] <- perkDefObject;
	}

	function removePerk( _perk )
	{
		local perkDef;
		switch (typeof _perk)
		{
			case "integer":
				perkDef = ::Const.Perks.PerkDefObjects[_perk].Const;
				break;

			case "string":
				perkDef = _perk;
				break;

			default:
				throw ::MSU.Exception.InvalidType(_perk);
		}

		if (::Const.Perks.PerkDefObjects[perkDef].ID in this.IDMap)
		{
			delete this.IDMap[id];
			foreach (row in this.Tree)
			{
				foreach (i, perk in row)
				{
					if (perk == perkDef) return row.remove(i);
				}
			}
		}
	}

	function hasPerkGroup( _perkGroup )
	{
		foreach (row in _perkGroup.getTree())
		{
			foreach (perk in row)
			{
				if (!this.hasPerk(perk)) return false;
			}
		}

		return true;
	}

	function addPerkGroup( _perkGroup, _isRefundable = true )
	{
		foreach (i, row in _perkGroup.getTree())
		{
			foreach (perk in row)
			{
				this.addPerk(perk, row + 1, _isRefundable);
			}
		}
	}

	function removePerkGroup( _perkGroup )
	{
		foreach (row in _perkGroup.getTree())
		{
			foreach (perk in row)
			{
				this.removePerk(perk);
			}
		}
	}
}
