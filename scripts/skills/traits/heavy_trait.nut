this.heavy_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.heavy";
		this.m.Name = "Heavy";
		this.m.Icon = "ui/traits/heavy_trait.png";
		this.m.Description = "Being exceptionally heavy, this character\'s strikes hurt plenty, but he\'s also slower.";
		this.m.Titles = [
			"the Mountain",
			"the Ox",
			"the Bear",
			"the Iron",
			"the Giant",
			"the Tower",
			"the Bull"
		];
		this.m.Excluded = [
			"trait.tiny",
			"trait.quick",
			"trait.frail",
			"trait.fragile",
			"trait.light"
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
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Melee Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20[/color] Initiative"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDamageMult *= 1.1;
		_properties.Initiative -= 20;
	}

});

