::mods_hookBaseClass("entity/tactical/actor", function(o) {
    while(!("BloodSaturation" in o.m)) o = o[o.SuperName]; // find the base class
    if(!("_mod_legend" in o))
    {
        o._mod_legend <- true;// only override the methods once per base instance
        o.m.BloodSaturation = 1.5;
        o.m.DeathBloodAmount = 1.5;
        o.m.BloodPoolScale = 1.25;
		o.m.RiderID <- "";
		o.m.FlatOnKillOtherActorModifier <- 0;
		o.m.PercentOnKillOtherActorModifier <- 1.0;
    }

	o.onOtherActorDeath <- function ( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying)
		{
			return;
		}

		if (_victim.getXPValue() <= 0)
		{
			return;
		}

		if (_victim.getFaction() == this.getFaction() && _victim.getCurrentProperties().TargetAttractionMult > 0.5 && this.getCurrentProperties().IsAffectedByDyingAllies)
		{
			local difficulty = this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow);
			if (_killer != null)
			{
				difficulty = this.Math.floor((this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow)) * _killer.getPercentOnKillOtherActorModifier()) + _killer.getFlatOnKillOtherActorModifier();
			}
			this.checkMorale(-1, difficulty, this.Const.MoraleCheckType.Default, "", true);
		}
		else if (this.getAlliedFactions().find(_victim.getFaction()) == null)
		{
			local difficulty = this.Const.Morale.EnemyKilledBaseDifficulty + _victim.getXPValue() * this.Const.Morale.EnemyKilledXPMult - this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.EnemyKilledDistancePow);

			if (_killer != null && _killer.isAlive() && _killer.getID() == this.getID())
			{
				difficulty = difficulty + this.Const.Morale.EnemyKilledSelfBonus;
			}

			this.checkMorale(1, difficulty);
		}
	}

	o.getPercentOnKillOtherActorModifier <- function ()
	{
		return this.m.PercentOnKillOtherActorModifier;
	}
	o.modifyPercentOnKillOtherActorModifier <- function ( _value )
	{
		this.m.PercentOnKillOtherActorModifier *= _value;
	}
	o.getFlatOnKillOtherActorModifier <- function ()
	{
		return this.m.FlatOnKillOtherActorModifier;
	}
	o.modifyFlatOnKillOtherActorModifier <- function ( _value )
	{
		this.m.FlatOnKillOtherActorModifier += _value;
	}

	o.isStabled <- function ()
	{
		return false;
	}

    local fn = o.onMovementFinish;
    o.onMovementFinish = function (_tile)
    {
        fn(_tile);
        this.m.Skills.MovementCompleted(_tile);
    }

    o.isArmedWithMagicStaff <- function()
	{
		local item = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return item != null && item.isItemType(this.Const.Items.ItemType.MagicStaff);
	}

    o.equipItem <- function( _item)
    {
        return this.getItems().equip(_item);
    }

    o.bagItem <- function (_item)
    {
        this.getItems().addToBag(_item);
    }

    o.setArmor <- function (_bodyPart, _value)
    {
        this.m.BaseProperties.Armor[_bodyPart] = _value;
    }

	o.onMissed = function ( _attacker, _skill, _dontShake = false )
	{
		if (!_dontShake && !this.isHiddenToPlayer() && this.m.IsShakingOnHit && (!_skill.isRanged() || _attacker.getTile().getDistanceTo(this.getTile()) == 1) && !this.Tactical.getNavigator().isTravelling(this))
		{
			this.Tactical.getShaker().shake(this, _attacker.getTile(), 4);
		}

		if (this.m.CurrentProperties.IsRiposting && _attacker != null && !_attacker.isAlliedWith(this) && _attacker.getTile().getDistanceTo(this.getTile()) == 1 && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _attacker.getID() && _skill != null && !_skill.isIgnoringRiposte())
		{
			local skill = this.m.Skills.getAttackOfOpportunity();

			if (skill != null)
			{
				local info = {
					User = this,
					Skill = skill,
					TargetTile = _attacker.getTile()
				};
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.Const.Combat.RiposteDelay, this.onRiposte.bindenv(this), info);
			}
		}


		if (this.m.CurrentProperties.IsParrying && _attacker != null && !_attacker.isAlliedWith(this) && _attacker.getTile().getDistanceTo(this.getTile()) == 1 && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _attacker.getID() && _skill != null && !_skill.isIgnoringRiposte())
		{

			_attacker.getSkills().add(this.new("scripts/skills/effects/legend_parried_effect"));
		}

		if (_skill != null && !_skill.isRanged())
		{
			this.m.Fatigue = this.Math.min(this.getFatigueMax(), this.Math.round(this.m.Fatigue + this.Const.Combat.FatigueLossOnBeingMissed * this.m.CurrentProperties.FatigueEffectMult * this.m.CurrentProperties.FatigueLossOnBeingMissedMult));
		}

		this.m.Skills.onMissed(_attacker, _skill);
	}

    o.resetPerks <- function ()
    {
        local perks =  0;
		local skills = _actor.getSkills();

		foreach( skill in skills.m.Skills)
		{
			if (!skill.isGarbage() && skill.isType(this.Const.SkillType.Perk) && !skill.isType(this.Const.SkillType.Racial))
			{
				perks += 1;
			}
		}

		perks = perks +this.m.PerkPoints;
		this.logDebug("perks before: "+ perks);
		local hasStudent = false;
		local hasGifted = false;

		if (this.getLevel() >= 11 && this.getSkills().hasSkill("perk.student"))
		{
			perks = perks - 1;
			hasStudent = true;
		}
		if (this.getSkills().hasSkill("perk.gifted"))
		{
			perks = perks - 1;
			hasGifted = true;
		}

		local freePerkPointsSpentFromOrigin = 0; // This is if we want further rows to be unlocked
		// set everything to 0 just in case
		this.m.PerkPoints = 0;
		this.m.PerkPointsSpent = 0;
		this.getSkills().removeByType(this.Const.SkillType.Perk);


		switch(this.World.Assets.getOrigin().getID()) {
		case "scenario.legends_rangers":
			if (this.getBackground().getID() == "background.legend_commander_ranger")
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_footwork"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_2"));
				perks = perks - 3;
				freePerkPointsSpentFromOrigin = 3;
			}
			else
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
			}
			break;
		case "scenario.legends_assassin":
			if (this.getBackground().getID() == "background.legend_commander_assassin")
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_backstabber"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_hidden"));
				perks = perks - 2;
				freePerkPointsSpentFromOrigin = 2;
			}
			else
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_hidden"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
			}
			break;
		case "scenario.legends_berserker":
			if (this.getBackground().getID() == "background.legend_commander_berserker")
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_berserk"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_bearform")); //?can't see this perk but it's definitely there because without taking it into account the amount of PPs is inaccurate
				perks = perks - 2;
				freePerkPointsSpentFromOrigin = 2;
				}
			else
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_berserk"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
			}
			break;
		case "scenario.legends_crusader":
			if (this.getBackground().getID() == "background.legend_commander_crusader")
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_fortified_mind"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_rebound"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_1"));
				perks = perks - 3;
				freePerkPointsSpentFromOrigin = 3;
			}
			else
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_fortified_mind"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
			}
			break;
		case "scenario.legends_druid":
			if (this.getBackground().getID() == "background.legend_commander_druid")
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_surpress_urges"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
			}
			break;
		case "scenario.legends_inquisition":
			this.getSkills().add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
			perks = perks - 1;
			freePerkPointsSpentFromOrigin = 1;
			break;
		case "scenario.legends_necro":
			if (this.getBackground().getID() == "background.legend_commander_necro")
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_1"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
				if (this.World.LegendsMod.Configs().LegendMagicEnabled())
				{
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_brink_of_death"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_siphon"));
					perks = perks - 2;
					freePerkPointsSpentFromOrigin = 3;
				}

			}
			else if (this.getSkills().hasSkill("injury.legend_rotten_flesh"))
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_zombie_bite"));
				perks = perks - 1;
				//freePerkPointsSpentFromOrigin = 1; //not an actual perk
			}
			break;
		case "scenario.legends_noble":
			if (this.getBackground().getID() == "background.legend_commander_noble")
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_2"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_4"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_rally_the_troops"));
				perks = perks - 4;
				freePerkPointsSpentFromOrigin = 4;
			}
			else
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
			}
			break;
		case "scenario.legends_rangers":
			if (this.getBackground().getID() == "background.legend_commander_ranger")
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_footwork"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_2"));
				perks = perks - 3;
				freePerkPointsSpentFromOrigin = 3;
			}
			else
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
			}
			break;
		case "scenario.legends_seer":
			if (this.getBackground().getID() == "background.legend_commander_witch")
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_daze"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_1"));
				perks = perks - 2;
				freePerkPointsSpentFromOrigin = 2;
				if (this.World.LegendsMod.Configs().LegendMagicEnabled())
				{
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_magic_missile"));
					perks = perks - 1;
					freePerkPointsSpentFromOrigin = 3;
				}

			}
			if (this.getLevel() < 11)
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_student"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
			}
			break;
		case "scenario.legends_sisterhood":
			if (this.getBackground().getID() == "background.legend_commander_vala")
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_roster_1"));
				this.getSkills().add(this.new("scripts/skills/perks/perk_hold_out"));
				perks = perks - 2;
				freePerkPointsSpentFromOrigin = 2;
			}
			else
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_hold_out"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
			}
			break;
		case "scenario.legends_troupe":
			this.getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
			perks = perks - 1;
			freePerkPointsSpentFromOrigin = 1;
			break;
		case "scenario.trader":
			if (!this.getBackground().isCombatBackground())
			{
				this.getSkills().add(this.new("scripts/skills/perks/perk_legend_pacifist"));
				perks = perks - 1;
				freePerkPointsSpentFromOrigin = 1;
			}
			break;
		default:
		}

		// Witch gets
		if (this.getBackground().getID() == "background.legend_witch" && this.World.LegendsMod.Configs().LegendMagicEnabled())
		{
			this.getSkills().add(this.new("scripts/skills/perks/perk_legend_magic_missile"));
			perks = perks - 1;
		}





		//this.m.PerkPointsSpent += freePerkPointsSpentFromOrigin; // We leave this commented out for now
		this.m.PerkPoints = perks;

		if (hasStudent)
		{
			this.m.PerkPointsSpent += 1;
			this.getSkills().add(this.new("scripts/skills/perks/perk_student"));
		}
		if (hasGifted)
		{
			this.m.PerkPointsSpent += 1;
			local giftedPerk = this.new("scripts/skills/perks/perk_gifted");
			giftedPerk.m.IsApplied = true;
			this.getSkills().add(giftedPerk);
		}
    }

	o.changeMorale <- function( _change, _showIconBeforeMoraleIcon = "", _noNewLine = false)
	{
		local oldMoraleState = this.m.MoraleState;
		this.m.MoraleState = _change;
		this.m.FleeingRounds = 0;

		if (oldMoraleState == this.Const.MoraleState.Fleeing && this.m.IsActingEachTurn)
		{
			if (this.m.IsUsingZoneOfControl)
			{
				this.getTile().addZoneOfControl(this.getFaction());
			}

			if (this.isPlayerControlled() || !this.isHiddenToPlayer())
			{
				if (_noNewLine)
				{
					this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " has rallied");
				}
				else
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this) + " has rallied");
				}
			}
		}
		else if (this.m.MoraleState == this.Const.MoraleState.Fleeing)
		{
			if (this.m.IsActingEachTurn && this.m.IsUsingZoneOfControl)
			{
				this.getTile().removeZoneOfControl(this.getFaction());
			}

			this.m.Skills.removeByID("effects.shieldwall");
			this.m.Skills.removeByID("effects.spearwall");
			this.m.Skills.removeByID("effects.riposte");
			this.m.Skills.removeByID("effects.return_favor");
			this.m.Skills.removeByID("effects.indomitable");
		}

		local morale = this.getSprite("morale");

		if (this.Const.MoraleStateBrush[this.m.MoraleState].len() != 0 && morale != null )
		{
			if (this.m.MoraleState == this.Const.MoraleState.Confident)
			{
				morale.setBrush(this.m.ConfidentMoraleBrush);
			}
			else
			{
				morale.setBrush(this.Const.MoraleStateBrush[this.m.MoraleState]);
			}

			morale.Visible = true;
		}
		else
		{
			morale.Visible = false;
		}

		if (this.isPlayerControlled() || !this.isHiddenToPlayer())
		{
			if (_noNewLine)
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + this.Const.MoraleStateEvent[this.m.MoraleState]);
			}
			else
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this) + this.Const.MoraleStateEvent[this.m.MoraleState]);
			}

			if (_showIconBeforeMoraleIcon != "")
			{
				this.Tactical.spawnIconEffect(_showIconBeforeMoraleIcon, this.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			}

			if (_change > 0)
			{
				this.Tactical.spawnIconEffect(this.Const.Morale.MoraleUpIcon, this.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			}
			else
			{
				this.Tactical.spawnIconEffect(this.Const.Morale.MoraleDownIcon, this.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			}
		}

		this.m.Skills.update();
		this.setDirty(true);

		if (this.m.MoraleState == this.Const.MoraleState.Fleeing && this.Tactical.TurnSequenceBar.getActiveEntity() != this)
		{
			this.Tactical.TurnSequenceBar.pushEntityBack(this.getID());
		}

		if (this.m.MoraleState == this.Const.MoraleState.Fleeing)
		{
			local actors = this.Tactical.Entities.getInstancesOfFaction(this.getFaction());

			if (actors != null)
			{
				foreach( a in actors )
				{
					if (a.getID() != this.getID())
					{
						a.onOtherActorFleeing(this);
					}
				}
			}
		}
	}


	o.checkMorale = function( _change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		if (!this.isAlive() || this.isDying())
		{
			return false;
		}

		if (this.m.MoraleState == this.Const.MoraleState.Ignore)
		{
			return false;
		}

		if (_change > 0 && this.m.MoraleState == this.Const.MoraleState.Confident)
		{
			return false;
		}

		if (_change < 0 && this.m.MoraleState == this.Const.MoraleState.Fleeing)
		{
			return false;
		}

		if (_change > 0 && this.m.MoraleState >= this.m.MaxMoraleState)
		{
			return false;
		}

		if (_change == 1 && this.m.MoraleState == this.Const.MoraleState.Fleeing)
		{
			return false;
		}

		local myTile = this.getTile();

		if (this.isPlayerControlled() && _change > 0 && (myTile.SquareCoords.X == 0 || myTile.SquareCoords.Y == 0 || myTile.SquareCoords.X == 31 || myTile.SquareCoords.Y == 31))
		{
			return false;
		}

		_difficulty = _difficulty * this.getCurrentProperties().MoraleEffectMult;
		local bravery = (this.getBravery() + this.getCurrentProperties().MoraleCheckBravery[_type]) * this.getCurrentProperties().MoraleCheckBraveryMult[_type];

		if (bravery > 500)
		{
			if (_change != 0)
			{
				return false;
			}
			else
			{
				return true;
			}
		}

		local numOpponentsAdjacent = 0;
		local numAlliesAdjacent = 0;
		local threatBonus = 0;

		for( local i = 0; i != 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = myTile.getNextTile(i);

				if (tile.IsOccupiedByActor && tile.getEntity().getMoraleState() != this.Const.MoraleState.Fleeing)
				{
					if (tile.getEntity().isAlliedWith(this))
					{
						numAlliesAdjacent = ++numAlliesAdjacent;
					}
					else
					{
						numOpponentsAdjacent = ++numOpponentsAdjacent;
						threatBonus = threatBonus + tile.getEntity().getCurrentProperties().Threat;
					}
				}
			}
		}

		if (_change > 0)
		{
			if (this.Math.rand(1, 100) > this.Math.minf(95, bravery + _difficulty - numOpponentsAdjacent * this.Const.Morale.OpponentsAdjacentMult - threatBonus))
			{
				return false;
			}
		}
		else if (_change < 0)
		{
			if (this.Math.rand(1, 100) <= this.Math.minf(95, bravery + _difficulty - numOpponentsAdjacent * this.Const.Morale.OpponentsAdjacentMult + numAlliesAdjacent * this.Const.Morale.AlliesAdjacentMult - threatBonus))
			{
				return false;
			}
		}
		else if (this.Math.rand(1, 100) <= this.Math.minf(95, bravery + _difficulty - numOpponentsAdjacent * this.Const.Morale.OpponentsAdjacentMult + numAlliesAdjacent * this.Const.Morale.AlliesAdjacentMult - threatBonus))
		{
			return true;
		}
		else
		{
			return false;
		}

		this.changeMorale(this.Math.min(this.Const.MoraleState.Confident, this.Math.max(0, this.m.MoraleState + _change)));
		return true;
	}

	local oacFn = o.onAppearanceChanged;
	o.onAppearanceChanged = function( _appearance, _setDirty = true )
	{
		oacFn(_appearance, _setDirty);

		if (this.hasSprite("helmet_vanity_lower"))
		{
			if (_appearance.HelmetLayerVanityLower.len() != 0 && !this.m.IsHidingHelmet)
			{
				local helmet = this.getSprite("helmet_vanity_lower");
				helmet.setBrush(_appearance.HelmetLayerVanityLower);
				helmet.Color = _appearance.HelmetColor;
				helmet.Visible = true;
			}
			else
			{
				this.getSprite("helmet_vanity_lower").Visible = false;
			}
		}

		if (this.hasSprite("helmet_helm"))
		{
			if (_appearance.HelmetLayerHelm.len() != 0 && !this.m.IsHidingHelmet)
			{
				local helmet = this.getSprite("helmet_helm");
				helmet.setBrush(_appearance.HelmetLayerHelm);
				helmet.Color = _appearance.HelmetColor;
				helmet.Visible = true;
			}
			else
			{
				this.getSprite("helmet_helm").Visible = false;
			}
		}

		if (this.hasSprite("helmet_top"))
		{
			if (_appearance.HelmetLayerTop.len() != 0 && !this.m.IsHidingHelmet)
			{
				local helmet = this.getSprite("helmet_top");
				helmet.setBrush(_appearance.HelmetLayerTop);
				helmet.Color = _appearance.HelmetColor;
				helmet.Visible = true;
			}
			else
			{
				this.getSprite("helmet_top").Visible = false;
			}
		}

		if (this.hasSprite("helmet_vanity"))
		{
			if (_appearance.HelmetLayerVanity.len() != 0 && !this.m.IsHidingHelmet)
			{
				local helmet = this.getSprite("helmet_vanity");
				helmet.setBrush(_appearance.HelmetLayerVanity);
				helmet.Color = _appearance.HelmetColor;
				helmet.Visible = true;
			}
			else
			{
				this.getSprite("helmet_vanity").Visible = false;
			}
		}

		if (this.hasSprite("armor_layer_chain"))
		{
				if (_appearance.ArmorLayerChain.len() != 0)
			{
				local armor = this.getSprite("armor_layer_chain");
				armor.setBrush(_appearance.ArmorLayerChain);
				armor.Visible = true;
			}
			else
			{
				this.getSprite("armor_layer_chain").Visible = false;
			}
		}

		if (this.hasSprite("armor_layer_plate"))
		{
			if (_appearance.ArmorLayerPlate.len() != 0)
			{
				local armor = this.getSprite("armor_layer_plate");
				armor.setBrush(_appearance.ArmorLayerPlate);
				armor.Visible = true;
			}
			else
			{
				this.getSprite("armor_layer_plate").Visible = false;
			}
		}

		if (this.hasSprite("armor_layer_tabbard"))
		{
			if (_appearance.ArmorLayerTabbard.len() != 0)
			{
				local armor = this.getSprite("armor_layer_tabbard");
				armor.setBrush(_appearance.ArmorLayerTabbard);
				armor.Visible = true;
			}
			else
			{
				this.getSprite("armor_layer_tabbard").Visible = false;
			}
		}

		if (this.hasSprite("armor_layer_cloak"))
		{
			if (_appearance.ArmorLayerCloak.len() != 0)
			{
				local armor = this.getSprite("armor_layer_cloak");
				armor.setBrush(_appearance.ArmorLayerCloak);
				armor.Visible = true;
			}
			else
			{
				this.getSprite("armor_layer_cloak").Visible = false;
			}
		}


	}

	o.kill <- function (_killer = null, _skill = null, _fatalityType = this.Const.FatalityType.None, _silent = false)
	{
		if (!this.isAlive())
		{
			return;
		}

		if (_killer != null && !_killer.isAlive())
		{
			_killer = null;
		}

		if (this.m.IsMiniboss && !this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("GiveMeThat", 1, 1);
		}

		this.m.IsDying = true;
		local isReallyDead = this.isReallyKilled(_fatalityType);

		if (!isReallyDead)
		{
			this.TherianthropeInfection( _killer );
			_fatalityType = this.Const.FatalityType.Unconscious;
			this.logDebug(this.getName() + " is unconscious.");
		}
		else
		{
			this.logDebug(this.getName() + " has died.");
		}

		if (!_silent)
		{
			this.playSound(this.Const.Sound.ActorEvent.Death, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] * this.m.SoundVolumeOverall, this.m.SoundPitch);
		}

		local myTile = this.isPlacedOnMap() ? this.getTile() : null;
		local tile = this.findTileToSpawnCorpse(_killer);
		this.m.Skills.onDeath();
		this.onDeath(_killer, _skill, tile, _fatalityType);

		if (!this.Tactical.State.isFleeing() && _killer != null)
		{
			_killer.onActorKilled(this, tile, _skill);
		}

		if (_killer != null && !_killer.isHiddenToPlayer() && !this.isHiddenToPlayer())
		{
			if (isReallyDead)
			{
				if (_killer.getID() != this.getID())
				{
					this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_killer) + " has killed " + this.Const.UI.getColorizedEntityName(this));
				}
				else
				{
					this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " has died");
				}
			}
			else if (_killer.getID() != this.getID())
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_killer) + " has struck down " + this.Const.UI.getColorizedEntityName(this));
			}
			else
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " is struck down");
			}
		}

		if (!this.Tactical.State.isFleeing() && myTile != null)
		{
			local actors = this.Tactical.Entities.getAllInstances();

			foreach( i in actors )
			{
				foreach( a in i )
				{
					if (a.getID() != this.getID())
					{
						a.onOtherActorDeath(_killer, this, _skill);
					}
				}
			}
		}

		if (!this.isHiddenToPlayer())
		{
			if (tile != null)
			{
				if (_fatalityType == this.Const.FatalityType.Decapitated)
				{
					this.spawnDecapitateSplatters(tile, 1.0 * this.m.DecapitateBloodAmount);
				}
				else if (_fatalityType == this.Const.FatalityType.Smashed && (this.getFlags().has("human") || this.getFlags().has("zombie_minion")))
				{
					this.spawnSmashSplatters(tile, 1.0);
				}
				else
				{
					this.spawnBloodSplatters(tile, this.Const.Combat.BloodSplattersAtDeathMult * this.m.DeathBloodAmount);

					if (!this.getTile().isSameTileAs(tile))
					{
						this.spawnBloodSplatters(this.getTile(), this.Const.Combat.BloodSplattersAtOriginalPosMult);
					}
				}
			}
			else if (myTile != null)
			{
				this.spawnBloodSplatters(this.getTile(), this.Const.Combat.BloodSplattersAtDeathMult * this.m.DeathBloodAmount);
			}
		}

		if (tile != null)
		{
			this.spawnBloodPool(tile, this.Math.rand(this.Const.Combat.BloodPoolsAtDeathMin, this.Const.Combat.BloodPoolsAtDeathMax));
		}

		this.m.IsTurnDone = true;
		this.m.IsAlive = false;

		if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull())
		{
			this.m.WorldTroop.Party.removeTroop(this.m.WorldTroop);
		}

		if (!this.Tactical.State.isScenarioMode())
		{
			this.World.Contracts.onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);
			this.World.Events.onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);
		}

		if (this.isPlayerControlled())
		{
			if (isReallyDead)
			{
				if (this.isGuest())
				{
					this.World.getGuestRoster().remove(this);
				}
				else
				{
					this.World.getPlayerRoster().remove(this);
				}
			}

			if (this.Tactical.Entities.getHostilesNum() != 0)
			{
				this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.PlayerDestroyed);
			}
			else
			{
				this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.EnemyDestroyed);
			}
		}
		else
		{
			if (!this.Tactical.State.isAutoRetreat())
			{
				this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.EnemyDestroyed);
			}

			if (_killer != null && _killer.isPlayerControlled() && !this.Tactical.State.isScenarioMode() && this.World.FactionManager.getFaction(this.getFaction()) != null && !this.World.FactionManager.getFaction(this.getFaction()).isTemporaryEnemy())
			{
				this.World.FactionManager.getFaction(this.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationUnitKilled);
			}
		}

		if (isReallyDead)
		{
			if (!this.Tactical.State.isScenarioMode() && this.isPlayerControlled() && !this.isGuest())
			{
				local roster = this.World.getPlayerRoster().getAll();

				foreach( bro in roster )
				{
					if (bro.isAlive() && !bro.isDying() && bro.getCurrentProperties().IsAffectedByDyingAllies)
					{
						bro.worsenMood(this.Const.MoodChange.BrotherDied, this.getName() + " died in battle");
					}
				}
			}

			this.die();
		}
		else
		{
			this.removeFromMap();
		}

		if (this.m.Items != null)
		{
			this.m.Items.onActorDied(tile);

			if (isReallyDead)
			{
				this.m.Items.setActor(null);
			}
		}

		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.getFaction() == this.Const.Faction.PlayerAnimals && _skill != null && _skill.getID() == "actives.wardog_bite")
		{
			this.updateAchievement("WhoLetTheDogsOut", 1, 1);
		}

		this.onAfterDeath(myTile);
	}


	o.removeArmorUpgrade <- function ( _slot, _item)
	{
		local armor = this.getItems().getItemAtSlot(_slot);
		if (armor == null)
		{
			return null;
		}

		return armor.removeUpgrade( _item );
	}

	o.setRiderID <- function ( _id)
	{
		if (_id == null)
		{
			_id = ""
		}
		this.m.RiderID = _id;
	}

	o.getRiderID <- function()
	{
		return this.m.RiderID
	}

	o.getRider <- function()
	{
		return null;
	}

	// o.getCompanyID <- function()
	// {
	// 	return -1;
	// }

	o.setTarget <- function (_entity)
	{
		if (this.m.AIAgent == null) return;

		this.m.AIAgent.setPriorityTarget(_entity);
	}

	o.TherianthropeInfection <- function (_killer)
	{
		return;
	}


	o.getSurroundedCount = function ()
	{
		local tile = this.getTile();
		local c = 0;

		for( local i = 0; i != 6; i = ++i )
		{
			if (tile == null)
			{
				continue
			}

			if (!tile.hasNextTile(i))
			{
				continue
			}

			local next = tile.getNextTile(i);
			if (next.getEntity() == null)
			{
				continue
			}

			if (next.IsOccupiedByActor && this.Math.abs(next.Level - tile.Level) <= 1 && !next.getEntity().isAlliedWith(this) && !next.getEntity().getCurrentProperties().IsStunned && !next.getEntity().isArmedWithRangedWeapon())
			{
				c = ++c;
			}
		}

		return this.Math.max(0, c - 1 - this.m.CurrentProperties.StartSurroundCountAt);
	}

	local szFn = o.onSerialize
	o.onSerialize = function( _out )
	{
		szFn(_out)
		_out.writeString(this.m.RiderID);
	}

	local dszFn = o.onDeserialize
	o.onDeserialize = function( _in )
	{
		dszFn(_in)
		this.m.RiderID = _in.readString();
	}




    // local onResurrected = o.onResurrected;
    // o.onResurrected = function ( _info )
    // {
    //     onResurrected(_info);
    //     this.World.getPlayerRoster().add(_info);
    // }
    // local onInit = o.onInit;
    // o.onInit = function ()
    // {
    //     o.onInit();
    //     o.m.BloodSaturation = 1.5;
    //     o.m.DeathBloodAmount = 1.5;
    //     o.m.BloodPoolScale = 1.25;
    //     o.m.BloodSplatterOffset = this.createVec(-1, -1);
    // }
    // }
});