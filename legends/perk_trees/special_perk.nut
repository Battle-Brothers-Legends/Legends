this.special_perk <- ::inherit("scripts/config/legend_dummy_bb_class", {
	m = {
		Perk = null,
		Chance = null,
		ChanceFunction = null,
		Tier = null,
		FlavorText = null
	},
	function create()
	{
	}

    function init( _chance, _tier, _perk, _flavorText, _chanceFunction = null )
	{
		this.setChance(_chance);
		this.setTier(_tier);
		this.setPerk(_perk);
		this.setFlavorText(_flavorText);
		if (_chanceFunction == null) _chanceFunction = @() this.Chance;
		else this.setChanceFunction(_chanceFunction);
	}

	function getChance()
	{
		return this.m.Chance;
	}

	function setChance( _chance )
	{
		::MSU.requireInteger(_chance);
		this.m.Chance = _chance;
	}

	function getTier()
	{
		return this.m.Tier;
	}

	function setTier( _tier )
	{
		::MSU.requireInteger(_tier);
		this.m.Tier = _tier;
	}

	function getPerk()
	{
		return this.m.Perk;
	}

	function setPerk( _perk )
	{
		this.m.Perk = _perk;
	}

	function setChanceFunction( _function )
	{
		::MSU.requireFunction(_function);
		this.m.ChanceFunction = _function;
	}

	function getFlavorText()
	{
		return this.m.FlavorText;
	}

	function setFlavorText( _flavorText )
	{
		::MSU.requireString(_flavorText);
		this.m.FlavorText = _flavorText;
	}

	function roll( _player, _map, _traits = null )
	{
		local chance = this.m.ChanceFunction(_player);

		if (chance == 0) return null;

		foreach (multiplier in _player.getBackground().m.SpecialPerkMultipliers)
		{
			if (multiplier[1] == this.m.Perk)
			{
				chance *= multiplier[0];
				break;
			}
		}

		if (chance == 0) return null;

		if (_traits == null) _traits = _player.getSkills().getSkillsByFunction(@(skill) skill.m.Type == ::Const.SkillType.Trait);

		foreach (trait in _traits)
		{
			foreach (multiplier in trait.m.SpecialPerkMultipliers)
			{
				if (multiplier[1] == this.m.Perk)
				{
					chance *= multiplier[0];
					break;
				}
			}
		}

		if (chance == 0) return null;

		foreach (category in _map)
		{
			foreach (perkGroup in category)
			{
				if ("SpecialPerkMultipliers" in perkGroup)
				{
					foreach (multiplier in perkGroup.SpecialPerkMultipliers)
					{
						if (multiplier[1] == this.m.Perk)
						{
							chance *= multiplier[0];
							break;
						}
					}
				}
			}
		}

		if (chance < 0 || ::Math.rand(1, 100) <= chance) return this;

		return null;
	}
});
