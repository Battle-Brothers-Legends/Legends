this.steel_brow_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.steel_brow";
		this.m.Name = "Steel Brow";
		this.m.Description = "Will turn any stun attacks made against you into dazes instead.";
		this.m.Icon = "ui/perks/perk_09.png";
		this.m.IconMini = "mini_steel_brow";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Any stun attack that hits you will turn into a daze instead"
			}
		];
	}

});

