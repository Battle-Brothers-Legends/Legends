this.sureshot_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.sureshot";
		this.m.Name = "Sureshot";
		this.m.Icon = "ui/traits/sureshot_trait.png";
		this.m.Description = "Takes time to hit the exact right spot on a target, this in turn makes them an easier target";
		this.m.Titles = [
			"Sureshot",
			"the Patient"
		];
		this.m.Excluded = [
			"trait.irrational",
			"trait.impatient",
			"trait.quick"
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
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Ranged Damage"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Ranged Defense"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.RangedDamageMult *= 1.1;
		_properties.RangedDefense -= 10;
	}

});

