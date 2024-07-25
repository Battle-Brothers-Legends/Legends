this.trader_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		Stash = null
	},
	function getStash()
	{
		return this.m.Stash;
	}

	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Trader;
		this.m.Escorting = true;		
		this.m.Slot = "trader";
		this.m.Name = "Trader";
		this.m.Description = "A shady character selling ill gotten goods";
		this.m.BannerImage = "ui/buttons/banner_rest.png"
		this.m.CanEnter = true;
		this.m.Stash = this.new("scripts/items/stash_container");
		this.m.Stash.setID("shop");
		this.m.Stash.setResizable(true);
	}

	function getDescription()
	{
		local desc = "";
		desc += "Unscrupulous trader hanging around camp"
		desc += "Perhaps something worth buying"
		return desc;
	}

	function getLevel()
	{
		local pro = "dude";
		local sub = "empty";
		if (this.getAssignedBros() > 0) {
			sub =  "full";
		}
		return pro + "_" + sub;
	}

	function getAssignedBros()
	{
		local mod = this.getModifiers();
		return mod.Assigned;
	}

	function getModifiers()
	{
		local ret = 
		{
			Assigned = 0
		}
		local roster = this.World.getPlayerRoster().getAll();
		foreach( bro in roster )
		{
			if (bro.getCampAssignment() != this.m.ID)
			{
				continue
			}
			++ret.Assigned
		}
		return ret;
	}


	function completed()
	{
	}
	
	function getResults()
	{
	}

	function onClicked( _campScreen )
	{
		_campScreen.getShopDialogModule().setShop(this);
		_campScreen.showShopDialog();
		this.camp_building.onClicked(_campScreen);
	}

	function onSettlementEntered()
	{
		foreach( item in this.m.Stash.getItems() )
		{
			if (item != null)
			{
				item.setSold(false);
			}
		}
	}

	function onUpdateShopList()
	{
		local list = [
			{
				R = 10,
				P = 1.0,
				S = "weapons/bludgeon"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/militia_spear"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/legend_militia_glaive"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/legend_wooden_spear"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/pitchfork"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/knife"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/legend_shiv"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/hatchet"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/legend_shovel"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/short_bow"
			},
				{
				R = 15,
				P = 1.0,
				S = "weapons/legend_sling"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 30,
				P = 1.0,
				S = "ammo/quiver_of_arrows"
			},
			{
				R = 10,
				P = 1.0,
				S = "armor/sackcloth"
			},
			{
				R = 20,
				P = 1.0,
				S = "armor/linen_tunic"
			},
			{
				R = 25,
				P = 1.0,
				S = "armor/thick_tunic"
			},
			{
				R = 10,
				P = 1.0,
				S = "helmets/straw_hat"
			},
			{
				R = 20,
				P = 1.0,
				S = "helmets/hood"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/legend_drum"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/legend_cat_o_nine_tails"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/lute"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/buckler_shield"
			},
			{
				R = 20,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 25,
				P = 1.0,
				S = "accessory/legend_pack_small"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/ground_grains_item"
			},
			{
				R = 40,
				P = 1.0,
				S = "supplies/legend_fresh_fruit_item"
			},
			{
				R = 20,
				P = 1.0,
				S = "supplies/legend_fresh_meat_item"
			},
			{
				R = 30,
				P = 1.0,
				S = "supplies/roots_and_berries_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			},
				{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_small_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
				{
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "accessory/bandage_item"
			}
		];

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, true);
	}

	function isHidden()
	{
		return !this.World.Flags.get("HasLegendCampTrader")
	}


	function onSerialize( _out )
	{
		this.camp_building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.camp_building.onDeserialize(_in);
	}
	
});
