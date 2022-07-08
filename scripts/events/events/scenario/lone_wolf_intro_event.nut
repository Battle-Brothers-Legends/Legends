this.lone_wolf_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.lone_wolf_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_137.png[/img]{You walk the stands of a jousting arena. Moldy fruits and vegetables litter the floor. Dried blood freckles the seats. And silence fills the air. When you sit, the wood of the place seems to groan in unison as though discomfited by the haunt of a rare visitor.\n\nIn your hands is a note. \'Looking fer hardy men, knowledge of the sword pref\'rred but all welcome.\' It is an old note, its purpose long since served. But what draws your eye is the price offered to the task: more crowns than you could muster in five tournaments.\n\n If this is the coin to be earned, then to hell with the jousts and the sparring. But you\'re not one to suit up for some other captain\'s orders. With all that you\'ve earned over the years you imagine you could start your own mercenary band just fine.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "And that\'s what I\'ll do.",
					function getResult( _event )
					{
						return "B"; //B = Pick a weapon, any weapon
					}

				},
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
		this.m.Screens.push({ //Pick a weapon, any weapon
			ID = "B",
			Text = "[img]gfx/ui/events/event_62.png[/img]{It occurs to you that before you embark on this journey of self discovery, you should probably arm yourself a little better - a lance is pointless without a horse. Your armour is old and you can trade it in for a fair price in exchange for a new set\n\n Visiting the local weaponsmith you spot an array of killing instruments, each carefully dressed and arranged like a breadmaker\'s stall. You only have enough crowns for one set, so you better choose wisely.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [ //maximum 6 options
				{
					Text = "A longsword and medium armour has never failed me.",
					function getResult( _event )
					{
						return "C"; //2h sword
					}

				},
				{
					Text = "A strong hammer, a sturdy shield and medium armour can weather anything.",
					function getResult( _event )
					{
						return "D"; //1h hammer + heater shield
					}

				},
				{
					Text = "An axe and buckler with ligth armour is a good balance and will be the best choice.",
					function getResult( _event )
					{
						return "E"; //Axe and buckler
					}

				},
				{
					Text = "I always was a good shot - I'll take the crossbow and a nice cutting weapon with some light armour.",
					function getResult( _event )
					{
						return "F"; //Crossbow + 1h sword
					}

				},
				{
					Text = "I\'m a little rusty, but a bow and dagger with some nice cloth armour is the proper choice.",
					function getResult( _event )
					{
						return "G"; //Bow + dagger
					}
				},
				{
					Text = "I\'ll stick to what I know - a pike is almost a jousting lance, right? I\'ll get the heavy armour too.",
					function getResult( _event )
					{
						return "H"; //Polearm
					}
				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});	
		this.m.Screens.push({ //Longsword
			ID = "C",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You pick up the longsword from the weapon rack - while not expertly made it has good balance and reach to win almost any fight.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Well balanced and fast. | Versatile and strong.}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				itemweapon.equip(this.new("scripts/items/weapons/legend_longsword"));
				// local item = this.new("scripts/items/weapons/legend_longsword");
				items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"lonewolf_longsword_helmet"
					]
				]));
				items.equip(this.Const.World.Common.pickArmor([
					[
						1,
						"lonewolf_longsword_armour"
					]
				]));
				// local armourhead = getItemAtSlot(this.Const.ItemSlot.Head));
				// armourhead.equip(this.new("scripts/items/armor/lonewolf_longsword_helmet"));
				// local armourhead = this.new("scripts/items/armor/lonewolf_longsword_helmet");
				// local armourbody = this.new("scripts/items/armor/lonewolf_longsword_armour");
				// armourhead.equip(armourhead.getItemAtSlot(this.Const.ItemSlot.Head));
				// armourbody.equip(armourbody.getItemAtSlot(this.Const.ItemSlot.Body));
				// this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + itemweapon.getIcon(),
					text = "You gain " + itemweapon.getName()
				});
			}

		});
		this.m.Screens.push({ //1h hammer + heater shield
			ID = "D",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You take a heater shield and a sturdy pick from the table, the weight of the pick feels good in your hand and balances out the weight of the shield nicely.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{No knight will stand before me! | Nothing is getting past this shield...}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				itemweapon.equip(this.new("scripts/items/weapons/military_pick"));
				itemshield.equip(this.new("scripts/items/shields/heater_shield"));
				items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"lonewolf_hammershield_helmet"
					]
				]));
				items.equip(this.Const.World.Common.pickArmor([
					[
						1,
						"lonewolf_hammershield_armour"
					]
				]));
				this.List.push({
					id = 10,
					icon = "ui/items/" + itemweapon.getIcon(),
					text = "You gain " + itemweapon.getName()
				});
				this.List.push({
					id = 10,
					icon = "ui/items/" + itemshield.getIcon(),
					text = "You gain " + itemshield.getName()
				});
			}

		});
		this.m.Screens.push({ //Axe and buckler
			ID = "E",
			Text = "[img]gfx/ui/events/event_01.png[/img]{Always wanting to break convention - you take a heavy fighting axe and what remains of your crowns is spent on a light buckler.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Heavy hitting and light on my feet.}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				itemweapon.equip(this.new("scripts/items/weapons/fighting_axe"));
				itemshield.equip(this.new("scripts/items/shields/buckler_shield"));
				items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"lonewolf_axebuckler_helmet"
					]
				]));
				items.equip(this.Const.World.Common.pickArmor([
					[
						1,
						"lonewolf_axebuckler_armour"
					]
				]));
				this.List.push({
					id = 10,
					icon = "ui/items/" + itemweapon.getIcon(),
					text = "You gain " + itemweapon.getName()
				});
				this.List.push({
					id = 10,
					icon = "ui/items/" + itemshield.getIcon(),
					text = "You gain " + itemshield.getName()
				});
			}

		});
		this.m.Screens.push({ //Crossbow + 1h sword
			ID = "F",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You grab the crossbow and arming sword from the rack. You look down the sights and wonder how hard it could be to get back into firing one again since your younger days hunting rabbits.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Well, if a peasant can use it... | If all else fails, I still have the sword.}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				itemweapon.equip(this.new("scripts/items/weapons/crossbow"));
				itemquiver.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				itembackup.addToBag(this.new("scripts/items/weapons/arming_sword"));
				items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"lonewolf_crossbowsword_helmet"
					]
				]));
				items.equip(this.Const.World.Common.pickArmor([
					[
						1,
						"lonewolf_crossbowsword_armour"
					]
				]));
				this.List.push({
					id = 10,
					icon = "ui/items/" + itemweapon.getIcon(),
					text = "You gain " + itemweapon.getName()
				});
				this.List.push({
					id = 10,
					icon = "ui/items/" + itemquiver.getIcon(),
					text = "You gain " + itemquiver.getName()
				});
				this.List.push({
					id = 10,
					icon = "ui/items/" + itembackup.getIcon(),
					text = "You gain " + itembackup.getName()
				});
			}

		});
		this.m.Screens.push({ //Bow + dagger
			ID = "G",
			Text = "[img]gfx/ui/events/event_01.png[/img]{You test the string on the hunting bow. Pulling it back reminds you of all the archery tournaments you won in the past and how hard it would be to hit a living, breathing and possible very angry target.\n\nEither way - you still have a nice, sharp dagger if they get close.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{I wonder how far the arrow goes... | It\'s better than a servant\'s knife I guess...}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				itemweapon.equip(this.new("scripts/items/weapons/hunting_bow"));
				itemquiver.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				itembackup.addToBag(this.new("scripts/items/weapons/rondel_dagger"));
				items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"lonewolf_bowdagger_helmet"
					]
				]));
				items.equip(this.Const.World.Common.pickArmor([
					[
						1,
						"lonewolf_bowdagger_armour"
					]
				]));
				this.List.push({
					id = 10,
					icon = "ui/items/" + itemweapon.getIcon(),
					text = "You gain " + itemweapon.getName()
				});
				this.List.push({
					id = 10,
					icon = "ui/items/" + itemquiver.getIcon(),
					text = "You gain " + itemquiver.getName()
				});
				this.List.push({
					id = 10,
					icon = "ui/items/" + itembackup.getIcon(),
					text = "You gain " + itembackup.getName()
				});
			}

		});
		this.m.Screens.push({ //Polearm
			ID = "H",
			Text = "[img]gfx/ui/events/event_01.png[/img]{Perhaps it\'s best to stick to what you are familiar with - a long pike that is much like a jousting lance in function and handling.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{I\'m about to ruin somebody\'s day with this... | Can\'t be much harder than using a lance...}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{

				itemweapon.equip(this.new("scripts/items/weapons/pike"));
				items.equip(this.Const.World.Common.pickHelmet([
					[
						1,
						"lonewolf_polearm_helmet"
					]
				]));
				items.equip(this.Const.World.Common.pickArmor([
					[
						1,
						"lonewolf_polearm_armour"
					]
				]));

				this.List.push({
					id = 10,
					icon = "ui/items/" + itemweapon.getIcon(),
					text = "You gain " + itemweapon.getName()
				});
			}

		});

	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

