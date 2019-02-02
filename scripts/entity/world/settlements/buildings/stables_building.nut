this.kennel_building <- this.inherit("scripts/entity/world/settlements/buildings/building", {
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
		this.m.ID = "building.kennel";
		this.m.Name = "Stables";
		this.m.Description = "Horses are bred and kept at the stables";
		this.m.UIImage = "ui/settlements/building_14";
		this.m.UIImageNight = "ui/settlements/building_14_night";
		this.m.Tooltip = "world-town-screen.main-dialog-module.Kennel";
		this.m.TooltipIcon = "ui/icons/buildings/stables.png";
		this.m.Stash = this.new("scripts/items/stash_container");
		this.m.Stash.setResizable(true);
		this.m.Sounds = [
			{
				File = "ambience/buildings/kennel_cage_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_cage_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_cage_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_10.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_11.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_12.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
			{
				File = "ambience/buildings/kennel_cage_00.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_cage_01.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_cage_02.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_00.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_01.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_02.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_03.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_04.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_05.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_06.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_07.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_08.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_09.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_10.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_11.wav",
				Volume = 0.5,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/kennel_dog_12.wav",
				Volume = 0.5,
				Pitch = 1.0
			}
		];
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
				R = 0,
				P = 1.0,
				S = "accessory/horse_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "accessory/horse_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "accessory/armored_wardog_item"
			}
		];

		if (this.Const.DLC.Unhold)
		{
			list.extend([
				{
					R = 40,
					P = 1.0,
					S = "misc/wardog_armor_upgrade_item"
				}
			]);
		}

		if (this.isSomethingToSee() && this.World.getTime().Days >= 7)
		{
			list = [
				{
					R = 0,
					P = 1.0,
					S = "supplies/goat_cheese_item"
				}
			];
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 0.75, false);
	}

	function onUpdateDraftList( _list )
	{
		_list.push("houndmaster_background");
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
