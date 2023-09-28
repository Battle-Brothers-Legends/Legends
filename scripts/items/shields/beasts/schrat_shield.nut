this.schrat_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.schrat";
		this.m.Name = "Schrat\'s Shield";
		this.m.Description = "The hardened bark from a schrat";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = false;
		this.m.Variant = 1;
		this.updateVariant();
		this.m.Value = 0;
		this.m.MeleeDefense = 20;
		this.m.RangedDefense = 20;
		this.m.StaminaModifier = 0;
		this.m.Condition = 32;
		this.m.ConditionMax = 32;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_schrat_shield_0" + this.m.Variant;
		this.m.SpriteDamaged = "bust_schrat_shield_0" + this.m.Variant + "_damaged";

		// These need to be set only if it's a player that obtained this shield, i.e. through transformation. Currently transformation is removed so this is unneeded (Should maybe be set in create() if its a player anyways?
		// this.m.ShieldDecal = "shield_heartwood_destroyed";
		// this.m.IconLarge = "shields/inventory_heartwood_shield.png";
		// this.m.Icon = "shields/icon_heartwood_shield.png";
	}

});

