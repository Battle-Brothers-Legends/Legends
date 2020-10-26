this.perk_push_the_advantage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.push_the_advantage";
		this.m.Name = this.Const.Strings.PerkName.PushTheAdvantage;
		this.m.Description = this.Const.Strings.PerkDescription.PushTheAdvantage;
		this.m.Icon = "ui/perks/onslaught_circle.png";
		this.m.IconDisabled = "ui/perks/onslaught_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (!_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			if (_targetEntity.getSkills().hasSkill("effects.sleeping") || _targetEntity.getSkills().hasSkill("effects.stunned") || _targetEntity.getSkills().hasSkill("effects.dazed") || _targetEntity.getSkills().hasSkill("effects.legend_dazed") || _targetEntity.getSkills().hasSkill("effects.net") || _targetEntity.getSkills().hasSkill("effects.legend_grappled") || _targetEntity.getSkills().hasSkill("effects.staggered") || _targetEntity.getSkills().hasSkill("effects.web") || _targetEntity.getSkills().hasSkill("effects.legend_baffled") || _targetEntity.getSkills().hasSkill("effects.rooted") || _targetEntity.getSkills().hasSkill("effects.distracted") || _targetEntity.getSkills().hasSkill("effects.debilitated") || _targetEntity.getSkills().hasSkill("effects.insect_swarm"))
			{
			_properties.MeleeSkill += 20;
			_properties.RangedSkill += 20;
			_properties.HitChance[this.Const.BodyPart.Head] += 20;
			}
		}
	}

});
