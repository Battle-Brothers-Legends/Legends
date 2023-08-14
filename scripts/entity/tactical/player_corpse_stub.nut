this.player_corpse_stub <- {
	m = {
		CombatStats = null,
		LifetimeStats = null,
		OriginalID = 0,
		Name = "",
		Title = "",
		DaysWithCompany = 0,
		Level = 0,
		DailyCost = 0,
		IsCommander = false,
		Gender = -1
	},
	function getName()
	{
		if (this.m.Title.len() != 0)
		{
			return this.m.Name + " " + this.m.Title;
		}
		else
		{
			return this.m.Name;
		}
	}

	function getNameOnly()
	{
		return this.m.Name;
	}

	function getTitle()
	{
		return this.m.Title;
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function setTitle( _t )
	{
		this.m.Title = _t;
	}

	function setCommander( _f )
	{
		this.m.IsCommander = _f;
	}

	function isCommander()
	{
		return this.m.IsCommander;
	}

	function setGender( _gender )
	{
		this.m.Gender = _gender;
	}

	function getGender()
	{
		return this.m.Gender;
	}

	function getCombatStats()
	{
		return this.m.CombatStats;
	}

	function setCombatStats( _s )
	{
		this.m.CombatStats = clone _s;
	}

	function setLifetimeStats( _s )
	{
		this.m.LifetimeStats = clone _s;
	}

	function isLeveled()
	{
		return false;
	}

	function getDaysWounded()
	{
		return 0;
	}

	function getOriginalID()
	{
		return this.m.OriginalID;
	}

	function setOriginalID( _id )
	{
		this.m.OriginalID = _id;
	}

	function isAlive()
	{
		return false;
	}

	function getImagePath()
	{
		return "tacticalentity(" + this.Math.rand() + "," + this.getID() + ")";
	}

	function getImageOffsetX()
	{
		return 0;
	}

	function getImageOffsetY()
	{
		return 0;
	}

	function getRosterTooltip()
	{
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			}
		];
		local time = this.m.DaysWithCompany;
		local text;

		if (time == -1)
		{
			text = "With the company from the very beginning.";
		}
		else if (time > 1)
		{
			text = "With the company for " + time + " days.";
		}
		else
		{
			text = "Had just joined the company.";
		}

		if (this.m.LifetimeStats.Battles != 0)
		{
			text = text + (" Took part in " + this.m.LifetimeStats.Battles + " battles and has " + this.m.LifetimeStats.Kills + " kills.");
		}

		if (this.m.LifetimeStats.MostPowerfulVanquished != "")
		{
					local vanquishedText = "{" + (" The most powerful opponent %they% vanquished was " + this.m.LifetimeStats.MostPowerfulVanquished + ".") + "}";
					local vars = [];
					this.Const.LegendMod.extendVarsWithPronouns(vars, this.getGender());
					vanquishedText = this.buildTextFromTemplate(vanquishedText, vars);
					text = text + vanquishedText;
		}

		tooltip.push({
			id = 2,
			type = "description",
			text = text
		});
		tooltip.push({
			id = 5,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = "Level " + this.m.Level
		});

		if (this.m.DailyCost != 0)
		{
			tooltip.push({
				id = 3,
				type = "text",
				icon = "ui/icons/asset_daily_money.png",
				text = "Paid [img]gfx/ui/tooltips/money.png[/img]" + this.m.DailyCost + " daily"
			});
		}

		return tooltip;
	}

	function create()
	{
	}

	function onInit()
	{
		this.setAlwaysApplySpriteOffset(true);
	}

};

