gt.Const.LegendMod.addLegendItemTypes <- function()
{
	this.Const.Items.addNewItemType("HorseArmor");
	this.Const.Items.ItemFilter.HorseArmor <- this.Const.Items.ItemType.HorseArmor;
	this.Const.Items.addNewItemType("HorseHelmet");
	this.Const.Items.addNewItemType("Cultist", "Cultist Item");
}
