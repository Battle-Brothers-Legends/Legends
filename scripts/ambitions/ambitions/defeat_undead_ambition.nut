this.defeat_undead_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.defeat_undead";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "The Undead are rising all over the lands, killing and devouring at sight.\nWe need to put an end to this, or soon there will be no world as we know it left!";
		this.m.UIText = "Defeat the Undead Scourge";
		this.m.TooltipText = "Defeat the Undead Scourge! Every contract against them, and every army or location destroyed, will bring you closer to saving the world of man.";
		this.m.SuccessText = "[img]gfx/ui/events/event_73.png[/img]Walking corpses shambling about in rags. The graveyards of every hamlet soon began to vomit them up, yet it was only the beginning. Ancient legions from an age long past awoke. Never tiring, never fearful, they marched on like a cold machine, ever forward. They conquered the known world once, and they may well have done so again, were it not for a tightly-knit band of mercenaries.%SPEECH_ON%Dead men marching, walking bones in foreign armor, things not from this world... I never thought I\'d see such horrors. But we prevailed!%SPEECH_OFF%%bravest_brother% exclaims, holding high his weapon as if to signal a charge.%SPEECH_ON%The %companyname% prevailed even against this enemy! Who would stand against us now?%SPEECH_OFF%Who, indeed?";
		this.m.SuccessButtonText = "The world of man is saved. For now.";
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
		if (!this.World.FactionManager.isUndeadScourge())
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
		if (this.World.FactionManager.getGreaterEvil().Type == 0 && this.World.FactionManager.getGreaterEvil().LastType == 3)
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

