this.orc_young_low <- this.inherit("scripts/entity/tactical/enemies/orc_young", {
	m = {},
	function create()
	{
		this.orc_young.create();
	}

	function onInit()
	{
		this.orc_young.onInit();
	}

	function onFinish()
	{
		this.actor.onFinish();
	}

	function assignRandomEquipment()
	{
		local r;
		local weapon;

		if (this.Math.rand(1, 100) <= 25)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/orc_javelin"));
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			local r = this.Math.rand(1, 3);

				if (r == 1)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_wooden_club");
				}
				else if (r == 2)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_metal_club");
				}
				else if (r == 3)
				{
					weapon = this.new("scripts/items/weapons/legend_chain");
				}
		}
		else
		{
			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				weapon = this.new("scripts/items/weapons/greenskins/goblin_falchion");
			}
			else if (r == 2)
			{
				weapon = this.new("scripts/items/weapons/greenskins/legend_meat_hacker");
			}
			else if (r == 3)
			{
				weapon = this.new("scripts/items/weapons/morning_star");
			}
			else if (r == 4)
			{
				weapon = this.new("scripts/items/weapons/greenskins/legend_bone_carver");
			}
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(weapon);
		}
		else
		{
			this.m.Items.addToBag(weapon);
		}

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_light_shield"));
		}

		r = this.Math.rand(1, 5);
		local item = this.Const.World.Common.pickArmor([
			[1, "greenskins/orc_young_very_light_armor"],
			[1, "greenskins/orc_young_light_armor"],
			[1, "greenskins/orc_young_medium_armor"],
			[2, ""]
		]);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[2, ""],
			[1, "greenskins/orc_young_light_helmet"],
			[1, "greenskins/orc_young_medium_helmet"]
		])
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

