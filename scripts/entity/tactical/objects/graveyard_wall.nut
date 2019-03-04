this.graveyard_wall <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "TODO";
	}

	function getDescription()
	{
		return "TODO";
	}

	function setDirBasedOnCenter( _centerTile, _dist )
	{
		local b = this.getSprite("body");
		local myTile = this.getTile();

		if (myTile.SquareCoords.X < _centerTile.SquareCoords.X)
		{
			if (myTile.SquareCoords.Y < _centerTile.SquareCoords.Y + _dist * 0.5 && myTile.SquareCoords.Y > _centerTile.SquareCoords.Y - _dist * 0.5)
			{
				b.setBrush("graveyard_29_07");
			}
			else if (myTile.SquareCoords.Y > _centerTile.SquareCoords.Y)
			{
				b.setBrush("graveyard_29_01");
			}
			else
			{
				b.setBrush("graveyard_29_02");
			}
		}
		else if (myTile.SquareCoords.X > _centerTile.SquareCoords.X)
		{
			if (myTile.SquareCoords.Y < _centerTile.SquareCoords.Y + _dist * 0.5 && myTile.SquareCoords.Y > _centerTile.SquareCoords.Y - _dist * 0.5)
			{
				b.setBrush("graveyard_29_06");
			}
			else if (myTile.SquareCoords.Y > _centerTile.SquareCoords.Y)
			{
				b.setBrush("graveyard_29_02");
			}
			else
			{
				b.setBrush("graveyard_29_01");
			}
		}
		else if (myTile.SquareCoords.Y < _centerTile.SquareCoords.Y)
		{
			b.setBrush("graveyard_29_03");
		}
		else
		{
			b.setBrush("graveyard_29_05");
		}
	}

	function onInit()
	{
		local body = this.addSprite("body");
		body.setBrush("graveyard_29_0" + this.Math.rand(1, 7));
		body.IgnoreCameraFlip = true;
	}

});

