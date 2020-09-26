this.perk_legend_onslaught <- this.inherit("scripts/skills/skill", {
	m = {
		TilesUsed = []
	},
	function create()
	{
		this.m.ID = "perk.legend_onslaught";
		this.m.Name = this.Const.Strings.PerkName.LegendOnslaught;
		this.m.Description = this.Const.Strings.PerkDescription.LegendOnslaught;
		this.m.Icon = "ui/perks/onslaught_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.SoundOnUse = [
			"sounds/combat/bash_01.wav",
			"sounds/combat/bash_02.wav",
			"sounds/combat/bash_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/bash_hit_01.wav",
			"sounds/combat/bash_hit_02.wav",
			"sounds/combat/bash_hit_03.wav"
		];
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.TilesUsed = [];
		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return false;
		}
		
		// if (_targetEntity.getCurrentProperties().IsImmuneToStun)
		// {
		// 	return false;
		// }

		if (_targetEntity.isNonCombatant())
		{
			return false;
		}

		local user = _skill.getContainer().getActor();
		local ourInit =  user.getInitiative();
		local targetInit = _targetEntity.getInitiative()


		if (ourInit <= targetInit)
		{
			return false;
		}


		if ( this.Math.rand(1, 100) > 50)
		{
			return false;
		}
		
		if (!_targetEntity.getSkills().hasSkill("effects.stunned"))
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_baffled_effect"));

			if (!user.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " battered " + this.Const.UI.getColorizedEntityName(_targetEntity) + " leaving them baffled");
			}
		}

		return true;
		
	}

	
});

