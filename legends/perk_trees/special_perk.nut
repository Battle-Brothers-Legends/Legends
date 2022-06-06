::Legends.Class.SpecialPerk <- class
{
	Perk = null;
	Chance = null;
	ChanceFunction = null;
	Tier = null;
	FlavorText = null;

	constructor( _chance, _tier, _perk, _flavorText, _chanceFunction = null  )
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
		return this.Chance;
	}

	function setChance( _chance )
	{
		::MSU.requireInteger(_chance);
		this.Chance = _chance;
	}

	function getTier()
	{
		return this.Tier;
	}

	function setTier( _tier )
	{
		::MSU.requireInteger(_tier);
		this.Tier = _tier;
	}

	function getPerk()
	{
		return this.Perk;
	}

	function setPerk( _perk )
	{
		this.Perk = _perk;
	}

	function setChanceFunction( _function )
	{
		::MSU.requireFunction(_function);
		this.ChanceFunction = _function;
	}

	function getFlavorText()
	{
		return this.FlavorText;
	}

	function setFlavorText( _flavorText )
	{
		::MSU.requireString(_flavorText);
		this.FlavorText = _flavorText;
	}

	function roll( _player, _map, _traits = null )
	{
		local chance = this.ChanceFunction(_player);

		if (chance == 0) return null;

		foreach (multiplier in _player.getBackground().m.SpecialPerkMultipliers)
		{
			if (multiplier[1] == this.Perk)
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
				if (multiplier[1] == this.Perk)
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
						if (multiplier[1] == this.Perk)
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
}
