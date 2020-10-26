this.predictable_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.predictable";
		this.m.Name = "Predictable";
		this.m.Icon = "ui/traits/predictable_trait.png";
		this.m.Description = "Guess where he\'s gonna hit.";
		this.m.Excluded = [
			"trait.natural",
			"trait.bright",
			"trait.dexterous",
			"trait.swift",
			"trait.unpredictable"
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
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Chance To Hit Head"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[this.Const.BodyPart.Head] -= 5;
		_properties.Initiative -= 5;
	}

});

