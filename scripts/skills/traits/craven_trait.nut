this.craven_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.craven";
		this.m.Name = "Craven";
		this.m.Icon = "ui/traits/trait_icon_40.png";
		this.m.Description = "Run for your lives! This character is a craven and will run at the slightest sign of the odds turning against them.";
		this.m.Titles = [
			"the Coward",
			"the Craven",
			"Turncoat",
			"the Spineless"
		];
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.fainthearted",
			"trait.deathwish",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.hate_greenskins",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.hate_nobles",
			"trait.aggressive",
			"trait.ambitious",
			"trait.natural"
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Resolve"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is always content with being in reserve"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += -10;
		_properties.IsContentWithBeingInReserve = true;
	}

});

