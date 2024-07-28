this.missing_finger_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.missing_finger";
		this.m.Name = "Missing Finger";
		this.m.Description = "A missing finger makes it harder to firmly grab a weapon or shield, but it also makes for a good story.";
		this.m.Icon = "ui/injury/injury_permanent_icon_02.png";
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
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Melee Skill"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Ranged Skill"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkillMult *= 0.95;
		_properties.RangedSkillMult *= 0.95;
		_properties.SurviveWithInjuryBonusChance += 10; // offsetting the perm injury cause it's minor
	}

	function onApplyAppearance()
	{
	}

});

