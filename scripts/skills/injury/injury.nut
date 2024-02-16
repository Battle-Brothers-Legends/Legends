this.injury <- this.inherit("scripts/skills/skill", {
	m = {
		HealingTimeMin = 1,
		HealingTimeMax = 1,
		TreatmentPriceMult = 1.0,
		TimeApplied = 0.0,
		DropIcon = "",
		InfectionChance = 0.0,
		IsFresh = true,
		IsTreated = false,
		IsTreatable = true,
		IsAlwaysInEffect = false,
		IsHealingMentioned = true,
		IsShownOnArm = false,
		IsShownOnBody = false,
		IsShownOnHead = false,
		IsShownOutOfCombat = false,
		IsContentWithReserve = true,
		Points = 0.0
		Queue = 0
	},
	function isFresh()
	{
		return this.m.IsFresh;
	}

	function isTreated()
	{
		return this.m.IsTreated;
	}

	function isTreatable()
	{
		return this.m.IsTreatable;
	}

	function getInfectionChance()
	{
		return this.m.InfectionChance;
	}

	function setTreated( _f )
	{
		this.m.IsTreated = _f;
	}

	function getQueue()
	{
		return this.m.Queue;
	}
	
	function setQueue( _f )
	{
		this.m.Queue = _f;
	}

	function setOutOfCombat( _f )
	{
		this.m.IsShownOutOfCombat = _f;
	}

	function getNameOnly()
	{
		return this.m.Name;
	}

	function getName()
	{
		return this.m.IsTreated ? this.m.Name + " (Treated)" : this.m.Name;
	}

	function getCost()
	{
		return this.m.HealingTimeMax + this.m.HealingTimeMin;
	}

	function getPrice()
	{
		local mult = this.World.State.getCurrentTown().getBuyPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()] * this.m.TreatmentPriceMult;
		local time = this.getTime();
		local maxt = this.Math.max(1, this.m.HealingTimeMax - this.Math.floor((time - this.m.TimeApplied) / this.World.getTime().SecondsPerDay));
		mult = mult * (1.0 + (this.getContainer().getActor().getLevel() - 1) * 0.2);
		local p = maxt * mult * this.Const.World.Assets.BaseWoundTreatmentPrice;
		p = this.Math.round(p * 0.1) * 10;
		return p;
	}

	function getHealingTime()
	{
		local time = this.getTime();
		local mint = this.Math.max(1, (this.m.IsTreated ? this.m.HealingTimeMin * 0.5 : this.m.HealingTimeMin) - this.Math.ceil((time - this.m.TimeApplied) / this.World.getTime().SecondsPerDay));
		local maxt = this.Math.max(1, (this.m.IsTreated ? this.m.HealingTimeMax * 0.5 : this.m.HealingTimeMax) - this.Math.floor((time - this.m.TimeApplied) / this.World.getTime().SecondsPerDay));

		if (("State" in this.World) && this.World.State != null && this.World.Retinue.hasFollower("follower.surgeon"))
		{
			mint = this.Math.max(1, mint - 1);
			maxt = this.Math.max(1, maxt - 1);
		}

		if (this.getContainer().getActor().getSkills().hasSkill("effects.nachzehrer_potion"))
		{
			mint = this.Math.max(1, mint - 1);
			maxt = this.Math.max(1, maxt - 1);
		}

		return {
			Min = mint,
			Max = maxt
		};
	}

	function addHealingTime( _days )
	{
		this.m.HealingTimeMin = this.Math.max(1, this.m.HealingTimeMin + _days);
		this.m.HealingTimeMax = this.Math.max(this.m.HealingTimeMin + 1, this.m.HealingTimeMax + _days);
	}

	function getPoints()
	{
		return this.m.Points;
	}

	function setPoints( _v)
	{
		this.m.Points = _v;
	}

	function getTreatedPercentage()
	{
 		return this.m.Points / this.getCost();
	}

	function create()
	{
		this.m.IsStacking = false;
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.Injury;
		this.m.Order = this.Const.SkillOrder.TemporaryInjury;
	}

	function addTooltipHint( _tooltip )
	{
		if (this.m.IsContentWithReserve)
		{
			_tooltip.push({
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is content for now with being in reserve"
			});
		}

		if (this.m.IsFresh && !this.m.IsAlwaysInEffect && !this.getContainer().getActor().getCurrentProperties().IsAffectedByFreshInjuries && this.m.IsHealingMentioned)
		{
			_tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Will take effect only after combat ends due to the Iron Will effect"
			});
		}

		if (!this.m.IsAlwaysInEffect && !this.getContainer().getActor().getCurrentProperties().IsAffectedByInjuries && this.m.IsHealingMentioned)
		{
			if (("State" in this.Tactical) && this.Tactical.State != null)
			{
				_tooltip.push({
					id = 7,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "Will take effect only after combat ends due to the Iron Will effect"
				});
			}
			else
			{
				_tooltip.push({
					id = 7,
					type = "text",
					icon = "ui/icons/warning.png",
					text = "Will take effect again only after the next battle due to the Iron Will effect"
				});
			}
		}

		if (("State" in this.World) && this.World.State != null && this.World.Assets.getMedicine() <= 0 && this.m.IsHealingMentioned)
		{
			_tooltip.push({
				id = 7,
				type = "hint",
				icon = "ui/icons/warning.png",
				text = "Will not heal because you have no medical supplies"
			});
		}
		else if (this.getContainer().getActor().getSkills().hasSkill("trait.oath_of_sacrifice") && this.m.IsHealingMentioned)
		{
			_tooltip.push({
				id = 7,
				type = "hint",
				icon = "ui/icons/warning.png",
				text = "Will not heal because this character has taken an oath of sacrifice"
			});
		}
		else
		{
			local ht = this.getHealingTime();
			local d;

			if (this.m.IsHealingMentioned)
			{
				if (ht.Max > 1 && ht.Min == ht.Max)
				{
					d = "Will heal in " + ht.Min + " days";
				}
				else if (ht.Max > 1)
				{
					d = "Will heal in " + ht.Min + " to " + ht.Max + " days";
				}
				else
				{
					d = "Will heal by tomorrow";
				}

				_tooltip.push({
					id = 6,
					type = "hint",
					icon = "ui/icons/days_wounded.png",
					text = d
				});
			}
			else
			{
				if (ht.Max > 1 && ht.Min == ht.Max)
				{
					d = "Will be gone in " + ht.Min + " days";
				}
				else if (ht.Max > 1)
				{
					d = "Will be gone in " + ht.Min + " to " + ht.Max + " days";
				}
				else
				{
					d = "Will be gone by tomorrow";
				}

				_tooltip.push({
					id = 6,
					type = "hint",
					icon = "ui/icons/action_points.png",
					text = d
				});
			}
		}
	}

	function isValid( _actor )
	{
		return true;
	}

	function onAdded()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			this.spawnIcon(this.m.DropIcon, this.getContainer().getActor().getTile());
		}

		if (this.m.TimeApplied == 0)
		{
			this.m.TimeApplied = this.getTime();
		}
	}

	function onUpdate( _properties )
	{
		if (this.m.IsContentWithReserve)
		{
			_properties.IsContentWithBeingInReserve = true;
		}
	}

	function onCombatStarted()
	{
		this.m.IsFresh = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();

		if (this.m.IsShownOutOfCombat)
		{
			this.m.IsFresh = false;
		}

		this.m.IsShownOutOfCombat = true;
	}

	function onNewDay()
	{
		if (!(this.getContainer().getActor().getSkills().hasSkill("trait.oath_of_sacrifice") && this.m.IsTreatable) && (this.World.Assets.getMedicine() >= this.Const.World.Assets.MedicinePerInjuryDay || !this.m.IsHealingMentioned))
		{
			if (this.m.IsHealingMentioned)
			{
				this.World.Assets.addMedicine(-this.Const.World.Assets.MedicinePerInjuryDay);
			}

			local time = this.getTime();
			local daysPassed = this.Math.ceil((time - this.m.TimeApplied) / this.World.getTime().SecondsPerDay);
			local minTime = this.m.HealingTimeMin * (this.m.IsTreated ? 0.5 : (1.0 - 0.5 * this.getTreatedPercentage()));
			local maxTime = this.m.HealingTimeMax * (this.m.IsTreated ? 0.5 : (1.0 - 0.5 * this.getTreatedPercentage()));

			if (this.World.Retinue.hasFollower("follower.surgeon"))
			{
				minTime = this.Math.max(1, minTime - 1);
				maxTime = this.Math.max(1, maxTime - 1);
			}

			if (this.getContainer().getActor().getSkills().hasSkill("effects.nachzehrer_potion"))
			{
				minTime = this.Math.max(1, minTime - 1);
				maxTime = this.Math.max(1, maxTime - 1);
			}

			if (daysPassed < minTime)
			{
				return;
			}

			local chance = daysPassed / (maxTime * 1.0) * 100.0;

			if (this.Math.rand(1, 100) <= chance)
			{
				this.removeSelf();
				return;
			}
		}
		else
		{
			this.m.TimeApplied = this.Math.minf(this.Time.getVirtualTimeF(), this.m.TimeApplied + this.World.getTime().SecondsPerDay);
		}
	}

	function showInjury()
	{
		if (!this.m.IsShownOutOfCombat)
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (this.m.IsShownOnHead)
		{
			local sprite = actor.getSprite("bandage_1");

			if (this.m.IsTreated)
			{
				sprite.setBrush("bandage_clean_01");
			}

			sprite.Visible = true;
		}

		if (this.m.IsShownOnBody)
		{
			local sprite = actor.getSprite("bandage_2");

			if (this.m.IsTreated)
			{
				sprite.setBrush("bandage_clean_02");
			}

			sprite.Visible = true;
		}

		if (this.m.IsShownOnArm)
		{
			local sprite = actor.getSprite("bandage_3");

			if (this.m.IsTreated)
			{
				sprite.setBrush("bandage_clean_03");
			}

			sprite.Visible = true;
		}
	}

	function getTime()
	{
		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			return this.World.State.getCombatStartTime();
		}
		else
		{
			return this.Time.getVirtualTimeF();
		}
	}

	function onSerialize( _out )
	{
		_out.writeF32(this.m.TimeApplied);
		_out.writeBool(this.m.IsTreated);
		_out.writeU32(this.m.HealingTimeMin);
		_out.writeU32(this.m.HealingTimeMax);
		_out.writeU8(this.m.Queue);
		_out.writeF32(this.m.Points);
		//_out.writeBool(false);
	}

	function onDeserialize( _in )
	{
		this.m.IsFresh = false;
		this.m.IsShownOutOfCombat = true;
		this.m.TimeApplied = _in.readF32();
		this.m.IsTreated = _in.readBool();
		this.m.HealingTimeMin = _in.readU32();
		this.m.HealingTimeMax = _in.readU32();
		this.m.Queue = _in.readU8();
		this.m.Points = _in.readF32();
		//_in.readBool();
	}

});

