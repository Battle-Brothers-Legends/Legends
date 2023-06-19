this.grow_shield_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "actives.grow_shield";
		this.m.Name = "Grow Shield";
		this.m.Description = "Regrow your bark, producing a protective shield";
		this.m.Icon = "skills/active_121.png";
		this.m.IconDisabled = "skills/active_121_bw.png";
		this.m.Overlay = "active_121";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/schrat_regrowth_01.wav",
			"sounds/enemies/dlc2/schrat_regrowth_02.wav",
			"sounds/enemies/dlc2/schrat_regrowth_03.wav",
			"sounds/enemies/dlc2/schrat_regrowth_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 50;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}
	
	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/melee_defense.png", // fix from /ui to ui/ Abyss 6/17/23
				text = "Grants a [color=" + this.Const.UI.Color.PositiveValue + "]" + "+20" + "[/color] Melee and Ranged Defense shield, with [color=" + this.Const.UI.Color.PositiveValue + "]" + "32" + "[/color] durability"
			}
		];
	}

	function isUsable()
	{
		return !this.getContainer().getActor().isArmedWithShield() && this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 250, function ( _idk )
		{
			actor.getItems().equip(this.new("scripts/items/shields/beasts/schrat_shield"));
			actor.getSprite("shield_icon").Alpha = 0;
			actor.getSprite("shield_icon").fadeIn(1500);
		}, null);
	}

});

