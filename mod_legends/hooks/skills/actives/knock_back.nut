::mods_hookExactClass("skills/actives/knock_back", function(o)
{
	o.m.ExtraShieldDamageMin <- 0;
	o.m.ExtraShieldDamageMax <- 0;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.FatigueCost = 15;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local tooltip = getTooltip();
		
		if (this.getContainer().getActor().getSkills().hasSkill("perk.shield_bash"))
		{
			local actor = this.getContainer().getActor();
			local p = this.getContainer().getActor().getCurrentProperties();
			local bodyHealth = actor.getHitpointsMax();
			local mult = p.MeleeDamageMult;
			local damagemin = this.Math.abs(10 * p.DamageTotalMult);
			local damagemax = this.Math.abs(25 * p.DamageTotalMult);
			if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_muscularity"))
			{
				local muscularity = this.Math.floor(bodyHealth * 0.1);
				damagemax += muscularity;
			}

			if (mult != 1.0)
			{
				damagemin = this.Math.floor(damagemin * mult);
				damagemax = this.Math.floor(damagemax * mult);
			}
			tooltip.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damagemin + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damagemax + "[/color] damage to hitpoints"
			});

			tooltip.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.abs(0.5 * damagemin) + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.abs(0.5 * damagemax) + "[/color] damage to armor"
			});
		}

		return tooltip;
	}

	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		this.m.IsAttack = false; // work around to allow targeting on allies
		local result = this.skill.onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;
		return result && !_targetTile.getEntity().getCurrentProperties().IsRooted;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (this.Math.rand(1, 100) > this.getHitchance(_targetTile.getEntity()))
		{
			target.onMissed(this.getContainer().getActor(), this);
			return false;
		}

		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

		if (knockToTile == null)
		{
			return false;
		}

		this.applyFatigueDamage(target, 10);

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab || target.getCurrentProperties().IsRooted)
		{
			return false;
		}

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has knocked back " + this.Const.UI.getColorizedEntityName(target));
		}

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");

		if (_user.getSkills().hasSkill("trait.oath_of_fortification") && _targetTile.IsOccupiedByActor && !target.isNonCombatant())
		{
			target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
			}
		}

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local hasShieldBash = _user.getSkills().hasSkill("perk.shield_bash");
		local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

		if (damage == 0 && !hasShieldBash)
		{
			this.Tactical.getNavigator().teleport(target, knockToTile, null, null, true);
		}
		else
		{
			local p = this.getContainer().getActor().getCurrentProperties();
			local tag = {
				Attacker = _user,
				Skill = this,
				HitInfo = clone this.Const.Tactical.HitInfo,
				HitInfoBash = null
			};
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			tag.HitInfo.BodyDamageMult = 1.0;
			tag.HitInfo.FatalityChanceMult = 1.0;

			if (hasShieldBash)
			{
				local p = this.getContainer().getActor().getCurrentProperties();
				local bodyHealth = this.getContainer().getActor().getHitpointsMax();
				local damagemin = this.Math.abs(10 * p.DamageTotalMult);
				local damagemax = this.Math.abs(25 * p.DamageTotalMult);

				if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_muscularity"))
				{
					local muscularity = this.Math.floor(bodyHealth * 0.1);
					damagemax += muscularity;
				}

				damage = damage + this.Math.rand(damagemin, damagemax);
				tag.HitInfoBash = clone this.Const.Tactical.HitInfo;
				tag.HitInfoBash.DamageRegular = damage * p.DamageRegularMult;
				tag.HitInfoBash.DamageArmor = this.Math.floor(damage * 0.5);
				tag.HitInfoBash.DamageFatigue = 10;
				tag.HitInfoBash.BodyPart = this.Const.BodyPart.Body;
				tag.HitInfoBash.BodyDamageMult = 1.0;
				tag.HitInfoBash.FatalityChanceMult = 0.0;
			}

			this.Tactical.getNavigator().teleport(target, knockToTile, this.onKnockedDown, tag, true);
		}

		return true;
	}

	o.onAfterUpdate <- function ( _properties )
	{
		this.m.FatigueCostMult = 1.0; //swap around to resetting the fatiguecostmult & only changing that with shield_bash perk ; this way our specialist stacks alongside shield bash but doesn't go reach limit of 0 fatigue eventually

		if (this.getContainer().getActor().getSkills().hasSkill("perk.shield_bash"))
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 3; // Maybe not both? not sure tbh
		}

		// if (this.getContainer().getActor().getSkills().hasSkill("perk.shield_bash"))
		// {
		// 	this.m.FatigueCostMult *= 0.9;
		// }
	}
	o.onTargetSelected <- function ( _targetTile )
	{
		local knockToTile = this.findTileToKnockBackTo(getContainer().getActor().getTile(), _targetTile);

		if (knockToTile == null)
			return;
		// to show where the target may be knocked back
		this.Tactical.getHighlighter().addOverlayIcon("mortar_target_02", knockToTile, knockToTile.Pos.X, knockToTile.Pos.Y);
	}

	o.getHitchance <- function ( _targetEntity )
	{
		if (this.getContainer().hasSkill("trait.teamplayer") && _targetEntity.isAlliedWith(getContainer().getActor()))
			return 100;

		return this.skill.getHitchance(_targetEntity);
	}
});
