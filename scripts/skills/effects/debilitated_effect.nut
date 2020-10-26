this.debilitated_effect <- this.inherit("scripts/skills/skill", {
	m = {
	TurnsLeft = 3
	},
	function create()
	{
		this.m.ID = "effects.debilitated";
		this.m.Name = "Debilitated";
		this.m.Description = "This character has is debilitated";
		this.m.Icon = "ui/perks/perk_34.png";
		this.m.IconMini = "perk_34_mini";
		this.m.Overlay = "perk_34";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has is debilitated and will only do [color=" + this.Const.UI.Color.NegativeValue + "] 75% [/color] damage each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasSkill("trait.ailing"))
		{
			++this.m.TurnsLeft;
		}
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 0.75;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

