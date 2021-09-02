this.legend_choke <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_choke";
		this.m.Name = "Choke";
		this.m.Description = "A well-placed attack at the opponent\'s neck. Ignores all armor but is harder to hit with and can not land critical hits for additional damage, nor inflict additional damage with double grip.";
		this.m.KilledString = "Choked";
		this.m.Icon = "skills/active_27.png";
		this.m.IconDisabled = "skills/active_27_sw.png";
		this.m.Overlay = "active_27";
		this.m.SoundOnUse = [
			"sounds/combat/puncture_01.wav",
			"sounds/combat/puncture_02.wav",
			"sounds/combat/puncture_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/puncture_hit_01.wav",
			"sounds/combat/puncture_hit_02.wav",
			"sounds/combat/puncture_hit_03.wav"
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
		this.m.HitChanceBonus = -50;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 40;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getMods()
	{
		local ret = {
			Min = 5,
			Max = 10,
			HasMusc = false,
			HasBro = false,
			HasOffhand = false,
			HasMainhand = false,
			HasTraining = false
		};
		local actor = this.getContainer().getActor();
		local offhand = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local mainhand = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local average = (actor.getInitiative() + actor.getHitpoints()) * 0.25;

		if (offhand != null)
		{
			average = average * 0.5;
			ret.HasOffhand = true;
		}

		if (mainhand != null)
		{
			average = average * 0.5;
			ret.HasMainhand = true;
		}

		if (actor.getSkills().hasSkill("perk.legend_unarmed_training"))
		{
			average = average * 1.5;
			ret.HasTraining = true;
		}

		ret.Min = average - 10;
		ret.Max = average + 10;

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

		foreach( bg in backgrounds )
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

		ret.Min = this.Math.floor(ret.Min * 0.5);
		ret.Max = this.Math.floor(ret.Max * 0.5);
		return ret;
	}

	function getTooltip()
	{
		local mods = this.getMods();
		local ret = [
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
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];

		if (mods.HasTraining)
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "+15% chance to hit due to unarmed training"
			});
		}
		else
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + mods.Min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + mods.Max + "[/color] damage"
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

		if (mods.HasMainhand)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Damage halved due to holding something in your main hand"
			});
		}

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

		return ret;
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return ((offhand == null || mainhand == null) || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}

	function isHidden()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return mainhand != null && offhand != null && !this.getContainer().hasSkill("effects.disarmed") || this.skill.isHidden() || this.m.Container.getActor().isStabled();
	}

	function getHitChance( _targetEntity )
	{
		if (_targetEntity == null)
		{
			return 0;
		}

		local mod = 0;

		if (_targetEntity.getSkills().hasSkill("effects.legend_dazed"))
		{
			mod = mod + 10;
		}

		if (_targetEntity.getSkills().hasSkill("effects.legend_parried"))
		{
			mod = mod + 10;
		}

		if (_targetEntity.getSkills().hasSkill("effects.legend_grappled"))
		{
			mod = mod + 50;
		}

		if (_targetEntity.getSkills().hasSkill("effects.stunned"))
		{
			mod = mod + 25;
		}

		if (_targetEntity.getSkills().hasSkill("effects.sleeping"))
		{
			mod = mod + 50;
		}

		if (_targetEntity.getSkills().hasSkill("effects.net"))
		{
			mod = mod + 25;
		}

		if (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			mod += 50;
		}

		local chance = (1.0 - _targetEntity.getFatiguePct()) * 50;
		return mod - this.Math.round(chance);
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInFists)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 4;
		}
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		local chance = this.getHitChance(_targetEntity);
		local mods = this.getMods();

		if (!mods.HasTraining)
		{
			chance = chance + 15;
		}

		_properties.DamageRegularMin += mods.Min;
		_properties.DamageRegularMax += mods.Max;
		_properties.IsIgnoringArmorOnAttack = true;
		_properties.MeleeSkill += chance;
		_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;
	}

});

