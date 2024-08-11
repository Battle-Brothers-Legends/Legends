local gt = this.getroottable();

gt.Const.LegendMod.hookFU <- function()
{
	local canResurrectOnTile = this.canResurrectOnTile;
	this.canResurrectOnTile = function( _tile, _force = false )
	{
		if (!canResurrectOnTile(_tile, _force)) 
		{
			return false;
		}

		if (_tile.Properties.Effect != null && _tile.Properties.Effect.Type == "legend_holyflame") 
		{
			return false;
		}

		return true;
	}

	this.Const.Items.addNewWeaponType("MagicStaff", "Mystic Staff");
	this.Const.Items.addNewWeaponType("Whip", "Whip");

	// we do what we want, gosh
	// TODO the whole vanilla mod thing
	//::FU.System.Keybinds.KeybindsByMod["vanilla"]["world_toggleCamping"].Function = function ()
	//{
	//	if (!this.m.MenuStack.hasBacksteps())
	//	{
	//		this.showCampScreen();
	//		return true;
	//	}
	//}
}
