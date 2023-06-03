this.terrifying_nightmares_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.terrifying_nightmares";
		this.m.Name = "Terrifying Nightmares";
		this.m.Description = "The people of this settlement are terrorized by nightmares. Many prefer to stay awake all night just to be safe.";
		this.m.Icon = "ui/settlement_status/settlement_effect_25.png";
		this.m.Rumors = [
			"The other day I came through %settlement%. Something is wrong there. Pale faces, tired eyes and shambling walks. It\'s like they didn\'t sleep in a week!",
			"I just got a letter from my aunt in %settlement% claiming that the whole town is troubled by terrible nightmares. I don\'t know, she\'s always been overly dramatic.",
			"The best recipe for a good night\'s sleep is hard work and a pint of ale! Come to think of it, someone should tell it to the folks over in %settlement%; from what I\'ve heard, whole town\'s got trouble sleeping."
		];
	}

	function onAdded( _settlement )
	{
		_settlement.resetRoster(true);
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		}
	}

	function onResolved( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
		} 
	}


	function getAddedString( _s )
	{
		return _s + " suffers from " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer suffers from " + this.m.Name;
	}

	function onUpdate( _modifiers )
	{
		_modifiers.RecruitsMult *= 0.75;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if  ( this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_nightwatch_background");
			_draftList.push("legend_nightwatch_background");
			_draftList.push("legend_nightwatch_background");
			_draftList.push("legend_man_at_arms_background");
		}

		if(this.LegendsMod.Configs().LegendMagicEnabled())
		{
			if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_warlock")
			{
				r = this.Math.rand(0, 9);
				if (r == 1)
				{
				_list.push("legend_vampire_background");
				}
			}

		}

	}

});

