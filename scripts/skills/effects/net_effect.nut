this.net_effect <- this.inherit("scripts/skills/skill", {
	m = {
		DropNet = false, // Net item will be dropped in battle if it was thrown with Net Mastery
		IsReinforced = false,
	},
	function create()
	{
		this.m.ID = "effects.net";
		this.m.Name = "Trapped in Net";
		this.m.Description = "A large net holds this character in place and hampers their ability to defend themself. To break free, the net will have to be cut.";
		this.m.Icon = "skills/status_effect_58.png";
		this.m.IconMini = "status_effect_58_mini";
		this.m.Overlay = "status_effect_58";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
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
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Unable to move[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-45%[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-45%[/color] Ranged Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-45%[/color] Initiative"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= 0.55;
		_properties.RangedDefenseMult *= 0.55;
		_properties.InitiativeMult *= 0.55;
	}

	function onDeath( _fatalityType )
	{
		if (this.m.DropNet)
		{
			local net;
			if (this.m.IsReinforced)
			{
				net = this.new("scripts/items/tools/reinforced_throwing_net");
			}
			else
			{
				net = this.new("scripts/items/tools/throwing_net");	
			}
			net.drop(this.getContainer().getActor().getTile());
		}
	}

});

