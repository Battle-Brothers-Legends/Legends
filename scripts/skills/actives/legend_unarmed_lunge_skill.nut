this.legend_unarmed_lunge_skill <- this.inherit("scripts/skills/skill", {
	m = {
		APCost = 6,
		FatMult = 1.0,
		SoundOnAttack = [
			"sounds/combat/dlc2/lunge_attack_01.wav",
			"sounds/combat/dlc2/lunge_attack_02.wav",
			"sounds/combat/dlc2/lunge_attack_03.wav",
			"sounds/combat/dlc2/lunge_attack_04.wav"
		]
	},
	function create()
	{
		this.m.ID = "actives.legend_unarmed_lunge";
		this.m.Name = "Jump Attack";
		this.m.Description = "A jump forward and attack combined into a single move";
		this.m.KilledString = "Hit";
		this.m.Icon = "skills/unarmed_lunge_square.png";
		this.m.IconDisabled = "skills/unarmed_lunge_square_bw.png";
		this.m.Overlay = "active_135";
		this.m.SoundOnUse = [
			"sounds/combat/dlc2/lunge_move_01.wav",
			"sounds/combat/dlc2/lunge_move_02.wav",
			"sounds/combat/dlc2/lunge_move_03.wav",
			"sounds/combat/dlc2/lunge_move_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/dlc2/lunge_attack_hit_01.wav",
			"sounds/combat/dlc2/lunge_attack_hit_02.wav",
			"sounds/combat/dlc2/lunge_attack_hit_03.wav",
			"sounds/combat/dlc2/lunge_attack_hit_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.HitChanceBonus = 0;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = this.m.APCost;
		this.m.FatigueCost = 30;
		this.m.MinRange = 2;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 33;
	}

	function getMods()
	{
		local ret = {
			Min = 10,
			Max = 20,
			HasMusc = false,
			HasBro = false,
			HasTraining = false,
			HasOffhand = false
		}

		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasSkill("perk.legend_unarmed_training"))
		{
			ret.HasTraining = true;
			local average = (actor.getInitiative() +  actor.getHitpointsMax()) * 0.25;


			if (offhand != this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand))
			{
				average = average * 0.5;
				ret.HasOffhand = true;
			}

			ret.Min = average - 10;
			ret.Max = average + 10;
			ret.HasTraining = true;
		}


		if (actor.getSkills().hasSkill("perk.legend_muscularity"))
		{
			ret.Max += this.Math.floor(actor.getHitpoints() * 0.1);
			ret.HasMusc = true;
		}

		local backgrounds = [
			"background.legend_druid_commander",
			"background.legend_druid",
			"background.brawler",
			"background.legend_commander_berserker",
			"background.legend_berserker"
		];

		foreach (bg in backgrounds)
		{
			if (!actor.getSkills().hasSkill(bg))
			{
				continue;
			}
			ret.Min *= 1.25;
			ret.Max *= 1.25;
			ret.HasBro = true;
			break;
		}

		ret.Min = this.Math.floor(ret.Min);
		ret.Max = this.Math.floor(ret.Max);
		return ret;
	}

	function getTooltip()
	{
		local mods = this.getMods();
		local ret = this.getDefaultTooltip();

		if (mods.HasBro)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Includes +25% damage due to background"
			});
		}

		if (mods.HasMusc)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Includes [color=" + this.Const.UI.Color.DamageValue + "]+10%[/color] of your hitpoints as damage due to Muscularity"
			});
		}

		if (mods.HasOffhand)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Damage halved due to holding something in your off hand"
			});
		}

		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Moves the user next to the target, ignoring Zone of Control"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts additional damage, the higher the user\'s current Initiative and Hitpoints"
			}
		]);

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used while rooted[/color]"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFists)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Costs [color=" + this.Const.UI.Color.PositiveValue + "]-1[/color] Action Point due to unarmed training"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsFleetfooted)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Costs [color=" + this.Const.UI.Color.PositiveValue + "]-1[/color] Action Point due to being Fleet Footed"
			});
		}

		return ret;
	}


	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return (mainhand == null || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function isHidden()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return mainhand != null && !this.getContainer().hasSkill("effects.disarmed") || this.skill.isHidden() || this.m.Container.getActor().isStabled() || this.getContainer().hasSkill("effect.legend_transformed_bear") || this.getContainer().hasSkill("effect.legend_transformed_wolf") || this.getContainer().hasSkill("effect.legend_transformed_tree");
	}


	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local myTile = this.getContainer().getActor().getTile();
		local hasTile = false;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
				continue;
			}
			local tile = _targetTile.getNextTile(i);

			if (tile.IsEmpty && tile.getDistanceTo(myTile) == 1 && this.Math.abs(myTile.Level - tile.Level) <= 1 && this.Math.abs(_targetTile.Level - tile.Level) <= 1)
			{
				hasTile = true;
				break;
			}
		}

		return hasTile;
	}

	function addResources()
	{
		this.skill.addResources();

		foreach( r in this.m.SoundOnAttack )
		{
			this.Tactical.addResource(r);
		}
	}

	function onAfterUpdate( _properties )
	{

		this.m.ActionPointCost = this.m.APCost;
		this.m.FatigueCostMult = this.m.FatMult;
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_unarmed_training"))
		{
			this.m.FatigueCostMult *= 0.5;
		}

		if (_properties.IsFleetfooted)
		{
			this.m.ActionPointCost -= 1;
		}

		if (_properties.IsSpecializedInFists)
		{
			this.m.ActionPointCost -= 1;
		}

	}

	function onUse( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local destTile;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
				continue;
			}

			local tile = _targetTile.getNextTile(i);

			if (tile.IsEmpty && tile.getDistanceTo(myTile) == 1 && this.Math.abs(myTile.Level - tile.Level) <= 1 && this.Math.abs(_targetTile.Level - tile.Level) <= 1)
			{
				destTile = tile;
				break;
			}

		}

		if (destTile == null)
		{
			return false;
		}

		this.getContainer().setBusy(true);
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};
		_user.spawnTerrainDropdownEffect(myTile);
		this.Tactical.getNavigator().teleport(_user, destTile, this.onTeleportDone.bindenv(this), tag, false, 3.0);
		return true;
	}

	function onTeleportDone( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local ZOC = [];
		this.getContainer().setBusy(false);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
				continue;
			}

			local tile = myTile.getNextTile(i);

			if (!tile.IsOccupiedByActor)
			{
				continue;
			}

			local actor = tile.getEntity();

			if (actor.isAlliedWith(_entity) || actor.getCurrentProperties().IsStunned)
			{
				continue;
			}

			ZOC.push(actor);
		}

		foreach( actor in ZOC )
		{
			if (!actor.onMovementInZoneOfControl(_entity, true))
			{
				continue;
			}

			if (actor.onAttackOfOpportunity(_entity, true))
			{
				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " lunges and is repelled");
				}

				if (!_entity.isAlive() || _entity.isDying())
				{
					return;
				}

				local dir = myTile.getDirectionTo(_tag.OldTile);

				if (myTile.hasNextTile(dir))
				{
					local tile = myTile.getNextTile(dir);

					if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
					{
						_tag.TargetTile = tile;
						this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}
			}
		}

		this.spawnAttackEffect(_tag.TargetTile, this.Const.Tactical.AttackEffectThrust);
		local s = this.m.SoundOnUse;
		this.m.SoundOnUse = this.m.SoundOnAttack;
		this.attackEntity(_entity, _tag.TargetTile.getEntity());
		this.m.SoundOnUse = s;
	}

	function onRepelled( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		local mods = this.getMods()
		_properties.DamageRegularMin += mods.Min;
		_properties.DamageRegularMax += mods.Max;

		if (!mods.HasTraining)
		{
			_properties.DamageArmorMult = 0.5;
		}

	}

});

