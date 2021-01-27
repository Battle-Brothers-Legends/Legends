this.mod_unload_ai_order <- this.inherit("scripts/ai/world/world_behavior", {
	//unloads items from the regular caravan
	//somehow the town is not found as an entity at its tile, and this is one of the enigma functions so I have to work around it by explicity assigning the base
	m = {},
	function create()
	{
		this.world_behavior.create();
		this.m.ID = this.Const.World.AI.Behavior.ID.Unload;
	}

	function onExecute( _entity, _hasChanged )
	{
		local settlement = this.getPlayerBase()
		if(settlement)
		{
			settlement.addSituation(this.new("scripts/entity/world/settlements/situations/mod_well_supplied_ai_situation"), 7);
		}
		this.getController().popOrder();
		return true;
	}

});

