this.armorsmith_building <- this.inherit("scripts/entity/world/settlements/buildings/building", {
	m = {
		Stash = null
	},
	function getStash()
	{
		return this.m.Stash;
	}

	function create()
	{
		this.building.create();
		this.m.ID = "building.armorsmith";
		this.m.Name = "Armorer";
		this.m.Description = "This armorer\'s workshop is the right place to look for well-made and durable protection";
		this.m.UIImage = "ui/settlements/building_01";
		this.m.UIImageNight = "ui/settlements/building_01_night";
		this.m.Tooltip = "world-town-screen.main-dialog-module.Armorsmith";
		this.m.TooltipIcon = "ui/icons/buildings/armorsmith.png";
		this.m.IsRepairOffered = true;
		this.m.Stash = this.new("scripts/items/stash_container");
		this.m.Stash.setID("shop");
		this.m.Stash.setResizable(true);
		this.m.Sounds = [
			{
				File = "ambience/buildings/blacksmith_hammering_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hammering_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hammering_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hammering_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hammering_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hammering_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hammering_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hammering_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hammering_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hammering_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hammering_10.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_hot_water_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_scrape_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_sharpening_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_sharpening_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_sharpening_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_sharpening_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_sharpening_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/blacksmith_sharpening_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [];
	}

	function onClicked( _townScreen )
	{
		_townScreen.getShopDialogModule().setShop(this);
		_townScreen.showShopDialog();
		this.pushUIMenuStack();
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
				R = 20,
				P = 1.0,
				S = "armor/padded_leather"
			},
			{
				R = 20,
				P = 1.0,
				S = "armor/basic_mail_shirt"
			},
			{
				R = 30,
				P = 1.0,
				S = "armor/mail_shirt"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/mail_coif"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/closed_mail_coif"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet"
			},
			{
				R = 65,
				P = 1.0,
				S = "helmets/kettle_hat"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/buckler_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 50,
				P = 1.0,
				S = "shields/heater_shield"
			},
			{
				R = 75,
				P = 1.0,
				S = "shields/legend_tower_shield"
			},
			{
				R = 45,
				P = 1.0,
				S = "shields/kite_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "armor/leather_lamellar"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/mail_hauberk"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/lamellar_harness"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			},
			{
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			},
			{
				R = 80,
				P = 1.0,
				S = "tents/tent_scrap"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/leather_lamellar"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/mail_hauberk"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/lamellar_harness"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			},
			{
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			},
			{
				R = 70,
				P = 1.0,
				S = "armor/scale_armor"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/heavy_lamellar_armor"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet_with_mail"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/bascinet_with_mail"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/kettle_hat_with_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/kettle_hat_with_closed_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/nasal_helmet_with_closed_mail"
			},
			{
				R = 45,
				P = 1.0,
				S = "helmets/reinforced_mail_coif"
			}
		];

		foreach( i in this.Const.Items.NamedArmors )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.NamedHelmets )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		if (this.Const.DLC.Unhold)
		{
			list.push({
				R = 45,
				P = 1.0,
				S = "armor/leather_scale_armor"
			});
			list.push({
				R = 55,
				P = 1.0,
				S = "armor/light_scale_armor"
			});
			list.push({
				R = 90,
				P = 1.0,
				S = "armor/noble_mail_armor"
			});
			list.push({
				R = 60,
				P = 1.0,
				S = "armor/sellsword_armor"
			});
			list.push({
				R = 50,
				P = 1.0,
				S = "armor/footman_armor"
			});
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/sallet_helmet"
			});
			list.push({
				R = 80,
				P = 1.0,
				S = "helmets/barbute_helmet"
			});
			list.push({
				R = 60,
				P = 1.0,
				S = "misc/paint_set_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_remover_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_black_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_orange_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_blue_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_green_yellow_item"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/metal_plating_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/metal_pauldrons_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/mail_patch_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/leather_shoulderguards_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/leather_neckguard_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/joint_cover_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/heraldic_plates_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/double_mail_upgrade"
			});
		}

		if (this.Const.DLC.Wildmen && this.m.Settlement.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.7)
		{
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/nordic_helmet"
			});
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/steppe_helmet_with_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/conic_helmet_with_closed_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/nordic_helmet_with_closed_mail"
			});
			list.push({
				R = 80,
				P = 1.0,
				S = "helmets/conic_helmet_with_faceguard"
			});
		}
		else
		{
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/flat_top_helmet"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/flat_top_with_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/flat_top_with_closed_mail"
			});
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.25, false);
	}

	function onUpdateLegendShopList( _id = null, _list = null )
	{
		local list = [
			{
				R = 50,
				P = 1.0,
				S = "helmets/mail_coif"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/closed_mail_coif"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet"
			},
			{
				R = 65,
				P = 1.0,
				S = "helmets/kettle_hat"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/buckler_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 50,
				P = 1.0,
				S = "shields/heater_shield"
			},
			{
				R = 75,
				P = 1.0,
				S = "shields/legend_tower_shield"
			},
			{
				R = 45,
				P = 1.0,
				S = "shields/kite_shield"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			},
			{
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			},
			{
				R = 80,
				P = 1.0,
				S = "tents/tent_scrap"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			},
			{
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet_with_mail"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/bascinet_with_mail"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/kettle_hat_with_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/kettle_hat_with_closed_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/nasal_helmet_with_closed_mail"
			},
			{
				R = 45,
				P = 1.0,
				S = "helmets/reinforced_mail_coif"
			}
		];

		local armorsL = [
		   [15, 1.0, "cloth/legend_gambeson"],
		   [15, 1.0, "cloth/legend_padded_surcoat"],
           [20, 1.0, "chain/legend_armor_mail_shirt_simple"],
           [20, 1.0, "chain/legend_armor_mail_shirt"],
           [35, 1.0, "chain/legend_armor_hauberk_sleevless"],
           [35, 1.0, "chain/legend_armor_short_mail"],
           [35, 1.0, "chain/legend_armor_basic_mail"],
           [35, 1.0, "chain/legend_armor_hauberk"],
           [40, 1.0, "chain/legend_armor_hauberk_full"],
           [40, 1.0, "chain/legend_armor_reinforced_mail"],
           [50, 1.0, "chain/legend_armor_reinforced_mail_shirt"],
           [35, 1.0, "plate/legend_armor_leather_padded"],
           [35, 1.0, "plate/legend_armor_leather_noble"],
           [35, 1.0, "plate/legend_armor_leather_lamellar_harness_reinforced"],
           [40, 1.0, "plate/legend_armor_leather_lamellar"],
           [40, 1.0, "plate/legend_armor_leather_riveted"],
           [40, 1.0, "plate/legend_armor_leather_riveted_light"],
           [45, 1.0, "plate/legend_armor_leather_scale"],
           [50, 1.0, "plate/legend_armor_leather_lamellar_harness_heavy"],
           [50, 1.0, "plate/legend_armor_leather_brigandine"],
           [50, 1.0, "plate/legend_armor_leather_lamellar_reinforced"],
           [55, 1.0, "plate/legend_armor_leather_lamellar_heavy"],
           [55, 1.0, "plate/legend_armor_leather_brigandine_hardened"],
           [55, 1.0, "plate/legend_armor_leather_brigandine_hardened_full"],
           [60, 1.0, "plate/legend_armor_plate_chest"],
           [60, 1.0, "plate/legend_armor_scale_shirt"],
           [65, 1.0, "plate/legend_armor_plate_cuirass"],
           [65, 1.0, "plate/legend_armor_scale"],
           [70, 1.0, "plate/legend_armor_scale_coat"],
           [75, 1.0, "plate/legend_armor_plate_full"],
		   [75, 1.0, "plate/legend_armor_plate_full_greaves"],
		   [65, 1.0, "cloak/legend_armor_cloak_common"],
		   [99, 2.0, "named/legend_armor_cloak_rich"],
		   [85, 1.0, "cloak/legend_armor_cloak_noble"],
		   [50, 1.0, "cloak/legend_armor_cloak_heavy"],
		   [65, 1.0, "tabard/legend_armor_tabard"],
		   [99, 2.0, "tabard/legend_armor_named_tabard"]
		]

		foreach( a in armorsL)
		{
			list.push({
				R = a[0],
				P = a[1],
				S = "legend_armor/" + a[2]
			});
		}

		foreach( i in this.Const.Items.LegendNamedArmorLayers )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.NamedHelmets )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		if (this.Const.DLC.Unhold)
		{
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/sallet_helmet"
			});
			list.push({
				R = 80,
				P = 1.0,
				S = "helmets/barbute_helmet"
			});
			list.push({
				R = 60,
				P = 1.0,
				S = "misc/paint_set_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_remover_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_black_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_orange_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_blue_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_green_yellow_item"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_metal_plating_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_metal_pauldrons_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_mail_patch_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_leather_shoulderguards_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_leather_neckguard_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_joint_cover_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_heraldic_plates_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_double_mail_upgrade"
			});
		}

		if (this.Const.DLC.Wildmen && this.m.Settlement.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.7)
		{
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/nordic_helmet"
			});
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/steppe_helmet_with_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/conic_helmet_with_closed_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/nordic_helmet_with_closed_mail"
			});
			list.push({
				R = 80,
				P = 1.0,
				S = "helmets/conic_helmet_with_faceguard"
			});
		}
		else
		{
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/flat_top_helmet"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/flat_top_with_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/flat_top_with_closed_mail"
			});
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.25, false);
	}

	function onSerialize( _out )
	{
		this.building.onSerialize(_out);
		this.m.Stash.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.building.onDeserialize(_in);
		this.m.Stash.onDeserialize(_in);
	}

});

