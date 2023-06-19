this.double_tongued_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.double_tongued";
		this.m.Name = "Double tongued";
		this.m.Icon = "ui/traits/trait_double_tongued.png";
		this.m.Description = "The nature of humanity brings out the destructive side in many, however this one appears to be worse than the usual.";
		this.m.Excluded = [
			"trait.optimist",
			"trait.teamplayer",
			"trait.determined",
			"trait.gift_of_people"
		];
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]10%[/color] chance to depress company morale at the start of a combat"
			},
		];
	}
	
	function onCombatStarted()
	{
		this.skill.onCombatStarted();
		
		if (this.Math.rand(1, 10) < 10)
		{
			return;
		}
		
		local allies = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());
		local ownID = this.getContainer().getActor().getID();

		foreach( ally in allies )
		{
			if (ally.getID() == ownID)
			{
				continue;
			}		
			local ally_morale = ally.getMoraleState();
			
			if (ally_morale > this.Const.MoraleState.Fleeing)
			{
				ally.setMoraleState(ally_morale - 1);
			}
		}
	}	

});

