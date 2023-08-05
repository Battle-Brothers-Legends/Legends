this.oracle_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.oracle";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_11.png[/img]{You come across a goatskin tent beside the road. The hide tarps have been dipped in purple dyes and there are fresh daisies twisted into the knots of matted goat hair. An old woman with a hunchback stands outside with her hands clasped and hanging. She sizes you up and down with withered eyes.%SPEECH_ON%Ah, a sellsword. No, a captain of sellswords. Or perhaps something more. You smell of a strange odor, and not just that of a man. Do you wish to have your fortune told?%SPEECH_OFF%She gestures to inside the tent. You see a number of long, cards laid facedown across the table.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Tell me my fortune, old woman.",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 20 && this.World.getTime().Days > 15)
						{
							return "D";
						}
						else if (r <= 80)
						{
							return "E";
						}
						else
						{
							return "F";
						}
					}

				},
				{
					Text = "I\'ll tell you yours instead: You\'re about to give us all your valuables.",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				},
				{
					Text = "No, we\'re good.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],

// function findItem()
// {
// 	local itemIDs = [
// 		"id1",
// 		"id2",
// 		"id3",
// 	];

// 	foreach (bro in this.World.getPlayerRoster().getAll())
// 	{
// 		local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

// 		if (item != null && itemIDs.find(item.getID()) != null) return true;
// 	}

// 	foreach (id in itemIDs)
// 	{
// 		if (this.World.Assets.getStash().hasItem(id)) return true;
// 	}

// 	return false;
// }
///-----Will clean up the below with the above later - Luft

			function start( _event )
			{	//may replace this with a flag on the old man sells event later
				local brothers = this.World.getPlayerRoster().getAll();				
				
				foreach( bro in brothers )
				{
					local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

					if (item != null && item.getID() == "accessory.legend_oms_amphora" || item.getID() == "accessory.legend_oms_fate" || item.getID() == "accessory.legend_oms_tome" || item.getID() == "accessory.legend_oms_paw" || item.getID() == "accessory.legend_oms_rib"))
					{
						this.Options.push({
							Text = "I\'ll pay you 100 crowns if you can tell me what this relic does.",
							function getResult( _event )
							{
								this.World.Flags.set("Item Identified", true); //Used to change the description of the identified item to explain it's effect(s)
								return "Relic_identify";
							}
						});
					}
				}

				foreach( item in stash )
				{
					local stash = this.World.Assets.getStash().getItems();

					if (item != null && item.getID() == "accessory.legend_oms_amphora" || item.getID() == "accessory.legend_oms_fate" || item.getID() == "accessory.legend_oms_tome" || item.getID() == "accessory.legend_oms_paw" || item.getID() == "accessory.legend_oms_rib"))
				
					{
						this.Options.push({
							Text = "I\'ll pay you 100 crowns if you can tell me what this relic does.",
							function getResult( _event )
							{
								this.World.Flags.set("Item Identified", true); //Used to change the description of the identified item to explain it's effect(s)
								return "Relic_identify";
							}
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "Relic_identify",
			Text = "", //text based on given item, not input here.
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Appreciate it.",
					function getResult( _event )
					{
						return "D";
					}
				}
			],
			function start( _event )
			{
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "accessory.legend_oms_amphora")
					{
						this.Text = "[img]gfx/ui/events/event_52.png[/img]{A hint of weariness enters the woman\'s voice as you ask your question. She offers her hand. %SPEECH_ON%Show me.%SPEECH_OFF% You hand the heavy jug to her, the contents of which slosh this way and that inside the vessel. Her eyes gleam and study the art covering the amphora. She whispers to herself a few things, but you only make out %SPEECH_ON%I thought I had lost you...%SPEECH_OFF% Without warning, she drips her finger into the mulch and sucks on it. You wait for a reaction but none comes, she either has tasted worse or hides her pain very well. She places the jug down and locks eyes with you. %SPEECH_ON%You have a problem, I know of this item and have come across it before - but it is not how I remember it. The mixture inside has spoiled, which I did not think was possible until now. It has long passed it\'s orginal purpose and I cannot guarantee what you will be drinking each time this refills.%SPEECH_OFF% She takes a sip from the vessel, and instantly pales and spits it out with a force that could blind a man. %SPEECH_ONFirst taste honey, second sip poison.%SPEECH_OFF%}";
					}
					else if (item != null && item.getID() == "accessory.legend_oms_fate")
					{
						this.Text = "[img]gfx/ui/events/event_52.png[/img]{The woman takes the tome and flicks through it\'s pages. At first the speed of which is rapid, but after a time she freezes and starts from the beginning again, reading very carefully and methodically between what appears to be blank pages. Minutes pass as she digests the information on each page before moving on. After a dozen pages, the reading becomes faster and she finally flicks through the last pages all the way to end end. %SPEECH_ON%Interesting, but not finished. I liked the part about the mackrel and the bucket.%SPEECH_OFF% Your mind begins to wander, is this another trick? She smiles at you wryly and folds her arms. %SPEECH_ON%It\'s blank for you, isn\'t it? I have read about this book before. It often trades hands because the owner doesn\'t like to be reminded of how uncontrollable their life is each time they pass their bookshelf. They think that passing on Van Hoorst\'s \'hronolosko ludilo\' will bring them back control. This is only one of five volumes, this is volume four, I believe.%SPEECH_OFF% The woman flicks through a few more of the pages again, possibly trying to discern if this conversation has had any impact on her end. She closes the book carefully and slides it across the table to you. %SPEECH_ON%Regardless, you should know that anyone who holds this is playing a risky game. Many think that the books alter fate themselves, not just reveal it. Those who die with these books in hand often do so with no chance at recovery. Some have said that they have seen men bleed to death from a pinprick because the book willed it so.%SPEECH_OFF%}";
					}
					else if (item != null && item.getID() == "accessory.legend_oms_tome") //ledger
					{
						this.Text = "[img]gfx/ui/events/event_52.png[/img]{The woman rolls her eyes and offers her hand. You produce the bound ledger and in almost the same motion, she flicks it open at a random page. Her eyes dart horizontially more than vertically across the page. She closes the ledger, and then opens it again and her curiosity deepens. With that, she closes the ledger a final time and throws it back at you, which you only just manage to catch. %SPEECH_ON%Boring!%SPEECH_OFF% She attends to a cooking pot starting to boil. %SPEECH_ON%I have seen these before, they\'re ledgers to track debtors and indebted alike. I know none of these names or what they mean but I do know the symbols in the margins.%SPEECH_OFF% She sips the soup from a spoon, and throws the spoon back into the pot the way a squirrel would discard a spent acorn. %SPEECH_ON%Symbols like \'Dead\' or \'Missing\', but there is one in there which is more broad - \'Taken\'. Be whom or what I am unsure, but based on the age of that skin and the names I think you found a relic of the Fallen Empire. Have you seen those packs of bones out there? Pretending like nothing is wrong despite being a magnet for wild and hungry dogs who don\'t know any better? They were a superstitious lot and even in death, they still are. If I were you i\'d tie that around my neck and you\'ll have them running back to that black pit of theirs in no time.}";
					}
					else if (item != null && item.getID() == "accessory.legend_oms_paw")
					{
						this.Text = "[img]gfx/ui/events/event_52.png[/img]{You take the hairy paw from your bag and lay it on the table. The woman barely looks at it. %SPEECH_ON%Manwolf paw. Seen a dozen of them. We like to collect them for sport.%SPEECH_OFF% She flashes another paw of a larger size than yours attached to a belt on her dress. You think you catch the paw twitching, but it could just be her movement making it sway. %SPEECH_ON%Good for vigor, gives you that energy you need to run through the woods...or more.%SPEECH_OFF% She flashes you a wry smile and looks you up and down. A veil of discomfort decends down on you. %SPEECH_ON%be aware that those who pretend to be a beast also think like a beast. They may be big, hairy and strong but they have the bravery of a dog all the same when real danger comes.}";
					}
					else (item != null && item.getID() == "accessory.legend_oms_rib")
					{
						this.Text = "[img]gfx/ui/events/event_52.png[/img]{You produce the rib from your pack, the woman studies it as it comes out and fixes her gaze at it touches the table. No sooner as your hand is clear does she take it and hold it at either end. She softly bites one end and taps it on the edge of her cooking pot. A jolt of energy runs up your legs as you wnat to move in to stop her mishandling the relic you paid so much for. %SPEECH_ON%It\'s the real thing. I am quite impressed. No sheep bones or plaster as usual, this is the bone of a woman who i feel a burning hatred for. I know a godwhore when I see one, or in this case, part of one.%SPEECH_OFF% She notices how jittery you have become, and places the bone neatly back into your hands. %SPEECH_ON%These fools die for many reasons. Mostly killed by their own kind. This one has a painful energy about it - a mixture of pain and fear. I feel sharpness and hear the whistling of arrows when I hold it.%SPEECH_OFF% She exhales as if to purge the memory from her mind. %SPEECH_ON%Her loss will be your gain, however. These martyrs often protect against what killed them in the first place. But often at a cost of what didn\'t kill them.%SPEECH_OFF% She purses her lips. %SPEECH_ON%Stay away from axes, spears and the like, stranger.%SPEECH_ON%}";
					}
					this.World.Assets.addMoney(-100);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]100[/color] Crowns"
					});
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = item.getName() + " is now identified and its tooltip has now been updated"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_11.png[/img]{A card reader such as this has probably done a fair bit of business, enough so that you wouldn\'t mind taking it for yourself. You order the company to pick the place apart. The woman says nothing as you move her out of the way, and she says nothing as the sellswords swarm her tent and tilt its pole to the ground. She smiles a little as they throw the goatskin tarp off to see the loot like magicians unveiling a failed trick. The smile fades as they begin to pick through her things, their boots crushing and smashing anything of no use to them. The hag shrugs and holds up two cards seemingly pulled right out of her sleeves.%SPEECH_ON%Tell me, sellsword, what do you see?%SPEECH_OFF%You take a look. The tarot cards depict a group of knights ransacking a village, and another is of a graveyard guarded by a particularly punitive keeper. You shrug and tell her she keeps those two cards tucked for events just like this and you\'re no fool to the notion of a helpless hag being runover on the road. You tell her she may have scared a few robbers with that trick, but you\'re not so easily fooled. She laughs.%SPEECH_ON%You are as wise as you are cruel.%SPEECH_OFF%Damn straight. Now let\'s see what the company has found.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s get back on the road.",
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
				local money = this.Math.rand(75, 200);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_11.png[/img]{You take a good look around you. If the hag had an ambush waiting somewhere you certainly don\'t see it. With a wave of your hand, you order the company to ransack her place. A few brothers slide into her tent and start picking it apart, flipping tables and yanking out drawers. The old woman steps aside, and keeps stepping, and keeps stepping. She\'s... grinning?%SPEECH_ON%Ay, take a look at this thing!%SPEECH_OFF%You turn back to see one of the mercenaries grabbing an orb that hangs from the tent ceiling. He yanks it down. The chain goes taut, snags, and there\'s a clank of a wire snapping loose. Blue sparks sidewind up the chain and zip down the length right into the orb. You don\'t hear a thing. The tent rips apart in a burst of blue flame and the pole punches into the sky and the silhouettes of sellswords stumble through the hot smoke. Grey and burning daisies twist through the air. You augur your ears to get your hearing back and then look to see where the woman is, but she\'s gone. Pursing your lips, you rush to see what damage has been done.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s get back on the road.",
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
					if (this.Math.rand(1, 100) <= 33)
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

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_11.png[/img]{The tent closes shut as you step in. An orange glow flicks and bobs from a lantern. Groaning, the old woman leans into it with a candlestick and broadens the light to a table and two chairs. She motions toward them.%SPEECH_ON%Sit.%SPEECH_OFF%You sit. She sits. She smacks her lips over toothless gums and nods and begins flipping the cards.%SPEECH_ON%First there is...%SPEECH_OFF%You lean forward to get a better look and the table breaks beneath your weight. The cards go fluttering and the woman falls backwards and the candle goes flying. You catch its stick midair with one hand and rush to save the lady from falling with the other. You set her back down and give her candle back. She stares at you, grinning with a black rim of a smile, her eyes squinted into dots.%SPEECH_ON%Let\'s forget this happened and say you get all that you ever wished for, sellsword, starting with this.%SPEECH_OFF%She gives you a slobbery kiss on the forehead and prods you with a dagger handle.%SPEECH_ON%Deal!%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What a dame.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/named/named_dagger");
				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_11.png[/img]{You step into the tent. A concerned %randombrother% looks in as the folds close him and the rest of the world out. The old woman lights a candle and carries it to her seat. Ironically, her olden shapes take further prominence in the dark as shadows find crevices you never knew could exist on a person, and her skin brims with lightning brought permanence. She immediately starts flipping cards and speaking.%SPEECH_ON%Defeat. Speculation. Doubt.%SPEECH_OFF%Poorly painted knights come and go, their limbs askew in bizarre poses.%SPEECH_ON%More defeat. But, also, victory. Many victories. You forget weakness. You grow tired of its contagious nature. You become powerful. Strength is survival. And there you are. Old. You die.%SPEECH_OFF%Raising an eyebrow you grab that last card and slide it into the light. You see a man with a long grey beard sitting in a chair. You tell the woman you\'ve never really been able to grow a beard and she snuffs the candle out and shoos you out of the tent.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I should stop shaving.",
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
			ID = "F",
			Text = "[img]gfx/ui/events/event_11.png[/img]{You step into the tent and its folds close and you\'re in nothing but darkness. You stand there for a time and ask the woman where she went. Pursing your lips, you open the tent flap to bring in some light. The slip of light strikes a sheen from the darkness and you turn around to see the dagger soaring forward. You block it away with your gauntlet and draw your sword and plunge it into the hag\'s chest. She drops the knife and clutches your shoulder.%SPEECH_ON%Such a monster you are, sellsword, killing a kind old woman such as I. You\'ll die for this. You and your men will all die.%SPEECH_OFF%You bring the witch in close and get a look at suddenly bright, wicked cat eyes. You spit and nod.%SPEECH_ON%Foretelling doom in a world where everything dies? Not a hard job. Do you know what my job is, you witch?%SPEECH_OFF%She grins a black rind of a gummy smile. Black blood spurts over her lips as she laughs.%SPEECH_ON%Oh, sellsword! We shall see what you are when Davkul has you in his hands.%SPEECH_OFF%The witch\'s body goes limp and your sword suddenly cuts straight through her flesh, leaving sliced flesh folding at your feet. You quickly exit the tent and have the whole thing burned. Some of the men swear they can see the woman\'s face grinning in the palls of smoke.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Burn the witch!",
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
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.Type == this.Const.World.TerrainType.Snow || currentTile.Type == this.Const.World.TerrainType.SnowyForest)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 100) //very niche situation but still...
		{
			return;
		}

		this.m.Score = 5;
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

