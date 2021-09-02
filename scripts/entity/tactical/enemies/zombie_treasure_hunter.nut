this.zombie_treasure_hunter <- this.inherit("scripts/entity/tactical/enemies/zombie_knight", {
	m = {},
	function create()
	{
		this.zombie_knight.create();
		this.m.Type = this.Const.EntityType.ZombieTreasureHunter;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.ZombieTreasureHunter.XP;
		this.m.Name = this.Const.Strings.EntityName[this.m.Type];
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_treasure_hunter";
	}

	function onInit()
	{
		this.zombie_knight.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.ZombieTreasureHunter);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.FatigueDealtPerHitMult = 2.0;
		b.DamageTotalMult = 1.25;
		b.DamageReceivedArmorMult = 0.75;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		local r;

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		local aList = [
			[1 "oriental/stitched_nomad_armor"],
			[1 "oriental/leather_nomad_robe"],
			[1 "oriental/nomad_robe"],
			[1 "oriental/thick_nomad_robe"]
		];
		local armor = this.Const.World.Common.pickArmor(aList);
		this.m.Items.equip(armor);
		local helmet = [
			[1, "oriental/nomad_head_wrap"]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}

});

