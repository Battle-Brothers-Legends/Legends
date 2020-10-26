this.perk_legend_balance <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_balance";
		this.m.Name = this.Const.Strings.PerkName.LegendBalance;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBalance;
		this.m.Icon = "ui/perks/balance.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getBonus()
	{
		if (this.getContainer() == null)
		{
			return 5;
		}

		local actor = this.getContainer().getActor();

		if (actor == null)
		{
			return 5;
		}
		
		local bodyitem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		if (bodyitem == null)
		{
			return 5;
		}
		local body = actor.getArmor(this.Const.BodyPart.Body);		
		local initiative = actor.getInitiative();
		local diff = this.Math.abs(body - 2 * initiative);
		return this.Math.max(5, this.Math.floor(40 - diff * 0.5));
	}

	function getTooltip()
	{
		local bonus = this.getBonus();
		local tooltip = this.skill.getTooltip();

		if (bonus > 5)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "You are gaining [color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "[/color] defence and damage reduction due to increased balance"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character\'s initiative and armor are too far out of alignment to gain more than[color=" + this.Const.UI.Color.PositiveValue + "] 5[/color] defense from balance"
			});
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill != null && !_skill.isAttack())
		{
			return;
		}

		local bonus = this.getBonus();
		_properties.DamageReceivedArmorMult *= 1.0 - bonus * 0.01;
	}

});

