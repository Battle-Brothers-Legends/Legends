this.legends_nine_lives_cheat_death_effect <- this.inherit("scripts/skills/skill", {
	m = {
        IsSpent = false,
		LastFrameUsed = 0,
        MinHP = 11,     // remaining after proccing
        MaxHP = 15      // remaining after proccing
    },

	function create()
	{
		this.m.ID = "effects.nine_lives_cheat_death";
		this.m.Name = "Cheat Death";
		this.m.Description = "Upon receiving a killing blow, survive instead with " + this.m.MinHP + " - " + this.m.MaxHP + " Hitpoints and have all damage over time effects (e.g. bleeding, poisoned) cured. Also gain improved defensive stats until your next turn.";
		this.m.Icon = "ui/perks/perk_07.png";
		this.m.IconMini = "perk_07_mini";
		this.m.Overlay = "perk_07";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
        this.m.IsSpent = false;
		this.m.LastFrameUsed = 0;
	}

	function onUpdate( _properties )
	{
		if (this.m.IsSpent && this.m.LastFrameUsed == this.Time.getFrame())
		{
			this.getContainer().removeByType(this.Const.SkillType.DamageOverTime);
		}
	}

	function isSpent()
	{
		return this.m.IsSpent;
	}

	function setSpent( _f )
	{
		if (_f && !this.m.IsSpent)
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " just survived certain death due to Nine Lives");
			this.getContainer().add(this.new("scripts/skills/effects/nine_lives_effect"));
			this.removeSelf();
		}

		this.m.IsSpent = _f;
		this.m.LastFrameUsed = this.Time.getFrame();
	}

	function getLastFrameUsed()
	{
		return this.m.LastFrameUsed;
	}
});
