this.fat_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.fat";
		this.m.Name = "Fat";
		this.m.Icon = "ui/traits/trait_icon_10.png";
		this.m.Description = "This character is more interested in pork chops than exercising, and will run out of breath more easily.";
		this.m.Titles = [
			"the Fat",
			"the Ox",
			"the Mountain",
			"the Pig",
			"the Swine"
		];
		this.m.Excluded = [
			"trait.athletic",
			"trait.swift",
			"trait.quick",
			"trait.strong",
			"trait.spartan",
			"trait.swift",
			"trait.iron_lungs"
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
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Max Fatigue"
			}
		];
	}

	function onAdded()
	{
		if (!this.m.IsNew)
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (actor.getBackground().getID() == "background.legend_donkey")
		{
			return;
		}

		if (actor.getEthnicity() == 1)
		{
			actor.getSprite("body").setBrush("bust_naked_body_southern_02");
		}
		else
		{
			actor.getSprite("body").setBrush("bust_naked_body_02");
		}
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints += 10;
		_properties.Stamina -= 10;
	}

});

