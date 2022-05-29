this.legend_lonewolf_companion_caravan_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Bro1 = null,
		Bro2 = null,
		Bro3 = null,
		Looted = 0
	},
	function create()
	{
		this.m.ID = "event.legend_lonewolf_companion_caravan";
		this.m.Title = "Encircled";
		this.m.Cooldown = 47.0 * this.World.getTime().SecondsPerDay; //—
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_60.png[/img]{As you travel along the road, the narrow meandering path breaks way into a crossroads where three large carts are circled around a dying tree. The caravan seems to not be under attack, right until a rock appears in the air from the treeline at unnatural speed and bounces off your helmet with a superhuman precision. WHile dazed, a naked man covered in leaves, mud and filth breaks from the treeline flanked by a half dozen similar fighters — all screaming at the top of their lungs.\n %Bro1% takes their weapon and drives it down into a wildwoman\'s torso, pinning her to the floor as she screams. Another comes at you only to be cut to pieces by the rest of the company.\n\n In the distance a group of merchants are standing on their wagons, firing crossbows into the groups of swarming wildmen while what remains of the caravan guards attempt to get some space back from the screaming throng. A tailor hides under wagon, occasionally stabbing a broken spear at the wildmen who try to pull them out.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Circle around! Take what you can!",
					function getResult( _event )
					{
						return "B"; //B = loot items
					}

				},
				{
					Text = "Push through to the carts!",
					function getResult( _event )
					{
						return "C"; //C = tailor recruit
					}

				},
				{
					Text = "Retreat, this isn\'t our fight!", //D = skip
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({ //B = loot items
			ID = "B",
			Text = "[img]gfx/ui/events/event_98.png[/img]{The company gets into a tight formation — so tight that you can feel yourself being pushed and pulled around as you all move in a single effort around the battlefield to one of the less guarded carts. A wildman is in the back, rubbing the fine tilks and linen between his fingertips, shortly before %randombro% pulls them by the ankles off the cart and stamps them down until he stops moving. The cart has several sealed crates and lockboxes, of which the company is only able to take a few of before attracting attention from the wildmen again.\n\n %companyname% backs up slowly while hauling the lighter chests away with whatever free hands they have. As you make distance, the wildmen lose interest again and return back to the caravan. Screams are heard but the melee is hard to distinguish as you move away. The company survived, but with a few ringing ears, dented helmets and rock-induced headaches to show for it.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Not a bad haul...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(98, 455);
				this.World.Assets.addMoney(money);
				switch(_event.m.Looted)
				{
				case 1:
					local r = this.Math.rand(1, 4); //item sets
					local item;

					if (r == 1) //best
					{
						item = this.new("silk_item");
						item = this.new("silverware_item");
						item = this.new("silk_item");
						item = this.new("silk_item");
						item = this.new("salt_item");
						item = this.new("legend_cooking_spices_item");
					}
					else if (r == 2)
					{
						item = this.new("ornate_tome_item");
						item = this.new("silverware_item");
						item = this.new("incense_item");
						item = this.new("gold_ingot_item");
						item = this.new("furs_item");
					}
					else if (r == 3)
					{
						item = this.new("cloth_rolls_item");
						item = this.new("cloth_rolls_item");
						item = this.new("furs_item");
						item = this.new("cloth_rolls_item");
						item = this.new("signet_ring_item");
					}
					else if (r == 4) //worst
					{
						item = this.new("legend_raw_wood_item");
						item = this.new("tin_ingots_item");
						item = this.new("peat_bricks_item");
						item = this.new("peat_bricks_item");
					}

					_event.m.Bro1.addLightInjury();
					_event.m.Bro2.addLightInjury();
					_event.m.Bro3.addLightInjury();

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					this.World.Assets.addMoney(money);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gained [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
					});
				}
			}

		});
		this.m.Screens.push({ //tailor recruit
			ID = "C",
			Text = "[img]gfx/ui/events/event_86.png[/img]{You order to push through into the wildmen — but instead of the gradual, steady advance you had planned, %companyname% breaks into a running sprint, weapons held high in the air to make clear their intentions. Perhaps they didn\'t hear you, or perhaps they felt it best to match the aggression of their opponents. %bro2% buries their weapon in the back of a distracted wildman while %bro3% kicks a wildwoman towards %bro1%, who skewers her to the ground again like they did with the last one, but takes a club to body for their trouble. Wildmen swarm %bro1% wheil they are on the ground — beating and kicking them while the rest of the company attack them from behind.\n\n You turn just in time to avoid a rock to the back of the head. As a wildman who missed their chance is hit so hard by you that, just for a moment, you question if you had hit anything at all. Right befrore you see the ruin of a man sprawled down at your feet. The rocks are coming faster now, like a hailstorm that is hammering every shield, helmet and inch of the ground around %companyname% They fall. And fall. And fall.\n\n Then all at once — the onslaught stops. Most of the wildmen are gone, the more injured of the band left for dead with gaping wounds across their naked bodies. You spy the carts and see everything has been taken from them, like an ocean tide the lunatics of nature came and swept away everything not heavy enough for two men to carry. %bro1% gets up, but has seen better days. They smile at you with bloody teeth.\n\n The merchant under the cart is as suprised as you are — and pleads to stay with you a little while longer.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "After all that, they can\'t be that bad of a fighter.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"tailor_background"

				_event.m.Dude.getSprite("miniboss").setBrush("bust_miniboss");
				_event.m.Dude.getBaseProperties().Hitpoints += 7;
				_event.m.Dude.getBaseProperties().Bravery += 5;
				_event.m.Dude.getBaseProperties().Stamina += 6;
				_event.m.Dude.getBaseProperties().MeleeSkill += 8;
				_event.m.Dude.getBaseProperties().RangedSkill += 6;
				_event.m.Dude.getBaseProperties().MeleeDefense += 5;
				_event.m.Dude.getBaseProperties().RangedDefense += 7;
				_event.m.Dude.getBaseProperties().Initiative += 10;

				_event.m.Dude.items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));

				_event.m.Dude.getBackground().m.RawDescription = "%name% has been hardened by an experience few of %their% ilk live through — a roadside ambush. While they they unlikely to survive, a little help from %companyname% changed that. You can\'t deny that they have changed since they got a taste for blood.";
				_event.m.Dude.addLightInjury();

				_event.m.Bro1.addLightInjury();
				_event.m.Bro1.addInjury(this.Const.Injury.Brawl);	
				_event.m.Bro2.addLightInjury();
				_event.m.Bro3.addLightInjury();
				]);
				this.Characters.push(_event.m.Dude.getImagePath());
			}
		});
		this.m.Screens.push({ //skip
			ID = "D",
			Text = "[img]gfx/ui/events/event_36.png[/img]This battle has been long since lost, and you aren\'t willing to dirty your hands in matters like these.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "These things happen...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.lone_wolf")
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days < 38)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		if (brothers.len() > 4)
		{
			return;
		}

		this.m.Score = 8;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"recruit",
			this.m.Dude.getName()
		]);
		_vars.push([
			"Bro1",
			this.m.Bro1.getNameOnly()
		]);
		_vars.push([
			"Bro2",
			this.m.Bro1.getNameOnly()
		]);
		_vars.push([
			"Bro3",
			this.m.Bro1.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Bro1 = null;
		this.m.Bro2 = null;
		this.m.Bro3 = null;
		this.m.Looted = null;
	}

});

