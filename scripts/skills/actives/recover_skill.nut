this.recover_skill <- this.inherit("scripts/skills/skill", {
	m = { 
		CanRecover = true,
		AP = 0
	},
	function create()
	{
		this.m.ID = "actives.recover";
		this.m.Name = "Recover";
		this.m.Description = "Take a deep breath and rest for a turn in order to recover your strength.";
		this.m.Icon = "ui/perks/perk_54_active.png";
		this.m.IconDisabled = "ui/perks/perk_54_active_sw.png";
		this.m.Overlay = "perk_54_active";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local fatReduc = actor.getActionPoints() * 3.0
		local ret = [
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Current Fatigue is reduced by [color=" + this.Const.UI.Color.PositiveValue + "]" + fatReduc + "%[/color] of maximum fatigue"
			}
		];
		return ret;
	}
	
	function onTurnStart()
	{
		this.m.CanRecover = true;
		this.m.AP = 0;
	}
	
	function isUsable()
	{
		return this.skill.isUsable() && this.m.CanRecover;
	}
	
	function getActionPointCost()
	{
		local actor = this.getContainer().getActor();
		return actor.getActionPoints();
	}
	
	function onBeforeUse ( _user, _targetTile )
	{
		this.m.AP = _user.getActionPoints();
	}

	function onUse( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		local fatMult = this.m.AP * 0.03;

		_user.setFatigue(_user.getFatigue() - fatMult * _user.getFatigueMax() );
		
		if (!_user.isHiddenToPlayer())
		{
			_user.playSound(this.Const.Sound.ActorEvent.Fatigue, this.Const.Sound.Volume.Actor * _user.getSoundVolume(this.Const.Sound.ActorEvent.Fatigue));
		}

		return true;
	}

});

