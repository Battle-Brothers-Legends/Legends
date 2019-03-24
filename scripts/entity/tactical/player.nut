this.player <- this.inherit("scripts/entity/tactical/human", {
	m = {
		Level = 1,
		PerkPoints = 0,
		PerkPointsSpent = 0,
		LevelUps = 0,
		Mood = 3.0,
		MoodChanges = [],
		LastDrinkTime = 0,
		PlaceInFormation = 255,
		Background = null,
		HiringCost = 0,
		HireTime = 0.0,
		IsTryoutDone = false,
		IsGuest = false,
		IsCommander = false,
		Attributes = [],
		Talents = [],
		CombatStats = {
			DamageDealtHitpoints = 0,
			DamageDealtArmor = 0,
			DamageReceivedHitpoints = 0,
			DamageReceivedArmor = 0,
			Kills = 0,
			XPGained = 0
		},
		LifetimeStats = {
			Kills = 0,
			Battles = 0,
			BattlesWithoutMe = 0,
			MostPowerfulVanquished = "",
			MostPowerfulVanquishedXP = 0,
			MostPowerfulVanquishedType = 0,
			FavoriteWeapon = "",
			FavoriteWeaponUses = 0,
			CurrentWeaponUses = 0
		},
		Formations = null,
		VeteranPerks = 0,
		CampAssignment = "camp.rest",
		CampHealing = 0,
		LastCampTime = 0
	},
	function setName( _value )
	{
		this.m.Name = _value;

		if (this.m.Background != null)
		{
			this.m.Background.buildDescription(true);
		}
	}

	function getTitle()
	{
		return this.m.Title;
	}

	function setTitle( _value )
	{
		this.m.Title = _value;

		if (this.m.Background != null)
		{
			this.m.Background.buildDescription(true);
		}
	}

	function getXP()
	{
		return this.m.XP;
	}

	function getXPValue()
	{
		return 100 + (this.m.Level - 1) * 30;
	}

	function getXPForNextLevel()
	{
		return this.m.Level < this.Const.LevelXP.len() ? this.Const.LevelXP[this.m.Level] : this.Const.LevelXP[this.Const.LevelXP.len() - 1];
	}

	function getLevel()
	{
		return this.m.Level;
	}

	function getPerkPoints()
	{
		return this.m.PerkPoints;
	}

	function getPerkPointsSpent()
	{
		return this.m.PerkPointsSpent;
	}

	function getLevelUps()
	{
		return this.m.LevelUps;
	}

	function getTalents()
	{
		return this.m.Talents;
	}

	function getCombatStats()
	{
		return this.m.CombatStats;
	}

	function getLifetimeStats()
	{
		return this.m.LifetimeStats;
	}

	function getPlaceInFormation()
	{
		return this.m.PlaceInFormation;
	}

	function setPlaceInFormation( _p )
	{
		this.m.PlaceInFormation = _p;
	}

	function getHiringCost()
	{
		return this.m.HiringCost;
	}

	function getTryoutCost()
	{
		return this.Math.max(10, this.Math.min(this.m.HiringCost - 25, 25 + this.m.HiringCost * this.Const.Tryouts.CostMult));
	}

	function getDailyCost()
	{
		return this.Math.max(0, this.m.CurrentProperties.DailyWage * this.m.CurrentProperties.DailyWageMult);
	}

	function getDailyFood()
	{
		return this.Math.maxf(0.0, this.m.CurrentProperties.DailyFood);
	}

	function getBackground()
	{
		return this.m.Background;
	}

	function getHireTime()
	{
		return this.m.HireTime;
	}

	function getLastDrinkTime()
	{
		return this.m.LastDrinkTime;
	}

	function setLastDrinkTime( _t )
	{
		this.m.LastDrinkTime = _t;
	}

	function setGuest( _f )
	{
		this.m.IsGuest = _f;
	}

	function setCommander( _f )
	{
		this.m.IsCommander = _f;
	}

	function setVeteranPerks( _f )
	{
		this.m.VeteranPerks = _f;
	}

	function isLeveled()
	{
		return (this.m.PerkPoints != 0 || this.m.LevelUps != 0) && !this.m.IsGuest;
	}

	function isGuest()
	{
		return this.m.IsGuest;
	}

	function isCommander()
	{
		return this.m.IsCommander
	}

	function isTryoutDone()
	{
		return this.m.IsTryoutDone;
	}

	function setTryoutDone( _t )
	{
		this.m.IsTryoutDone = _t;
	}

	function getCampAssignment()
	{
		return this.m.CampAssignment;
	}

	function setCampAssignment( _id )
	{
		this.m.CampAssignment = _id;
	}

	function getMood()
	{
		return this.m.Mood;
	}

	function getMoodState()
	{
		return this.Math.floor(this.m.Mood);
	}

	function getMoodChanges()
	{
		return this.m.MoodChanges;
	}

	function improveMood( _a = 1.0, _reason = "" )
	{
		this.m.Mood = this.Math.minf(this.m.Mood + _a, this.Const.MoodState.len() - 0.0500000007);

		if (_reason != "")
		{
			local time = 0.0;

			if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
			{
				time = this.World.State.getCombatStartTime();
			}
			else
			{
				time = this.Time.getVirtualTimeF();
			}

			if (this.m.MoodChanges.len() >= 1 && this.m.MoodChanges[0].Text == _reason)
			{
				this.m.MoodChanges[0].Time = time;
			}
			else
			{
				if (this.m.MoodChanges.len() >= 5)
				{
					this.m.MoodChanges.remove(this.m.MoodChanges.len() - 1);
				}

				this.m.MoodChanges.insert(0, {
					Positive = true,
					Text = _reason,
					Time = time
				});
			}
		}

		this.getSkills().update();
	}

	function worsenMood( _a = 1.0, _reason = "" )
	{
		this.m.Mood = this.Math.maxf(this.m.Mood - _a, 0.0);

		if (_reason != "")
		{
			local time = 0.0;

			if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
			{
				time = this.World.State.getCombatStartTime();
			}
			else
			{
				time = this.Time.getVirtualTimeF();
			}

			if (this.m.MoodChanges.len() >= 1 && this.m.MoodChanges[0].Text == _reason)
			{
				this.m.MoodChanges[0].Time = time;
			}
			else
			{
				if (this.m.MoodChanges.len() >= 5)
				{
					this.m.MoodChanges.remove(this.m.MoodChanges.len() - 1);
				}

				this.m.MoodChanges.insert(0, {
					Positive = false,
					Text = _reason,
					Time = time
				});
			}
		}

		this.getSkills().update();
	}

	function recoverMood()
	{
		if (this.m.MoodChanges.len() != 0 && this.m.MoodChanges[this.m.MoodChanges.len() - 1].Time + this.Const.MoodChange.Timeout < this.Time.getVirtualTimeF())
		{
			this.m.MoodChanges.remove(this.m.MoodChanges.len() - 1);
		}

		if (this.m.Mood < 3.1500001)
		{
			local mult = this.getSkills().hasSkill("trait.optimist") ? this.Const.MoodChange.OptimistMult : 1.0;
			local diff = this.Math.maxf(this.Const.MoodChange.RecoveryPerHour, (3.1500001 - this.m.Mood) * this.Const.MoodChange.RelativeRecoveryPerHour);
			this.m.Mood = this.Math.minf(3.1500001, this.m.Mood + diff * mult * this.Const.MoodChange.CheckIntervalHours);
			this.getSkills().update();
		}
		else if (this.m.Mood > 3.1500001)
		{
			local mult = this.getSkills().hasSkill("trait.pessimist") ? this.Const.MoodChange.PessimistMult : 1.0;
			local diff = this.Math.maxf(this.Const.MoodChange.RecoveryPerHour, (this.m.Mood - 3.1500001) * this.Const.MoodChange.RelativeRecoveryPerHour);
			this.m.Mood = this.Math.maxf(3.1500001, this.m.Mood - diff * mult * this.Const.MoodChange.CheckIntervalHours);
			this.getSkills().update();
		}
	}

	function getHiringTraits()
	{
		local ret = [];

		if (!this.m.IsTryoutDone)
		{
			return ret;
		}

		foreach( s in this.m.Skills.m.Skills )
		{
			if (s.getType() == this.Const.SkillType.Trait)
			{
				ret.push({
					id = s.getID(),
					icon = s.getIconColored()
				});
			}
		}

		return ret;
	}

	function getHiringTalents()
	{
		local ret = [];

		if (!this.m.IsTryoutDone)
		{
			return ret;
		}

		local talents = this.getTalents()

		for (local i = 0; i < this.Const.Attributes.COUNT; i = ++i)
		{
			if (talents[i] > 0)
			{
				local r = {
					talent = "",
					value = talents[i]
				};

				switch(i)
				{
				case 0:
					r.talent = "HP";
					break;

				case 1:
					r.talent = "RES";
					break;

				case 2:
					r.talent = "FAT";
					break;

				case 3:
					r.talent = "INIT";
					break;

				case 4:
					r.talent = "MA";
					break;

				case 5:
					r.talent = "RA";
					break;

				case 6:
					r.talent = "MD";
					break;

				case 7:
					r.talent = "RD";
					break;
				}

				ret.push(r);
			}
		}

		return ret;
	}

	function getDaysWithCompany()
	{
		local time;

		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			time = this.Math.round((this.World.State.getCombatStartTime() - this.m.HireTime) / this.World.getTime().SecondsPerDay);
		}
		else
		{
			time = this.Math.round((this.Time.getVirtualTimeF() - this.m.HireTime) / this.World.getTime().SecondsPerDay);
		}

		return time;
	}

	function getTooltip( _targetedWithSkill = null )
	{
		if (!this.isPlacedOnMap() || !this.isAlive() || this.isDying())
		{
			return [];
		}

		local turnsToGo = this.Tactical.TurnSequenceBar.getTurnsUntilActive(this.getID());
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName(),
				icon = "ui/tooltips/height_" + this.getTile().Level + ".png"
			}
		];

		if (!this.isPlayerControlled() && _targetedWithSkill != null && this.isKindOf(_targetedWithSkill, "skill"))
		{
			local tile = this.getTile();

			if (tile.IsVisibleForEntity && _targetedWithSkill.isUsableOn(this.getTile()))
			{
				tooltip.push({
					id = 3,
					type = "headerText",
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + _targetedWithSkill.getHitchance(this) + "%[/color] chance to hit",
					children = _targetedWithSkill.getHitFactors(tile)
				});
			}
		}

		tooltip.extend([
			{
				id = 2,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = this.Tactical.TurnSequenceBar.getActiveEntity() == this ? "Acting right now!" : this.isTurnDone() || turnsToGo == null ? "Turn done" : "Acts in " + turnsToGo + (turnsToGo > 1 ? " turns" : " turn")
			},
			{
				id = 3,
				type = "progressbar",
				icon = "ui/icons/armor_head.png",
				value = this.getArmor(this.Const.BodyPart.Head),
				valueMax = this.getArmorMax(this.Const.BodyPart.Head),
				text = "" + this.getArmor(this.Const.BodyPart.Head) + " / " + this.getArmorMax(this.Const.BodyPart.Head) + "",
				style = "armor-head-slim"
			},
			{
				id = 4,
				type = "progressbar",
				icon = "ui/icons/armor_body.png",
				value = this.getArmor(this.Const.BodyPart.Body),
				valueMax = this.getArmorMax(this.Const.BodyPart.Body),
				text = "" + this.getArmor(this.Const.BodyPart.Body) + " / " + this.getArmorMax(this.Const.BodyPart.Body) + "",
				style = "armor-body-slim"
			},
			{
				id = 5,
				type = "progressbar",
				icon = "ui/icons/health.png",
				value = this.getHitpoints(),
				valueMax = this.getHitpointsMax(),
				text = "" + this.getHitpoints() + " / " + this.getHitpointsMax() + "",
				style = "hitpoints-slim"
			},
			{
				id = 6,
				type = "progressbar",
				icon = "ui/icons/morale.png",
				value = this.getMoraleState(),
				valueMax = this.Const.MoraleState.COUNT - 1,
				text = this.Const.MoraleStateName[this.getMoraleState()],
				style = "morale-slim"
			},
			{
				id = 7,
				type = "progressbar",
				icon = "ui/icons/fatigue.png",
				value = this.getFatigue(),
				valueMax = this.getFatigueMax(),
				text = "" + this.getFatigue() + " / " + this.getFatigueMax() + "",
				style = "fatigue-slim"
			}
		]);
		local result = [];
		local statusEffects = this.getSkills().query(this.Const.SkillType.StatusEffect | this.Const.SkillType.TemporaryInjury, false, true);

		foreach( i, statusEffect in statusEffects )
		{
			tooltip.push({
				id = 100 + i,
				type = "text",
				icon = statusEffect.getIcon(),
				text = statusEffect.getName()
			});
		}

		return tooltip;
	}

	function getRosterTooltip()
	{
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			}
		];
		local time = this.getDaysWithCompany();
		local text;

		if (!this.isGuest())
		{
			if (this.m.Background != null && this.m.Background.getID() == "background.companion")
			{
				text = "With the company from the very beginning.";
			}
			else if (time > 1)
			{
				text = "With the company for " + time + " days.";
			}
			else
			{
				text = "Has just joined the company.";
			}

			if (this.m.LifetimeStats.Battles != 0)
			{
				if (this.m.LifetimeStats.Battles == 1)
				{
					text = text + (" Took part in " + this.m.LifetimeStats.Battles + " battle");
				}
				else
				{
					text = text + (" Took part in " + this.m.LifetimeStats.Battles + " battles");
				}

				if (this.m.LifetimeStats.Kills == 1)
				{
					text = text + (" and has " + this.m.LifetimeStats.Kills + " kill.");
				}
				else if (this.m.LifetimeStats.Kills > 1)
				{
					text = text + (" and has " + this.m.LifetimeStats.Kills + " kills.");
				}
				else
				{
					text = text + ".";
				}

				if (this.m.LifetimeStats.MostPowerfulVanquished != "")
				{
					text = text + (" The most powerful opponent he vanquished was " + this.m.LifetimeStats.MostPowerfulVanquished + ".");
				}
			}

			tooltip.push({
				id = 2,
				type = "description",
				text = text
			});
			tooltip.push({
				id = 5,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "Level " + this.m.Level
			});

			if (this.getDailyCost() != 0)
			{
				tooltip.push({
					id = 3,
					type = "text",
					icon = "ui/icons/asset_daily_money.png",
					text = "Paid [img]gfx/ui/tooltips/money.png[/img]" + this.getDailyCost() + " daily"
				});
			}

			tooltip.push({
				id = 4,
				type = "text",
				icon = this.Const.MoodStateIcon[this.getMoodState()],
				text = this.Const.MoodStateName[this.getMoodState()]
			});

			if (this.m.PlaceInFormation <= 26)
			{
				tooltip.push({
					id = 6,
					type = "hint",
					icon = "ui/icons/stat_screen_dmg_dealt.png",
					text = "In the fighting line"
				});
			}
			else
			{
				tooltip.push({
					id = 6,
					type = "hint",
					icon = "ui/icons/camp.png",
					text = "In reserve"
				});
			}

			tooltip.push({
				id = 7,
				type = "hint",
				text = this.getBackground().getBackgroundDescription(false)
			})
		}

		local injuries = this.getSkills().query(this.Const.SkillType.Injury | this.Const.SkillType.SemiInjury);

		foreach( injury in injuries )
		{
			if (injury.isType(this.Const.SkillType.TemporaryInjury))
			{
				local ht = injury.getHealingTime();

				if (ht.Min != ht.Max)
				{
					tooltip.push({
						id = 90,
						type = "text",
						icon = injury.getIcon(),
						text = injury.getName() + " (" + ht.Min + "-" + ht.Max + " days)"
					});
				}
				else if (ht.Min > 1)
				{
					tooltip.push({
						id = 90,
						type = "text",
						icon = injury.getIcon(),
						text = injury.getName() + " (" + ht.Min + " days)"
					});
				}
				else
				{
					tooltip.push({
						id = 90,
						type = "text",
						icon = injury.getIcon(),
						text = injury.getName() + " (" + ht.Min + " day)"
					});
				}
			}
			else
			{
				tooltip.push({
					id = 90,
					type = "text",
					icon = injury.getIcon(),
					text = injury.getName()
				});
			}
		}

		if (this.getHitpoints() < this.getHitpointsMax())
		{
			local ht = this.Math.ceil((this.getHitpointsMax() - this.getHitpoints()) / this.Const.World.Assets.HitpointsPerHour / 24.0);

			if (ht > 1)
			{
				tooltip.push({
					id = 133,
					type = "text",
					icon = "ui/icons/days_wounded.png",
					text = "Light Wounds (" + ht + " days)"
				});
			}
			else
			{
				tooltip.push({
					id = 133,
					type = "text",
					icon = "ui/icons/days_wounded.png",
					text = "Light Wounds (" + ht + " day)"
				});
			}
		}

		return tooltip;
	}

	function getOverlayImage()
	{
		if (("State" in this.World) && this.World.State != null)
		{
			return this.World.Assets.getBanner();
		}
		else
		{
			return "banner_06";
		}
	}

	function getImagePath( _ignoreLayers = [] )
	{
		local result = "tacticalentity(" + this.m.ContentID + "," + this.getID() + ",socket,arrow";

		for( local i = 0; i < _ignoreLayers.len(); i = ++i )
		{
			result = result + ("," + _ignoreLayers[i]);
		}

		result = result + ")";
		return result;
	}

	function getDaysWounded()
	{
		if (this.getHitpoints() < this.getHitpointsMax())
		{
			return this.Math.ceil((this.getHitpointsMax() - this.getHitpoints()) / this.Const.World.Assets.HitpointsPerHour / 24.0);
		}
		else
		{
			return 0;
		}
	}

	function onUpdateInjuryLayer()
	{
		if (!this.hasSprite("injury"))
		{
			return;
		}

		local injury = this.getSprite("injury");
		local injury_body = this.getSprite("injury_body");
		local p = this.m.Hitpoints / this.getHitpointsMax();

		if (p > 0.670000017)
		{
			this.setDirty(this.m.IsDirty || injury.Visible || injury_body.Visible);
			injury.Visible = false;
			injury_body.Visible = false;
		}
		else
		{
			this.setDirty(this.m.IsDirty || !injury.Visible || !injury_body.Visible);
			injury.Visible = true;
			injury_body.Visible = true;

			if (p > 0.330000013)
			{
				injury.setBrush("bust_head_injured_01");
			}
			else
			{
				injury.setBrush("bust_head_injured_02");
			}

			if (p > 0.400000006)
			{
				injury_body.Visible = false;
			}
			else
			{
				injury_body.Visible = true;
				injury_body.setBrush(this.getSprite("body").getBrush().Name + "_injured");
			}
		}
	}

	function isInReserves()
	{
		return this.CampAssignment == this.Const.World.CampBuildings.Healer
	}

	function create()
	{
		this.m.IsControlledByPlayer = true;
		this.m.IsGeneratingKillName = false;
		this.m.Type = this.Const.EntityType.Player;
		this.m.BloodType = this.Const.BloodType.Red;
		this.human.create();
		this.getTags().add("human");
		this.getTags().set("PotionLastUsed", 0.0);
		this.getTags().set("PotionsUsed", 0);
		this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
		this.m.AIAgent.setActor(this);
		this.m.Formations = this.new("scripts/entity/tactical/formations_container")
	}

	function onHired()
	{
		this.m.HireTime = this.Time.getVirtualTimeF();
		this.improveMood(1.5, "Joined a mercenary company");

		if (this.World.getPlayerRoster().getSize() >= 12)
		{
			this.updateAchievement("AFullCompany", 1, 1);
		}

		if (this.World.getPlayerRoster().getSize() >= 20)
		{
			this.updateAchievement("PowerInNumbers", 1, 1);
		}
	}

	function onCombatStart()
	{
		this.m.MaxEnemiesThisTurn = 1;
		this.m.CombatStats.DamageReceivedHitpoints = 0;
		this.m.CombatStats.DamageReceivedArmor = 0;
		this.m.CombatStats.DamageDealtHitpoints = 0;
		this.m.CombatStats.DamageDealtArmor = 0;
		this.m.CombatStats.Kills = 0;
		this.m.CombatStats.XPGained = 0;
		this.m.Skills.onCombatStarted();
		this.m.Skills.update();
		this.getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Retreat] = 0.0;
	}

	function onBeforeCombatResult()
	{
		this.onCombatFinished();
		this.m.LifetimeStats.Battles += 1;
		this.getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Retreat] = 0.0;
	}

	function onCombatFinished()
	{
		this.actor.resetRenderEffects();
		this.m.IsAlive = true;
		this.m.Hitpoints = this.Math.max(1, this.m.Hitpoints);
		this.m.MaxEnemiesThisTurn = 1;

		if (this.m.MoraleState != this.Const.MoraleState.Ignore)
		{
			this.setMoraleState(this.Const.MoraleState.Steady);
		}

		this.resetBloodied(false);
		this.getSprite("dirt").Visible = false;
		this.getTags().set("Devoured", false);
		this.getTags().set("Charmed", false);
		this.getTags().set("Sleeping", false);
		this.getTags().set("Nightmare", false);
		this.m.Fatigue = 0;
		this.m.ActionPoints = 0;
		this.m.Items.onCombatFinished();
		this.m.Skills.onCombatFinished();

		if (this.m.IsAlive)
		{
			this.updateLevel();
			this.updateInjuryVisuals(false);
			this.setDirty(true);
		}
	}

	function isReallyKilled( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.None)
		{
			return true;
		}

		if (this.Tactical.State.isScenarioMode())
		{
			return true;
		}

		if (this.Tactical.State.isAutoRetreat())
		{
			return true;
		}

		if (this.Math.rand(1, 100) <= this.Const.Combat.SurviveWithInjuryChance * this.m.CurrentProperties.SurviveWithInjuryChanceMult)
		{
			local potential = [];
			local injuries = this.Const.Injury.Permanent;
			local numPermInjuries = 0;

			foreach (inj in injuries)
			{
				if (inj.ID == "injury.broken_elbow_joint" && !this.m.Skills.hasSkill("injury.broken_elbow_joint") && !this.m.Skills.hasSkill("trait.vazl_prosthetic_forearm"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.broken_knee" && !this.m.Skills.hasSkill("injury.broken_knee") && !this.m.Skills.hasSkill("trait.vazl_prosthetic_leg"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.maimed_foot" && !this.m.Skills.hasSkill("injury.maimed_foot") && !this.m.Skills.hasSkill("trait.vazl_prosthetic_foot"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.missing_ear" && !this.m.Skills.hasSkill("injury.missing_ear") && !this.m.Skills.hasSkill("trait.vazl_prosthetic_ear"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.missing_eye" && !this.m.Skills.hasSkill("injury.missing_eye") && !this.m.Skills.hasSkill("trait.vazl_prosthetic_eye"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.missing_finger" && !this.m.Skills.hasSkill("injury.missing_finger") && !this.m.Skills.hasSkill("trait.vazl_prosthetic_finger"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.missing_hand" && !this.m.Skills.hasSkill("injury.missing_hand") && !this.m.Skills.hasSkill("trait.vazl_prosthetic_hand"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.missing_nose" && !this.m.Skills.hasSkill("injury.missing_nose") && !this.m.Skills.hasSkill("trait.vazl_prosthetic_nose"))
				{
					potential.push(inj);
				}
				else if (inj.ID != "injury.broken_elbow_joint" && inj.ID != "injury.broken_knee" && inj.ID != "injury.maimed_foot" && inj.ID != "injury.missing_ear" && inj.ID != "injury.missing_eye" && inj.ID != "injury.missing_finger" && inj.ID != "injury.missing_hand" && inj.ID != "injury.missing_nose" && !this.m.Skills.hasSkill(inj.ID))
				{
					potential.push(inj);
				}
				else
				{
					numPermInjuries = ++numPermInjuries;
				}
			}

			if (potential.len() != 0)
			{
				local skill = this.new("scripts/skills/" + potential[this.Math.rand(0, potential.len() - 1)].Script);
				this.m.Skills.add(skill);
				this.Tactical.getSurvivorRoster().add(this);
				this.m.IsDying = false;
				this.worsenMood(this.Const.MoodChange.PermanentInjury, "Suffered a permanent injury");
				this.updateAchievement("ScarsForLife", 1, 1);

				if (numPermInjuries + 1 >= 3)
				{
					this.updateAchievement("HardToKill", 1, 1);
				}

				return false;
			}
		}

		return true;
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _fatalityType != this.Const.FatalityType.Unconscious)
		{
			if (this.getLevel() >= 11 && this.World.Assets.isIronman())
			{
				this.updateAchievement("ToughFarewell", 1, 1);
			}
			else
			{
				this.updateAchievement("BloodyToll", 1, 1);
			}

			if (_killer != null && this.isKindOf(_killer, "player") && _killer.getSkills().hasSkill("effects.charmed"))
			{
				this.updateAchievement("NothingPersonal", 1, 1);
			}
		}

		local flip = this.Math.rand(0, 100) < 50;
		this.m.IsCorpseFlipped = flip;
		local isResurrectable = _fatalityType == this.Const.FatalityType.None || _fatalityType == this.Const.FatalityType.Disembowled;
		local appearance = this.getItems().getAppearance();
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");
		local sprite_hair = this.getSprite("hair");
		local sprite_beard = this.getSprite("beard");
		local sprite_beard_top = this.getSprite("beard_top");
		local tattoo_body = this.getSprite("tattoo_body");
		local tattoo_head = this.getSprite("tattoo_head");
		local sprite_surcoat = this.getSprite("surcoat");
		local sprite_accessory = this.getSprite("accessory");

		if (!this.isGuest())
		{
			local stub = this.Tactical.getCasualtyRoster().create("scripts/entity/tactical/player_corpse_stub");
			stub.setCommander(this.isCommander());
			stub.setOriginalID(this.getID());
			stub.setName(this.getNameOnly());
			stub.setTitle(this.getTitle());
			stub.setCombatStats(this.m.CombatStats);
			stub.setLifetimeStats(this.m.LifetimeStats);
			stub.m.DaysWithCompany = this.getDaysWithCompany();
			stub.m.Level = this.getLevel();
			stub.m.DailyCost = this.getDailyCost();
			stub.addSprite("blood_1").setBrush(this.Const.BloodPoolDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodPoolDecals[this.Const.BloodType.Red].len() - 1)]);
			stub.addSprite("blood_2").setBrush(this.Const.BloodDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodDecals[this.Const.BloodType.Red].len() - 1)]);
			stub.setSpriteOffset("blood_1", this.createVec(0, -15));
			stub.setSpriteOffset("blood_2", this.createVec(0, -30));

			if (_fatalityType == this.Const.FatalityType.Devoured)
			{
				for( local i = 0; i != this.Const.CorpsePart.len(); i = ++i )
				{
					stub.addSprite("stuff_" + i).setBrush(this.Const.CorpsePart[i]);
				}
			}
			else
			{
				local decal = stub.addSprite("body");
				decal.setBrush(sprite_body.getBrush().Name + "_dead");
				decal.Color = sprite_head.Color;
				decal.Saturation = sprite_head.Saturation;

				if (tattoo_body.HasBrush)
				{
					decal = stub.addSprite("tattoo_body");
					decal.setBrush(tattoo_body.getBrush().Name + "_dead");
					decal.Color = tattoo_body.Color;
					decal.Saturation = tattoo_body.Saturation;
				}

				if (appearance.CorpseArmor != "")
				{
					decal = stub.addSprite("armor");
					decal.setBrush(appearance.CorpseArmor);
				}

				if (sprite_surcoat.HasBrush)
				{
					decal = stub.addSprite("surcoat");
					decal.setBrush("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_dead");
				}

				if (sprite_accessory.HasBrush)
				{
					decal = stub.addSprite("accessory");
					decal.setBrush(sprite_accessory.getBrush().Name + "_dead");
				}

				if (_fatalityType == this.Const.FatalityType.Disemboweled)
				{
					stub.addSprite("guts").setBrush("bust_body_guts_01");
				}
				else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
				{
					if (appearance.CorpseArmor != "")
					{
						stub.addSprite("arrows").setBrush(appearance.CorpseArmor + "_arrows");
					}
					else
					{
						stub.addSprite("arrows").setBrush(appearance.Corpse + "_arrows");
					}
				}
				else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
				{
					if (appearance.CorpseArmor != "")
					{
						stub.addSprite("arrows").setBrush(appearance.CorpseArmor + "_javelin");
					}
					else
					{
						stub.addSprite("arrows").setBrush(appearance.Corpse + "_javelin");
					}
				}

				if (_fatalityType != this.Const.FatalityType.Decapitated)
				{
					if (!appearance.HideCorpseHead)
					{
						decal = stub.addSprite("head");
						decal.setBrush(sprite_head.getBrush().Name + "_dead");
						decal.Color = sprite_head.Color;
						decal.Saturation = sprite_head.Saturation;

						if (tattoo_head.HasBrush)
						{
							decal = stub.addSprite("tattoo_head");
							decal.setBrush(this.getSprite("tattoo_head").getBrush().Name + "_dead");
							decal.Color = tattoo_head.Color;
							decal.Saturation = tattoo_head.Saturation;
						}
					}

					if (!appearance.HideBeard && !appearance.HideCorpseHead && sprite_beard.HasBrush)
					{
						decal = stub.addSprite("beard");
						decal.setBrush(sprite_beard.getBrush().Name + "_dead");
						decal.Color = sprite_beard.Color;
						decal.Saturation = sprite_beard.Saturation;
					}

					if (!appearance.HideHair && !appearance.HideCorpseHead && sprite_hair.HasBrush)
					{
						decal = stub.addSprite("hair");
						decal.setBrush(sprite_hair.getBrush().Name + "_dead");
						decal.Color = sprite_hair.Color;
						decal.Saturation = sprite_hair.Saturation;
					}

					if (_fatalityType == this.Const.FatalityType.Smashed)
					{
						stub.addSprite("smashed").setBrush("bust_head_smashed_01");
					}
					else if (appearance.HelmetCorpse != "")
					{
						decal = stub.addSprite("helmet");
						decal.setBrush(this.getItems().getAppearance().HelmetCorpse);
					}

					if (!appearance.HideBeard && !appearance.HideCorpseHead && sprite_beard_top.HasBrush)
					{
						decal = stub.addSprite("beard_top");
						decal.setBrush(sprite_beard_top.getBrush().Name + "_dead");
						decal.Color = sprite_beard.Color;
						decal.Saturation = sprite_beard.Saturation;
					}
				}
			}
		}

		if (_tile != null)
		{
			local decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
			decal.Color = sprite_head.Color;
			decal.Saturation = sprite_head.Saturation;
			decal.Scale = 0.899999976;
			decal.setBrightness(0.899999976);

			if (tattoo_body.HasBrush)
			{
				decal = _tile.spawnDetail(tattoo_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Color = tattoo_body.Color;
				decal.Saturation = tattoo_body.Saturation;
				decal.Scale = 0.899999976;
				decal.setBrightness(0.899999976);
			}

			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.899999976;
				decal.setBrightness(0.899999976);
			}

			if (sprite_surcoat.HasBrush && this.doesBrushExist("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_dead"))
			{
				decal = _tile.spawnDetail("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.899999976;
				decal.setBrightness(0.899999976);
			}

			if (sprite_accessory.HasBrush)
			{
				decal = _tile.spawnDetail(sprite_accessory.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.899999976;
				decal.setBrightness(0.899999976);
			}

			if (_fatalityType == this.Const.FatalityType.None && (!_skill || _skill.getProjectileType() == this.Const.ProjectileType.None) && this.Math.rand(1, 100) <= 33)
			{
				decal = _tile.spawnDetail("dead_body_splatter", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Alpha = 160;
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				decal = _tile.spawnDetail("bust_body_guts_0" + this.Math.rand(1, 3), this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				decal.Scale = 0.899999976;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}
				else
				{
					decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}

				decal.Scale = 0.899999976;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_javelin", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}
				else
				{
					decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
				}

				decal.Scale = 0.899999976;
			}

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				if (!appearance.HideCorpseHead)
				{
					local decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = 0.899999976;
					decal.setBrightness(0.899999976);

					if (tattoo_head.HasBrush)
					{
						decal = _tile.spawnDetail(tattoo_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Color = tattoo_head.Color;
						decal.Saturation = tattoo_head.Saturation;
						decal.Scale = 0.899999976;
						decal.setBrightness(0.899999976);
					}
				}

				if (!appearance.HideBeard && !appearance.HideCorpseHead && sprite_beard.HasBrush)
				{
					local decal = _tile.spawnDetail(sprite_beard.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_beard.Color;
					decal.Saturation = sprite_beard.Saturation;
					decal.Scale = 0.899999976;
					decal.setBrightness(0.899999976);

					if (sprite_beard_top.HasBrush)
					{
						local decal = _tile.spawnDetail(sprite_beard_top.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
						decal.Color = sprite_beard.Color;
						decal.Saturation = sprite_beard.Saturation;
						decal.Scale = 0.899999976;
						decal.setBrightness(0.899999976);
					}
				}

				if (!appearance.HideHair && !appearance.HideCorpseHead && sprite_hair.HasBrush)
				{
					local decal = _tile.spawnDetail(sprite_hair.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Color = sprite_hair.Color;
					decal.Saturation = sprite_hair.Saturation;
					decal.Scale = 0.899999976;
					decal.setBrightness(0.899999976);
				}

				if (_fatalityType == this.Const.FatalityType.Smashed)
				{
					decal = _tile.spawnDetail("bust_head_smashed_01", this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Scale = 0.899999976;
				}
				else if (appearance.HelmetCorpse != "")
				{
					local decal = _tile.spawnDetail(this.getItems().getAppearance().HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip, false, this.Const.Combat.HumanCorpseOffset);
					decal.Scale = 0.899999976;
					decal.setBrightness(0.899999976);
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [];

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (!appearance.HideCorpseHead && tattoo_head.HasBrush)
				{
					layers.push(tattoo_head.getBrush().Name + "_dead");
				}

				if (!appearance.HideBeard && sprite_beard.HasBrush)
				{
					layers.push(sprite_beard.getBrush().Name + "_dead");
				}

				if (!appearance.HideHair && sprite_hair.HasBrush)
				{
					layers.push(sprite_hair.getBrush().Name + "_dead");
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					layers.push(appearance.HelmetCorpse);
				}

				if (!appearance.HideBeard && sprite_beard_top.HasBrush)
				{
					layers.push(sprite_beard_top.getBrush().Name + "_dead");
				}

				local decap = this.Tactical.spawnHeadEffect(_tile, layers, this.createVec(0, 0), -90.0, "bust_head_dead_bloodpool");
				local idx = 0;

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = 0.899999976;
					decap[idx].setBrightness(0.899999976);
					idx = ++idx;
				}

				if (!appearance.HideCorpseHead && tattoo_head.HasBrush)
				{
					decap[idx].Color = tattoo_head.Color;
					decap[idx].Saturation = tattoo_head.Saturation;
					decap[idx].Scale = 0.899999976;
					decap[idx].setBrightness(0.899999976);
					idx = ++idx;
				}

				if (!appearance.HideBeard && sprite_beard.HasBrush)
				{
					decap[idx].Color = sprite_beard.Color;
					decap[idx].Saturation = sprite_beard.Saturation;
					decap[idx].Scale = 0.899999976;
					decap[idx].setBrightness(0.899999976);
					idx = ++idx;
				}

				if (!appearance.HideHair && sprite_hair.HasBrush)
				{
					decap[idx].Color = sprite_hair.Color;
					decap[idx].Saturation = sprite_hair.Saturation;
					decap[idx].Scale = 0.899999976;
					decap[idx].setBrightness(0.899999976);
					idx = ++idx;
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decap[idx].Scale = 0.899999976;
					decap[idx].setBrightness(0.899999976);
					idx = ++idx;
				}

				if (!appearance.HideBeard && sprite_beard_top.HasBrush)
				{
					decap[idx].Color = sprite_beard.Color;
					decap[idx].Saturation = sprite_beard.Saturation;
					decap[idx].Scale = 0.899999976;
					decap[idx].setBrightness(0.899999976);
					idx = ++idx;
				}
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local custom = {
				IsZombified = false,
				InjuryType = 4,
				Face = sprite_head.getBrush().Name,
				Body = sprite_body.getBrush().Name,
				TattooBody = tattoo_body.HasBrush ? tattoo_body.getBrush().Name : null,
				TattooHead = tattoo_head.HasBrush ? tattoo_head.getBrush().Name : null,
				Hair = sprite_hair.HasBrush ? sprite_hair.getBrush().Name : null,
				HairColor = sprite_hair.Color,
				HairSaturation = sprite_hair.Saturation,
				Beard = sprite_beard.HasBrush ? sprite_beard.getBrush().Name : null,
				Surcoat = this.m.Surcoat
			};
			local corpse = clone this.Const.Corpse;
			corpse.Type = "scripts/entity/tactical/enemies/zombie_player";
			corpse.Faction = this.getFaction();
			corpse.CorpseName = this.getName();
			corpse.Tile = _tile;
			corpse.Value = 9.0;
			corpse.Hitpoints = 1.0;
			corpse.IsResurrectable = isResurrectable;
			corpse.IsConsumable = _fatalityType != this.Const.FatalityType.Unconscious;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.Name = "Wiederganger " + this.getNameOnly();
			corpse.Items = _fatalityType != this.Const.FatalityType.Unconscious ? this.getItems() : null;
			corpse.Color = sprite_head.Color;
			corpse.Saturation = sprite_head.Saturation;
			corpse.Custom = custom;
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			corpse.IsPlayer = true;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.getItems().dropAll(_tile, _killer, !flip);
		}

		if (_tile != null && !this.Tactical.State.isScenarioMode() && this.World.FactionManager.isUndeadScourge() && isResurrectable && this.Math.rand(1, 100) <= 50)
		{
			local corpse = _tile.Properties.get("Corpse");
			corpse.Faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getID();
			corpse.Hitpoints = 1.0;
			corpse.Items = this.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(2, 3), this.Tactical.Entities.resurrect, corpse);
		}

		if (!this.m.IsGuest && !this.Tactical.State.isScenarioMode())
		{
			this.World.Assets.addScore(-5 * this.getLevel());
		}

		if (!this.m.IsGuest && !this.Tactical.State.isScenarioMode() && _fatalityType != this.Const.FatalityType.Unconscious && (_skill != null && _killer != null || _fatalityType == this.Const.FatalityType.Devoured))
		{
			local killedBy;

			if (_fatalityType == this.Const.FatalityType.Devoured)
			{
				killedBy = "Devoured by a Nachzehrer";
			}
			else if (_fatalityType == this.Const.FatalityType.Suicide)
			{
				killedBy = "Committed Suicide";
			}
			else if (_skill.isType(this.Const.SkillType.StatusEffect))
			{
				killedBy = _skill.getKilledString();
			}
			else if (_killer.getID() == this.getID())
			{
				killedBy = "Killed in battle";
			}
			else
			{
				if (_fatalityType == this.Const.FatalityType.Decapitated)
				{
					killedBy = "Beheaded";
				}
				else if (_fatalityType == this.Const.FatalityType.Disemboweled)
				{
					if (this.Math.rand(1, 2) == 1)
					{
						killedBy = "Disemboweled";
					}
					else
					{
						killedBy = "Gutted";
					}
				}
				else
				{
					killedBy = _skill.getKilledString();
				}

				killedBy = killedBy + (" by " + _killer.getKilledName());
			}

			local fallen = {
				Name = this.getName(),
				Time = this.World.getTime().Days,
				TimeWithCompany = this.Math.max(1, this.getDaysWithCompany()),
				Kills = this.m.LifetimeStats.Kills,
				Battles = this.m.LifetimeStats.Battles + 1,
				KilledBy = killedBy
			};
			this.World.Statistics.addFallen(fallen);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onInit()
	{
		this.human.onInit();
		this.m.Skills.add(this.new("scripts/skills/special/stats_collector"));
		this.m.Skills.add(this.new("scripts/skills/special/mood_check"));
		this.m.Skills.add(this.new("scripts/skills/special/weapon_breaking_warning"));
		this.m.Skills.add(this.new("scripts/skills/special/no_ammo_warning"));
		this.m.Skills.add(this.new("scripts/skills/effects/battle_standard_effect"));
		this.m.Skills.add(this.new("scripts/skills/actives/break_ally_free_skill"));
		this.m.Skills.add(this.new("scripts/skills/effects/realm_of_nightmares_effect"));
		this.setFaction(this.Const.Faction.Player);
		this.m.Items.setUnlockedBagSlots(2);
		this.m.Skills.add(this.new("scripts/skills/special/bag_fatigue"));
		this.setDiscovered(true);
	}

	function onActorKilled( _actor, _tile, _skill )
	{
		this.actor.onActorKilled(_actor, _tile, _skill);
		local XPkiller = this.Math.floor(_actor.getXPValue() * this.Const.XP.XPForKillerPct);
		local XPgroup = _actor.getXPValue() * (1.0 - this.Const.XP.XPForKillerPct);
		this.addXP(XPkiller);
		local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

		if (brothers.len() == 1)
		{
			this.addXP(XPgroup);
		}
		else
		{
			foreach( bro in brothers )
			{
				bro.addXP(this.Math.max(1, this.Math.floor(XPgroup / brothers.len())));
			}
		}
	}

	function setMoraleState( _m )
	{
		if (_m == this.Const.MoraleState.Confident && this.m.Skills.hasSkill("trait.insecure"))
		{
			return;
		}

		this.actor.setMoraleState(_m);
	}

	function checkMorale( _change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		if (_change > 0 && this.m.MoraleState == this.Const.MoraleState.Steady && this.m.Skills.hasSkill("trait.insecure"))
		{
			return false;
		}

		if (_change > 0 && this.m.Skills.hasSkill("trait.optimist"))
		{
			_difficulty = _difficulty + 5;
		}
		else if (_change < 0 && this.m.Skills.hasSkill("trait.pessimist"))
		{
			_difficulty = _difficulty - 5;
		}
		else if (this.m.Skills.hasSkill("trait.irrational"))
		{
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 10 : -10);
		}

		if (_change < 0 && _type == this.Const.MoraleCheckType.MentalAttack && this.m.Skills.hasSkill("trait.superstitious"))
		{
			_difficulty = _difficulty - 10;
		}

		return this.actor.checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);
	}

	function addXP( _xp )
	{
		if (this.m.Level >= this.Const.LevelXP.len() || this.isGuest())
		{
			return;
		}

		_xp = _xp * this.Const.Combat.GlobalXPMult;

		if (this.m.Level >= 11)
		{
			_xp = _xp * this.Const.Combat.GlobalXPVeteranLevelMult;
		}

		if (this.m.XP + _xp * this.m.CurrentProperties.XPGainMult >= this.Const.LevelXP[this.Const.LevelXP.len() - 1])
		{
			this.m.CombatStats.XPGained += this.Const.LevelXP[this.Const.LevelXP.len() - 1] - this.m.XP;
			this.m.XP = this.Const.LevelXP[this.Const.LevelXP.len() - 1];
			return;
		}

		this.m.XP += this.Math.floor(_xp * this.m.CurrentProperties.XPGainMult);
		this.m.CombatStats.XPGained += this.Math.floor(_xp * this.m.CurrentProperties.XPGainMult);
	}

	function unlockPerk( _id , _background )
	{
		if (this.hasPerk(_id))
		{
			return true;
		}

		local perk = this.Const.Perks.findByBackground(_id, _background);

		if (perk == null)
		{
			return false;
		}

		if (this.m.PerkPoints > 0)
		{
			--this.m.PerkPoints;
		}

		++this.m.PerkPointsSpent;
		local p = this.new(perk.Script);
		this.m.Skills.add(p);
		this.m.Skills.update();

		if (this.m.Level >= 11 && _id == "perk.student")
		{
			++this.m.PerkPoints;
		}

		//++this.m.PerkPoints //// DEBUG, UNCOMMENT FOR UNLIMITED UNLOCKS 

		return true;
	}

	function isPerkUnlockable( _id )
	{
		if (this.m.PerkPoints == 0 || this.hasPerk(_id))
		{
			return false;
		}

		local perk = this.Const.Perks.findByBackground(_id, this.getBackground().getID());

		if (this.m.PerkPointsSpent >= perk.Unlocks)
		{
			return true;
		}

		return false;
	}

	function hasPerk( _id )
	{
		return this.m.Skills.hasSkill(_id);
	}

	function isPerkTierUnlocked( _category, _tier )
	{
		local numPerks = 0;

		for( local j = 0; j < this.m.PerksUnlocked[_category].len(); j = ++j )
		{
			numPerks = numPerks + this.m.PerksUnlocked[_category][j];
		}

		if (numPerks < this.Const.Perks.UnlockRequirementsPerTier[_tier])
		{
			return false;
		}

		return true;
	}

	function getPerksUnlocked( _category, _tier )
	{
		return this.m.PerksUnlocked[_category][_tier];
	}

	function updateLevel()
	{
		while (this.m.Level < this.Const.LevelXP.len() && this.m.XP >= this.Const.LevelXP[this.m.Level])
		{
			++this.m.Level;
			++this.m.LevelUps;

			if (this.m.Level <= this.Const.XP.MaxLevelWithPerkpoints)
			{
				++this.m.PerkPoints;
			}

			if (this.m.Level == 11 && this.m.Skills.hasSkill("perk.student"))
			{
				++this.m.PerkPoints;
			}

			if (this.m.Level == 11)
			{
				this.updateAchievement("OldAndWise", 1, 1);
			}

			if (this.m.Level > 11 && this.m.VeteranPerks > 0)
			{
				if ((this.m.Level - 1) % this.m.VeteranPerks == 0) {
					++this.m.PerkPoints;
				}
			}
		}
	}

	function assignRandomEquipment()
	{
		if (this.Math.rand(0, 2) != 0)
		{
			this.assignRandomMeleeEquipment();
		}
		else
		{
			this.assignRandomRangedEquipment();
		}
	}

	function assignRandomMeleeEquipment()
	{
		local r = this.Math.rand(1, 24);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/armor/coat_of_plates"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/armor/lamellar_harness"));
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 9)
		{
			this.m.Items.equip(this.new("scripts/items/armor/heavy_lamellar_armor"));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.new("scripts/items/armor/scale_armor"));
		}
		else if (r == 12)
		{
			this.m.Items.equip(this.new("scripts/items/armor/coat_of_scales"));
		}
		else if (r == 13)
		{
			this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
		else if (r == 14)
		{
			this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}
		else if (r == 15)
		{
			this.m.Items.equip(this.new("scripts/items/armor/heraldic_mail"));
		}
		else if (r == 16)
		{
			this.m.Items.equip(this.new("scripts/items/armor/named/black_leather_armor"));
		}
		else if (r == 17)
		{
			this.m.Items.equip(this.new("scripts/items/armor/named/golden_scale_armor"));
		}
		else if (r == 18)
		{
			this.m.Items.equip(this.new("scripts/items/armor/named/blue_studded_mail_armor"));
		}
		else if (r == 19)
		{
			this.m.Items.equip(this.new("scripts/items/armor/named/brown_coat_of_plates_armor"));
		}
		else if (r == 20)
		{
			this.m.Items.equip(this.new("scripts/items/armor/named/green_coat_of_plates_armor"));
		}
		else if (r == 21)
		{
			this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}
		else if (r == 22)
		{
			this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
		}
		else if (r == 23)
		{
			this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
		}
		else if (r == 24)
		{
			this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
		}

		r = this.Math.rand(1, 30);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/hood"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/mail_coif"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/closed_mail_coif"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/reinforced_mail_coif"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/kettle_hat"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/padded_nasal_helmet"));
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet_with_mail"));
		}
		else if (r == 9)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/full_helm"));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/flat_top_helmet"));
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/padded_flat_top_helmet"));
		}
		else if (r == 12)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/flat_top_with_mail"));
		}
		else if (r == 13)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/kettle_hat_with_mail"));
		}
		else if (r == 14)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/kettle_hat_with_closed_mail"));
		}
		else if (r == 15)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/closed_flat_top_with_neckguard"));
		}
		else if (r == 16)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/closed_flat_top_helmet"));
		}
		else if (r == 17)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/closed_flat_top_with_mail"));
		}
		else if (r == 18)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/witchhunter_hat"));
		}
		else if (r == 19)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/named/golden_feathers_helmet"));
		}
		else if (r == 20)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/named/heraldic_mail_helmet"));
		}
		else if (r == 21)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/named/nasal_feather_helmet"));
		}
		else if (r == 22)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/named/norse_helmet"));
		}
		else if (r == 23)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/named/sallet_green_helmet"));
		}
		else if (r == 24)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/named/wolf_helmet"));
		}

		r = this.Math.rand(1, 17);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/noble_sword"));
			this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/winged_mace"));
			this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}
		else if (r == 9)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/fighting_axe"));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
		}
		else if (r == 12)
		{
			this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
			this.m.Items.equip(this.new("scripts/items/weapons/warhammer"));
		}
		else if (r == 13)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/military_cleaver"));
		}
		else if (r == 14)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r == 15)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pike"));
		}
		else if (r == 16)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/two_handed_hammer"));
		}
		else if (r == 17)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
		}
	}

	function assignRandomRangedEquipment()
	{
		local r = this.Math.rand(1, 10);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}
		else if (r == 9)
		{
			this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
		}

		r = this.Math.rand(1, 7);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/hood"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
		}

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/short_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/light_crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
	}

	function assignRandomThrowingEquipment()
	{
		local r = this.Math.rand(1, 8);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/hood"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
		}

		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/throwing_axe"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/javelin"));
		}
	}

	function setScenarioValues()
	{
		local b = this.m.BaseProperties;
		b.ActionPoints = 9;
		b.Hitpoints = 60;
		b.Bravery = this.Math.rand(45, 55);
		b.Stamina = 120;
		b.MeleeSkill = 65;
		b.RangedSkill = 65;
		b.MeleeDefense = 10;
		b.RangedDefense = 10;
		b.Initiative = 115;
		this.setName(this.Const.Tactical.Common.getRandomPlayerName());
		local background = this.new("scripts/skills/backgrounds/" + this.Const.CharacterBackgrounds[this.Math.rand(0, this.Const.CharacterBackgrounds.len() - 1)]);
		background.setScenarioOnly(true);
		this.m.Skills.add(background);
		background.buildDescription();
		background.setAppearance();
		local c = this.m.CurrentProperties;
		this.m.ActionPoints = c.ActionPoints;
		this.m.Hitpoints = c.Hitpoints;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
	}

	function setStartValuesEx( _backgrounds )
	{
		if (this.isSomethingToSee() && this.World.getTime().Days >= 7)
		{
			_backgrounds = this.Const.CharacterPiracyBackgrounds;
		}

		local background = this.new("scripts/skills/backgrounds/" + _backgrounds[this.Math.rand(0, _backgrounds.len() - 1)]);
		this.m.Skills.add(background);
		this.m.Background = background;
		
		if (this.m.Name.len() == 0 && background.isFemaleBackground() == false)
		{
			this.m.Name = this.Const.Tactical.Common.getRandomPlayerName();
		}
		if (this.m.Name.len() == 0 && background.isFemaleBackground() == true)
		{
			this.m.Name = this.Const.Tactical.Common.getRandomPlayerNameFemale();
		}

		if (background.isFemaleBackground()) {
			this.m.Gender = 1;
		}
	
		background.buildAttributes();
		background.buildDescription();
		local maxTraits = this.Math.rand(this.Math.rand(0, 1) == 0 ? 0 : 1, 2);
		local traits = [
			background
		];

		for( local i = 0; i < maxTraits; i = ++i )
		{
			for( local j = 0; j < 10; j = ++j )
			{
				local trait = this.Const.CharacterTraits[this.Math.rand(0, this.Const.CharacterTraits.len() - 1)];
				local nextTrait = false;

				for( local k = 0; k < traits.len(); k = ++k )
				{
					if (traits[k].getID() == trait[0] || traits[k].isExcluded(trait[0]))
					{
						nextTrait = true;
						break;
					}
				}

				if (!nextTrait)
				{
					traits.push(this.new(trait[1]));
					break;
				}
			}
		}

		for( local i = 1; i < traits.len(); i = ++i )
		{
			this.m.Skills.add(traits[i]);

			if (traits[i].getContainer() != null)
			{
				traits[i].addTitle();
			}
		}

		background.addEquipment();
		background.setAppearance();
		background.buildDescription(true);
		this.m.Skills.update();
		local p = this.m.CurrentProperties;
		this.m.Hitpoints = p.Hitpoints;
		this.fillTalentValues(3);
		this.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
	}

	function fillTalentValues( _num, _force = false )
	{
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);

		if (this.getBackground() != null && this.getBackground().isUntalented() && !_force)
		{
			return;
		}

		for( local done = 0; done < _num;  )
		{
			local i = this.Math.rand(0, this.Const.Attributes.COUNT - 1);

			if (this.m.Talents[i] == 0 && (this.getBackground() == null || this.getBackground().getExcludedTalents().find(i) == null))
			{
				local r = this.Math.rand(1, 100);

				if (r <= 60)
				{
					this.m.Talents[i] = 1;
				}
				else if (r <= 90)
				{
					this.m.Talents[i] = 2;
				}
				else
				{
					this.m.Talents[i] = 3;
				}

				done = ++done;
			}
		}
	}

	function fillAttributeLevelUpValues( _amount, _maxOnly = false, _minOnly = false )
	{
		if (this.m.Attributes.len() == 0)
		{
			this.m.Attributes.resize(this.Const.Attributes.COUNT);

			for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
			{
				this.m.Attributes[i] = [];
			}
		}

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			for( local j = 0; j < _amount; j = ++j )
			{
				if (_minOnly)
				{
					this.m.Attributes[i].insert(0, 1);
				}
				else if (_maxOnly)
				{
					this.m.Attributes[i].insert(0, this.Const.AttributesLevelUp[i].Max);
				}
				else
				{
					this.m.Attributes[i].insert(0, this.Math.rand(this.Const.AttributesLevelUp[i].Min + (this.m.Talents[i] == 3 ? 2 : this.m.Talents[i]), this.Const.AttributesLevelUp[i].Max + (this.m.Talents[i] == 3 ? 1 : 0)));
				}
			}
		}
	}

	function getAttributeLevelUpValues()
	{
		local b = this.getBaseProperties();

		if (this.m.Attributes[0].len() == 0)
		{
			for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
			{
				this.m.Attributes[i].push(1);
			}
		}

		local ret = {
			hitpoints = b.Hitpoints,
			hitpointsMax = 150,
			hitpointsIncrease = this.m.Attributes[this.Const.Attributes.Hitpoints][0],
			bravery = b.Bravery,
			braveryMax = 150,
			braveryIncrease = this.m.Attributes[this.Const.Attributes.Bravery][0],
			fatigue = b.Stamina,
			fatigueMax = 150,
			fatigueIncrease = this.m.Attributes[this.Const.Attributes.Fatigue][0],
			initiative = b.Initiative,
			initiativeMax = 200,
			initiativeIncrease = this.m.Attributes[this.Const.Attributes.Initiative][0],
			meleeSkill = b.MeleeSkill,
			meleeSkillMax = 120,
			meleeSkillIncrease = this.m.Attributes[this.Const.Attributes.MeleeSkill][0],
			rangeSkill = b.RangedSkill,
			rangeSkillMax = 120,
			rangeSkillIncrease = this.m.Attributes[this.Const.Attributes.RangedSkill][0],
			meleeDefense = b.MeleeDefense,
			meleeDefenseMax = 100,
			meleeDefenseIncrease = this.m.Attributes[this.Const.Attributes.MeleeDefense][0],
			rangeDefense = b.RangedDefense,
			rangeDefenseMax = 100,
			rangeDefenseIncrease = this.m.Attributes[this.Const.Attributes.RangedDefense][0]
		};
		return ret;
	}

	function setAttributeLevelUpValues( _v )
	{
		local b = this.getBaseProperties();
		b.Hitpoints += _v.hitpointsIncrease;
		this.m.Hitpoints += _v.hitpointsIncrease;
		b.Stamina += _v.maxFatigueIncrease;
		b.Bravery += _v.braveryIncrease;
		b.MeleeSkill += _v.meleeSkillIncrease;
		b.RangedSkill += _v.rangeSkillIncrease;
		b.MeleeDefense += _v.meleeDefenseIncrease;
		b.RangedDefense += _v.rangeDefenseIncrease;
		b.Initiative += _v.initiativeIncrease;
		this.m.LevelUps = this.Math.max(0, this.m.LevelUps - 1);

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			this.m.Attributes[i].remove(0);
		}

		this.getSkills().update();
		this.setDirty(true);

		if (b.MeleeSkill >= 90)
		{
			this.updateAchievement("Swordmaster", 1, 1);
		}

		if (b.RangedSkill >= 90)
		{
			this.updateAchievement("Deadeye", 1, 1);
		}
	}

	function addInjury( _injuries, _maxThreshold = 1.0, _isOutOfCombat = true )
	{
		if (_injuries.len() == 0)
		{
			return null;
		}

		local candidates = [];

		foreach( inj in _injuries )
		{
			if (inj.Threshold <= _maxThreshold && !this.m.Skills.hasSkill(inj.ID))
			{
				candidates.push(inj.Script);
			}
		}

		if (candidates.len() == 0)
		{
			return null;
		}

		local injury = this.new("scripts/skills/" + candidates[this.Math.rand(0, candidates.len() - 1)]);

		if (_isOutOfCombat)
		{
			injury.setOutOfCombat(true);
		}
		else
		{
			this.worsenMood(this.Const.MoodChange.Injury, "Suffered an injury");
		}

		this.m.Skills.add(injury);
		this.setHitpoints(this.Math.max(1, this.getHitpoints() - this.Math.rand(5, 20)));
		this.updateInjuryVisuals();
		return injury;
	}

	function addLightInjury()
	{
		this.setHitpoints(this.Math.max(1, this.getHitpoints() - this.Math.rand(5, 20)));
	}

	function addHeavyInjury()
	{
		this.setHitpoints(this.Math.max(1, this.getHitpoints() - this.Math.rand(20, 40)));
	}

	function retreat()
	{
		if (!this.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this) + " has retreated from battle");
		}

		this.m.IsTurnDone = true;
		this.Tactical.getRetreatRoster().add(this);
		this.removeFromMap();
		this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.PlayerRetreated);
	}



	function saveFormation()
	{
		this.m.Formations.savePosition(this.m.PlaceInFormation);
		this.m.Formations.saveItems(this.getItems());
	}
	
	function setFormation( _i )
	{
		if (_i == this.m.Formations.getCurrentIndex()) 
		{
			return;
		}

		this.m.Formations.setFormation(_i)
		this.setPlaceInFormation(this.m.Formations.getPosition());
		local items = this.m.Formations.getItems();
		//Find the item in the stash, remove from stash and equip it
		foreach (itemId in items)
		{
			local res = this.Stash.getItemByInstanceID(itemId);
			if (res == null) {
				this.logInfo("saveFormation::could not find item for " + itemId);
				continue
			}

			this.Stash.remove(res.item);
			this.m.Items.equip(res.item);
		}

		local bags = this.m.Formations.getBags();
		foreach (itemId in bags)
		{
			local res = this.Stash.getItemByInstanceID(itemId);
			if (res == null) {
				this.logInfo("saveFormation::could not find item for " + itemId);
				continue
			}

			this.Stash.remove(res.item);
			this.m.Items.addToBag(res.item);
		}
	}

	function getStashModifier()
	{
		local broStash = this.Const.LegendMod.getMaxStash(this.getBackground().getID());
		local item = this.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);
		if (item != null && item.getID() == "accessory.legend_pack_small")
		{
			broStash += item.m.StashSize;
		}
		local skill = this.getSkills().getSkillByID("perk.legend_skillful_stacking")
		if( skill != null)
		{
			broStash += skill.m.StashSize;
		}
		skill = this.getSkills().getSkillByID("perk.legend_efficient_packing")
		if( skill != null)
		{
			broStash += skill.m.StashSize;
		}		
		return broStash;
	}

	function getAmmoModifier()
	{
		local ammo = this.Const.LegendMod.getMaxAmmo(this.getBackground().getID());
		if( this.getSkills().getSkillByID("perk.legend_ammo_bundles"))
		{
			ammo +=20;
		}
		if( this.getSkills().getSkillByID("perk.legend_ammo_binding"))
		{
			ammo +=10;
		}
		return ammo
	}

	function getArmorPartsModifier()
	{
		local parts = this.Const.LegendMod.getMaxArmorParts(this.getBackground().getID());
		if( this.getSkills().getSkillByID("perk.legend_tools_spares"))
		{
			parts +=20;
		}
		if( this.getSkills().getSkillByID("perk.legend_tools_drawers"))
		{
			parts +=10;
		}
		return parts;
	}

	function getMedsModifier()
	{
		local meds = this.Const.LegendMod.getMaxMedicine(this.getBackground().getID());
		if( this.getSkills().getSkillByID("perk.legend_med_packages"))
		{
			meds +=10;
		}
		if( this.getSkills().getSkillByID("perk.legend_med_ingredients"))
		{
			meds +=20;
		}
		return meds;
	}

	function getCampHealing() 
	{
		return this.m.CampHealing;
	}

	function setCampHealing( _v )
	{
		this.m.CampHealing = _v;
	}

	function getLastCampTime()
	{
		return this.m.LastCampTime;
	}

	function setLastCampTime( _t )
	{
		this.m.LastCampTime = _t;
	}

	function onSerialize( _out )
	{
		this.actor.onSerialize(_out);
		_out.writeU8(this.m.Level);
		_out.writeU8(this.m.PerkPoints);
		_out.writeU8(this.m.PerkPointsSpent);
		_out.writeU8(this.m.LevelUps);
		_out.writeF32(this.m.Mood);
		_out.writeU8(this.m.MoodChanges.len());

		for( local i = 0; i != this.m.MoodChanges.len(); i = ++i )
		{
			_out.writeBool(this.m.MoodChanges[i].Positive);
			_out.writeString(this.m.MoodChanges[i].Text);
			_out.writeF32(this.m.MoodChanges[i].Time);
		}

		_out.writeF32(this.m.HireTime);
		_out.writeF32(this.m.LastDrinkTime);

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			_out.writeU8(this.m.Talents[i]);
		}

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			_out.writeU8(this.m.Attributes[i].len());

			foreach( a in this.m.Attributes[i] )
			{
				_out.writeU8(a);
			}
		}

		_out.writeU8(this.m.PlaceInFormation);
		_out.writeU32(this.m.LifetimeStats.Kills);
		_out.writeU32(this.m.LifetimeStats.Battles);
		_out.writeU32(this.m.LifetimeStats.BattlesWithoutMe);
		_out.writeU16(this.m.LifetimeStats.MostPowerfulVanquishedType);
		_out.writeString(this.m.LifetimeStats.MostPowerfulVanquished);
		_out.writeU16(this.m.LifetimeStats.MostPowerfulVanquishedXP);
		_out.writeString(this.m.LifetimeStats.FavoriteWeapon);
		_out.writeU32(this.m.LifetimeStats.FavoriteWeaponUses);
		_out.writeU32(this.m.LifetimeStats.CurrentWeaponUses);
		_out.writeBool(this.m.IsTryoutDone);
		this.m.Formations.onSerialize(_out);
		_out.writeU8(this.m.VeteranPerks);
		_out.writeBool(this.m.IsCommander);
		_out.writeString(this.m.CampAssignment);
		_out.writeF32(this.m.LastCampTime);

	}

	function onDeserialize( _in )
	{
		this.actor.onDeserialize(_in);
		this.m.Level = _in.readU8();
		this.m.PerkPoints = _in.readU8();
		this.m.PerkPointsSpent = _in.readU8();
		this.m.LevelUps = _in.readU8();
		this.m.Mood = _in.readF32();
		local numMoodChanges = _in.readU8();
		this.m.MoodChanges.resize(numMoodChanges, 0);

		for( local i = 0; i != numMoodChanges; i = ++i )
		{
			local moodChange = {};
			moodChange.Positive <- _in.readBool();
			moodChange.Text <- _in.readString();
			moodChange.Time <- _in.readF32();
			this.m.MoodChanges[i] = moodChange;
		}

		this.m.HireTime = _in.readF32();
		this.m.LastDrinkTime = _in.readF32();
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			this.m.Talents[i] = _in.readU8();
		}

		this.m.Attributes.resize(this.Const.Attributes.COUNT);

		for( local i = 0; i != this.Const.Attributes.COUNT; i = ++i )
		{
			this.m.Attributes[i] = [];
			local n = _in.readU8();
			this.m.Attributes[i].resize(n);

			for( local j = 0; j != n; j = ++j )
			{
				this.m.Attributes[i][j] = _in.readU8();
			}
		}

		local ret = this.m.Skills.query(this.Const.SkillType.Background);

		if (ret.len() != 0)
		{
			this.m.Background = ret[0];
			this.m.Background.adjustHiringCostBasedOnEquipment();
			this.m.Background.buildDescription(true);
			if (this.m.Background.isFemaleBackground())
			{
				this.m.Gender = 1;
			}
		}

		this.m.PlaceInFormation = _in.readU8();
		this.m.LifetimeStats.Kills = _in.readU32();
		this.m.LifetimeStats.Battles = _in.readU32();

		if (_in.getMetaData().getVersion() >= 20)
		{
			this.m.LifetimeStats.BattlesWithoutMe = _in.readU32();
		}

		if (_in.getMetaData().getVersion() >= 37)
		{
			this.m.LifetimeStats.MostPowerfulVanquishedType = _in.readU16();
		}

		this.m.LifetimeStats.MostPowerfulVanquished = _in.readString();
		this.m.LifetimeStats.MostPowerfulVanquishedXP = _in.readU16();
		this.m.LifetimeStats.FavoriteWeapon = _in.readString();
		this.m.LifetimeStats.FavoriteWeaponUses = _in.readU32();
		this.m.LifetimeStats.CurrentWeaponUses = _in.readU32();
		this.m.IsTryoutDone = _in.readBool();
		this.m.Skills.update();

		if (_in.getMetaData().getVersion() >= 46)
		{
			this.m.Formations.onDeserialize(_in);
		}
		
		if (_in.getMetaData().getVersion() >= 47)
		{
			this.m.VeteranPerks = _in.readU8();
		}

		if (_in.getMetaData().getVersion() >= 48)
		{
			this.m.IsCommander = _in.readBool();
		}

		if (_in.getMetaData().getVersion() >= 52)
		{
			this.m.CampAssignment = _in.readString();
			this.m.LastCampTime = _in.readF32();
		}

	}

});
