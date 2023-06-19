this.smoke_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.smoke";
		this.m.Name = "Covered by Smoke";
		this.m.Icon = "skills/status_effect_117.png";
		this.m.IconMini = "status_effect_117_mini";
		this.m.Overlay = "status_effect_117";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is covered by dense layers of smoke. Slipping in and out of visibility, they can move freely and ignore any zones of control.";
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Ranged Skill"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+100%[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Not affected by Zones of Control and will hide you"
			}
		];
	}

	function onNewRound()
	{
		local tile = this.getContainer().getActor().getTile();

		if (tile.Properties.Effect == null || tile.Properties.Effect.Type != "smoke")
		{
			this.removeSelf();
		}
	}

	function onUpdate( _properties )
	{
		this.skill.onUpdate(_properties);
		local actor = this.getContainer().getActor();
		local tile = this.getContainer().getActor().getTile();
		//local target = _targetTile.getEntity();

		if (tile.Properties.Effect == null || tile.Properties.Effect.Type != "smoke")
		{
			this.removeSelf();
		}
		else
		{
			actor.getSkills().add(::new("scripts/skills/terrain/hidden_effect"));		
			_properties.RangedSkillMult *= 0.5;
			_properties.RangedDefenseMult *= 2.0;
			
		}
		return true;
	}

});

