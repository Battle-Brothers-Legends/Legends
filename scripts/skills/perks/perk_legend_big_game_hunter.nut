this.perk_legend_big_game_hunter <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_big_game_hunter";
		this.m.Name = "Hunting big game";
		this.m.Description = this.Const.Strings.PerkDescription.LegendBigGameHunter;
		this.m.Icon = "ui/perks/BigGameHunterPerk.png";
		this.m.IconDisabled = "ui/perks/BigGameHunterPerk_bw.png"
		this.m.IconMini = "mini_big_game_hunter";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "If an enemy has more health than you, gain % damage equal to their health divided by your health. So if an enemy has 1,000 health, and you have 100 health, you would gain +10% damage. If you have 10 health, gain +100% damage. If you have 1 health, gain +1000% damage.";
	}

	function onUpdate( _properties)
	{
		this.m.IsHidden = !this.getContainer().getActor().isArmedWithRangedWeapon()
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || this.m.IsHidden)
		{
			return
		}
	
		local actor = this.getContainer().getActor();
		local targetHP = _targetEntity.getHitpoints()
		local ourHP =  actor.getHitpoints();
		local ratio = targetHP / ourHP.tofloat();
		if (ratio > 1.0)
		{
			_properties.DamageRegularMult *= 1.0 + ratio * 0.01; 
		}
	}

});
