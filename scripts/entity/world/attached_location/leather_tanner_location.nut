this.leather_tanner_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Leather Tanner";
		this.m.ID = "attached_location.leather_tanner";
		this.m.Description = "This leather tanner\'s workshop produces durable leather pieces from hides. The supply of this leather will increase the availability of light armor in the nearest settlement.";
		this.m.Sprite = "world_leather_tanner_01";
		this.m.SpriteDestroyed = "world_leather_tanner_01_ruins";
	}

	function onUpdateDraftList( _list, _gender)
	{
		if (!this.isActive())
		{
			return;
		}
		_list.push("legend_taxidermist_background");
		_list.push("legend_taxidermist_background");
		_list.push("militia_background");
		_list.push("apprentice_background");
		_list.push("retired_soldier_background");
		_list.push("butcher_background");
		_list.push("butcher_background");

		if(this.World.LegendsMod.Configs().LegendMagicEnabled())
		{
			local r;
			if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_seer")
			{
			r = this.Math.rand(0, 25);
				if (r == 1)
				{
				_list.push("legend_ancient_summoner_background");
				}
			}
			else if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_warlock")
			{
				_list.push("legend_ancient_summoner_background");
			}
			else
			{
			r = this.Math.rand(0, 49);
				if (r == 1)
				{
				_list.push("legend_ancient_summoner_background");
				}
			}
		}

	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/leather_tunic"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/leather_tunic"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/apron"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_chain"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/full_leather_cap"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_hunter"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_craft"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/full_leather_cap"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/leather_lamellar"
			});
			_list.push({
				R = 35,
				P = 1.0,
				S = "armor/mail_hauberk"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			});
			_list.push({
				R = 35,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			});
			_list.push({
				R = 45,
				P = 1.0,
				S = "helmets/closed_flat_top_helmet"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "shields/kite_shield"
			});
		}
	}

});

