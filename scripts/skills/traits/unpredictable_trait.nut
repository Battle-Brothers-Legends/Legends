this.unpredictable_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.unpredictable";
		this.m.Name = "Unpredictable";
		this.m.Icon = "ui/traits/unpredictable_trait.png";
		this.m.Description = "It is unclear what this character will ever do next, often dodging, faking and feinting moves. This makes it easier to score good hits.";
		this.m.Titles = [
			"the Dicey"
		];
		this.m.Excluded = [
			"trait.pessimist",
			"trait.hesitant",
			"trait.dumb",
			"trait.predictable"
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Chance To Hit Head"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[this.Const.BodyPart.Head] += 5;
		_properties.Initiative += 5;
	}

});

