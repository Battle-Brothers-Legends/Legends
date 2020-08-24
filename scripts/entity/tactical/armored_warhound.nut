this.armored_warhound <- this.inherit("scripts/entity/tactical/warhound", {
	m = {},
	function create()
	{
		this.warhound.create();
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "special/wardog_armor"]
		]));
	}

});

