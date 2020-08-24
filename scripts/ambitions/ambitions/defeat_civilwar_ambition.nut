this.defeat_civilwar_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.defeat_civilwar";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "If we can win this war for one of the noble houses, our name will be unmatched.\nLet us pick a side, bask in the glory of battle and get rich for it!";
		this.m.UIText = "End the war between noble houses";
		this.m.TooltipText = "Pick one of the noble houses and work with them to crush their enemies. Every army destroyed, and every contract fulfilled, will bring you closer to ending the war.";
		this.m.SuccessText = "[img]gfx/ui/events/event_65.png[/img]At the behest of %winninghouse%, the %companyname% confronted the armored ranks of the other houses, a seemingly insurmountable challenge. It was a hard fought struggle, against opponents trained, disciplined, and well equipped, but in the end you overcame the enemies of %winninghouse% and triumphed on its behalf.\n\nDuring the celebrations that follow, %randomnoble%, one of the lesser members of %winninghouse%, suggests that you end the festivities early. Your men are getting too rowdy, and he\'s concerned they may take advantage of his family\'s hospitality, walking off with the silver plate or fighting with the staff. He notes that there has already been a broken window and points towards some broken glass on the floor.\n\nYou reply that although %winninghouse% was victorious, it is also at this point much weaker and more vulnerable than ever. Now would be a foolish time to alienate friends... or to make new enemies.\n\nHe takes your advice to heart and the celebration continues until dawn.";
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

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isCivilWar())
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
		if (this.World.FactionManager.getGreaterEvil().Type == 0 && this.World.FactionManager.getGreaterEvil().LastType == 1)
		{
			return true;
		}

		this.World.Ambitions.updateUI();
		return false;
	}

	function onPrepareVariables( _vars )
	{
		local allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);
		local bestRelations = 0.0;
		local best;

		foreach( a in allies )
		{
			local f = this.World.FactionManager.getFaction(a);

			if (f != null && f.getType() == this.Const.FactionType.NobleHouse && f.getPlayerRelation() > bestRelations)
			{
				bestRelations = f.getPlayerRelation();
				best = f;
			}
		}

		_vars.push([
			"winninghouse",
			best.getName()
		]);
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

