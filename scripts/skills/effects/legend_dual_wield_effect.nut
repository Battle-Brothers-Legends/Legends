this.legend_dual_wield_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null,
		SkillID = null,
		ActionPointIncrease = 0,
		FatigueCostIncrease = 0
	},

	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function setSkill( _i )
	{
		this.m.SkillID = _i;
	}

	function create()
	{
		this.m.ID = "effects.legend_dual_wield";
		this.m.Name = "Dual Wield Stance";
		this.m.Description = "This character will use both weapons to attack."
		this.m.Icon = "skills/en_garde_circle.png";
		this.m.IconMini = "mini_en_garde_circle";
		this.m.Overlay = "en_garde_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] more Action Point cost for attacks with the main hand weapon"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] more fatigue cost for attacks with the main hand weapon"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Every attack with the main hand weapon will follow up with " + this.getContainer().getSkillByID(this.m.SkillID).getName() + "from your off hand weapon"
			}
		];
	}

	function added()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			this.removeSelf();
			return;
		}
		if (this.m.SkillID == null || this.m.Item == null)
			return;
		// fail safe if the item/skill isn't set for whatever reason
	}

	function onAfterUpdate( _properties )
		{
			local weapon = this.getContainer().getActor().getMainhandItem();

			if (weapon != null && weapon.m.FatigueOnSkillUse > 0)
				foreach (mhSkill in weapon.getSkills())
				// double fatigue use and 1.5x more ap cost by default
				// i'd like to add something like buckler bash to dual wield and it'll annoying if there isn't an option to increase the damage more dynamically
				if (this.m.FatigueCostIncrease)
					mhSkill.m.FatigueCost += this.m.FatigueCostIncrease;
				else
					mhSkill.m.FatigueCost = this.Math.floor(mhSkill.m.FatigueCost * 2);	
				if (this.m.ActionPointIncrease)
					mhSkill.m.ActionPointCost += this.m.ActionPointIncrease;
				else
					mhSkill.m.ActionPointCost = this.Math.floor(mhSkill.m.ActionPointCost * 1.5);
		}	

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!_skill.m.IsAttack)
			return;

		foreach (offSkill in this.m.Item.m.OffHandSkillsIDs)
		{
			if (_skill.getID == offSkill)
				return;
		}

		// return if skill isn't attack or is from offhand

		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (_targetEntity != null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) && off != null)
		{
			if (!_forFree)
			{
				if (_targetTile == null) // Is this necessary?
				{
					return;
				}
				local info = {
					TargetTile = _targetTile
				};
				::Time.scheduleEvent(::TimeUnit.Virtual, ::Const.Combat.RiposteDelay, this.executeFollowUpAttack.bindenv(this), info);
			}
		}
	}

	function executeFollowUpAttack( _info )
	{
		local attack = this.getContainer().getSkillByID(this.m.SkillID);
		off_hand.setItem(this.m.Item);
		if (attack != null)
		{
			attack.useForFree(_info.TargetTile);
		}
	}

});

