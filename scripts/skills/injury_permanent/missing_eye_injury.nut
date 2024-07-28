this.missing_eye_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.missing_eye";
		this.m.Name = "Missing Eye";
		this.m.Description = "A missing eye makes it difficult to judge distance properly, and limits the field of view.";
		this.m.Icon = "ui/injury/injury_permanent_icon_03.png";
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
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Ranged Skill"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-2[/color] Vision"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.RangedSkillMult *= 0.5;
		_properties.Vision -= 2;
		_properties.SurviveWithInjuryBonusChance += 5; // offsetting the perm injury cause it's minor
	}

	function onApplyAppearance()
	{
		local sprite = this.getContainer().getActor().getSprite("permanent_injury_4");
		sprite.setBrush("permanent_injury_04");
		sprite.Visible = true;
	}

});

