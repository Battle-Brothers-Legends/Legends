this.bandit_marksman_low <- this.inherit("scripts/entity/tactical/enemies/bandit_marksman", {
	m = {},
	function create()
	{
		this.bandit_marksman.create();
		this.m.IsLow = true;
	}

	function onInit()
	{
		this.bandit_marksman.onInit();
		this.m.BaseProperties.Initiative -= 10;
		this.m.BaseProperties.RangedSkill -= 10;
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
	}

});

