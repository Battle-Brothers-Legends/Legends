this.legend_flogging <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_flogging";
		this.m.Name = "Flogging";
		this.m.Description = "Whip the flesh of someone nearby to inflict a slow bleed ";
		this.m.KilledString = "Flogged";
		this.m.Icon = "skills/bleed_square.png";
		this.m.IconDisabled = "skills/bleed_square_bw.png";
		this.m.Overlay = "bleed";
		this.m.SoundOnUse = [
			"sounds/combat/rupture_blood_01.wav",
			"sounds/combat/rupture_blood_02.wav",
			"sounds/combat/rupture_blood_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/humans/0/human_fatigue_01.wav"
		];
		this.m.SoundVolume = 1.25;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;

		this.m.ActionPointCost = 1;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip()
		ret.push(
		{
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Flog someone, inflicting a bleed of 2 damage per turn over 5 turns"
		})
		return ret;
	}
	
	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}


		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (!target.isAlive())
		{
			return;
		}

		if (target.getSkills().hasSkill("effects.legend_grazed_effect"))
		{
			return;
		}
		

		target.getSkills().add(this.new("scripts/skills/effects/legend_grazed_effect"));

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " flogged " + this.Const.UI.getColorizedEntityName(target) + " leaving them bleeding");
		}
	}

});
