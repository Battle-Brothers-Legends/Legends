this.peasant <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Peasant;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Peasant.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.getFlags().add("peasant");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Peasant);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.getSprite("socket").setBrush("bust_base_militia");
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			}

	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 14);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_sickle"));
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));
		}
		else if (r == 9)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_scythe"));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hoe"));
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_shiv"));
		}
		else if (r == 12)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 13)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 14)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}

		
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[1, "thick_tunic"],
			[1, "apron"],
			[1, "tattered_sackcloth"],
			[4, "linen_tunic"]
		]));

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "straw_hat"],
				[1, "hood"],
				[1, "head_scarf"],
				[1, "feathered_hat"]
			]))
		}
	}

});

