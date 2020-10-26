this.perk_legend_freedom_of_movement <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_freedom_of_movement";
		this.m.Name = this.Const.Strings.PerkName.LegendFreedomOfMovement;
		this.m.Icon = "ui/perks/freedom_of_movement_circle.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "You are moving with freedom ";
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "When an enemy attacks you, subtract their fatigue as a percent from your fatigue as a percent. Gain that as hitpoint damage reduction."
			});
		}


		return tooltip;
	}



	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		local ourFatigue = this.getContainer().getActor().getFatigue();
		local ourFatigueMax = this.getContainer().getActor().getFatigueMax();
		local ourFatiguePercent = ourFatigueMax / 100;
		local ourFatiguePercentCurrent = ourFatigue / ourFatiguePercent;

		local enemyFatigue = _attacker.getFatigue();
		local enemyFatigueMax = _attacker.getFatigueMax();
		local enemyFatiguePercent = enemyFatigueMax / 100;
		local enemyFatiguePercentCurrent = enemyFatigue / enemyFatiguePercent;

		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		local bonus = 1;

		if (ourFatiguePercentCurrent < enemyFatiguePercentCurrent)
		{
			local diff = enemyFatiguePercentCurrent - ourFatiguePercentCurrent;
			local diffPoint = this.Math.max(5, this.Math.min(95, diff)) * 0.01;
			bonus = 1 - diffPoint;
		}
		_properties.DamageReceivedRegularMult *= bonus;
	}

});

