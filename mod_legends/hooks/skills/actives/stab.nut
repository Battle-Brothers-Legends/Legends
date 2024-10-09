::mods_hookExactClass("skills/actives/stab", function(o)
{
	q.m.Item = null;

	q.setItem <- function( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	o.onAfterUpdate = function ( _properties )
	{
		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 3;
		}
		else
		{
			this.m.FatigueCostMult = 1.0;
		}
	}
});
