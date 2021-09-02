this.getroottable().Const.LegendMod.hookAISkills <- function()
{
	::mods_hookExactClass("ai/tactical/behaviors/ai_attack_default", function(o) 
	{
		o.m.PossibleSkills.extend([
			"actives.cat_bite",
			"actives.legend_staff_bash",
			"actives.legend_skin_ghoul_claws",
			"actives.legend_white_wolf_bite",
			"actives.legend_redback_spider_bite",
			"actives.legend_great_slash",
			"actives.legend_glaive_slash",
			"actives.legend_spear_lunge_skill",
			"actives.legend_chain_flail_skill",
			"actives.legend_demon_hound_bite",
			"actives.legend_ranged_flail",
			"actives.legend_halberd_impale",
			"actives.legend_voulge_cleave",
			"actives.legend_horse_kick",
			"actives.legend_donkey_kick",
			"actives.legend_bear_bite",
			"actives.legend_bear_claws",
			"actives.legend_flaggelate",
			"actives.legend_boar_gore",
			"actives.legend_rat_claws",
			"actives.legend_rat_bite",
			"actives.legend_en_garde",
			"actives.lunge"
		]);
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_attack_bow", function(o) 
	{
		o.m.PossibleSkills.extend([
			"actives.legend_catapult_boulder",
			"actives.legend_sling_heavy_stone",
			"actives.legend_shoot_dart"
		]);
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_adrenaline", function(o) 
	{
		o.m.PossibleSkills.extend([
			"actives.adrenaline",
			"actives.legend_transform_into_bear"
		]);
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_attack_crush_armor", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_halberd_smite");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_attack_decapitate", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_voulge_decapitate");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_attack_lash", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_ranged_lash");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_attack_thresh", function(o)
	{
		o.m.PossibleSkills.push("actives.legend_chain_thresh");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_attack_swallow_whole", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_skin_ghoul_swallow_whole");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_attack_terror", function(o) 
	{
		o.m.PossibleSkills.extend([
			"actives.legend_banshee_scream",
			"actives.legend_horrific_scream"
		]);
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_boost_stamina", function(o) 
	{
		o.m.PossibleSkills.extend([
			"actives.legend_drums_of_life",
			"actives.legend_drums_of_war",
			"actives.legend_push_forward",
			"actives.legend_hold_the_line"
		]);
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_buff_howl", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_white_wolf_howl");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_charge", function(o) 
	{
		o.m.PossibleSkills.extend([
			"actives.charge",
			"actives.unstoppable_charge",
			"actives.legend_horse_charge"
		]);
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_charm", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_intensely_charm");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_corruption", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_demon_shadows");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_darkflight", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_teleport");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_defend_knock_back", function ( o ) 
	{
		o.m.PossibleSkills.extend([
			"actives.legend_kick",
			"actives.legend_revolt",
			"actives.legend_push",
			"actives.legend_chain_hook"
		]);
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_defend_riposte", function(o) 
	{
		o.m.PossibleSkills.extend([
			"actives.legend_staff_riposte",
			"actives.return_favor"
		]);
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_disengage", function(o) 
	{
		o.m.PossibleSkills.extend([
			"actives.footwork",
			"actives.legend_horse_pirouette"
		]);
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_engage_ranged", function(o) 
	{
		o.m.PossibleSkills.extend([
			"actives.legend_magic_missile",
			"actives.legend_catapult_boulder",
			"actives.legend_sling_heavy_stone",
			"actives.legend_shoot_dart"
		]);
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_line_breaker", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_boar_charge");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_move_tail", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_stollwurm_move_tail");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_move_tentacle", function(o) 
	{
		o.m.PossibleSkills.push("actives.legend_stollwurm_move");
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_attack_puncture", function(o) 
	{
		o.m.PossibleSkills.push("actives.puncture_parry_dagger");

		o.onExecute = function ( _entity )
		{
			if (this.m.IsFirstExecuted)
			{
				this.getAgent().adjustCameraToTarget(this.m.TargetTile);
				this.m.IsFirstExecuted = false;
				return false;
			}

			if (this.m.TargetTile != null && this.m.TargetTile.IsOccupiedByActor)
			{
				if (this.Const.AI.VerboseMode)
				{
					this.logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + " against " + this.m.TargetTile.getEntity().getName() + "!");
				}

				this.m.Skill.use(this.m.TargetTile);

				if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer))
				{
					this.getAgent().declareAction();
				}

				this.m.TargetTile = null;
			}

			return true;
		}
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_attack_knock_out", function ( o )
	{
		o.m.PossibleSkills.extend([
			"actives.legend_staff_knock_out",
			"actives.legend_grapple",
			"actives.legend_buckler_bash",
			"actives.legend_ninetails_disarm"
		]);

		local getBestTarget = o.getBestTarget;
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

			local getBestTarget = getBestTarget(_entity, _skill, _targets);
			
			while( resume getBestTarget == null)
			{
				yield null;
			}
			
			return getBestTarget;
		};
	});

	::mods_hookExactClass("ai/tactical/behaviors/ai_defend_rotation", function(o) 
	{
		o.onExecute = function( _entity )
		{
			if (this.m.IsFirstExecuted)
			{
				this.getAgent().adjustCameraToTarget(this.m.TargetTile);
				this.m.IsFirstExecuted = false;
				return false;
			}

			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using Rotation!");
			}

			this.m.Skill.use(this.m.TargetTile);

			if (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer)
			{
				this.getAgent().declareEvaluationDelay(3000);
				this.getAgent().declareAction();
			}

			this.m.TargetTile = null;
			this.m.Skill = null;
			return true;
		}

	});
	delete this.Const.LegendMod.hookAISkills;
}