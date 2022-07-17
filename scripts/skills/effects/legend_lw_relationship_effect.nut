this.legend_lw_relationship_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_lw_relationship";
		this.m.Name = "Band of Brothers";
		this.m.Description = "Trust is in short supply, and trusting those around you allows you to fight and focus better on the battlefield";
		this.m.Icon = "ui/traits/trait_icon_58.png"; //change
		this.m.IconMini = "status_effect_78_mini"; //change
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
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] Melee Skill per ally adjacent"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+3[/color] Ranged Skill per ally adjacent"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] Melee Defense per ally adjacent"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] Ranged Defense per ally adjacent"
			}
		];
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.IsHidden = true;
			return;
		}

		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local isSupported = true;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}

			if (ally.getTile().getDistanceTo(myTile) <= 1)
			{
				isSupported = true;
				break;
			}
		}
	}

	function onUpdate( _properties )
	{
		if (isSupported)
		{
			this.m.IsHidden = false;
			_properties.MeleeSkill += 2;
			_properties.RangedSkill += 3;
			_properties.MeleeDefense += 2;
			_properties.RangedDefense += 2;
			// _properties.Initiative += 2;
		}
		else
		{
			this.m.IsHidden = true;
		}
	}

	function onCombatFinished()
	{
		this.m.IsHidden = true;
	}

});

