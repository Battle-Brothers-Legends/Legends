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
			CurrentWeaponUses = 0,
			Tags = null
		},
		Formations = null,
		VeteranPerks = 5,
		CampAssignment = "camp.rest",
		LastCampAssignment = "camp.rest",
		CampHealing = 0,
		LastCampTime = 0,
		InReserves = false,
        StarWeights = [50,50,50,50,50,50,50,50],
        // Alignment = null,
        CompanyID = 0
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
		return this.Math.ceil(this.Math.max(10, this.Math.min(this.m.HiringCost - 25, 25 + this.m.HiringCost * this.Const.Tryouts.CostMult) * this.World.Assets.m.TryoutPriceMult));
	}

	function getDailyCost()
	{
		local wageMult = (this.m.CurrentProperties.DailyWageMult * (("State" in this.World) && this.World.State != null ? this.World.Assets.m.DailyWageMult : 1.0)) - this.World.State.getPlayer().getWageModifier();
		//local costAdj = this.Math.max(0, this.m.CurrentProperties.DailyWageMult * barterMult);
		return this.Math.max(0, this.m.CurrentProperties.DailyWage * wageMult);
	}

	function getDailyFood()
	{
		local food = this.Math.maxf(0.0, this.m.CurrentProperties.DailyFood);
		if (this.isInReserves() && !this.m.Skills.hasSkill("perk.legend_peaceful"))
		{
			food *= 2;
		}
		food -= this.World.State.getPlayer().getFoodModifier();
		return food;
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
		return this.m.IsCommander;
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

	function getLastCampAssignment()
	{
		return this.m.LastCampAssignment;
	}

	function setLastCampAssignment( _id )
	{
		this.m.LastCampAssignment = _id;
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
		this.m.Mood = this.Math.minf(this.m.Mood + _a, this.Const.MoodState.len() - 0.05);

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

		local talents = this.getTalents();

		for( local i = 0; i < this.Const.Attributes.COUNT; i = ++i )
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
				text = this.Tactical.TurnSequenceBar.getActiveEntity() == this ? "Acting right now!" : this.m.IsTurnDone || turnsToGo == null ? "Turn done" : "Acts in " + turnsToGo + (turnsToGo > 1 ? " turns" : " turn")
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

			if (!this.isInReserves())
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
			});
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
			local ht = this.Math.ceil((this.getHitpointsMax() - this.getHitpoints()) / (this.Const.World.Assets.HitpointsPerHour * (("State" in this.World) && this.World.State != null ? this.World.Assets.m.HitpointsPerHourMult : 1.0)) / 24.0);

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
		local result = "tacticalentity(" + this.m.ContentID + "," + this.getID() + ",socket,miniboss,arrow";

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
			return this.Math.ceil((this.getHitpointsMax() - this.getHitpoints()) / (this.Const.World.Assets.HitpointsPerHour * (("State" in this.World) && this.World.State != null ? this.World.Assets.m.HitpointsPerHourMult : 1.0)) / 24.0);
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

		if (p > 0.67)
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

			if (p > 0.33)
			{
				injury.setBrush("bust_head_injured_01");
			}
			else
			{
				injury.setBrush("bust_head_injured_02");
			}

			if (p > 0.4)
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
		return this.m.InReserves;
	}

	function setInReserves( _v )
	{
		this.m.InReserves = _v;
	}

	function isStabled()
	{
		if (this.getBackground() == null)
		{
			return false;
		}

		return this.getBackground().isStabled();
	}

	function create()
	{
		this.m.IsControlledByPlayer = true;
		this.m.IsGeneratingKillName = false;
		this.m.Type = this.Const.EntityType.Player;
		this.m.BloodType = this.Const.BloodType.Red;
		this.human.create();
		this.getFlags().add("human");
		this.getFlags().set("PotionLastUsed", 0.0);
		this.getFlags().set("PotionsUsed", 0);
		this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
		this.m.AIAgent.setActor(this);
		this.m.Formations = this.new("scripts/entity/tactical/formations_container");
		this.m.LifetimeStats.Tags = this.new("scripts/tools/tag_collection");
	}

	function onHired()
	{
		this.m.HireTime = this.Time.getVirtualTimeF();

		if (this.getBackground().getID() != "background.slave")
		{
			this.improveMood(1.5, "Joined a mercenary company");
		}

		if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin().getID() == "scenario.manhunters")
		{
			if (this.getBackground().getID() != "background.slave")
			{
				this.getSkills().add(this.new("scripts/skills/actives/whip_slave_skill"));
			}
			else
			{
				this.getSprite("miniboss").setBrush("bust_miniboss_indebted");
			}
		}

		if (this.World.getPlayerRoster().getSize() >= 12)
		{
			this.updateAchievement("AFullCompany", 1, 1);
		}

		if (this.World.getPlayerRoster().getSize() >= 20)
		{
			this.updateAchievement("PowerInNumbers", 1, 1);
		}

		this.World.Assets.getOrigin().onHiredByScenario(this);
        // this.m.CompanyID = this.World.State.addNewID(this);

		if (this.getSkills().hasSkill("trait.intensive_training_trait") && this.getLevel() > 1 )
		{
			if ( this.getBackground().getNameOnly()=="Donkey" )
			{
				return;
			}
			local inTraining = this.getSkills().getSkillByID("trait.intensive_training_trait");

			local addSkills = this.Math.rand(0, this.getLevel()+2);
			addSkills = this.Math.min(addSkills, inTraining.getMaxSkillsCanBeAdded() - 1);
			inTraining.addRandomSkills(this, addSkills);
		}
		if (this.World.State.getPlayer() != null)
		{
			this.World.State.getPlayer().calculateModifiers();
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
		this.getAIAgent().setUseHeat(false);
	}

	function onCombatFinished()
	{
		this.actor.resetRenderEffects();
		this.m.IsAlive = true;
		this.m.IsDying = false;
		this.m.IsAbleToDie = true;
		this.m.Hitpoints = this.Math.max(1, this.m.Hitpoints);
		this.m.MaxEnemiesThisTurn = 1;

		if (this.m.MoraleState != this.Const.MoraleState.Ignore)
		{
			this.setMoraleState(this.Const.MoraleState.Steady);
		}

		this.resetBloodied(false);
		this.getSprite("dirt").Visible = false;
		this.getFlags().set("Devoured", false);
		this.getFlags().set("Charmed", false);
		this.getFlags().set("Sleeping", false);
		this.getFlags().set("Nightmare", false);
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

		if (this.isGuest())
		{
			return true;
		}

		if (this.Math.rand(1, 100) <= this.Const.Combat.SurviveWithInjuryChance * this.m.CurrentProperties.SurviveWithInjuryChanceMult || this.World.Assets.m.IsSurvivalGuaranteed && !this.m.Skills.hasSkillOfType(this.Const.SkillType.PermanentInjury) && (this.World.Assets.getOrigin().getID() != "scenario.manhunters" || this.getBackground().getID() != "background.slave"))
		{


			local potential = [];
			local injuries = this.Const.Injury.Permanent;
			local numPermInjuries = 0;

			foreach (inj in injuries)
			{
				if (inj.ID == "injury.broken_elbow_joint" && !this.m.Skills.hasSkill("injury.broken_elbow_joint") && !this.m.Skills.hasSkill("trait.legend_prosthetic_forearm"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.broken_knee" && !this.m.Skills.hasSkill("injury.broken_knee") && !this.m.Skills.hasSkill("trait.legend_prosthetic_leg"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.maimed_foot" && !this.m.Skills.hasSkill("injury.maimed_foot") && !this.m.Skills.hasSkill("trait.legend_prosthetic_foot"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.missing_ear" && !this.m.Skills.hasSkill("injury.missing_ear") && !this.m.Skills.hasSkill("trait.legend_prosthetic_ear"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.missing_eye" && !this.m.Skills.hasSkill("injury.missing_eye") && !this.m.Skills.hasSkill("trait.legend_prosthetic_eye"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.missing_finger" && !this.m.Skills.hasSkill("injury.missing_finger") && !this.m.Skills.hasSkill("trait.legend_prosthetic_finger"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.missing_hand" && !this.m.Skills.hasSkill("injury.missing_hand") && !this.m.Skills.hasSkill("trait.legend_prosthetic_hand"))
				{
					potential.push(inj);
				}
				else if (inj.ID == "injury.missing_nose" && !this.m.Skills.hasSkill("injury.missing_nose") && !this.m.Skills.hasSkill("trait.legend_prosthetic_nose"))
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

			if (potential.len() == 0)
			{
				return true;
			}

			if (numPermInjuries + 1 >= 3)
			{
				this.updateAchievement("HardToKill", 1, 1);
			}

			local skill = this.new("scripts/skills/" + potential[this.Math.rand(0, potential.len() - 1)].Script);
			this.m.Skills.add(skill);

			if (this.m.CurrentProperties.SurvivesAsUndead && !this.getFlags().has("PlayerZombie") && !this.getFlags().has("PlayerSkeleton"))
			{
				local r = this.Math.rand(0, 1);

				if (r == 0)
				{
					this.getFlags().add("PlayerSkeleton");
					this.getFlags().add("undead");
					this.getFlags().add("skeleton");
					local body = this.getSprite("body");
					local skill = this.new("scripts/skills/injury_permanent/legend_fleshless");
					this.m.Skills.add(skill);
					this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
				}
				else
				{
					this.getFlags().add("PlayerZombie");
					this.getFlags().add("undead");
					this.getFlags().add("zombie_minion");
					local skill = this.new("scripts/skills/injury_permanent/legend_rotten_flesh");
					this.m.Skills.add(skill);
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_zombie_bite"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
				}
			}

			this.Tactical.getSurvivorRoster().add(this);
			this.m.IsDying = false;
			this.worsenMood(this.Const.MoodChange.PermanentInjury, "Suffered a permanent injury");
			this.updateAchievement("ScarsForLife", 1, 1);

			if (this.getFlags().has("PlayerSkeleton") || this.getFlags().has("PlayerZombie"))
			{
				return false;
			}

			return false;
		}
		return true;
	}

	function onOtherActorDeath( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying)
		{
			return;
		}

		if (!this.isGuest() && _victim.getFaction() == this.getFaction() && ("getBackground" in _victim) && _victim.getBackground().getID() == "background.slave" && this.getBackground().getID() != "background.slave")
		{
			return;
		}

		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function kill( _killer = null, _skill = null, _fatalityType = this.Const.FatalityType.None, _silent = false )
	{
		if (!this.Tactical.State.isScenarioMode() && this.World.Assets.m.IsSurvivalGuaranteed && !this.m.Skills.hasSkillOfType(this.Const.SkillType.PermanentInjury) && (this.World.Assets.getOrigin().getID() != "scenario.manhunters" || this.getBackground() != null && this.getBackground().getID() != "background.slave"))
		{
			_fatalityType = this.Const.FatalityType.None;
		}

		this.actor.kill(_killer, _skill, _fatalityType, _silent);
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
		local isResurrectable = _fatalityType == this.Const.FatalityType.None || _fatalityType == this.Const.FatalityType.Disemboweled;
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

				if (appearance.CorpseArmorUpgradeBack != "")
				{
					decal = stub.addSprite("upgrade_back");
					decal.setBrush(appearance.CorpseArmorUpgradeBack);
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

				if (appearance.CorpseArmorUpgradeFront != "")
				{
					decal = stub.addSprite("upgrade_front");
					decal.setBrush(appearance.CorpseArmorUpgradeFront);
				}
			}
		}

		if (_tile != null)
		{
			this.human.onDeath(_killer, _skill, _tile, _fatalityType);
			local corpse = _tile.Properties.get("Corpse");
			corpse.IsPlayer = true;
			corpse.Value = 10.0;
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

			this.World.Statistics.addFallen(this, killedBy);
		}
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
		this.m.Skills.add(this.new("scripts/skills/special/legend_horserider_skill"));

		if (this.Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

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

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.isInReserves() && bro.getSkills().hasSkill("perk.legend_peaceful"))
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
		else if (this.m.Skills.hasSkill("trait.mad"))
		{
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 15 : -15);
		}

		if (_change < 0 && _type == this.Const.MoraleCheckType.MentalAttack && this.m.Skills.hasSkill("trait.superstitious"))
		{
			_difficulty = _difficulty - 10;
		}

		return this.actor.checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);
	}

	function getXPForNextLevel()
	{
		if (this.m.Level >= 7 && ("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getBackground().getID() == "background.slave")
		{
			return this.Const.LevelXP[6];
		}
		else
		{
			return this.m.Level < this.Const.LevelXP.len() ? this.Const.LevelXP[this.m.Level] : this.Const.LevelXP[this.Const.LevelXP.len() - 1];
		}
	}

	function addXP( _xp, _scale = true )
	{
		local isScenarioMode = !(("State" in this.World) && this.World.State != null);

		if (this.m.Level >= this.Const.LevelXP.len() || this.isGuest() || !isScenarioMode && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.m.Level >= 7 && this.getBackground().getID() == "background.slave")
		{
			return;
		}

		if (_scale)
		{
			_xp = _xp * this.Const.Combat.GlobalXPMult;
		}

		if (this.m.Level >= 11)
		{
			_xp = _xp * this.Const.Combat.GlobalXPVeteranLevelMult;
		}

		if (this.getFlags().has("PlayerSkeleton"))
		{
			_xp = _xp * 0.33;
		}

		if (!isScenarioMode)
		{
			if (_scale)
			{
				_xp = _xp * this.World.Assets.m.XPMult;

				if (this.World.Retinue.hasFollower("follower.drill_sergeant"))
				{
					_xp = _xp * this.Math.maxf(1.0, 1.2 - 0.02 * (this.m.Level - 1));
				}
			}

			if (this.World.getPlayerRoster().getSize() < 3)
			{
				_xp = _xp * (1.0 - (3 - this.World.getPlayerRoster().getSize()) * 0.15);
			}
		}

		if (this.getFlags().has("PlayerZombie"))
		{
			_xp = _xp * 0.25;
		}
	//	if (("State" in this.World) && this.World.State != null && this.World.getPlayerRoster().getSize() < 3)
	//	{
	//		_xp = _xp * (1.0 - (3 - this.World.getPlayerRoster().getSize()) * 0.15);
	//	}

		if (this.m.XP + _xp * this.m.CurrentProperties.XPGainMult >= this.Const.LevelXP[this.Const.LevelXP.len() - 1])
		{
			this.m.CombatStats.XPGained += this.Const.LevelXP[this.Const.LevelXP.len() - 1] - this.m.XP;
			this.m.XP = this.Const.LevelXP[this.Const.LevelXP.len() - 1];
			return;
		}
		else if (!isScenarioMode && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.m.XP + _xp * this.m.CurrentProperties.XPGainMult >= this.Const.LevelXP[6] && this.getBackground().getID() == "background.slave")
		{
			this.m.CombatStats.XPGained += this.Const.LevelXP[6] - this.m.XP;
			this.m.XP = this.Const.LevelXP[6];
			return;
		}

		this.m.XP += this.Math.floor(_xp * this.m.CurrentProperties.XPGainMult);
		this.m.CombatStats.XPGained += this.Math.floor(_xp * this.m.CurrentProperties.XPGainMult);
	}

	function unlockPerk( _id )
	{
		if (this.hasPerk(_id))
		{
			return true;
		}

		local perk = this.getBackground().getPerk(_id);

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
		p.onUnlocked();
		this.m.Skills.update();

		if ((this.m.Level >= 11 || this.m.Level >= 7 && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getBackground().getID() == "background.slave") && _id == "perk.student")
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

		local perk = this.getBackground().getPerk(_id);

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

			if ((this.m.Level == 11 || this.m.Level == 7 && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getBackground().getID() == "background.slave") && this.m.Skills.hasSkill("perk.student"))
			{
				++this.m.PerkPoints;
			}

			if (this.m.Level == 11)
			{
				this.updateAchievement("OldAndWise", 1, 1);
			}

			if (this.m.Level > 11 && this.m.VeteranPerks > 0)
			{
				if ((this.m.Level - 1) % this.m.VeteranPerks == 0)
				{
					++this.m.PerkPoints;
				}
			}

			if (this.m.Level == 11 && this.m.Skills.hasSkill("trait.player"))
			{
				this.updateAchievement("TooStubbornToDie", 1, 1);
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

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_surcoat"],
			[1, "mail_shirt"],
			[1, "coat_of_plates"],
			[1, "gambeson"],
			[1, "leather_tunic"],
			[1, "lamellar_harness"],
			[1, "sackcloth"],
			[1, "heavy_lamellar_armor"],
			[1, "basic_mail_shirt"],
			[1, "scale_armor"],
			[1, "coat_of_scales"],
			[1, "linen_tunic"],
			[1, "tattered_sackcloth"],
			[1, "heraldic_mail"],
			[1, "named/black_leather_armor"],
			[1, "named/golden_scale_armor"],
			[1, "named/blue_studded_mail_armor"],
			[1, "named/brown_coat_of_plates_armor"],
			[1, "named/green_coat_of_plates_armor"],
			[1, "reinforced_mail_hauberk"],
			[1, "mail_hauberk"],
			[1, "leather_lamellar"],
		]));

		local item = this.Const.World.Common.pickHelmet([
			[6, ""],
			[1, "hood"],
			[1, "mail_coif"],
			[1, "closed_mail_coif"],
			[1, "reinforced_mail_coif"],
			[1, "kettle_hat"],
			[1, "nasal_helmet"],
			[1, "padded_nasal_helmet"],
			[1, "nasal_helmet_with_mail"],
			[1, "full_helm"],
			[1, "flat_top_helmet"],
			[1, "padded_flat_top_helmet"],
			[1, "flat_top_with_mail"],
			[1, "kettle_hat_with_mail"],
			[1, "kettle_hat_with_closed_mail"],
			[1, "closed_flat_top_with_neckguard"],
			[1, "closed_flat_top_helmet"],
			[1, "closed_flat_top_with_mail"],
			[1, "witchhunter_hat"],
			[1, "named/golden_feathers_helmet"],
			[1, "named/heraldic_mail_helmet"],
			[1, "named/nasal_feather_helmet"],
			[1, "named/norse_helmet"],
			[1, "named/sallet_green_helmet"],
			[1, "named/wolf_helmet"]
		])

		if (item != null)
		{
			this.m.Items.equip(item);
		}

		local r = this.Math.rand(1, 17);

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
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_surcoat"],
			[1, "mail_shirt"],
			[1, "padded_leather"],
			[1, "gambeson"],
			[1, "leather_tunic"],
			[1, "sackcloth"],
			[1, "linen_tunic"],
			[1, "tattered_sackcloth"],
			[1, "ragged_surcoat"],
			[1, "thick_tunic"],
		]));

		local item = this.Const.World.Common.pickHelmet([
			[2, ""],
			[1, "hood"],
			[1, "aketon_cap"],
			[1, "full_aketon_cap"],
			[1, "open_leather_cap"],
			[1, "full_leather_cap"]
		])

		if (item != null)
		{
			this.m.Items.equip(item);
		}


		local r = this.Math.rand(1, 4);

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
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_surcoat"],
			[1, "mail_shirt"],
			[1, "padded_leather"],
			[1, "gambeson"],
			[1, "leather_tunic"],
			[1, "sackcloth"],
			[1, "linen_tunic"],
			[1, "tattered_sackcloth"],
		]));

		local item = this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "hood"],
			[1, "aketon_cap"],
			[1, "full_aketon_cap"]
		])

		if (item != null)
		{
			this.m.Items.equip(item);
		}

		local r = this.Math.rand(1, 2);

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
		local background = this.new("scripts/skills/backgrounds/" + this.Const.CharacterFemaleBackgrounds[this.Math.rand(0, this.Const.CharacterFemaleBackgrounds.len() - 1)]);
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

	function setStartValuesEx( _backgrounds, _addTraits = true, _gender = -1, _addEquipment = true )
	{
		if (this.isSomethingToSee() && this.World.getTime().Days >= 7)
		{
			_backgrounds = this.Const.CharacterPiracyBackgrounds;
		}

		local background = this.new("scripts/skills/backgrounds/" + _backgrounds[this.Math.rand(0, _backgrounds.len() - 1)]);

		if (this.World.LegendsMod.Configs().LegendGenderLevel() == 2)
		{
			background.setGender(_gender);
		}
		this.m.Skills.add(background);

		/*Skill onAdded sets these values
		this.m.Background = background;
		this.m.Ethnicity = this.m.Background.getEthnicity();
		background.buildAttributes();
		*/
		background.buildDescription();

		if (background.isFemaleBackground())
		{
			this.setGender(1);
		}

		local attributes = background.buildPerkTree();
		local maxTraits = 0;

		if (this.getFlags().has("PlayerZombie"))
		{
			this.m.StarWeights = background.buildAttributes("zombie", attributes);
		}
		else if (this.getFlags().has("PlayerSkeleton"))
		{
			this.m.StarWeights = background.buildAttributes("skeleton", attributes);
		}
		else
		{
			this.m.StarWeights = background.buildAttributes(null, attributes);
		}

		background.buildDescription();
		local inTraining = this.new("scripts/skills/traits/intensive_training_trait");

		if (!this.getSkills().hasSkill("trait.intensive_training_trait"))
		{
			this.m.Skills.add(inTraining);
		}

		if (_addTraits)
		{
			local maxTraits = 2;
			local traits = [
				background
			];

			for( local i = 0; i < maxTraits; i = ++i )
			{
				while (true)
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

					if (this.getSkills().hasSkill("trait.intensive_training_trait") && this.getSkills().getSkillByID("trait.intensive_training_trait").isExcluded(trait[0]))
					{
						nextTrait = true;
						break;
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
		}

		if (_addEquipment)
		{
			background.addEquipment();
		}

		if (this.getFlags().has("PlayerZombie"))
		{
			background.setAppearance("zombie");
		}
		else if (this.getFlags().has("PlayerSkeleton"))
		{
			background.setAppearance("skeleton");
		}
		else
		{
			background.setAppearance();
		}

		background.buildDescription(true);
		this.m.Skills.update();
		local p = this.m.CurrentProperties;
		this.m.Hitpoints = p.Hitpoints;

		if (_addTraits)
		{
			this.fillTalentValues(3);
			this.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		}

	}

    function getAlignment()
    {
        return this.m.Alignment;
    }

    // function getCompanyID()
    // {
    //     return this.m.CompanyID;
    // }

	// function setCompanyID( _num )
	// {
	// 	this.m.CompanyID = _num;
	// }

	function fillTalentValues( _num, _force = false )
	{
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);

		if (this.getBackground() != null && this.getBackground().isUntalented() && !_force)
		{
			return;
		}

		local attributes = [];
		local weights = [];
		local totalWeight = 0;

		for (local i = 0; i < this.m.StarWeights.len(); i = ++i)
		{
			if (this.m.Talents[i] != 0 )
			{
				continue;
			}

			if (this.getBackground() != null && this.getBackground().getExcludedTalents().find(i) != null)
			{
				continue;
			}

			if (this.getFlags().has("PlayerZombie") && (i == this.Const.Attributes.Bravery || i == this.Const.Attributes.Fatigue || i == this.Const.Attributes.Initiative))
			{
				continue;
			}
			else if (this.getFlags().has("PlayerSkeleton") && (i == this.Const.Attributes.Bravery || i == this.Const.Attributes.Fatigue || i == this.Const.Attributes.Hitpoints))
			{
				continue;
			}
			attributes.push(i);
			weights.push(this.m.StarWeights[i]);
			totalWeight += this.m.StarWeights[i];
		}

		for( local done = 0; done < _num; done = ++done )
		{
			local weight = this.Math.rand(1, totalWeight);
			local totalhere = 0;

			for( local i = 0; i < attributes.len(); i = ++i )
			{
				if (weight > totalhere && weight <= totalhere + weights[i])
				{
					local r = this.Math.rand(1, 100);
					local j = attributes[i];

					if (r <= 60)
					{
						this.m.Talents[j] = 1;
					}
					else if (r <= 90)
					{
						this.m.Talents[j] = 2;
					}
					else
					{
						this.m.Talents[j] = 3;
					}

					attributes.remove(i);
					totalWeight = totalWeight - weights[i];
					weights.remove(i);
					break;
				}
				else
				{
					totalhere = totalhere + weights[i];
				}

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
			if (this.m.Attributes[i].len() == 0) {
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

		local injury;

		while (candidates.len() != 0)
		{
			local r = this.Math.rand(0, candidates.len() - 1);
			injury = this.new("scripts/skills/" + candidates[r]);

			if (!injury.isValid(this))
			{
				candidates.remove(r);
				injury = null;
				continue;
			}

			break;
		}

		if (injury == null)
		{
			return null;
		}

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
		this.m.IsAbleToDie = false;
		this.Tactical.getRetreatRoster().add(this);
		this.removeFromMap();
		this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.PlayerRetreated);
	}

	function copyFormation( _from, _to )
	{
		this.m.Formations.copy(_from, _to);
	}

	function saveFormation()
	{
		this.m.Formations.savePosition(this.m.PlaceInFormation);
		this.m.Formations.saveItems(this.getItems());
	}

	function setFormation( _i, _stash )
	{
		if (_i == this.m.Formations.getCurrentIndex())
		{
			return [[], []];
		}

		this.m.Formations.setFormation(_i);
		this.setPlaceInFormation(this.m.Formations.getPosition());
		local items = this.m.Formations.getItems();
		local eTransfer = [];
		local bTransfer = [];

		foreach( itemId in items )
		{
			local item = _stash.remove(itemId);

			if (item == null)
			{
				this.logInfo("setFormation::Items; could not find item for " + itemId);
				continue;
			}
			eTransfer.push(item);

			//this.m.Items.equip(item);
		}

		local bags = this.m.Formations.getBags();

		foreach( itemId in bags )
		{
			local item = _stash.remove(itemId);

			if (item == null)
			{
				this.logInfo("setFormation::Bags; could not find item for " + itemId);
				continue;
			}

			bTransfer.push(item);
		}
		return [eTransfer, bTransfer];
	}

	function getStashModifier()
	{
		local broStash = this.getBackground().getModifiers().Stash;
		local item = this.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

		if (item != null)
		{
			broStash = broStash + item.getStashModifier();
		}

		local skills =
		[
			"perk.legend_skillful_stacking",
			"perk.legend_efficient_packing"
		];

		foreach( s in skills )
		{
			local skill = this.getSkills().getSkillByID(s);
			if (skill != null)
			{
				broStash += skill.getModifier();
			}
		}

		return broStash;
	}

	function getAmmoModifier()
	{
		local mod = this.getBackground().getModifiers().Ammo;
		local skills = [
			"perk.legend_ammo_bundles",
			"perk.legend_ammo_binding"
		];

		foreach( s in skills )
		{
			local skill = this.getSkills().getSkillByID(s);

			if (skill != null)
			{
				mod = mod + skill.getModifier();
			}
		}

		return mod;
	}

	function getArmorPartsModifier()
	{
		local mod = this.getBackground().getModifiers().ArmorParts;
		local skills = [
			"perk.legend_tools_spares",
			"perk.legend_tools_drawers"
		];

		foreach( s in skills )
		{
			local skill = this.getSkills().getSkillByID(s);

			if (skill != null)
			{
				mod += skill.getModifier();
			}
		}

		return mod;
	}

	function getMedsModifier()
	{
		local mod = this.getBackground().getModifiers().Meds;
		local skills = [
			"perk.legend_med_packages",
			"perk.legend_med_ingredients"
		];

		foreach( s in skills )
		{
			local skill = this.getSkills().getSkillByID(s);

			if (skill != null)
			{
				mod = mod + skill.getModifier();
			}
		}

		return mod;
	}

	function getBarterModifier()
	{
		local mod = this.getBackground().getModifiers().Barter;
		local skills = [
			"perk.legend_barter_trustworthy",
			"perk.legend_barter_convincing",
			"perk.legend_barter_greed"
		];

		foreach( s in skills )
		{
			local skill = this.getSkills().getSkillByID(s);

			if (skill != null)
			{
				mod += skill.getModifier();
			}
		}

		return mod;
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

	function getDeadTraits()
	{
		local skills = this.getSkills().query(this.Const.SkillType.Trait, false, true);
		local list = [];

		foreach( i, s in skills )
		{
			if (s.isType(this.Const.SkillType.StatusEffect) || s.isType(this.Const.SkillType.Active) || s.isType(this.Const.SkillType.Racial) || s.isType(this.Const.SkillType.Special) || s.isType(this.Const.SkillType.Perk) || s.isType(this.Const.SkillType.Terrain) || s.isType(this.Const.SkillType.Injury) || s.isType(this.Const.SkillType.PermanentInjury) || s.isType(this.Const.SkillType.SemiInjury) || s.isType(this.Const.SkillType.DrugEffect) || s.isType(this.Const.SkillType.DamageOverTime))
			{
				continue;
			}

			list.append(s.getIcon());
		}

		for( local i = list.len(); i < 4; i++ )
		{
			list.append("");
		}

		return list;
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (this.m.Sound[_type].len() == 0)
		{
			return;
		}

		local volume = 1.0;

		if (this.getBackground() != null && this.getBackground().isFemaleBackground())
		{
			if (this.m.VoiceSet > this.Const.WomanSounds.len() - 1)
			{
				this.m.VoiceSet = this.Math.rand(0, this.Const.WomanSounds.len() - 1);
			}
			volume *= this.Const.WomanSounds[this.m.VoiceSet].Volume;
		}
		else
		{
			volume *= this.Const.HumanSounds[this.m.VoiceSet].Volume;
		}

		this.Sound.play(this.m.Sound[_type][this.Math.rand(0, this.m.Sound[_type].len() - 1)], volume, this.getPos(), _pitch);
	}

	function getRemoveLayerTooltip(_slot, _layer)
	{
		local armor = this.getItems().getItemAtSlot(_slot);
		local title = "";

		switch(_layer)
		{
		case 0:
			title = _slot == this.Const.ItemSlot.Body ? "Chain Mail Layer" : "Helmet Layer";
			break;

		case 1:
			title = _slot == this.Const.ItemSlot.Body ? "Plate Layer" : "Top Layer";
			break;

		case 2:
			title = _slot == this.Const.ItemSlot.Body ? "Tabard Layer" : "Vanity Layer";
			break;

		case 3:
			title = "Cloak Layer";
			break;

		case 4:
			title = "Upgrade Attachment Layer";
			break;

		case 5:
			title = "Rune Layer";
			break;
		}

		local tt = [
			{
				id = 1,
				type = "title",
				text = title
			}
		];

		if (armor == null)
		{
			tt.push({
				id = 2,
				type = "description",
				text = _slot == this.Const.ItemSlot.Body ? "A base piece of armor, such as a tunic or surcoat, needs to be worn in order to attach a layer" : "A base piece of helmet, such as a hood or scarf, needs to be worn in order to attach a layer"
			});
			return tt;
		}

		if (armor.upgradeIsBlocked(_layer))
		{
			tt.push({
				id = 2,
				type = "description",
				text = _slot == this.Const.ItemSlot.Body ? "The layer can not be attached to this piece of armor." : "The layer can not be attached to this helmet"
			});
			return tt;
		}

		local upgrade = armor.getUpgrade(_layer);

		if (upgrade == null)
		{
			tt.push({
				id = 2,
				type = "description",
				text = "This layer is vacant. Right-click or drag a layer piece from the stash to attach it to this armor"
			});
			return tt;
		}

		tt.extend(upgrade.getTooltip());
		tt.push({
			id = 1,
			type = "hint",
			icon = "ui/icons/mouse_right_button.png",
			text = "UnEquip layer"
		});

		foreach( t in tt )
		{
			if (t.id != 65)
			{
				continue;
			}

			t.text = "Click this button to remove the attached layer and return it to the stash.";
			break;
		}

		return tt;
	}


	function TherianthropeInfection(_killer)
	{
		if (!this.World.LegendsMod.Configs().LegendTherianthropyEnabled())
		{
			return;
		}

		local TherianthropyGroup = [
							[this.Const.Perks.PerkDefs.LegendTrueForm],
							[],
							[this.Const.Perks.PerkDefs.LegendSurpressUrges],
							[],
							[this.Const.Perks.PerkDefs.LegendControlInstincts],
							[],
							[this.Const.Perks.PerkDefs.LegendMasterAnger]
					];

		if (_killer.getSkills().hasSkill("injury.legend_aperthropy") && !this.getSkills().hasSkill("injury.legend_aperthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_aperthropy_injury"));
			this.getBackground().addPerkGroup(TherianthropyGroup);
			this.logDebug(this.getName() + " gained aperthropy");
		}

		if (_killer.getSkills().hasSkill("injury.legend_arborthropy") && !this.getSkills().hasSkill("injury.legend_arborthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_arborthropy_injury"));
			this.getBackground().addPerkGroup(TherianthropyGroup);
			this.logDebug(this.getName() + " gained arborthropy");
		}

		if (_killer.getSkills().hasSkill("injury.legend_lycanthropy") && !this.getSkills().hasSkill("injury.legend_lycanthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_lycanthropy_injury"));
			this.getBackground().addPerkGroup(TherianthropyGroup);
			this.logDebug(this.getName() + " gained lycanthropy");
		}

		if (_killer.getSkills().hasSkill("injury.legend_ursathropy") && !this.getSkills().hasSkill("injury.legend_ursathropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_ursathropy_injury"));
			this.getBackground().addPerkGroup(TherianthropyGroup);
			this.logDebug(this.getName() + " gained ursathropy");
		}
	}

	function TherianthropeInfectionRandom()
	{

		if (!this.World.LegendsMod.Configs().LegendTherianthropyEnabled())
		{
			return;
		}

		local TherianthropyGroup = [
							[this.Const.Perks.PerkDefs.LegendTrueForm],
							[],
							[this.Const.Perks.PerkDefs.LegendSurpressUrges],
							[],
							[this.Const.Perks.PerkDefs.LegendControlInstincts],
							[],
							[this.Const.Perks.PerkDefs.LegendMasterAnger]
					];
		local r = this.Math.rand(1,99);

		if (r <= 50 && !this.getSkills().hasSkill("injury.legend_lycanthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_lycanthropy_injury"));
			this.getBackground().addPerkGroup(TherianthropyGroup);
			this.logDebug(this.getName() + " gained lycanthropy");
		}

		if (r > 50 && r <= 75 && !this.getSkills().hasSkill("injury.legend_aperthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_aperthropy_injury"));
			this.getBackground().addPerkGroup(TherianthropyGroup);
			this.logDebug(this.getName() + " gained aperthropy");
		}

		if (r > 75 && r <= 90 && !this.getSkills().hasSkill("injury.legend_arborthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_arborthropy_injury"));
			this.getBackground().addPerkGroup(TherianthropyGroup);
			this.logDebug(this.getName() + " gained arborthropy");
		}

		if (r > 90 && r <= 98 && !this.getSkills().hasSkill("injury.legend_ursathropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_ursathropy_injury"));
			this.getBackground().addPerkGroup(TherianthropyGroup);
			this.logDebug(this.getName() + " gained ursathropy");
		}

		if (r == 99 && !this.getSkills().hasSkill("injury.legend_vermesthropy"))
		{
			this.getSkills().add(this.new("scripts/skills/injury_permanent/legend_vermesthropy_injury"));
			this.getBackground().addPerkGroup(TherianthropyGroup);
			this.logDebug(this.getName() + " gained vermesthropy");
		}
	}

	function onSerialize( _out )
	{
		this.human.onSerialize(_out);
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
		this.m.LifetimeStats.Tags.onSerialize(_out);
		_out.writeBool(this.m.IsTryoutDone);
		this.m.Formations.onSerialize(_out);
		_out.writeU8(this.m.VeteranPerks);
		_out.writeBool(this.m.IsCommander);
		_out.writeString(this.m.CampAssignment);
		_out.writeF32(this.m.LastCampTime);
		_out.writeBool(this.m.InReserves);
		_out.writeU8(this.m.CompanyID);
	}

	function onDeserialize( _in )
	{
		if (_in.getMetaData().getVersion() >= 59)
		{
			this.human.onDeserialize(_in);
		}
		else
		{
			this.actor.onDeserialize(_in);
		}

		this.m.Surcoat = null;
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
				this.m.VoiceSet = this.Math.rand(0, this.Const.WomanSounds.len() - 1);
			}
		}

		this.m.PlaceInFormation = _in.readU8();
		this.m.LifetimeStats.Kills = _in.readU32();
		this.m.LifetimeStats.Battles = _in.readU32();
		this.m.LifetimeStats.BattlesWithoutMe = _in.readU32();

		if (_in.getMetaData().getVersion() >= 37)
		{
			this.m.LifetimeStats.MostPowerfulVanquishedType = _in.readU16();
		}

		this.m.LifetimeStats.MostPowerfulVanquished = _in.readString();
		this.m.LifetimeStats.MostPowerfulVanquishedXP = _in.readU16();
		this.m.LifetimeStats.FavoriteWeapon = _in.readString();
		this.m.LifetimeStats.FavoriteWeaponUses = _in.readU32();
		this.m.LifetimeStats.CurrentWeaponUses = _in.readU32();

		if (_in.getMetaData().getVersion() >= 57)
		{
			this.m.LifetimeStats.Tags.onDeserialize(_in);
		}

		this.m.IsTryoutDone = _in.readBool();
		this.m.Skills.update();

		if (_in.getMetaData().getVersion() >= 46)
		{
			this.m.Formations.onDeserialize(_in);
		}

		if (_in.getMetaData().getVersion() >= 47)
		{
			this.m.VeteranPerks = _in.readU8();

			if (this.m.VeteranPerks == 0)
			{
				this.m.VeteranPerks = 5;
			}
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

		if (_in.getMetaData().getVersion() >= 54)
		{
			this.m.InReserves = _in.readBool();
		}

		this.m.CompanyID = _in.readU8();
	}

});

