this.nine_lives_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.nine_lives";
		this.m.Name = "Nine Lives";
		this.m.Description = "This character seems to have nine lives! Just having had a close encounter with death, they are in a heightened state of survival until their next turn.";
		this.m.Icon = "ui/perks/perk_07.png";
		this.m.IconMini = "perk_07_mini";
		this.m.Overlay = "perk_07";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Ranged Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Resolve"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Initiative"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 15;
		_properties.RangedDefense += 15;
		_properties.Bravery += 15;
		_properties.Initiative += 15;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});

