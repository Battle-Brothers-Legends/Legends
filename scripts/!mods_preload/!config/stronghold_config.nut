local gt = this.getroottable();
gt.Const.World.StrongholdPriceMult <- 1000;
gt.getPlayerBase <- function()
{
	local player_faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player)
	if (player_faction)
	{
		local player_settlements = player_faction.getSettlements()
		if (player_settlements.len() > 0)
		{
			return player_settlements[0]
		}
	}
	foreach (settlement in this.World.EntityManager.getSettlements())
	{
		if ("isPlayerBase" in settlement.m)
		{
			return settlement
		}
	}
	return false
}
