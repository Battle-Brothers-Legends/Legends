this.defeat_holywar_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.defeat_holywar";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "The fires of religious turmoil threaten to engulf the lands. Let the company be forged\nstronger than ever by its heat and flames, and earn a fortune by winning the war!";
		this.m.UIText = "End the war between north and south";
		this.m.TooltipText = "Pick either the northern noble houses or the southern city states and work with them to win their holy war. Every army destroyed, and every contract fulfilled, will bring you closer to ending the war.";
		this.m.SuccessButtonText = "Whether they love or hate us, everyone knows the %companyname% now!";
	}

	function getUIText()
	{
		local f = this.World.FactionManager.getGreaterEvil().Strength / this.Const.Factions.GreaterEvilStartStrength;
		local text;

		if (f >= 0.95)
		{
			text = "Just started";
		}
		else if (f >= 0.5)
		{
			text = "Raging";
		}
		else if (f >= 0.25)
		{
			text = "Dragging On";
		}
		else
		{
			text = "Almost Over";
		}

		return this.m.UIText + " (" + text + ")";
	}

	function getSuccessText()
	{
		local north = 0;
		local south = 0;
		local sites = [
			"location.holy_site.oracle",
			"location.holy_site.meteorite",
			"location.holy_site.vulcano"
		];
		local locations = this.World.EntityManager.getLocations();

		foreach( v in locations )
		{
			foreach( i, s in sites )
			{
				if (v.getTypeID() == s && v.getFaction() != 0)
				{
					if (this.World.FactionManager.getFaction(v.getFaction()).getType() == this.Const.FactionType.NobleHouse)
					{
						north = ++north;
					}
					else
					{
						south = ++south;
					}
				}
			}
		}

		if (north >= south)
		{
			return "[img]gfx/ui/events/event_92.png[/img]{The air you breathe, the ground beneath your feet, neither feel the least bit different. Yet around you there is the rejoice of the northern throngs as though every soul had been gifted their every wish. You\'ve gotten news that the Southerners have relented and sent the doves, ending the holy war in the favor of the North. In turn, the North will have occupation of the holy sites and permit southern entrance so long as they submit that their \'Gilder\' is but one of many in the pantheon of the old gods. A young girl comes to you with a flower.%SPEECH_ON%They speak of knights and heroes, but I seen you myself. You went that way, and good news came, and you went thataway, and more good news came. It was as if you were heaven sent, the right hand of the old gods themselves.%SPEECH_OFF%You thank the girl and she pirouettes and runs off. %randombrother% walks up to you with pursed lips.%SPEECH_ON%Heaven sent and the best they can do is give you a bloody flower?%SPEECH_OFF%}";
		}
		else
		{
			return "[img]gfx/ui/events/event_171.png[/img]{You watch as crowds of the great Gilder\'s followers stream toward the holy sites, the whole land free from the shackles of religious war, and the holy war settled in the favor of the South. From what you have heard, the Viziers have enforced a rule that while Northerners may visit the holy lands, they must pay a tax to the governors overseeing those territories. It is a miserly result, though not a particularly violent and vengeful one.\n\n As you take stock of your inventory, a dozen old men come up the road and stop before you. They announce themselves as scribes and historians who are undertaking the great recollection of the holy war. Apparently someone had pointed you out to them, but they\'re not entirely sure who you are. You explain that the Viziers hired you to-%SPEECH_ON%Hired, you say? As in, you are a Crownling?%SPEECH_OFF%One of the old men cuts you off, his quill pen scratching to a sudden stop. He shakes his head.%SPEECH_ON%No no no, we are looking to catalog the successes of those responsible for returning sacred lands to the Gilder\'s light. You are a shriveling, opportunistic, and no doubt conniving Crownling. Have a nice day.%SPEECH_OFF%They depart before you can retort, though you suspect if you were in the mood for a bit of back and forth you\'d probably have given them a bit of steel to deal with. %randombrother% walks up and asks who they were. You shrug.%SPEECH_ON%Just a bunch of nobodies.%SPEECH_OFF%}";
		}
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (!this.World.FactionManager.isHolyWar())
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		this.m.Score = 10;
	}

	function onCheckSuccess()
	{
		if (this.World.FactionManager.getGreaterEvil().Type == 0 && this.World.FactionManager.getGreaterEvil().LastType == 4)
		{
			return true;
		}

		this.World.Ambitions.updateUI();
		return false;
	}

	function onPrepareVariables( _vars )
	{
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

