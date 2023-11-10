this.legend_estoc_effect <- this.inherit("scripts/skills/skill", {
	m = {
        BonusMeleeDefense = 1
	},
	function create()
	{
		this.m.ID = "effects.legend_estoc";
		this.m.Name = "Named Estoc Effect";
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
        this.m.BonusMeleeDefense = _bonus;
    }

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += this.m.BonusMeleeDefense;
	}

});

