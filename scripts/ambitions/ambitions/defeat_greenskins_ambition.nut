this.defeat_greenskins_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.defeat_greenskins";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "The Greenskin Invasion is threatening to sweep away our world.\nWe shall stand strong and fend it off, for this is how legends are born!";
		this.m.UIText = "Defeat the Greenskin Invasion";
		this.m.TooltipText = "Defeat the Greenskin Invasion! Every contract against them, and every army or location destroyed, will bring you closer to saving the world of man.";
		this.m.SuccessText = "[img]gfx/ui/events/event_81.png[/img]This was a task like none undertaken by the men of the company before, to fend off an entire invasion by some of the fiercest foes man has ever faced. A foe that could not be reasoned with, whose alien mind knows not mercy or compassion, but only war. Orcs and goblins had united in a savage green tide that threatened to wash away the race of man.\n\nUnder a pitiless sun at day and by the light of burning towns at night, the company campaigned against the green menace across the borderlands, rooting it out wherever it raised its ugly, scarred head. The men faced many a hard battle, and made many a sacrifice, but it was all worth it.\n\nThe %companyname% prevailed. After many a savage struggle, after uncounted days where each man\'s life seemed to hang on the roll of a die, the green tide finally seemed to ebb. As orcs and goblins scatter back into the wild, you know that the world of man is saved. For now.";
		this.m.SuccessButtonText = "Bards will sing our names now. If there are any left.";
	}

	function getUIText()
	{
		local f = this.World.FactionManager.getGreaterEvil().Strength / this.Const.Factions.GreaterEvilStartStrength;
		local text;

		if (f >= 0.95)
		{
			text = "Losing";
		}
		else if (f >= 0.5)
		{
			text = "Undecided";
		}
		else if (f >= 0.25)
		{
			text = "Winning Slightly";
		}
		else
		{
			text = "Winning";
		}

		return this.m.UIText + " (" + text + ")";
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isGreenskinInvasion())
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
		if (this.World.FactionManager.getGreaterEvil().Type == 0 && this.World.FactionManager.getGreaterEvil().LastType == 2)
		{
			return true;
		}

		this.World.Ambitions.updateUI();
		return false;
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

