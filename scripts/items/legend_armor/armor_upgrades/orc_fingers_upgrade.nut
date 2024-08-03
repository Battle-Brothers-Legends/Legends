this.orc_fingers_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.orc_fingers";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Chain of fingers";
		this.m.Description = "A string of fingers showing prowess in battle";
		this.m.ArmorDescription = "A gruesome string of fingers";
		this.m.Icon = "armor_upgrades/icon_orc_fingers_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_orc_fingers_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_orc_fingers_01.png";
		this.m.SpriteBack = "bust_orc_fingers_01";
		this.m.SpriteDamagedBack = "bust_orc_fingers_01_damaged";
		this.m.SpriteCorpseBack = "bust_orc_fingers_01_dead";

		this.m.Value = 200;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -3;
		this.m.DirectDamageModifier = -20.0;
	}
});

