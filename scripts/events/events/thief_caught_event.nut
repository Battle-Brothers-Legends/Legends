this.thief_caught_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.thief_caught";
		this.m.Title = "During camp...";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]During a short rest, your company managed to catch a thief that tried to make off with some of your supplies. The villain\'s clothes are but rags and looks more skeleton than human. What are you going to do with the crook?",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Give that poor soul some food and water.",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "Give the rotter a good beating.",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "Put that thief to the sword.",
					function getResult( _event )
					{
						return "F";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_33.png[/img]Under the cloak of night some thief managed to nick some of your supplies. Supplies that will probably be offered back to you in the next settlement...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Damn thieves!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					local food = this.World.Assets.getFoodItems();
					food = food[this.Math.rand(0, food.len() - 1)];
					this.World.Assets.getStash().remove(food);
					this.List = [
						{
							id = 10,
							icon = "ui/items/" + food.getIcon(),
							text = "You lose " + food.getName()
						}
					];
				}
				else if (r == 2)
				{
					local amount = this.Math.rand(20, 50);
					this.World.Assets.addAmmo(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_ammo.png",
							text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] Ammunition"
						}
					];
				}
				else if (r == 3)
				{
					local amount = this.Math.rand(5, 10);
					this.World.Assets.addArmorParts(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_supplies.png",
							text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] Tools and Supplies"
						}
					];
				}
				else if (r == 4)
				{
					local amount = this.Math.rand(5, 10);
					this.World.Assets.addMedicine(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_medicine.png",
							text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] Medical Supplies"
						}
					];
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_33.png[/img]%randombrother% gives the thief a proper beating with a short cane. The shaft lands viciously hard and you can hear the sound of the blows passing through the theif\'s almost hollow frame. The beaten culprit wilts and turns and tries hard to get away, but the sellsword is persistent in meting out the punishment. When it\'s all said and done, you leave the beaten thief behind, wimpering and clutching the dirt between frail fingers.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let this be a lesson to you!",
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
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_33.png[/img]Feeling bad for the feeble cutpurse, you decide to offer some water and food. The withered person almost snatches the meal away from you and drives a famished face into it. The thief thanks you between every bite.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Not everyone will be this lenient...",
					function getResult( _event )
					{
						if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax() || this.Math.rand(1, 100) <= 25)
						{
							return 0;
						}
						else
						{
							return "E";
						}
					}

				}
			],
			function start( _event )
			{
				local food = this.World.Assets.getFoodItems();
				food = food[this.Math.rand(0, food.len() - 1)];
				food.setAmount(this.Math.maxf(0.0, food.getAmount() - 5.0));
				this.List = [
					{
						id = 10,
						icon = "ui/items/" + food.getIcon(),
						text = "You lose some " + food.getName()
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_33.png[/img] You tell the mercenaries to get back to marching. The thief uses a thin arm to wipe their mouth and stands up, wobbling on weak legs to take a few steps after you and asks if maybe they could join the company. %SPEECH_ON%I\'ll give my life for you, if I must, just anything to not have to steal anymore.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Well, fine, you might as well join us.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "We need warriors, not underfed thieves.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
						{
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx(this.Const.CharacterThiefBackgrounds);
						_event.m.Dude.getSkills().add(this.new("scripts/skills/racial/skeleton_racial"));
						_event.m.Dude.getSkills().add(this.new("scripts/skills/injury_permanent/legend_fleshless"));
						}
					else
					{
					_event.m.Dude.setStartValuesEx(this.Const.CharacterThiefBackgrounds);
					}

				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_33.png[/img]As you draw your sword, the thief cowers, beggin for mercy as their mirrored face ripples over the blade\'s fuller and edges. You raise the weapon. The theif screams out that %SPEECH_ON% I\'ll work for you, I\'ll work for free, anything to spare my life.%SPEECH_OFF% You hesitate, your sword still lingering in the air.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Die with some dignity at last.",
					function getResult( _event )
					{
						return "G";
					}

				},
				{
					Text = "Fine. I\'ll spare your life  if you work for me.",
					function getResult( _event )
					{
						return "H";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_33.png[/img]%SPEECH_ON%The punishment for thievery is death.%SPEECH_OFF%You plunge the sword down, cutting off the thief\'s last words with a quick stab into their chest. The body seizes up, speechless save for the scratching of thin hands grabbing the killing implement, and then the face falls back, dead within moment. You retrieve your weapon and clean it off in the nook of your elbow. The dead head turns to a side as blood pools quietly beneath.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It\'s better this way.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.refugee" || bro.getBackground().getID() == "background.beggar"  || bro.getBackground().getID() == "background.female_beggar")
					{
						if (bro.getSkills().hasSkill("trait.bloodthirsty"))
						{
							continue;
						}

						bro.worsenMood(1.0, "Felt for a thief killed by you");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_05.png[/img]You lower your weapon and the theif crawls to you and hugs your legs, kissing your feet until you draw away.\n\nTo get things straight, you give a long list of orders and how it is to work in the company. You also give a contract which is then signed with a jagged \'x\'. A few of the company then spend the rest of the day teaching the ropes and introducing the new selssword to the rest of the company. By night\'s end, it seems like the new blood is already beginning to fit in. By next morning, you wake to see a great number of supplies are missing and the new recruit is nowhere in sight. It appears that, although you stayed the thief\'s execution, they went on ahead and stole things anyway. Let that be a lesson to you.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That damn scoundrel!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					local food = this.World.Assets.getFoodItems();
					food = food[this.Math.rand(0, food.len() - 1)];
					this.World.Assets.getStash().remove(food);
					this.List = [
						{
							id = 10,
							icon = "ui/items/" + food.getIcon(),
							text = "You lose " + food.getName()
						}
					];
				}
				else if (r == 2)
				{
					local amount = this.Math.rand(20, 50);
					this.World.Assets.addAmmo(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_ammo.png",
							text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] Ammunition"
						}
					];
				}
				else if (r == 3)
				{
					local amount = this.Math.rand(5, 10);
					this.World.Assets.addArmorParts(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_supplies.png",
							text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] Tools and Supplies"
						}
					];
				}
				else if (r == 4)
				{
					local amount = this.Math.rand(5, 10);
					this.World.Assets.addMedicine(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_medicine.png",
							text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] Medical Supplies"
						}
					];
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getFood() < 25 || this.World.Assets.getMedicine() < 10 || this.World.Assets.getArmorParts() < 10 || this.World.Assets.getAmmo() <= 50)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 10)
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		this.m.Score = this.isSomethingToSee() && this.World.getTime().Days >= 7 ? 50 : 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		if (!this.isSomethingToSee() && this.Math.rand(1, 100) <= 75)
		{
			return "A";
		}
		else
		{
			return "B";
		}
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

