this.perk_nine_lives <- this.inherit("scripts/skills/skill", {
	m = {
		EffectGranted = false
	},

	function create()
	{
		this.m.ID = "perk.nine_lives";
		this.m.Name = this.Const.Strings.PerkName.NineLives;
		this.m.Description = this.Const.Strings.PerkDescription.NineLives;
		this.m.Icon = "ui/perks/perk_07.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if(this.m.EffectGranted == false)
		{
			this.onCombatStarted();
		}
		delete this.onUpdate;
	}

	function onCombatStarted()
	{
		if(this.m.EffectGranted == false)
		{
			this.m.EffectGranted = true;
			this.getContainer().add(this.new("scripts/skills/effects/legends_nine_lives_cheat_death_effect"));
		}
	}

});

