this.whipped_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3,
		Level = 0
	},
	function create()
	{
		this.m.ID = "effects.whipped";
		this.m.Name = "Whipped";
		this.m.Icon = "skills/status_effect_121.png";
		this.m.IconMini = "status_effect_121_mini";
		this.m.Overlay = "status_effect_121";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character just received a hurtful reminder of what they need to do for their masters. It will last for another " + this.m.TurnsLeft + " round(s).";
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (12 + this.m.Level) + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (14 + this.m.Level) + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + (5 + this.m.Level) + "[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (9 + this.m.Level) + "[/color] Initiative"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (5 + this.m.Level) + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (5 + this.m.Level) + "[/color] Ranged Defense"
			}
		];
	}

	function setLevel( _l )
	{
		this.m.Level = _l;
	}

	function onAdded()
	{
		this.m.TurnsLeft = 3;
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").setBrush("bust_slave_whipped");
		actor.setDirty(true);
	}

	function onRefresh()
	{
		this.m.TurnsLeft = 3;
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").resetBrush();
		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 12 + this.m.Level;
		_properties.RangedSkill += 14 + this.m.Level;
		_properties.Bravery -= (5 + this.m.Level);
		_properties.MeleeDefense += 5 + this.m.Level;
		_properties.RangedDefense += 5 + this.m.Level;
		_properties.Initiative += 9 + this.m.Level;
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").setBrush(this.m.TurnsLeft > 1 ? "bust_slave_whipped" : "bust_slave_whipped_expiring");
		actor.setDirty(true);
	}

	function onRoundEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

