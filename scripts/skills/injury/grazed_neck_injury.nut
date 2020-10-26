this.grazed_neck_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {
		LastRoundApplied = 0
	},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.grazed_neck";
		this.m.Name = "Grazed Neck";
		this.m.Description = "A grazing wound on the neck bleeds profusely. If survived, it is followed by lowered constitution due to loss of blood.";
		this.m.KilledString = "Bled to death";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_44";
		this.m.Icon = "ui/injury/injury_icon_44.png";
		this.m.IconMini = "injury_icon_44_mini";
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 2;
		this.m.IsAlwaysInEffect = true;
	}

	function getTooltip()
	{
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
			}
		];

		if (!this.m.IsShownOutOfCombat)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/health.png",
				text = "This character will continue to lose [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] hitpoint each turn in combat"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Hitpoints"
			});
		}

		this.addTooltipHint(ret);
		return ret;
	}

	function applyDamage()
	{
		if (!this.m.IsShownOutOfCombat && this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon("status_effect_01", this.getContainer().getActor().getTile());
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = 1;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
		}
	}

	function onTurnEnd()
	{
		this.applyDamage();
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);

		if (!_properties.IsAffectedByInjuries || this.m.IsFresh && !_properties.IsAffectedByFreshInjuries)
		{
			return;
		}

		if (this.m.IsShownOutOfCombat)
		{
			_properties.HitpointsMult *= 0.85;
		}
	}

});

