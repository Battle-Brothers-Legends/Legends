this.werewolf_transformation_effect <- this.inherit("scripts/skills/skill", {
	m = {
		hasTransformed = false,
	},
	function create()
	{
		this.m.ID = "effects.werewolf_transformation";
		this.m.Name = "Transformed";
		this.m.Icon = "ui/injury/injury_permanent_icon_03.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "";
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
		];
	}

	function onUpdate(_properties)
	{
		//check for transformation
		if (!this.m.hasTransformed)
		{
			this.transform()
			local actor = this.getContainer().getActor();
			local myTile = actor.getTile();

			if (!myTile.hasZoneOfOccupationOtherThan(actor.getAlliedFactions()))
			{
				return;
			}
			this.transform()
		}
		//add stats or whatever
		_properties.MeleeSkill += 10
		_properties.RangedSkill += 10
	}

	function transform()
	{
		this.m.hasTransformed = true

		local actor = this.getContainer().getActor();
		this.Sound.play("sounds/combat/werewolf_transform.wav", this.Const.Sound.Volume.Skill, actor.getTile().Pos);
		local head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("tattoo_body");
		head.setBrush("were_head_black");
		body.setBrush("were_body_black");
		actor.setDirty(true);

		actor.m.Name = "Werewolf " + actor.getName()

		actor.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
	}


});

