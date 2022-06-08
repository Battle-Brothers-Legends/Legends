// Base (abstract) class - never instantiated on its own
this.perk_tree <- ::inherit("scripts/config/legend_dummy_bb_class", {
	m = {
		Tree = [],
		TreeTemplate = []
	}

	function init()
	{
	}

	function build()
	{
		this.__build(this.m.TreeTemplate);
	}

	function rebuild()
	{
	}

	function __build( _treeTemplate )
	{
		::MSU.requireArray(_treeTemplate);

		this.clear():

		foreach (row in _treeTemplate)
		{
			::MSU.requireArray(row);
			foreach (perk in row)
			{
				this.addPerk(perk);
			}
		}
	}

	function toTreeTemplate()
	{
		local ret = array(this.m.Tree.len());
		foreach (i, row in this.m.Tree)
		{
			ret[i] = array(row.len());
			foreach (i, perkDef in row)
			{
				ret[i][j] = perkDef.ID;
			}
		}
		return ret;
	}

	function getTree()
	{
		return this.m.Tree;
	}

	function merge( _other )
	{
		_other = _other.toTreeTemplate();
		local template = this.toTreeTemplate();
		foreach (i, row in _other)
		{
			if (template.len() < i + 1) template[i] = [];

			foreach (perkDef in row)
			{
				if (template[i].find(perk) == null) template[i].push(perk);
			}
		}
		this.__build(template);
	}

	function clear()
	{
		this.m.Tree.clear();
	}

	function hasPerk( _id )
	{
		foreach (row in this.m.Tree)
		{
			foreach (perkDef in row)
			{
				if (perkDef.ID == _id) return true;
			}
		}

		return false;
	}

	function getPerk( _id )
	{
		foreach (row in this.m.Tree)
		{
			foreach (perkDef in row)
			{
				if (perkDef.ID == _id) return perkDef;
			}
		}
	}

	function addPerk( _perk, _tier = 1, _isRefundable = true )
	{
		if (this.hasPerk(_perk)) return;

		local perkDef = clone ::Const.Perks.findById(_perk);
		perkDef.Row <- _tier - 1;
		perkDef.Unlocks <- _tier - 1;
		perkDef.IsRefundable <- _isRefundable;
		for (local i = this.m.Tree.len(); i < tier; i++)
		{
			this.m.Tree.push([]);
		}
		this.m.Tree[_tier - 1].push(perkDef);
	}

	function removePerk( _perk )
	{
		foreach (row in this.m.Tree)
		{
			foreach (i, perk in row)
			{
				if (perk.ID == _perk) return row.remove(i);
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
