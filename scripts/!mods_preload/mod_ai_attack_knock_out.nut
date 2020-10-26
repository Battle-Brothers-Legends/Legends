::mods_hookNewObject("ai/tactical/behaviors/ai_attack_knock_out", function ( o )
{
	o.m.PossibleSkills.push("actives.legend_staff_knock_out");
	o.m.PossibleSkills.push("actives.legend_grapple");
	o.m.PossibleSkills.push("actives.legend_buckler_bash");
	o.m.PossibleSkills.push("actives.legend_ninetails_disarm");
	local fn = o.getBestTarget;
	o.getBestTarget = function ( _entity, _skill, _targets )
	{
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();

		if (attackSkill == null)
		{
			this.m.BestTarget = {
				Target = null,
				Score = 0.0
			};
			yield null;
			return true;
		}

		local gBT = fn(_entity, _skill, _targets);
		
		while( resume gBT == null)
		{
			yield null;
		}
		
		return gBT;
	};
});