this.ai_always_use <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.crack_the_whip"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.AlwaysUse;
		this.m.Order = this.Const.AI.Behavior.Order.AlwaysUse;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getCurrentProperties().IsStunned)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		return this.Const.AI.Behavior.Score.AlwaysUse * score;
	}

	function onExecute( _entity )
	{
		this.m.Skill.use(_entity.getTile());

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		return true;
	}

});

