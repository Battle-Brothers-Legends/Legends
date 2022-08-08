this.legend_lonewolf_companion_caravan_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Looted = 0
	},
	function create()
	{
		this.m.ID = "event.legend_lonewolf_companion_caravan";
		this.m.Title = "Encircled";
		this.m.Cooldown = 47.0 * this.World.getTime().SecondsPerDay; //—
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_60.png[/img]{As you travel along the road, the narrow meandering path breaks way into a crossroads where three large carts are circled around a dying tree. The caravan seems to not be under attack, right until a rock appears in the air from the treeline at unnatural speed and bounces off your helmet with a superhuman precision. WHile dazed, a naked man covered in leaves, mud and filth breaks from the treeline flanked by a half dozen similar fighters — all screaming at the top of their lungs.\n %randombro% takes their weapon and drives it down into a wildwoman\'s torso, pinning her to the floor as she screams. Another comes at you only to be cut to pieces by the rest of the company who jump to your side.\n\n In the distance a group of merchants are standing on their wagons, firing crossbow bolts into the groups of swarming wildmen while what remains of the caravan guards attempt to claw some space back from the screaming throng. A tailor hides under wagon, occasionally stabbing a wooden spear at the wildmen who try to pull them out from underneith the safety of the broke cart.}",
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
			Text = "[img]gfx/ui/events/event_98.png[/img]{The company gets into a tight formation — so tight that you can feel yourself being pushed and hemmed in as you all move in a single effort around the battlefield to one of the less guarded carts. A wildman perches in the back, rubbing the fine silks and linen between his fingertips, shortly before %randombro% pulls them by the ankles off the cart and stamps them down until he stops moving. The cart has several sealed crates and lockboxes, of which the company is only able to take a few of before attracting attention from the wildmen again.\n\n A few wildmen begin to make noise in your direction as %companyname% backs up slowly while hauling the lighter chests away with whatever free hands they have. As you make distance, the wildmen lose interest again and return back to the caravan. Screams are heard but the melee is hard to distinguish as you move away. The company survived with a few wounds, dented helmets and rock-induced headaches to show for it.\n\n The company gathers as %randombro% cracks open the first chest...}",
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
						item = this.new("gold_ingot_item");
						item = this.new("legend_cooking_spices_item");
					}
					else if (r == 2)
					{
						item = this.new("silverware_item");
						item = this.new("incense_item");
						item = this.new("signet_ring_item");
					}
					else if (r == 3)
					{
						item = this.new("cloth_rolls_item");
						item = this.new("furs_item");
						item = this.new("cloth_rolls_item");
						item = this.new("signet_ring_item");
					}
					else if (r == 4) //worst
					{
						item = this.new("legend_raw_wood_item");
						item = this.new("peat_bricks_item");
						item = this.new("peat_bricks_item");
					}

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

				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						if (this.Math.rand(1, 100) <= 66)
						{
							local injury = bro.addInjury(this.Const.Injury.Brawl);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " suffers " + injury.getNameOnly()
							});
						}
						else
						{
							bro.addLightInjury();
							this.List.push({
								id = 10,
								icon = "ui/icons/days_wounded.png",
								text = bro.getName() + " suffers light wounds"
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({ //tailor recruit
			ID = "C",
			Text = "[img]gfx/ui/events/event_86.png[/img]{You order to push through into the wildmen — but instead of the gradual, steady advance you had planned, %companyname% breaks into a running sprint, weapons held high in the air to make clear their intentions. Perhaps they didn\'t hear you, or perhaps they felt it best to match the aggression of their opponents. %randombro% buries their weapon in the back of a distracted wildman while another kicks a wildwoman towards you, who you skewer to the ground while the rest of the company join in. An errant club flies through the air and a cry of pain is heard as Wildmen swarm %randombro% while they are on the ground — beating and kicking them as the rest of the company attack the mob from behind.\n\n You turn just in time to avoid a rock to the back of the head. The wildman who missed their chance is hit so hard by you that, just for a moment, you question if you had hit anything at all — then you see the ruin of a man sprawled down at your feet.\n The rocks are coming faster now, like a hailstorm that is hammering every shield, helmet and inch of the ground around %companyname% is showered with projectiles.\n\n They fall.\n\n And fall.\n\n And fall.\n\n Then all at once — the onslaught stops. Most of the wildmen are gone, the more injured of the horde left for dead with gaping wounds across their naked bodies. You spy the carts and see everything has been taken from them, like an ocean tide the lunatics of nature came and swept away everything not heavy enough for two men or fewer to carry. %randombro% gets up, but has seen better days as they smile at you with bloody teeth.\n\n The merchant under the cart is as suprised as you are — and pleads to stay with you for a little while longer.}",
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
				]);
				_event.m.Dude.getSprite("miniboss").setBrush("bust_miniboss");
				_event.m.Dude.getBaseProperties().Hitpoints += 7;
				_event.m.Dude.getBaseProperties().Bravery += 5;
				_event.m.Dude.getBaseProperties().Stamina += 6;
				_event.m.Dude.getBaseProperties().MeleeSkill += 8;
				_event.m.Dude.getBaseProperties().RangedSkill += 6;
				_event.m.Dude.getBaseProperties().MeleeDefense += 5;
				_event.m.Dude.getBaseProperties().RangedDefense += 7;
				_event.m.Dude.getBaseProperties().Initiative += 10;
				_event.m.Dude.addLightInjury();

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}
				
				_event.m.Dude.getItems().equip(this.new("scripts/items/weapons/legend_wooden_spear"));

				_event.m.Dude.getBackground().m.RawDescription = "%name% has been hardened by an experience few of %their% ilk live through — a roadside ambush. While they they unlikely to survive, a little help from %companyname% changed that.";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());

				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						if (this.Math.rand(1, 100) <= 66)
						{
							local injury = bro.addInjury(this.Const.Injury.Brawl);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " suffers " + injury.getNameOnly()
							});
						}
						else
						{
							bro.addLightInjury();
							this.List.push({
								id = 10,
								icon = "ui/icons/days_wounded.png",
								text = bro.getName() + " suffers light wounds"
							});
						}
					}
				}
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

		// if (this.World.getTime().Days < 38)
		// {
		// 	return;
		// }

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
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Looted = null;
	}

});

