::mods_hookDescendants("entity/tactical/actor", function(o)
{

	if(!("assignRandomEquipment" in o)) return
	local assignRandomEquipment = o.assignRandomEquipment
	o.assignRandomEquipment = function()
	{
		assignRandomEquipment()
		this.Const.ItemTables.equipActor(this)
	}

});