this.legend_conscript_ranged_background <- this.inherit("scripts/skills/backgrounds/legend_conscript_background", {
	m = {},
	function create()
	{
		this.m.Name = "Conscript Gunner";
		this.m.Icon = "ui/backgrounds/background_ranged_conscript.png"; //TO DO
		this.nomad_background.create();
		this.m.HiringCost = 325;
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				8,
				8
			],
			Bravery = [
				6,
				4
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				5,
				3
			],
			RangedSkill = [
				15,
				12
			],
			MeleeDefense = [
				2,
				0
			],
			RangedDefense = [
				6,
				8
			],
			Initiative = [
				10,
				10
			]
		};
		return c;
	}
	
	function onAdded()
	{
		this.character_background.onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_throw_sand"));
	}	

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/oriental/saif"));
		}
		this.m.Items.equip(this.new("scripts/items/weapons/oriental/handgonne"));
		this.m.Items.equip(this.new("scripts/items/ammo/powder_bag"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, "oriental/padded_vest"]
		]))

		local helm = this.Const.World.Common.pickHelmet([
			[1, "oriental/nomad_head_wrap"],
			[1, "oriental/gunner_hat"],
			[1, ""]
		]);
		items.equip(helm);
	}
});

