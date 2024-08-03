this.orc_ears_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.orc_ears";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Chain of Ears";
		this.m.Description = "A string of ears showing prowess in battle";
		this.m.ArmorDescription = "A gruesome string of ears";
		this.m.Icon = "armor_upgrades/icon_orc_ears_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_orc_ears_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_orc_ears_01.png";
		this.m.SpriteBack = "bust_orc_ears_01";
		this.m.SpriteDamagedBack = "bust_orc_ears_01_damaged";
		this.m.SpriteCorpseBack = "bust_orc_ears_01_dead";

		this.m.Value = 200;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -3;
		this.m.DirectDamageModifier = -20.0;
	}
});

