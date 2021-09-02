local gt = this.getroottable();

gt.Const.LegendMod.hookMSU <- function()
{
	local canResurrectOnTile = this.MSU.Tile.canResurrectOnTile;
	this.MSU.Tile.canResurrectOnTile = function( _tile, _force = false )
	{
		if (!canResurrectOnTile(_tile, _force)) 
		{
			return false;
		}

		if (_targetTile.Properties.Effect.Type == "legend_holyflame") 
		{
			return false;
		}

		return true;
	}
}