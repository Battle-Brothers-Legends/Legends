this.armored_wardog <- this.inherit("scripts/entity/tactical/wardog", {
	m = {},
	function create()
	{
		this.wardog.create();
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "special/wardog_armor"]
		]));
	}

});

