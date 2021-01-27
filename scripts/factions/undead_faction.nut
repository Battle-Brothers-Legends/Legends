this.undead_faction <- this.inherit("scripts/factions/faction", {
	m = {},
	function create()
	{
		this.faction.create();
		this.m.Type = this.Const.FactionType.Undead;
		this.m.Base = "world_base_03";
		this.m.TacticalBase = "bust_base_undead";
		this.m.CombatMusic = this.Const.Music.UndeadTracks;
		this.m.Footprints = this.Const.UndeadFootprints;
		this.m.PlayerRelation = 0.0;
		this.m.IsRelationDecaying = false;
		this.m.BannerPrefix = "banner_undead_";
	}

	function onSerialize( _out )
	{
		this.faction.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.faction.onDeserialize(_in);
	}

	function getUIBanner()
	{
		return "ui/banners/banner_skeletons_" + (this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner) + ".png";
	}

	function getUIBannerSmall()
	{
		return "ui/banners/banner_skeletons_" + (this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner) + "s.png";
	}

	function getBannerSmall()
	{
		return "banner_skeletons_" + (this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner);
	}

});

