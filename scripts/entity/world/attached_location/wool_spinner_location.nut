this.wool_spinner_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "Wool Spinner";
		this.m.ID = "attached_location.wool_spinner";
		this.m.Description = "The wool of the sheep herded here is spun into wool and then shipped to the next settlement. Refined wares like these can be quite valuable.";
		this.m.Sprite = "world_wool_spinner_01";
		this.m.SpriteDestroyed = "world_wool_spinner_01_ruins";
	}

	function onUpdateProduce( _list )
	{
		_list.push("trade/cloth_rolls_item");
	}

	function onUpdateDraftList( _list, _gender)
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("apprentice_background");
		_list.push("caravan_hand_background");
		_list.push("tailor_background");
		_list.push("tailor_background");
		_list.push("shepherd_background");
		if (_gender)
		{
		_list.push("female_tailor_background");

		}
		if(this.World.LegendsMod.Configs().LegendMagicEnabled())
		{
			_list.push("legend_enchanter_background");
		}
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/linen_tunic"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/linen_tunic"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/hood"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_heal"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_fletcher"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_enchant"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_craft"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/cloth_rolls_item"
			});

			if (this.World.LegendsMod.Configs().LegendArmorsEnabled())
			{
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_tunic_collar_thin"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_tunic_wrap"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_tunic_collar_deep"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_peasant_dress"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_robes"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_ancient_cloth_restored"
				});
				_list.push({
					R = 20,
					P = 1.0,
					S = "legend_armor/cloth/legend_thick_tunic"
				});
				_list.push({
					R = 40,
					P = 1.0,
					S = "legend_armor/cloth/legend_robes_nun"
				});
				_list.push({
					R = 30,
					P = 1.0,
					S = "legend_armor/cloth/legend_gambeson"
				});
				_list.push({
					R = 90,
					P = 1.0,
					S = "legend_armor/cloth/legend_robes_magic"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "legend_armor/cloak/legend_armor_cloak_common"
				});
				_list.push({
					R = 95,
					P = 1.0,
					S = "legend_armor/cloak/legend_armor_cloak_noble"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "legend_armor/cloak/legend_armor_cloak_heavy"
				});
				_list.push({
					R = 99,
					P = 2.0,
					S = "legend_armor/named/legend_armor_cloak_rich"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "legend_armor/cloak/legend_sash"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "legend_armor/tabard/legend_common_tabard"
				});
				_list.push({
					R = 99,
					P = 2.0,
					S = "legend_armor/named/legend_armor_named_tabard"
				});
			}


		}
		else if (_id == "building.specialized_trader")
		{
		}
	}

});

