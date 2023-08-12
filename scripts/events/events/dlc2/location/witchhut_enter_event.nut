this.witchhut_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.witchhut_enter";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_115.png[/img]{You pause at the forest clearing. The hut before you stands like a mere crumb. It\'s so quaint and easily forgotten you wondered how it could survive, but perhaps its total banality and unassuming nature is itself a sort of armor. But you\'ve been around this world long enough to know to trust your instinct, and right now your instinct is to wait.\n\n Soon enough, the hut\'s door pops open and an elderly woman hobbles out. She immediately waves in your direction.%SPEECH_ON%You, and only you.%SPEECH_OFF%Confused, you ask why just yourself, or more particularly why would you ever trust her to begin with. She smiles.%SPEECH_ON%Because I know what the False King dreams of at night.%SPEECH_OFF%The mercenaries around you turn about and ask what she said. You put a hand up and tell them to stay their ground while you go have a talk with the mysterious woman.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Stay here and stay on guard.",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_115.png[/img]{You come in with your sword drawn just to find the woman offering you a bowl of stew. She suggests it is only rabbit and potatoes, and more the former than the latter. Sheathing your sword, you take the bowl and have a seat at a table with her opposite you. A couple of candles burn nearby, and there are glyphs painted on the walls in white, and similar shapes hang from the ceiling as dreamcatchers. The woman puts her elbows on the table. There are trinkets wound into her hair, clips of bird bones and feathers. She carries a weathered face, though her eyes are starkly young like pearls glimmering from the depths of a swamp.%SPEECH_ON%I knew you would come in, a phantom of a friend, like a moth to the flame, seeking truth which cannot be tamed.%SPEECH_OFF%Pushing the bowl back across the table, you ask if she is a witch. She nods affirmatively and stares at you before nodding again.%SPEECH_ON%Good. You haven\'t killed me which means you\'re thinking now. I am indeed a so-called witch, but I am alone. Entirely alone. And hounded by the others. You might call them my \'sisters\', but these others know who you are, just as I do, and they want your blood. They can smell it and that is why I want to talk.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What is it you want?",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_115.png[/img]{The woman draws a long object wrapped in table cloth and sets it on the table. She throws back its linens to reveal a jagged obsidian blade with a leather strips for a grip.%SPEECH_ON%Cut your flesh and bleed upon the black. The hexen and their lowly craft shall come, and then you shall kill them all. After that, we can talk. Sellsword and witch, witch and sellsword.%SPEECH_OFF%You ask what is in it for you. The witch cackles.%SPEECH_ON%Oh sellsword, you are not in the business of allegiance, but in the business of gold, and with a clever turn of coin you know friend can turn to foe. But I offer something more. A truth which cannot be seen, a truth for the False King.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We\'ve already come this far.",
					function getResult( _event )
					{
						return "D";
					}
				}
			],
			function start( _event )
			{	//may replace this with a flag on the old man sells event later
				local brothers = this.World.getPlayerRoster().getAll();				
				
				foreach( bro in brothers ) //replicated in oracle_event.nut
				{
					local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

					if (item != null && item.getID() == "accessory.legend_oms_amphora" || item.getID() == "accessory.legend_oms_fate" || item.getID() == "accessory.legend_oms_tome" || item.getID() == "accessory.legend_oms_paw" || item.getID() == "accessory.legend_oms_rib")
					{
						this.Options.push({
							Text = "Can tell me what this relic does?",
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

					if (item != null && item.getID() == "accessory.legend_oms_amphora" || item.getID() == "accessory.legend_oms_fate" || item.getID() == "accessory.legend_oms_tome" || item.getID() == "accessory.legend_oms_paw" || item.getID() == "accessory.legend_oms_rib")
				
					{
						this.Options.push({
							Text = "Can tell me what this relic does?",
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
					Text = "Back to the knife...",
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
					this.List = [
						{
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = item.getName() + " is now identified and its tooltip has now been updated"
						}
					];
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_115.png[/img]{The black blade rests in your hand, and your reflection rests jaggedly in its stony grooves, stretched and pulled into every divot and edge. Tis a simple stone. A simple dagger. That is all. Not the least bit heavy, but you can feel the import, like dust tossed upon a grave, there is not so much weight in the sand as there is in the throw itself. This blade is either loss or gain and there\'s only one way to see to which. The witch nods. You nod back and slash your upper arm. The blood pools onto the stone and your reflections disappear beneath the crimson. Almost growling, the witch eagerly leans in and presses the blade against the skin.%SPEECH_ON%More. More, sellsword. More!%SPEECH_OFF%You slash again and flex. A spurt hits the stone. She takes the knife and slaps a spotless cloth onto the wound.%SPEECH_ON%Well enough, sellsword. Go to your men and prepare.%SPEECH_OFF%You stand and look at the woman. You ask.%SPEECH_ON%And once I kill your enemies, then we talk again?%SPEECH_OFF%She smiles.%SPEECH_ON%In so many words, yes.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Then I will do so.",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_115.png[/img]{When you step outside and inform the company that hostiles are coming. Soon enough, the haggard women are spotted walking between the trees of the forest, their long fingernails scratching across the bark and their drooling lips sniveling up to snort and cackle. The first to come through has a long head shaped like a canoe. An infant\'s skull dangles from her necklace, and a leather bag bounces at her hip, two rabbit feet sticking out of the pouch. She glares at the hut and sniffs the air, then shifts her eyes upon you.%SPEECH_ON%Ah, you have made covenant with that bitch?%SPEECH_OFF%You nod.%SPEECH_ON%The deal\'s been made, aye, and it will end with you dying on the end of this blade. And I believe she prefers to just be called \'witch.\'%SPEECH_OFF%Another hexen steps forward.%SPEECH_ON%We prefer to call her cunt. Kill the sellswords. Take the captain alive, but remove his eyes and that lousy tongue.%SPEECH_OFF%The throng of witches rush forward, some already shifting into licentious looking younglings while others revolve their arms in ritual rites.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To battle!",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setAttackable(true);
						}

						this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						this.World.Events.showCombatDialog(true, true, true);
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
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

});

