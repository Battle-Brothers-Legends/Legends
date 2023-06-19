this.impatient_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.impatient";
		this.m.Name = "Impatient";
		this.m.Icon = "ui/traits/trait_icon_46.png";
		this.m.Description = "Let\'s go already! What\'s taking so long? This character wants things to get started now.";
		this.m.Titles = [
			"the Quick",
			"the Eager",
			"the Anxious"
		];
		this.m.Excluded = [
			"trait.hesitant",
			"trait.clubfooted",
			"trait.teamplayer",
			"trait.sureshot",
			"trait.slack"
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
				icon = "ui/icons/special.png",
				text = "Always acts first in the very first round of combat"
			}
		];
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().isPlacedOnMap() && this.Time.getRound() <= 1)
		{
			_properties.InitiativeForTurnOrderAdditional += 1000;
		}
	}

});

