this.legend_bandit_raider_low <- this.inherit("scripts/entity/tactical/enemies/legend_bandit_raider", {
	m = {},
	function create()
	{
		this.legend_bandit_raider.create();
		this.m.IsLow = true;

		//TODO: Look athow to normalize this for low tier units?
		local writeTable = clone this.Const.RandomizedCharacterInfo["BanditRaiderLow"];
		this.writeTablesFromParam(writeTable)
	}

	function onInit()
	{
		this.legend_bandit_raider.onInit();
		this.m.BaseProperties.MeleeSkill -= 5;
		this.m.BaseProperties.MeleeDefense -= 5;
		this.m.BaseProperties.RangedDefense -= 5;
		this.m.BaseProperties.FatigueRecoveryRate = 15;
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		this.legend_bandit_raider.assignRandomEquipment();
		
		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 25)
		{
			local r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
			}
		}
	}

	// function assignRandomEquipment()
	// {
	// 	local r = this.Math.rand(0, 7);

	// 	if (r <= 1)
	// 	{
	// 		if (this.Const.DLC.Unhold)
	// 		{
	// 			r = this.Math.rand(0, 3);

	// 			if (r == 0)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
	// 			}
	// 			else if (r == 1)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
	// 			}
	// 			else if (r == 2)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/pike"));
	// 			}
	// 			else if (r == 3)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
	// 			}
	// 		}
	// 		else
	// 		{
	// 			r = this.Math.rand(0, 2);

	// 			if (r == 0)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
	// 			}
	// 			else if (r == 1)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
	// 			}
	// 			else if (r == 2)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/pike"));
	// 			}
	// 		}
	// 	}
	// 	else
	// 	{
	// 		if (r == 2)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
	// 		}
	// 		else if (r == 3)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
	// 		}
	// 		else if (r == 4)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
	// 		}
	// 		else if (r == 5)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
	// 		}
	// 		else if (r == 6)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
	// 		}
	// 		else if (r == 7)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/flail"));
	// 		}

	// 		if (this.Math.rand(1, 100) <= 66)
	// 		{
	// 			if (this.Math.rand(1, 100) <= 33)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
	// 			}
	// 			else
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
	// 			}
	// 		}
	// 	}

	// 	if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 25)
	// 	{
	// 		r = this.Math.rand(1, 2);

	// 		if (r == 1)
	// 		{
	// 			this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
	// 		}
	// 		else if (r == 2)
	// 		{
	// 			this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
	// 		}
	// 	}

	// 	local item = this.Const.World.Common.pickArmor([
	// 		[10, "bandit_armor_light"],
	// 		[20, "ragged_surcoat"],
	// 		[20, "padded_leather"],
	// 		[15, "worn_mail_shirt"],
	// 		[15, "leather_lamellar"],
	// 		[20, "patched_mail_shirt"]
	// 	])
	// 	this.m.Items.equip(item);

	// 	if (this.Math.rand(1, 100) <= 75)
	// 	{
	// 		local item = this.Const.World.Common.pickHelmet([
	// 			[1, "nasal_helmet"],
	// 			[1, "dented_nasal_helmet"],
	// 			[1, "rusty_mail_coif"],
	// 			[1, "headscarf"]
	// 		])
	// 		if (item != null)
	// 		{
	// 			this.m.Items.equip(item);
	// 		}
	// 	}
	// }

});

