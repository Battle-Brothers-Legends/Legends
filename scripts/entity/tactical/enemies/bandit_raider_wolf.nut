this.bandit_raider_wolf <- this.inherit("scripts/entity/tactical/enemies/bandit_raider", {
	m = {},
	function create()
	{
		this.bandit_raider.create();
		this.m.Name = "Disguised Bandit";
	}

	function onInit()
	{
		this.bandit_raider.onInit();
		if (this.LegendsMod.Configs().LegendTherianthropyEnabled())
		{
			if(this.Math.rand(1, 10) == 1)
			{
				this.m.Skills.add(this.new("scripts/skills/injury_permanent/legend_lycanthropy_injury"));
				this.m.Skills.add(this.new("scripts/skills/traits/weasel_trait"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
			}
		}
	}

	function assignRandomEquipment()
	{
	}

});

