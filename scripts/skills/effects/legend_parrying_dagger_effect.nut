this.legend_parrying_dagger_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 5,
		BonusDaggerComboDamage = 10,
		OffHandSkillsIDs = [],
	},
	function create()
	{
		this.m.ID = "effects.legend_parrying_dagger";
		this.m.Name = "Parrying Dagger Defense";
		this.m.Description = "Parrying Daggers work best against a single opponent, giving +20 melee defense when there is only a single adjacent enemy. This effect diminishes when facing more than one enemy at a time.";
		this.m.Icon = "ui/perks/parrying_circle.png";
		this.m.IconMini = "mini_parrying_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		// Note: because this effect is added via item.addSkill in legend_parrying_dagger, changing m.Order won't change how this effect will appear above all the other perk on the character screen
		// This appears to be the game's default behaviour for item-added effects. See legend_parrying_dagger for how the parrying effect is added differently such that it appears with the other effects/perks.
		this.m.Order = this.Const.SkillOrder.Item;
		this.m.IsActive = false;
		this.m.IsStacking = false;
	}

	function onEquip( _item )
	{
		if (::MSU.isNull(getItem()) || ::MSU.isEqual(getItem(), _item)) 
			return; // parrying dagger has already been unequipped or it's itself

		if (_item == null || !::isKindOf(_item, "weapon") || !_item.isWeaponType(::Const.Items.WeaponType.Dagger))
			return; // not a dagger

		// remove parrying duplicated skill
		foreach (skill in _item.getSkills())
		{
			if (m.OffHandSkillsIDs.find(skill.getID()) == null)
				continue;

			foreach (duplicate in getItem().getSkills())
			{
				if (duplicate.getID() + "_offhand" != skill.getID())
					continue;

				getItem().removeSkill(duplicate);
				break;
			}
		}
	}

	function onUnequip( _item )
	{
		if (::MSU.isNull(getItem()) || ::MSU.isEqual(getItem(), _item)) 
			return; // parrying dagger has already been unequipped or it's itself

		if (_item == null || !::isKindOf(_item, "weapon") || !_item.isWeaponType(::Const.Items.WeaponType.Dagger))
			return; // not a dagger

		// remove parrying duplicated skill
		foreach (id in m.OffHandSkillsIDs)
		{
			foreach (duplicate in getItem().getSkills())
			{
				if (duplicate.getID() != id + "_offhand")
					continue;

				getItem().removeSkill(duplicate);
				break;
			}
		}

		// readd the skills as the main hand dagger has been removed
		getItem().addDaggerSkills();
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Bonus + "[/color] Melee Defense"
			}
		];

		local main = getContainer().getActor().getMainhandItem();

		// free bonus for having a double dagger combo
		if (main != null && ::isKindOf(main, "weapon") && main.isWeaponType(::Const.Items.WeaponType.Dagger))
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + m.BonusDaggerComboDamage + "%[/color] Damage due to dual wielding daggers"
			})

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.IsParrying = true;

		local main = getContainer().getActor().getMainhandItem();

		// free bonus for having a double dagger combo
		if (main != null && ::isKindOf(main, "weapon") && main.isWeaponType(::Const.Items.WeaponType.Dagger))
			_properties.MeleeDamageMult *= 1.0 + m.BonusDaggerComboDamage * 0.01;

		if (!this.getContainer().getActor().isPlacedOnMap())
			return;

		local actor = this.getContainer().getActor();
		local numAdjacentEnemies = ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len();

		this.m.Bonus = numAdjacentEnemies == 1 ? 20 : 5;

		_properties.MeleeDefense += this.m.Bonus;
	}

});
