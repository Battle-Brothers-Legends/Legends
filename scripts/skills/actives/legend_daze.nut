this.legend_daze <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_daze";
		this.m.Name = "Daze";
		this.m.Description = "Assault the senses of your target with a flurry of colorful sparks, whirs, and pops. Such an astonishing display is sure to leave anyone too bewildered to fight effectively. Does no damage";
		this.m.KilledString = "Dazed";
		this.m.Icon = "skills/daze_square.png";
		this.m.IconDisabled = "skills/daze_square_bw.png";
		this.m.Overlay = "daze_square";
		this.m.SoundOnUse = [
			"sounds/combat/stupefy_01.wav",
			"sounds/combat/stupefy_02.wav",
			"sounds/combat/stupefy_03.wav",
			"sounds/combat/stupefy_04.wav",
			"sounds/combat/stupefy_05.wav"

		];
		this.m.SoundOnHit = [
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav",
			"sounds/humans/0/human_fatigue_01.wav",
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
		this.m.IsRanged = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip()
		ret.push(
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Leave your opponent bewildered, halving their damage, fatigue and initiative"
			}
		)
		ret.push(
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Uses Ranged skill to hit. Hit chance doubled if you also have the Taunt perk."
			}
		)
			
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local target = _targetTile.getEntity();
		local r = this.Math.rand(1,100);
		if (_user.getSkills().hasSkill("perk.taunt"));
		{
		 r = this.Math.rand(1,50);
		}
		local ourSkill = _user.getCurrentProperties().getRangedSkill();
		local theirSkill = targetEntity.getCurrentProperties().getRangedDefense();

		if (r < (ourSkill - theirSkill))
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);

			if (target.isAlive())
			{
				target.getSkills().add(this.new("scripts/skills/effects/legend_dazed_effect"));

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " stupefied " + this.Const.UI.getColorizedEntityName(target) + " leaving them dazed");
				}
			}
		}
		else
		{
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " failed to stupefy " + this.Const.UI.getColorizedEntityName(target));
		}

	}

});
