
this.legend_helmet_jester_hat <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {
		BonusHeadChance = 10,
		HCMin = 10,
		HCMax = 30
	},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.legend_helmet_jester_hat";
		this.m.Name = "Jester Hat";
		this.m.Description = "The quintessential hat of performing folk in noble court";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [];
		for(local i = 1; i < 65; i++)
		{
			this.m.Variants.push(i);
		}
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 200;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -1;
		this.m.Vision = 0;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		//option for bhc range
		// this.m.BonusHeadChance = this.Math.rand(this.m.HCMin, this.m.HCMax);
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		this.onArmorTooltip(result)
		return result;
	}

	function onArmorTooltip( result )
	{
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.BonusHeadChance + "%[/color] Chance To Hit Head"
		});
		return result
	}

    function onUpdateProperties(_properties)
    {
        this.legend_helmet_upgrade.onUpdateProperties(_properties);
        _properties.HitChance[this.Const.BodyPart.Head] += this.m.BonusHeadChance;
    }

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_jester_hat" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_jester_hat" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_jester_hat" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_jester_hat" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}
});
