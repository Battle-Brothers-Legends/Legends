::mods_hookExactClass("skills/actives/thrust", function(o)
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		ret = getTooltip();
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpearThrust)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] damage bonus due to Thrust Master"
			});
		}

		return ret;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 20;

			if (_properties.IsSpecializedInSpearThrust )
			{
				_properties.DamageTotalMult *= 1.15;
			}
		}
	}
});