this.hand_to_hand <- this.inherit("scripts/skills/skill", {
	m = {
		Backgrounds = [
			"background.legend_commander_druid",
			"background.legend_druid",
			"background.brawler",
			"background.legend_commander_berserker",
			"background.legend_berserker"
		]
	},
	function create()
	{
		this.m.ID = "actives.hand_to_hand";
		this.m.Name = "Hand-to-Hand Attack";
		this.m.Description = "Let them fly! Use your limbs to inflict damage on your enemy.";
		this.m.KilledString = "Pummeled to death";
		this.m.Icon = "skills/active_08.png";
		this.m.IconDisabled = "skills/active_08_sw.png";
		this.m.Overlay = "active_08";
		this.m.SoundOnUse = [
			"sounds/combat/hand_01.wav",
			"sounds/combat/hand_02.wav",
			"sounds/combat/hand_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted+3;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsSerialized = false;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local actor = this.getContainer().getActor();
		local fatigueMultiplier = 1;
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFists) { 
			fatigueMultiplier = 2;
		}
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * fatigueMultiplier + "[/color] extra fatigue on hit"
		});

		foreach( bg in this.m.Backgrounds )
		{
			if (actor.getSkills().hasSkill(bg))
			{
				ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] damage from background"
			});
				break;
			}
		}

		return ret;
	}


	function isUsable() // If ambidextrous & offhand free, or mainhand free, or disarmed
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		
		if (this.m.Container.hasSkill("perk.legend_ambidextrous") && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) && this.skill.isUsable)
		{
			return true;
		}

		return (main == null || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}

	function isHidden()
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (this.m.Container.hasSkill("perk.legend_ambidextrous") && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand)) // if ambidextrous && offhand free, then NOT hidden
		{
			return false;
		}

		return (main != null && !this.getContainer().hasSkill("effects.disarmed")) || this.skill.isHidden() || this.m.Container.getActor().isStabled();
	}

	function onAfterUpdate( _properties )
	{
		if ("IsSpecializedInFists" in _properties)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
			if (this.m.Container.hasSkill("perk.legend_ambidextrous")) //ambidextrous & specialzed
			{
				this.m.ActionPointCost = 3
			}
		}
		if (this.m.Container.hasSkill("perk.legend_ambidextrous")) 
		{
			// If ambidextrous & you have a mainhand use that as your AOO.
			if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
			{
				this.m.IsIgnoredAsAOO = true;
			}
			else {
				this.m.IsIgnoredAsAOO = false;
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		_properties.DamageRegularMin += 5;
		_properties.DamageRegularMax += 10;
		_properties.DamageArmorMult = 0.5;

		if (this.m.Container.hasSkill("effects.disarmed") || this.m.Container.hasSkill("perk.legend_ambidextrous"))
		{
			local mhand = actor.getMainhandItem();

			if (mhand != null)
			{
				_properties.DamageRegularMin -= mhand.m.RegularDamage;
				_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
			}
		}
		_properties.FatigueDealtPerHitMult += 1.0; // Increase fatigue damage from 5 to 10

		if (this.m.Container.hasSkill("perk.legend_ambidextrous"))
		{
			if (actor.getMainhandItem() != null)
			{
				_properties.MeleeDamageMult/=1.25; // Attempt to undo double grip damage bonus for just this skill. Might not work for missing hand.
			}
		}

		// Damage bonus for certain bgs
		foreach( bg in this.m.Backgrounds )
		{
			if (actor.getSkills().hasSkill(bg))
			{
				_properties.DamageTotalMult *= 1.25;
				break;
			}
		}

		if (("IsSpecializedInFists" in _properties) && _properties.IsSpecializedInFists)
		{
			_properties.FatigueDealtPerHitMult += 1.0; // If you have mastery, increase from 10 to 15 fat damage.
		}
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

