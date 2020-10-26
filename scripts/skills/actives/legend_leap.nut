this.legend_leap <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_leap";
		this.m.Name = "Leap";
		this.m.Description = "Learning to jump extended distances allows escape from usually impossible situations";
		this.m.Icon = "skills/leap_square.png";
		this.m.IconDisabled = "skills/leap_square_bw.png";
		this.m.Overlay = "horse_pirouette";
		this.m.SoundOnUse = [
			"sounds/combat/jump_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDisengagement = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 50;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 2;
	}

	function getTooltip()
	{
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
			}
		];


		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used while rooted[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		if ( !this.getContainer().getActor().getCurrentProperties().IsRooted)
		{

			return true;

		}
		else
		{
			return false;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		return true;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsFleetfooted ? 0.5 : 1.0;
		this.m.ActionPointCost = _properties.IsFleetfooted ? 3 : 6;
	}

	function onUse( _user, _targetTile )
	{
		this.Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
		return true;
	}

});

