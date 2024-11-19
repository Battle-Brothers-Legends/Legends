::mods_hookExactClass("entity/world/settlements/situations/archery_contest_situation", function(o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function ( _draftList )
	{
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
		onUpdateDraftList(_draftList);
	}
});
