this.legend_parrying_dagger_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Bonus = 5
	},
	function create()
	{
		this.m.ID = "effects.legend_parrying_dagger";
		this.m.Name = "Parry defense";
		this.m.Description = "Parrying daggers work best against a single opponent, +20 defense when there is only a single enemy within 2 tiles";
		this.m.Icon = "ui/perks/perk_61.png";
		this.m.IconMini = "perk_61_mini";
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Bonus + "[/color] Melee Defense"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsParrying = true;
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.IsHidden = true;
			return;
		}

		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local myFaction = actor.getFaction();
		local nearbyEnemies = 0;
		local actors = this.Tactical.Entities.getAllInstances();
		local bonus = 0;

		foreach( i in actors )
		{
			foreach( a in i )
			{
				if (a.getFaction() != myFaction)
				{
					if (a.getTile().getDistanceTo(myTile) <= 1)
						{
							++nearbyEnemies;
							break;
						}

				}
			}
		}
		if (nearbyEnemies == 1)
		{
		this.m.Bonus = 20;
		}
		if (nearbyEnemies == 2)
		{
		this.m.Bonus = 5;
		}

		_properties.MeleeDefense += this.m.Bonus;



	}

	function onCombatFinished()
	{
		this.m.IsHidden = true;
	}

});
