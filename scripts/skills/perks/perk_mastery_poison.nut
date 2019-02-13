this.perk_mastery_poison <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery_poison";
		this.m.Name = this.Const.Strings.PerkName.LegendSpecPoion;
		this.m.Description = this.Const.Strings.PerkDescription.LegendSpecPoison;
		this.m.Icon = "ui/perks/mastery-poison.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.coat_with_poison_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/coat_with_poison_skill"));
		}
	}
		function onRemoved()
	{
		this.m.Container.removeByID("actives.coat_with_poison_skills");
	}

});
