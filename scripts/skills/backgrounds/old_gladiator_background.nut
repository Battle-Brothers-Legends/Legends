this.old_gladiator_background <- this.inherit("scripts/skills/backgrounds/gladiator_background", {
	m = {},
	function create()
	{
		this.gladiator_background.create();
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Level = 3;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("body");
		tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		tattoo_body.Visible = true;
		tattoo_head.setBrush("scar_02_head");
		tattoo_head.Visible = true;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local a = this.Const.World.Common.pickArmor([
			[1, "oriental/gladiator_harness"]
		]);

		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			a.setUpgrade(this.new("scripts/items/" +
				(this.World.LegendsMod.Configs().LegendArmorsEnabled() ? "legend_armor/armor_upgrades/legend_light_gladiator_upgrade" : "armor_upgrades/light_gladiator_upgrade")
			))
		}
		else if (r == 2)
		{
			a.setUpgrade(this.new("scripts/items/" +
				(this.World.LegendsMod.Configs().LegendArmorsEnabled() ? "legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade" : "armor_upgrades/heavy_gladiator_upgrade")
			))
		}
		items.equip(a);
	}
});

