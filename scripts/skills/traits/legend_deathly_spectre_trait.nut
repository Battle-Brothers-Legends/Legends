this.legend_deathly_spectre_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.legend_deathly_spectre";
		this.m.Name = "Deathly spectre";
		this.m.Icon = "ui/perks/raisedead2_circle.png";
		this.m.Description = "The shadow of undeath follows this character due to having a necromancer nearby, they will probably be resurrected after death but retain any injuries sustained.";
		this.m.Titles = [
			"the Doomed",
			"the Forsaken",
			"the Dying"
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
		_properties.SurviveWithInjuryBonusChance += 30;
		_properties.SurvivesAsUndead = true;
	}

});

