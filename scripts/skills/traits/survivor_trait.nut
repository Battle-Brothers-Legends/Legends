this.survivor_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.survivor";
		this.m.Name = "Survivor";
		this.m.Icon = "ui/traits/trait_icon_43.png";
		this.m.Description = "Why won\'t you just stay dead? This character is a survivor and will outlive most of their peers.";
		this.m.Titles = [
			"the Survivor",
			"the Lucky",
			"the Blessed"
		];
		this.m.Excluded = [
			"trait.bleeder",
			"trait.pessimist",
			"trait.deathwish",
			"trait.ailing"
		];
	}

	function getTooltip()
	{
		local surviveWithInjury = this.World.Assets.m.IsSurvivalGuaranteed ? 60 : 30;
		surviveWithInjury += this.getContainer().getActor().getCurrentProperties().SurviveWithInjuryBonusChance * this.getContainer().getActor().getCurrentProperties().SurviveWithInjuryChanceMult;
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
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + surviveWithInjury + "%[/color] chance to survive if struck down and not killed by a fatality"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.SurviveWithInjuryBonusChance += 60;
	}

});
