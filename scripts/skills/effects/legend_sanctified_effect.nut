this.legend_sanctified_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 4
	},
	function create()
	{
		this.m.ID = "effects.legend_sanctified_effect";
		this.m.Name = "Sancitified";
		this.m.Description = "This character is being cleansed by holy light";
		this.m.Icon = "ui/perks/holybluefire_circle.png";
		this.m.IconMini = "mini_bluefire_circle";
		this.m.Overlay = "bluefire_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Not psychologically affected by injuries or losing hitpoints. Immune to bleeding and poison for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turns"
		});
		return ret;
	}

	function onAdded()
	{
		this.m.TurnsLeft = 2;
	}

	function onRefresh()
	{
		this.m.TurnsLeft = 2;
		this.spawnIcon("bluefire_circle", this.getContainer().getActor().getTile());
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.IsAffectedByInjuries = false;
		_properties.IsAffectedByFreshInjuries = false;
		_properties.IsImmuneToBleeding = true;
		_properties.IsImmuneToPoison = true;
	}

});

