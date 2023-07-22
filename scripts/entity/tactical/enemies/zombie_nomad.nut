this.zombie_nomad <- this.inherit("scripts/entity/tactical/enemies/zombie_yeoman", {
	m = {},
	function create()
	{
		this.zombie_yeoman.create();
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_nomad";
	}

	function assignRandomEquipment()
	{
		local weapons = [
			"weapons/oriental/saif",
			"weapons/scimitar",
			"weapons/oriental/nomad_mace",
			"weapons/boar_spear",
			"weapons/bludgeon",
			"weapons/butchers_cleaver",
			"weapons/oriental/light_southern_mace",
			"weapons/oriental/two_handed_saif",
			"weapons/two_handed_wooden_hammer",
			"weapons/woodcutters_axe"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 50)
		{
			local shields = [
				"shields/oriental/southern_light_shield"
			];
			local shield = this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]);

			if (this.Math.rand(1, 100) <= 66)
			{
				shield.setCondition(this.Math.round(shield.getConditionMax() / 2 - 1) / 1.0);
			}

			this.m.Items.equip(shield);
		}

		local armor = [
			"armor/oriental/stitched_nomad_armor",
			"armor/oriental/plated_nomad_mail",
			"armor/oriental/leather_nomad_robe",
			"armor/oriental/nomad_robe",
			"armor/oriental/thick_nomad_robe"
		];
		local armor = this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]);

		if (this.Math.rand(1, 100) <= 66)
		{
			armor.setArmor(this.Math.round(armor.getArmorMax() / 2 - 1) / 1.0);
		}

		this.m.Items.equip(armor);
		local helmet = [
			"helmets/oriental/nomad_leather_cap",
			"helmets/oriental/nomad_light_helmet",
			"helmets/oriental/nomad_reinforced_helmet",
			"helmets/oriental/leather_head_wrap",
			"helmets/oriental/nomad_head_wrap",
			"helmets/oriental/nomad_head_wrap"
		];
		local helmet = this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]);

		if (this.Math.rand(1, 100) <= 66)
		{
			helmet.setArmor(this.Math.round(helmet.getArmorMax() / 2 - 1) / 1.0);
		}

		this.m.Items.equip(helmet);
	}

});

