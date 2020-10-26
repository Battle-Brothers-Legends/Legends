this.legend_tower_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_tower_shield";
		this.m.Name = "Tower Shield";
		this.m.Description = "A large square shield that offers excellent protection for yourself and others, very heavy and hard to maneuver";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = this.Math.rand(1, 21);
		this.updateVariant();
		this.m.Value = 1000;
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 25;
		this.m.StaminaModifier = -30;
		this.m.Condition = 96;
		this.m.ConditionMax = 96;
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.Sprite = "towershield_" + variant;
		this.m.SpriteDamaged = "towershield_" + variant + "_damaged";
		this.m.ShieldDecal = "towershield_" + variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_towershield_" + variant + ".png";
		this.m.Icon = "shields/icon_towershield_" + variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/legend_fortify_skill"));
		this.addSkill(this.new("scripts/skills/actives/legend_safegaurd"));
	}

	function onPaintSpecificColor( _color )
	{
		this.setVariant( _color );
		this.updateAppearance();
	}

	function onPaintInCompanyColors()
	{
		this.setVariant(this.World.Assets.getBannerID() + 11);
		this.updateAppearance();
	}

});

