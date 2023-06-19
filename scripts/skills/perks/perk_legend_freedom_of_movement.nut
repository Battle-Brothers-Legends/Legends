this.perk_legend_freedom_of_movement <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_freedom_of_movement";
		this.m.Name = this.Const.Strings.PerkName.LegendFreedomOfMovement;
		this.m.Description = "You are moving with freedom";
		this.m.Icon = "ui/perks/freedom_of_movement_circle.png";	
		this.m.IconDisabled = "ui/perks/freedom_of_movement_circle_bw.png";	
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gain hit point damage reduction proportional to the difference between your current initiative and your attacker\'s, up to 80% for 100 initiative."
		});
		return tooltip;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker == null || _attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		local ourCurrentInitiative = this.getContainer().getActor().getInitiative();
		local enemyCurrentInitiative = _attacker.getInitiative();
		local bonus = 1;

		if (ourCurrentInitiative > enemyCurrentInitiative)
		{
			local diff = (ourCurrentInitiative - enemyCurrentInitiative) / 100.0;
			local diffPoint = this.Math.minf(1, this.Math.pow(diff, 0.4)) * 0.80;
			bonus = 1 - diffPoint;
		}

		_properties.DamageReceivedRegularMult *= bonus;
	}

});

