this.barbarian_camp_nithing_pole <- this.inherit("scripts/entity/tactical/entity", {
	m = {
		IsSupplies = true	
	},
	function getName()
	{
		return "Nithing Pole";
	}

	function getDescription()
	{
		return "A long, wooden pole with a recently cut horse head at the end, directed towards the enemy and target of a curse.";
	}

	function setFlipped( _flip )
	{
		this.getSprite("bottom").setHorizontalFlipping(_flip);
		this.getSprite("top").setHorizontalFlipping(_flip);
	}

	function onInit()
	{
		local variants = [
			"08"
		];
		local v = variants[this.Math.rand(0, variants.len() - 1)];
		local flip = this.Math.rand(0, 1) == 1;
		local bottom = this.addSprite("bottom");
		bottom.setBrush("barbarians_" + v + "_bottom");
		bottom.setHorizontalFlipping(flip);
		local top = this.addSprite("top");
		top.setBrush("barbarians_" + v + "_top");
		top.setHorizontalFlipping(flip);
		this.setSpriteOcclusion("top", 1, 2, -3);
		this.setBlockSight(false);
	}

});

