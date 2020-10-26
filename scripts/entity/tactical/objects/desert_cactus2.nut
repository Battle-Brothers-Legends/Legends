this.desert_cactus2 <- this.inherit("scripts/entity/tactical/entity", {
	m = {
		IsTree = true
	},
	function getName()
	{
		return this.Const.Strings.Tactical.EntityName.Plant;
	}

	function getDescription()
	{
		return this.Const.Strings.Tactical.EntityDescription.Plant;
	}

	function onInit()
	{
		local body = this.addSprite("body");
		body.setBrush("desert_cactus_0" + this.Math.rand(2, 3));
		body.setHorizontalFlipping(this.Math.rand(0, 100) < 50);
		body.varyColor(0.03, 0.03, 0.03);
	}

});

