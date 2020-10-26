this.legend_armor_named_warlock_cloak <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.legend_named_warlock_cloak";
		this.m.Description = "A cloak made from the skin of dead men and dark magic. +10% melee skill and defense when at confident morale. Also grants +20 hitpoints";
		this.m.Name = "Warlock cloak"
		this.m.NameList = [
			"Dead Man\'s Skin",
			"Necromancer\'s Robe",
			"Seance\'s Skin",
			"Warlock\'s Cloak",
			"Deathcloak",
			"Sorceror\'s Hood"
		];
		this.m.Variant = 508;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 5000;
		this.m.Condition = 180;
		this.m.ConditionMax = 180;
		this.m.StaminaModifier = 8;
		this.randomizeValues();

	}


	function getTooltip()
	{
		local result = this.legend_named_armor.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=" + this.Const.UI.Color.PositiveEventValue + "] +10%[/color] Melee skill when at confident morale."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=" + this.Const.UI.Color.PositiveEventValue + "] +10%[/color] Melee defense when at confident morale."
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=" + this.Const.UI.Color.PositiveEventValue + "] +10%[/color] Ranged defense when at confident morale."
		});
		result.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increase max hitpoints by [color=" + this.Const.UI.Color.PositiveEventValue + "] +20[/color]."
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_named_armor.onUpdateProperties(_properties);
		_properties.Hitpoints += 20;
	}


	function onEquip()
	{
		this.legend_named_armor.onEquip();
		local a = this.getContainer().getActor();
		if (a == null)
		{
			return;
		}

		if (!a.getSkills().hasSkill("perk.legend_assured_conquest"))
		{
			a.getSkills().add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		}
	}

	function onUnequip()
	{
		local a = this.getContainer().getActor();
		if (a == null)
		{
			return;

		}
		a.getSkills().removeByID("perk.legend_assured_conquest");
		this.legend_named_armor.onUnequip();
	}

});

