this.legend_goblin_light_helmet <- this.inherit("scripts/items/helmets/greenskins/goblin_light_helmet", {
	m = {},
	function create()
	{
		this.goblin_light_helmet.create();
		this.m.ID = "armor.head.legend_goblin_light_helmet";
		this.m.IsDroppedAsLoot = true;
	}

	function getLootLayers()
	{
		local L = [];
		local helmet = this.Const.World.Common.pickHelmet([[1, "legend_goblin_light_helmet"]]);

		local layers = helmet.getUpgrades();
	
		foreach (idx, l in layers)
		{
			if (l == 1)
			{
				L.push(helmet.removeUpgrade(idx))
			}
		}

		return L;
	}
});

