this.perk_quick_hands <- this.inherit("scripts/skills/skill", {
	//THIS PERK IS MODIFIED BY MSU, CHECK msu_mod_skills.nut for up to date code (I have mirrored it here 2021/09/04)

	m = {},
	function create()
	{
		this.m.ID = "perk.quick_hands";
		this.m.Name = this.Const.Strings.PerkName.QuickHands;
		this.m.Description = "Maybe use this instead? This character has quick hands and can still swap an item for free this turn.";
		this.m.Icon = "ui/perks/perk_39.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk | this.Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().isPlayerControlled() && this.getContainer().getActor().isPlacedOnMap() && this.getContainer().getActor().getItems().m.ActionCost == 0)
		{
			this.m.IsHidden = false;
		}
		else
		{
			this.m.IsHidden = true;
		}
	}

	function getName()
	{
		local name = this.skill.getName();
		if (this.getContainer() != null && this.getContainer().hasSkill("injury.missing_hand")) name = ::stringReplace(name, "Quick Hands", "Quick Hand")
		return name;
	}

	function getDescription()
	{
		local description = this.skill.getDescription()
		if (this.getContainer() != null && this.getContainer().hasSkill("injury.missing_hand")) description = ::stringReplace(description, "has quick hands", "has a quick hand")
		return description;
	}

	function onCombatStarted()
	{
		this.skill.onCombatStarted();

		if (this.getContainer().getActor().isPlayerControlled())
		{
			this.m.IsHidden = false;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsHidden = true;
	}

});

