this.perk_tree_dynamic <- ::inherit("scripts/legends/perk_trees/perk_tree", {
	m = {
		DynamicPerkTreeMap = null,
		Player = null,
		Mins = null,
		LocalMap = null,
		Traits = null
	},
	function create()
	{
	}

	function init( _player, _map, _mins = null )
	{
		this.perk_tree.init();
		if (!::MSU.isKindOf(_player, "player")) throw ::MSU.Exception.InvalidType(_player);
		this.m.Player = ::MSU.asWeakTableRef(_player);
		this.m.DynamicPerkTreeMap = _map;
		if (_mins == null) _mins = ::Const.Perks.DynamicPerkTreeMins;
		else this.setMins(_mins);

		return this;
	}

	function getMins()
	{
		return this.m.Mins;
	}

	function setMins( _mins )
	{
		this.m.Mins = _mins;
	}

	function hasPerk( _id )
	{
		local ret = this.perk_tree.hasPerk(_id);
		if (!ret && this.m.LocalMap != null)
		{
			foreach (category in this.m.LocalMap)
			{
				foreach (perkGroup in category)
				{
					if (perkGroup.hasPerk(_id)) return true;
				}
			}
		}

		return ret;
	}

	function build()
	{
		// if (!("PerkMultipliers" in this.m.Player.getBackground().m))
		// {
		// 	this.m.Player.getBackground().m.PerkMultipliers <- [];
		// }

		local invalidCategoryName = "";
		foreach (categoryName, perkGroupContainers in this.m.DynamicPerkTreeMap)
		{
			foreach (container in perkGroupContainers)
			{
				switch (typeof container)
				{
					case "string":
						if (::Const.Perks.PerkGroup.findById(container) == null) invalidCategoryName = categoryName;
						break;

					case "instance":
						if (container instanceof ::MSU.Class.WeightedContainer)
						{
							container.apply(@(item, weight) if(::Const.Perks.PerkGroup.findById(item) == null) invalidCategoryName = categoryName);
						}
						break;

					default:
						invalidCategoryName = categoryName;
				}
			}
		}

		if (invalidCategoryName != "")
		{
			::logError("Background " + this.m.Player.getBackground().getID() + " has wrongly formatted dynamic perk tree -- Category: " + invalidCategoryName);
			throw ::MSU.Exception.InvalidValue(invalidCategoryName);
		}

		this.m.LocalMap = {};
		this.m.Traits = this.m.Player == null ? null : this.m.Player.getSkills().getSkillsByFunction(@(skill) skill.m.Type == ::Const.SkillType.Trait);

		foreach (categoryName in this.OrderOfAssignment)
		{
			this.m.LocalMap[categoryName] <- [];

			if (categoryName in this.m.DynamicPerkTreeMap)
			{
				local exclude = array(this.m.LocalMap[categoryName].len());
				foreach (i, perkGroup in this.m.LocalMap[categoryName])
				{
					exclude[i] = perkGroup.getID();
				}

				foreach (perkGroupContainer in this.m.DynamicPerkTreeMap[categoryName])
				{
					local perkGroup;

					if (typeof perkGroupContainer == "string")
					{
						perkGroup = ::Const.Perks.PerkGroup.findById(perkGroupContainer);
					}
					else
					{
						if (perkGroupContainer.len() == 1)
						{
							perkGroup = perkGroupContainer.rand();
						}
						else
						{
							this.__applyMultipliers(perkGroupContainer);

							perkGroup = ::Const.Perks.PerkGroup.findById(perkGroupContainer.roll());

							if (perkGroup.getID() == "perk_group.random")
							{
								perkGroup = this.__getWeightedRandomGroupFromCategory(categoryName, exclude);
							}
							else if (perkGroup == null) perkGroup = ::Const.Perks.PerkGroup.findById("perk_group.none");
						}
					}

					this.m.LocalMap[categoryName].push(perkGroup);
					if (perkGroup.getID() != "perk_group.none") exclude.push(perkGroup.getID());
				}
			}

			if (categoryName in this.m.Mins)
			{
				if (categoryName == "Styles")
				{
					local hasRangedWeaponGroup = false;
					local hasMeleeWeaponGroup = false;

					foreach (perkGroup in ::Const.Perks.PerkGroupCollection.RangedWeapon.getList())
					{
						if (this.hasPerkGroup(perkGroup))
						{
							hasRangedWeaponGroup = true;
							break;
						}
					}

					foreach (perkGroup in ::Const.Perks.PerkGroupCollection.MeleeWeapon.getList())
					{
						if (this.hasPerkGroup(perkGroup))
						{
							hasMeleeWeaponGroup = true;
							break;
						}
					}

					if (!hasRangedWeaponGroup) this.m.Player.getBackground().m.PerkGroupMultipliers.push([0, ::Const.Perks.PerkGroup.RangedStyles]);
					if (!hasMeleeWeaponGroup)
					{
						this.m.Player.getBackground().m.PerkGroupMultipliers.push([0, ::Const.Perks.OneHandedStyles]);
						this.m.Player.getBackground().m.PerkGroupMultipliers.push([0, ::Const.Perks.TwoHandedStyles]);
					}
				}

				local exclude = array(this.m.LocalMap[categoryName].len());
				foreach (i, perkGroup in this.m.LocalMap[categoryName])
				{
					exclude[i] = perkGroup.getID();
				}

				local r = ::Math.rand(0, 100);
				for (local i = this.m.LocalMap[categoryName].len(); i < this.m.Mins[categoryName]; i++)
				{
					local perkGroup = this.__getWeightedRandomGroupFromCategory(categoryName, exclude);
					this.m.LocalMap[categoryName].push(perkGroup);
					exclude.push(perkGroup.getID());
				}
			}
		}

		this.m.TreeTemplate = array(11);

		foreach (category in this.m.LocalMap)
		{
			foreach (perkGroup in category)
			{
				foreach (rowNumber, perkIDs in perkGroup.getTree())
				{
					this.m.TreeTemplate[rowNumber] = array(perkIDs.len());
					foreach (i, perkID in perkIDs)
					{
						this.m.TreeTemplate[rowNumber][i] = perkID;
					}
				}
			}
		}

		foreach (specialPerk in ::Const.Perks.SpecialPerks)
		{
			local object = specialPerk.roll(this.m.Player, this.m.LocalMap, this.m.Traits);
			if (object == null) continue;

			local hasRow = false;
			local direction = -1;
			local row = object.Tier - 1;

			while (row >= 0 && row <= 6)
			{
				if (this.m.TreeTemplate[row].len() < 13)
				{
					hasRow = true;
					break;
				}

				row += direction;

				if (row == -1)
				{
					row = object.Tier - 1;
					direction = 1;
				}
			}

			row = hasRow ? this.Math.max(0, this.Math.min(row, 6)) : object.Tier - 1;

			this.m.TreeTemplate[row].push(object.getID());
		}

		local attributes = ::Const.Perks.TraitsTrees.getBaseAttributes();
		foreach (tree in this.m.LocalMap.Traits)
		{
			if ("Attributes" in tree)
			{
				local c = tree.Attributes;
				attributes.Hitpoints[0] += c.Hitpoints[0];
				attributes.Hitpoints[1] += c.Hitpoints[1];
				attributes.Bravery[0] += c.Bravery[0];
				attributes.Bravery[1] += c.Bravery[1];
				attributes.Stamina[0] += c.Stamina[0];
				attributes.Stamina[1] += c.Stamina[1];
				attributes.MeleeSkill[0] += c.MeleeSkill[0];
				attributes.MeleeSkill[1] += c.MeleeSkill[1];
				attributes.MeleeDefense[0] += c.MeleeDefense[0];
				attributes.MeleeDefense[1] += c.MeleeDefense[1];
				attributes.RangedSkill[0] += c.RangedSkill[0];
				attributes.RangedSkill[1] += c.RangedSkill[1];
				attributes.RangedDefense[0] += c.RangedDefense[0];
				attributes.RangedDefense[1] += c.RangedDefense[1];
				attributes.Initiative[0] += c.Initiative[0];
				attributes.Initiative[1] += c.Initiative[1];
			}
		}

		this.m.LocalMap = null;
		this.m.Traits = null;

		this.__build(this.m.TreeTemplate);

		return attributes;
	}

	function __applyMultipliers( _perkGroupContainer )
	{
		local multipliers = clone this.m.Player.getBackground().m.PerkGroupMultipliers;

		foreach (category in this.m.LocalMap)
		{
			foreach (perkGroup in category)
			{
				multipliers.extend(perkGroup.getMultipliers());
			}
		}

		local weapon = this.m.Player.getMainhandItem();
		if (weapon != null)
		{
			local perkGroups = [];

			foreach (weaponTypeName, weaponType in ::Const.Items.WeaponType)
			{
				if (weapon.isWeaponType(weaponType) && (weaponTypeName in ::Const.Perks.PerkGroup))
				{
					perkGroups.push(::Const.Perks.PerkGroup[weaponTypeName]);
				}
			}

			if (perkGroups.len() > 0)
			{
				multipliers.push([[-1, ::MSU.Array.rand(perkGroups)]]);
			}
		}

		if (this.m.Player.getTalents().len() > 0)
		{
			local talents = this.m.Player.getTalents();

			for (local attribute = 0; attribute < this.Const.Attributes.COUNT; attribute++)
			{
				if (talents[attribute] == 0) continue;

				foreach (mult in ::Const.Perks.TalentMultipliers[attribute])
				{
					multipliers.push(
						[mult[0] < 1 ? mult[0] / talents[attribute] : mult[0] * talents[attribute], mult[1]]
					);
				}
			}
		}

		if (this.m.Traits != null)
		{
			foreach (trait in this.m.Traits)
			{
				multipliers.extend(trait.m.PerkGroupMultipliers);
			}
		}

		foreach (multiplier in multipliers)
		{
			local perkGroup = multiplier[1];
			if (_perkGroupContainer.contains(perkGroup)) _perkGroupContainer.setWeight(perkGroup, _perkGroupContainer.getWeight(perkGroup) * multiplier[0]);
		}
	}

	function __getWeightedRandomGroupFromCategory ( _categoryName, _exclude = null )
	{
		local potentialGroups = ::MSU.Class.WeightedContainer();

		foreach (group in ::Const.Perks.PerkGroupCollection[_categoryName].getList())
		{
			if (_exclude != null && _exclude.find(group.getID()) != null)	continue;
			potentialGroups.add(group, group.getSelfMultiplier());
		}

		if (potentialGroups.len() != 0)
		{
			this.__applyMultipliers(potentialGroups);
		}

		local group = potentialGroups.roll();
		return group != null ? group : ::Const.Perks.PerkGroup.findById("perk_group.none");
	}
});
