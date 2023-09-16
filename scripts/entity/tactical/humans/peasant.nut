this.peasant <- this.inherit("scripts/entity/tactical/randomized_unit_abstract", {
	m = {
		Outfits = [
			[1, "peasant_outfit_00"],
		]
		WeaponsAndTrees = [
			["scripts/items/weapons/knife", this.Const.Perks.DaggerTree, 100, this.Const.Perks.KnifeClassTree, 80],
			["scripts/items/weapons/pitchfork", this.Const.Perks.PolearmTree, 100, this.Const.Perks.PitchforkClassTree, 60],
			["scripts/items/weapons/wooden_stick", this.Const.Perks.SpearTree, 100, this.Const.Perks.MilitiaClassTree, 65],
			["scripts/items/weapons/pickaxe", this.Const.Perks.HammerTree, 100, this.Const.Perks.HammerClassTree, 45],
			["scripts/items/weapons/legend_hammer", this.Const.Perks.HammerTree, 100, this.Const.Perks.HammerClassTree, 60],
			["scripts/items/weapons/legend_sickle", this.Const.Perks.SwordTree, 100, this.Const.Perks.SickleClassTree, 80],
			["scripts/items/weapons/legend_wooden_pitchfork", this.Const.Perks.PolearmTree, 100, this.Const.Perks.PitchforkClassTree, 65],
			["scripts/items/weapons/legend_scythe", this.Const.Perks.CleaverTree, 100, this.Const.Perks.ButcherClassTree, 75],
			["scripts/items/weapons/legend_hoe", this.Const.Perks.AxeTree, 100],
			["scripts/items/weapons/legend_shiv", this.Const.Perks.DaggerTree, 100, this.Const.Perks.KnifeClassTree, 75],
			["scripts/items/weapons/legend_shovel", this.Const.Perks.MaceTree, 100, this.Const.Perks.ShovelClassTree, 80],
			["scripts/items/weapons/legend_staff", this.Const.Perks.StaffTree, 100],
			["scripts/items/weapons/butchers_cleaver", this.Const.Perks.CleaverTree, 100, this.Const.Perks.ButcherClassTree, 45],
			["scripts/items/weapons/legend_wooden_spear", this.Const.Perks.SpearTree, 100, this.Const.Perks.MilitiaClassTree, 80]
		],
		BasePower = this.Const.RandomizedPower.VeryLow + 1,
		PerkPower = this.Const.RandomizedPower.VeryLow - 1
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.Peasant;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Peasant.XP;
		this.randomized_unit_abstract.create();
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
		this.randomized_unit_abstract.onInit();
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
		this.randomized_unit_abstract.assignRandomEquipment();
	}
	// function assignRandomEquipment()
	// {
	// 	local r;
	// 	r = this.Math.rand(1, 14);

	// 	if (r == 1)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/knife"));
	// 	}
	// 	else if (r == 2)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
	// 	}
	// 	else if (r == 3)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
	// 	}
	// 	else if (r == 4)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
	// 	}
	// 	else if (r == 5)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
	// 	}
	// 	else if (r == 6)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
	// 	}
	// 	else if (r == 7)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_sickle"));
	// 	}
	// 	else if (r == 8)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));
	// 	}
	// 	else if (r == 9)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_scythe"));
	// 	}
	// 	else if (r == 10)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_hoe"));
	// 	}
	// 	else if (r == 11)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_shiv"));
	// 	}
	// 	else if (r == 12)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_shovel"));
	// 	}
	// 	else if (r == 13)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/legend_staff"));
	// 	}
	// 	else if (r == 14)
	// 	{
	// 		this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
	// 	}


	// 	this.m.Items.equip(this.Const.World.Common.pickArmor([
	// 		[1, "sackcloth"],
	// 		[1, "thick_tunic"],
	// 		[1, "apron"],
	// 		[1, "tattered_sackcloth"],
	// 		[4, "linen_tunic"]
	// 	]));

	// 	if (this.Math.rand(1, 100) <= 33)
	// 	{
	// 		this.m.Items.equip(this.Const.World.Common.pickHelmet([
	// 			[1, "straw_hat"],
	// 			[1, "hood"],
	// 			[1, "headscarf"],
	// 			[1, "feathered_hat"]
	// 		]))
	// 	}
	// }

});

