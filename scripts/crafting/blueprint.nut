this.blueprint <- {
	m = {
		ID = "",
		PreviewCraftable = null,
		PreviewComponents = [],
		PreviewSkills = [],
		Sounds = this.Const.Sound.CraftingGeneral,
		Cost = 0,
		TimesCrafted = 0,
		Enchanter = false,
		Type = this.Const.Items.ItemType.None
	},
	function isValid()
	{
		return true;
	}

	function getID()
	{
		return this.m.ID;
	}

	function getItemType()
	{
		return this.m.Type;
	}

	function getName()
	{
		return this.m.PreviewCraftable.getName();
	}

	function getDescription()
	{
		return this.m.PreviewCraftable.getDescription();
	}

	function getIcon()
	{
		return this.m.PreviewCraftable.getIcon();
	}

	function getIconLarge()
	{
		return this.m.PreviewCraftable.getIconLarge();
	}

	function getCost()
	{
		return this.Math.ceil(this.m.Cost * this.World.Assets.m.TaxidermistPriceMult);
	}

	function getSounds()
	{
		return this.m.Sounds;
	}

	function getTooltip()
	{
		return this.m.PreviewCraftable.getTooltip();
	}

	function getTooltipForComponent( _idx )
	{
		if (_idx > this.m.PreviewComponents.len() - 1)
		{
			this.logError("Out of bound error on blueprint :: " + this.m.ID);
			return null
		}
		return this.m.PreviewComponents[_idx].Instance.getTooltip();
	}

	function getTooltipForSkill( _idx )
	{
		foreach (c in this.m.PreviewSkills)
		{
			foreach (s in c.Instances)
			{
				if (s.getID() == _idx)
				{
					return s.getTooltip();
				}
			}
		}
		return null;
	}

	function create()
	{
	}

	function init( _comps )
	{
		foreach( i in _comps )
		{
			local c = this.new(i.Script);
			local pc = {
				Name = i.Script,
				Num = i.Num,
				Instance = c
			}
			if ("LegendsArmor" in i)
			{
				pc.LegendsArmor <- i.LegendsArmor
			}
			this.m.PreviewComponents.push(pc);
		}
	}

	function initSkills( _skills )
	{
		foreach( i in _skills )
		{
			local C = []
			foreach ( s in i.Scripts )
			{
				C.push(this.new(s));
			}
			this.m.PreviewSkills.push({
				Instances = C
			});
		}
	}

	function reset()
	{
		this.onReset();
	}

	function requirementsMet( _ids )
	{
		local roster = this.World.getPlayerRoster().getAll();
        foreach( bro in roster )
        {
			foreach ( id in _ids)
			{
				if (bro.getSkills().hasSkill(id))
				{
					return true
				}
			}
		}
		return false;
	}


	function isCraftable()
	{
		local itemsMap = {}
		foreach( item in this.World.Assets.getStash().getItems())
		{
			if (item == null)
			{
				continue;
			}

			if (!(item.getID() in itemsMap))
			{
				itemsMap[item.getID()] <- 0;
			}
			itemsMap[item.getID()] = itemsMap[item.getID()] + 1
		}

		foreach( c in this.m.PreviewComponents )
		{

			if ("LegendsArmor" in c)
			{
				if (c.LegendsArmor && !this.World.LegendsMod.Configs().LegendArmorsEnabled())
				{
					continue;
				}
				if (!c.LegendsArmor && this.World.LegendsMod.Configs().LegendArmorsEnabled())
				{
					continue;
				}
			}

			local num = 0;
			if (c.Instance.getID() in itemsMap)
			{
				num = itemsMap[c.Instance.getID()];
			}

			if (num < c.Num)
			{
				return false;
			}
		}

		foreach( c in this.m.PreviewSkills )
		{
			local ids = [];
			foreach (s in c.Instances) {
				ids.push(s.getID());
			}
			if (!this.requirementsMet(ids))
			{
				return false;
			}
		}

		return true;
	}

	function isQualified()
	{
		if (this.m.Enchanter)
		{
			return false
		}

		if (this.World.LegendsMod.Configs().LegendAllBlueprintsEnabled())
		{
			return true;
		}

		if (this.m.TimesCrafted >= 1)
		{
			return true;
		}

		return this.isCraftable();
	}

	function isQualifiedEnchant()
	{
		if (this.m.Enchanter)
		{
			return true;
		}

		return false;
	}

	function getUIData()
	{
		local ret = {
			ID = this.getID(),
			Name = this.getName(),
			Description = this.getDescription(),
			ImagePath = this.getIcon(),
			LargeImagePath = this.getIconLarge() != null ? this.getIconLarge() : this.getIcon(),
			Ingredients = this.getIngredients(),
			Cost = this.getCost(),
			IsCraftable = this.isCraftable(),
			Type = this.getItemType()
		};
		return ret;
	}

	function getIngredients()
	{
		local ret = [];
		local itemsMap = {}
		foreach( item in this.World.Assets.getStash().getItems())
		{
			if (item == null)
			{
				continue;
			}

			if (!(item.getID() in itemsMap))
			{
				itemsMap[item.getID()] <- 0;
			}
			itemsMap[item.getID()] = itemsMap[item.getID()] + 1
		}

		foreach(c in this.m.PreviewSkills )
		{
			foreach (s in c.Instances)
			{
				ret.push({
					InstanceID = s.getID(),
					ImagePath = s.getIconColored(),
					IsMissing = !this.requirementsMet([s.getID()]),
					IsSkill = 1
				});
			}
		}

		foreach( i, c in this.m.PreviewComponents )
		{
			local num = 0;
			if (c.Instance == null)
			{
				local name = "";
				if (c.Name != null)
				{
					name = c.Name;
				}
				this.logInfo("ERROR, blueprint instance is null. item name = " + name)
				continue;
			}

			if ("LegendsArmor" in c)
			{
				if (c.LegendsArmor && !this.World.LegendsMod.Configs().LegendArmorsEnabled())
				{
					continue;
				}
				if (!c.LegendsArmor && this.World.LegendsMod.Configs().LegendArmorsEnabled())
				{
					continue;
				}
			}

			if (c.Instance.getID() in itemsMap)
			{
				num = itemsMap[c.Instance.getID()];
			}

			for( local j = 1; j <= c.Num; j = ++j )
			{
				ret.push({
					InstanceID = i,
					ImagePath = c.Instance.getIcon(),
					IsMissing = j > num,
					IsSkill = 0
				});
			}
		}

		return ret;
	}

	function craft()
	{
		if (!this.isQualified())
		{
			return;
		}

		this.updateAchievement("IMadeThis", 1, 1);
		local stash = this.World.Assets.getStash();
		local hasAlchemist = this.World.Retinue.hasFollower("follower.alchemist");

		foreach( c in this.m.PreviewComponents )
		{
			if ("LegendsArmor" in c)
			{
				if (c.LegendsArmor && !this.World.LegendsMod.Configs().LegendArmorsEnabled())
				{
					continue;
				}
				if (!c.LegendsArmor && this.World.LegendsMod.Configs().LegendArmorsEnabled())
				{
					continue;
				}
			}

			for( local j = 0; j < c.Num; j = ++j )
			{
				local item = stash.getItemByID(c.Instance.getID());

				if (!hasAlchemist || item.getMagicNumber() > 25)
				{
					stash.remove(item);
				}
				else
				{
					item.setMagicNumber(this.Math.rand(1, 100));
				}
			}
		}

		++this.m.TimesCrafted;
		this.onCraft(stash);
	}

	function enchant( _bonus )
	{
		if (!this.isQualifiedEnchant())
		{
			return;
		}

		local stash = this.World.Assets.getStash();

		foreach( c in this.m.PreviewComponents )
		{
			if ("LegendsArmor" in c)
			{
				if (c.LegendsArmor && !this.World.LegendsMod.Configs().LegendArmorsEnabled())
				{
					continue;
				}
				if (!c.LegendsArmor && this.World.LegendsMod.Configs().LegendArmorsEnabled())
				{
					continue;
				}
			}

			for( local j = 0; j < c.Num; j = ++j )
			{
				stash.removeByID(c.Instance.getID());
			}
		}

		++this.m.TimesCrafted;
		this.onEnchant(stash, _bonus);
	}

	function onEnchant( _stash, _bonus )
	{
	}

	function onCraft( _stash )
	{
	}

	function onReset()
	{
	}

	function onSerialize( _out )
	{
		_out.writeU32(this.m.TimesCrafted);
	}

	function onDeserialize( _in )
	{
		this.m.TimesCrafted = _in.readU32();
	}

};

