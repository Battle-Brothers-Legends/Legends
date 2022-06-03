::Legends.Class.PerkGroupCollection <- class
{
	Array = null,

	constructor( _array = null )
	{
		if (_array == null) this.Array = [];
		else
		{
			::MSU.requireArray(_array);
			foreach (group in _array)
			{
				::MSU.requireInstanceOf(::Legends.Class.PerkGroup, group);
			}
			this.Array = _array;
		}
	}

	function getRandomGroup( _exclude = null )
	{
		if (_exclude != null)
		{
			::MSU.requireArray(_exclude);
			return ::MSU.Array.rand(this.Array.filter(@(idx, group) _exclude.find(group) == null));
		}

		return ::MSU.Array.rand(this.Array);
	}

	function getRandomPerk( _exclude = null )
	{
		if (_exclude != null)
		{
			local perks = [];
			foreach (group in this.Array)
			{
				local perk = group.getRandomPerk(_exclude);
				perks.push(perk);
			}
			return ::MSU.Array.rand(perks);
		}

		return this.getRandomGroup().getRandomPerk();
	}
}
