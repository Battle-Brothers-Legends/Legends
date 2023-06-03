this.mirage_sightings_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.mirage_sightings";
		this.m.Name = "Mirage Sightings";
		this.m.Description = "The cracking heat and flickering air have caused a lot of mirage sightings with reportedly strange figures shuffling within them. ";
		this.m.Icon = "ui/settlement_status/settlement_effect_43.png";
		this.m.Rumors = [
			"I tell you, a wonderous lush oasis, golden roofs flimmering in the distance, rainbow colored birds ahead! Where I saw that? Well, it was on the road to %settlement%. I swear!",
			"Some evils do not come in the dark of the night or hide in the shadows. They come out in the scorching sun, during the mid of day. Head on to %settlement% if you want to find out what I am talking about.",
			"Mirages can be seen occasionally in the deserts, and following them can lead to a fate way worse than getting lost in the desert."
		];
	}

	function getAddedString( _s )
	{
		return _s + " now has " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer has " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		}
		_settlement.removeSituationByID("situation.safe_roads");
		_settlement.resetShop();
	}

	function onResolved( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
		}
	}

	function onUpdate( _modifiers )
	{
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

	if(this.LegendsMod.Configs().LegendMagicEnabled())
		{
			local r;
			if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_seer")
			{
			r = this.Math.rand(0, 5);
				if (r == 1)
				{
					_draftList.push("legend_illusionist_background");
				}
			}
			else
			{
				r = this.Math.rand(0, 9);
				if (r == 1)
				{
					_draftList.push("legend_illusionist_background");
				}
			}
		}

	}

});

