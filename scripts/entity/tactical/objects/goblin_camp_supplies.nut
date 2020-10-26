this.goblin_camp_supplies <- this.inherit("scripts/entity/tactical/entity", {
	m = {
		IsSupplies = true	
	},
	function getName()
	{
		return "Supplies";
	}

	function getDescription()
	{
		return "Supplies to feed this camp\'s inhabitants.";
	}

	function onInit()
	{
		local variants = [
			"03"
		];
		local body = this.addSprite("body");
		body.setBrush("goblins_" + variants[this.Math.rand(0, variants.len() - 1)]);
	}

});

