this.desert_camp_furniture <- this.inherit("scripts/entity/tactical/entity", {
	m = {
		IsTree = true		
	},
	function getName()
	{
		return "Furniture";
	}

	function getDescription()
	{
		return "Wooden furniture for this camp\'s inhabitants.";
	}

	function onInit()
	{
		local variants = [
			"04",
			"06"
		];
		local body = this.addSprite("body");
		body.setBrush("desert_camp_" + variants[this.Math.rand(0, variants.len() - 1)]);
	}

});

