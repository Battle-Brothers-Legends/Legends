this.zombie_yeoman <- this.inherit("scripts/entity/tactical/enemies/zombie", {
	m = {},
	function create()
	{
		this.zombie.create();
		this.m.Type = this.Const.EntityType.ZombieYeoman;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.ZombieYeoman.XP;
		this.m.ResurrectionValue = 3.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_yeoman";
	}

	function onInit()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.ZombieYeoman);
		b.SurroundedBonus = 10;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		{
			b.FatigueDealtPerHitMult = 2.0;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		{
			b.DamageTotalMult += 0.1;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 6);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
		}

		r = this.Math.rand(1, 5);
		local armor;

		if (r == 1)
		{
			armor = this.new("scripts/items/armor/padded_leather");
		}
		else if (r == 2)
		{
			armor = this.new("scripts/items/armor/worn_mail_shirt");
		}
		else if (r == 3)
		{
			armor = this.new("scripts/items/armor/patched_mail_shirt");
		}
		else if (r == 4)
		{
			armor = this.new("scripts/items/armor/ragged_surcoat");
		}
		else if (r == 5)
		{
			armor = this.new("scripts/items/armor/basic_mail_shirt");
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			armor.setArmor(this.Math.round(armor.getArmorMax() / 2 - 1) / 1.0);
		}

		this.m.Items.equip(armor);

		if (this.Math.rand(1, 100) <= 75)
		{
			r = this.Math.rand(1, 7);
			local helmet;

			if (r == 1)
			{
				helmet = this.new("scripts/items/helmets/aketon_cap");
			}
			else if (r == 2)
			{
				helmet = this.new("scripts/items/helmets/full_aketon_cap");
			}
			else if (r == 3)
			{
				helmet = this.new("scripts/items/helmets/kettle_hat");
			}
			else if (r == 4)
			{
				helmet = this.new("scripts/items/helmets/padded_kettle_hat");
			}
			else if (r == 5)
			{
				helmet = this.new("scripts/items/helmets/dented_nasal_helmet");
			}
			else if (r == 6)
			{
				helmet = this.new("scripts/items/helmets/mail_coif");
			}
			else if (r == 7)
			{
				helmet = this.new("scripts/items/helmets/full_leather_cap");
			}

			if (this.Math.rand(1, 100) <= 66)
			{
				helmet.setArmor(this.Math.round(helmet.getArmorMax() / 2 - 1) / 1.0);
			}

			this.m.Items.equip(helmet);
		}
	}

});

