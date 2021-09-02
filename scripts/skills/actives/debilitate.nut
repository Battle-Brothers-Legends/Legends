this.debilitate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.debilitate";
		this.m.Name = "Debilitate";
		this.m.Icon = "skills/debilitate_square.png";
		this.m.IconDisabled = "skills/debilitate_square_bw.png";
		this.m.Overlay = "perk_34_active";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getDescription()
	{
		return "Prepare your next attack to debilitate a target for three turns, reducing their ability to inflict damage by [color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color]. Missing the target will waste the effect.";
	}

	function getTooltip()
	{
		return this.skill.getDefaultUtilityTooltip();
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().getSkills().hasSkill("effects.debilitating_attack");
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Container.add(this.new("scripts/skills/effects/debilitating_attack_effect"));
		return true;
	}

	function onRemoved()
	{
		this.m.Container.removeByID("effects.debilitating_attack");
	}

});

