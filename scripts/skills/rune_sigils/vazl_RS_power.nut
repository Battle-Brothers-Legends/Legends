this.vazl_RS_power <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.vazl_RS_power";
		this.m.Name = "Rune Sigil: Power";
		this.m.Description = "This item has been inscribed with the rune sigil of power, increasing the wielder's damage.";
		this.m.Icon = "ui/rune_sigils/vazl_RS_power.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
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
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Damage"
		});
		return ret;
	}


	function onUpdate (_properties)
	{
		_properties.DamageTotalMult *= 1.1;
	}
});
