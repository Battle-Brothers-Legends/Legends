this.perk_legend_blend_in <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_blend_in";
		this.m.Name = this.Const.Strings.PerkName.LegendBlendIn;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBlendIn;
		this.m.Icon = "ui/perks/perk_42.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 0.1;
		_properties.MeleeDefense += 3;
		_properties.RangedDefense += 5;
		this.m.IsHidden = this.m.Stacks == 0;
	}

	function onCombatStarted()
	{
		this.m.Stacks = 1;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.extend([{
			id = 6,
			type = "hint",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Melee Defense."
		},
		{
			id = 6,
			type = "hint",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Ranged Defense."
		},
		{
			id = 6,
			type = "hint",
			icon = "ui/icons/special.png",
			text = "Makes enemies less likely to attack you instead of an ally."
		},
		{
			id = 6,
			type = "hint",
			icon = "ui/icons/special.png",
			text = "Always evade the first attack made against this character in combat."
		}]);

		return tooltip;
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (this.m.Stacks > 0)
		{
			_properties.IsEvadingAllAttacks = true;		
		}
	}

	function onMissed( _attacker, _skill )
	{
		if (this.m.Stacks > 0)
		{
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_attacker) + " underestimated " + this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " due to " + ["their","his","her"][this.getContainer().getActor().getGender() + 1] + " meekness!");
			this.m.Stacks--;	
		}
	}

});

