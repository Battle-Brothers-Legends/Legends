this.legend_rapier_effect <- this.inherit("scripts/skills/skill", {
	m = {
        BonusInitiativePct = 1
	},
	function create()
	{
		this.m.ID = "effects.legend_rapier";
		this.m.Name = "Named Rapier Effect";
		this.m.Description = ""
		this.m.Icon = "skills/en_garde_circle.png";
		this.m.IconMini = "mini_en_garde_circle";
		this.m.Overlay = "en_garde_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
        this.m.IsWeaponSkill = true;
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
			}
		];
	}

    function setBonus( _bonus )
    {
        this.m.BonusInitiativePct = _bonus;
    }

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 1 + (this.m.BonusInitiativePct * 0.01);
	}

});

