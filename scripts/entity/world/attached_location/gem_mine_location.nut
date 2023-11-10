this.gem_mine_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Gem Mine";
		this.m.ID = "attached_location.gem_mine";
		this.m.Description = "The shiny gems found in this mine are usually brought directly to the next settlement in well-guarded caravans for further refinement. Contributes gems, miners, pickaxes, sellswords, caravan hands and thieves to the local town.";
		this.m.Sprite = "world_gem_mine_01";
		this.m.SpriteDestroyed = "world_gem_mine_01_ruins";
	}

	function getSounds( _all = true )
	{
		local r = [];

		if (this.World.getTime().IsDaytime)
		{
			r = [
				{
					File = "ambience/settlement/mines_00.wav",
					Volume = 1.25,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/mines_01.wav",
					Volume = 1.25,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/mines_shoveling_00.wav",
					Volume = 1.25,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/mines_shoveling_01.wav",
					Volume = 1.25,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/mines_shoveling_02.wav",
					Volume = 1.25,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/mines_shoveling_03.wav",
					Volume = 1.25,
					Pitch = 1.0
				}
			];

			foreach( s in r )
			{
				s.Volume *= this.Const.Sound.Volume.Ambience / this.Const.Sound.Volume.AmbienceOutsideSettlement;
			}
		}

		return r;
	}

	function onUpdateProduce( _list )
	{
		_list.push("trade/uncut_gems_item");
		_list.push("trade/legend_gem_shards_item");
	}

	function onUpdateDraftList( _list, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if (!this.isActive())
		{
			return;
		}

		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("sellsword_background");
		_list.push("caravan_hand_background");
		_list.push("thief_background");

	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/pickaxe"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/pickaxe"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "weapons/military_pick"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_enchant"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/uncut_gems_item"
			});
			_list.push({
				R = 30,
				P = 1.1,
				S = "loot/gemstones_item"
			});
			_list.push({
				R = 80,
				P = 1.2,
				S = "loot/glittering_rock_item"
			});
			_list.push({
				R = 95,
				P = 1.3,
				S = "loot/jeweled_crown_item"
			});
			_list.push({
				R = 95,
				P = 1.3,
				S = "loot/signet_ring_item"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
	}

	function getNewResources()
	{
		return 2;
	}

});

