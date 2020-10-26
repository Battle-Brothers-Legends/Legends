this.legend_bandit_army_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Location1 = null,
		Location2 = null,
		NextObjective = null,
		Target = null,
		Dude = null,
		Briber = null,
		Reward = 0,
		OriginalReward = 0,
		MinStrength = 100,
		BribeMoney = 1000,
		Perk = "perk.legend_favoured_enemy_bandit",
		ValidTypes = this.Const.LegendMod.FavoriteBandit
	},
	function getBanner()
	{
		return "ui/banners/factions/banner_legend_s";
	}

	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_bandit_army_contract";
		this.m.Name = "Brigands Army (Legendary)";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.DifficultyMult = this.Math.rand(175, 195) * 0.01;

	}

	function generateName()
	{
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				this.Const.World.LocationNames.VillageWestern[this.Math.rand(0, this.Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(this.Const.Strings.BanditLeaderNames[this.Math.rand(0, this.Const.Strings.BanditLeaderNames.len() - 1)], vars);
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		if (this.m.Home == null)
		{
			this.setHome(this.World.State.getCurrentTown());
		}

		local settlements = clone this.World.FactionManager.getFaction(this.m.Faction).getSettlements();
		local i = 0;
		while (i < settlements.len())
		{
		 	local s = settlements[i];

		 	if (s.isIsolatedFromRoads() || !s.isDiscovered() || s.getID() == this.m.Home.getID())
		 	{
		 		settlements.remove(i);
		 		continue;
		 	}

		 	i = ++i;
		}


		this.m.Location1 = this.WeakTableRef(this.getNearestLocationTo(this.m.Home, settlements, true));
		this.m.Location2 = this.WeakTableRef(this.getNearestLocationTo(this.m.Location1, settlements, true));
		local banditcamp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getNearestSettlement(this.m.Home.getTile());
		this.m.Destination = this.WeakTableRef(banditcamp);
		this.m.Flags.set("DestinationName", banditcamp.getName());
		this.m.Payment.Pool = 1200 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		this.m.BribeMoney = this.Math.round(400 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult());


		if (this.Math.rand(1, 100) <= 90)
		{
			this.m.Payment.Completion = 0.9;
			this.m.Payment.Advance = 0.1;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Investigate supossed army of bandits"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				this.Contract.m.Destination.clearTroops();
				this.Contract.m.Destination.getLoot().clear();
				this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.BanditDefenders, 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setLootScaleBasedOnResources(200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 200 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
				this.Flags.set("BribeEventDone", false);
				local party;
				local tile;
				local tile = this.Contract.m.Destination.getTile();
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Brigand Scouts", false, this.Const.World.Spawn.BanditRoamers, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("banner").setBrush(this.Contract.m.Destination.getBanner());
				party.setAttackableByAI(false);
				this.Contract.m.Target = this.WeakTableRef(party);
				local c = party.getController();
				local intercept = this.new("scripts/ai/world/orders/intercept_order");
				intercept.setTarget(this.World.State.getPlayer());
				c.addOrder(intercept);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(true);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
				party.setDescription("Just an ordinary bandit group.");
				party.getLoot().Money = this.Math.rand(150, 300);
				party.getLoot().ArmorParts = this.Math.rand(0, 20);
				party.getLoot().Medicine = this.Math.rand(0, 10);
				party.getLoot().Ammo = this.Math.rand(0, 30);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.Location1.getSprite("selection").Visible = true;
				this.Contract.m.Location2.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = false;
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.NextObjective = this.Contract.m.Location1;
				this.Contract.m.BulletpointsObjectives = [
					"Gather intel at " + this.Contract.m.Location1.getName()
				];
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Location1))
				{
					this.Contract.setScreen("FirstIntel");
					this.World.Contracts.showActiveContract();
				}

				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					this.Contract.setScreen("LootTime");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}

				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (!this.Flags.get("Intercepted"))
					{
						this.Contract.setScreen("Shortcut");
						this.World.Contracts.showActiveContract();
						this.Flags.set("Intercepted",true);
					}
					else
					{
						return 0;
					}
				}
			}
		});
		this.m.States.push({
			ID = "MoreIntel",
			function start()
			{
				this.Contract.m.Location1.getSprite("selection").Visible = false;
				this.Contract.m.Location2.getSprite("selection").Visible = true;
				this.Contract.m.Home.getSprite("selection").Visible = false;
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.NextObjective = this.Contract.m.Location2;
				this.Contract.m.BulletpointsObjectives = [
					"We need more clues from " + this.Contract.m.Location2.getName()
				];
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Location2))
				{
					this.Contract.setScreen("SecondIntel");
					this.World.Contracts.showActiveContract();
				}

				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					this.Contract.setScreen("LootTime");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}

				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (!this.Flags.get("Intercepted"))
					{
						this.Contract.setScreen("Shortcut");
						this.World.Contracts.showActiveContract();
						this.Flags.set("Intercepted",true);
					}
					else
					{
						return 0;
					}
				}
			}

		});
		this.m.States.push({
			ID = "FindThem",
			function start()
			{
				this.Contract.m.Location1.getSprite("selection").Visible = false;
				this.Contract.m.Location2.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.NextObjective = this.Contract.m.Home;
				this.Contract.m.BulletpointsObjectives = [
					"Report back to " + this.Contract.m.Home.getName()
				];
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("ISEEYOU");
					this.World.Contracts.showActiveContract();
				}

				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					this.Contract.setScreen("LootTime");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}

				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (!this.Flags.get("Intercepted"))
					{
						this.Contract.setScreen("Shortcut");
						this.World.Contracts.showActiveContract();
						this.Flags.set("Intercepted",true);
					}
					else
					{
						return 0;
					}
				}
			}

		});
		this.m.States.push({
			ID = "TOBATTLE",
			function start()
			{

				this.Contract.m.Location1.getSprite("selection").Visible = false;
				this.Contract.m.Location2.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = false;
				this.Contract.m.Destination.getSprite("selection").Visible = true;
				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				this.Contract.m.NextObjective = this.Contract.m.Destination;
				this.Contract.m.BulletpointsObjectives = [
					"Defeat outlaw army at " + this.Contract.m.Destination.getName()
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}

			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					this.Contract.setScreen("LootTime");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
			}


			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (!this.Flags.get("BribeEventDone"))
				{
					local bros = this.World.getPlayerRoster().getAll();
					local candidates = [];

					foreach( bro in bros )
					{
						if (bro.getBackground().getID() == "background.thief" || bro.getBackground().getID() == "background.sellsword" || bro.getBackground().getID() == "background.legend_trader_commander" || bro.getBackground().getID() == "background.legend_assassin_commander" || bro.getBackground().getID() == "background.legend_assassin" || bro.getBackground().getID() == "background.female_thief" || bro.getSkills().hasSkill("perk.legend_bribe"))
						{
							candidates.push(bro);
						}
					}

					if (candidates.len() == 0)
					{
						this.Contract.setScreen("AttackDest");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.m.Briber = candidates[this.Math.rand(0, candidates.len() - 1)];
						this.Contract.setScreen("Bribe");
						this.World.Contracts.showActiveContract();
					}
				}

				if (this.Flags.get("BribeEventDone"))
				{
					this.Contract.setScreen("AttackDest");
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return to " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success1");
					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_20.png[/img]{ %employer% looks on as you fumble for somewhere to sit.%SPEECH_ON%Hoy, mercenary, how long has it been since you\'ve slaked your sword with the blood of evil, cruel men?%SPEECH_OFF%He drops the sarcasm and you figure you\'ll be standing now.%SPEECH_ON%We here at %townname% are having a bit of a tiff with some local brigands. Local to us, that is, with their little rat\'s hole must be somewhere not far from here. Peasants bother me every day about this. They panic like it was whole army of these little troublemakers! Can you believe it? Obviously, I think the answer to this issue is to hire some finely armed men such as your little company of good folk. So, does that pique your interest, mercenary, or do I need to find sturdier types for the task?%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{How many crowns are we talking about? | What is %townname% prepared to pay for their safety? | Let\'s talk money.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{Not interested. | We have more important matters to settle. | I wish you luck, but we\'ll not be part of this.}",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "AttackDest",
			Title = "Before the attack...",
			Text = "[img]gfx/ui/events/event_54.png[/img] At this point there is no negotiating with these outlaws.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Prepare the attack!",
					function getResult()
					{
						this.World.Contracts.showCombatDialog();
						this.Contract.setState("TOBATTLE");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Bribe",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_54.png[/img] As you approach bandit encampment you notice they do not seem like any raiders you\'ve encountered. You expected to be attacked instantly, but they hesitate. Some of outlaw scum, even though well equipped, do not seem eager for a fight. %shouter% notices some familiar faces, trader folk from former dealings. Deals that are not exactly inside boundries of local law. Before any hostilities starts, %shouter% aproaches you with a risky idea, if you\'re willing to try.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Attack them!",
					function getResult()
					{
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.BanditDefenders, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.World.Contracts.showCombatDialog();
						this.Flags.set("BribeEventDone", true);
						return 0;
					}

				},
				{
					Text = "%shouter% knows how to bargain with these people...",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 80)
						{
							return "BribeSuccess";
						}
						else
						{
							return "BribeFailure";
						}
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Briber.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "BribeSuccess",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_54.png[/img] %shouter% starts negotiations with some of the less bloodthristy looking bandits. Promises of great wealth without spiling blood appeal to sizeable part of outlaw gathering. You notice quite few of raiders taking the coins %shouter% offers and preparing to leave the encampemt. This situation while acceptable for the greedy, does not sit well with the ones looking for blood. The camp Atmosphere grows more tense with every minute, as those intrested in bribery leave and all you are left looking at is hungry people with violence in thier eyes. The last moment of peacefull negotiations is interrupted when one of bandit leaders approches %shouter% and yells %SPEECH_ON%We aint interested in petty kickbacks. We take all the gold, after we take your lives. KILL THEM ALL!!%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "At least we got some of them.",
					function getResult()
					{
						this.Flags.set("BribeEventDone", true);
						local playerTile = this.World.State.getPlayer().getTile();
						local party;
						party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Settlement).spawnEntity(playerTile, "Bribed Raiders", false, this.Const.World.Spawn.BanditDefenders, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.setDescription("Those who like gold above all");
						this.World.Contracts.showCombatDialog();
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Briber.getImagePath());
				this.World.Assets.addMoney(-this.Contract.m.BribeMoney);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + this.Contract.m.BribeMoney + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "BribeFailure",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_54.png[/img] At first it looked like great idea. For a moment few of raiders seems to be swayed by the coins in %shouter% purse. Suddenly a grim looking brute strikes %shouter% with a weapon. %shouter% throws coins on ground and escapes to back your group. Instead of chasing, the raider only laughs and shouts %SPEECH_ON%Look at the wee babe running back to the apron strings. You dropped something coward!!%SPEECH_OFF% as a group cackle and descend on gold dropped by %shouter%. You heara  shout comming from criminal that appears to be thier leader %SPEECH_ON%SHOW\'S OVER!!  KILL THEM!!%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "There goes nothnig...",
					function getResult()
					{
						this.Flags.set("BribeEventDone", true);
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.BanditDefenders, 30 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.World.Contracts.showCombatDialog();
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Briber.getImagePath());
				local injury1;
				local injury2;

				if (this.Math.rand(1, 100) <= 90)
				{
					injury1 = this.Contract.m.Briber.addInjury(this.Const.Injury.BluntBody);
					injury2 = this.Contract.m.Briber.addInjury(this.Const.Injury.BluntBody);
				}
				else
				{
					injury1 = this.Contract.m.Briber.addInjury(this.Const.Injury.BluntBody);
					injury2 = this.Contract.m.Briber.addInjury(this.Const.Injury.BluntHead);
				}

				this.List.push({
					id = 10,
					icon = injury2.getIcon(),
					text = this.Contract.m.Briber.getName() + " suffers " + injury1.getNameOnly() + " and " + injury2.getNameOnly()
				});
				this.Contract.m.Briber.worsenMood(1.0, "Failed to negotiatie with bandits");

				if (this.Contract.m.Briber.getMoodState() <= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[this.Contract.m.Briber.getMoodState()],
						text = this.Contract.m.Briber.getName() + this.Const.MoodStateEvent[this.Contract.m.Briber.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "LootTime",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_22.png[/img] {You look around battleground. Everywhere you see slain bodies... some missing an arm or leg, others without head cut off in with what was most likely one powerful swing. Most of the equipment carries marks of heavy fighting not long ago. You start looking over your crew to assess situation. With as many spoils as your company can carry, it is time to get paid at %Home% }",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We move out!",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "FirstIntel",
			Title = "At %location1%...",
			Text = "[img]gfx/ui/events/event_45.png[/img]{You reach %location1% and order your mercenaries to start gathering any informations related to bandit activities. News of your arrival spreads, and commoners begin to ask you if the threat of bandit hordes is real. With your agenda in mind and little care for the safety of locals, you tell them the main force of outlaws has already been defeated. Locals are told you were hired to hunt down the remaining bandits that most likely retreated back to their encampment.  Thanks to this strategy you are able to collect a few hints about where their main force operate from. Due to the misinformation you seeded into villagers minds, some of them are more willing to trade as you prepare to head out from %location1%.    }",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Rumors mostly but we will take it anyway.",
					function getResult()
					{
						this.Contract.setState("MoreIntel");
						return 0;
					}

				}
			],
			function start()
			{
				if (this.Math.rand(1, 100) <= 30)
				{
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/high_spirits_situation"), 2, this.Contract.m.Location1, this.List);
				}
			}

		});
		this.m.Screens.push({
			ID = "SecondIntel",
			Title = "At %location2%...",
			Text = "[img]gfx/ui/events/event_45.png[/img]{%location2% is where you were told to find more clues. Your mercenaries approach locals with the same lies that worked last time. To your amusement these people seems to take the bait and are soon spilling rumors that could be helpful in your main objective. Spirits among %location2% inhabitants are noticeably raised. Hoping all the gossip you were able to get is enough to find the bandit army you head back to consult with you employer about the next move. }",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "This better be enough...",
					function getResult()
					{
						this.Contract.setState("FindThem");
						return 0;
					}

				}
			],
			function start()
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/high_spirits_situation"), 2, this.Contract.m.Location2, this.List);
				}
			}

		});
		this.m.Screens.push({
			ID = "ISEEYOU",
			Title = "At %Home%...",
			Text = "[img]gfx/ui/events/event_45.png[/img]{ Not long after you enter %Home%, your employer summons you. This time you enter meeting that is more war council than tea party. All local militia captains are present, discussing the defensive capabilities of %Home% and outlying farms in case of siege. With the rumours you gathered you brought and information from other agents, the location of the bandit army is finally determined. You begin to wondering if this job is worth the risk. With the threat confirmed, your hesitance clearly terrifies your employer greatly. He assures you money he promised will be paid to the last crown if threat is eliminated. Food, wine and company are offered if you success, anything to convince you to stop the bandits or die trying, anything to slow the bandit army down.  Preparing to move out from %Home% you notice unusual mobilization of local levies.  }",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "To war.",
					function getResult()
					{
						this.Contract.setState("TOBATTLE");
						return 0;
					}

				}
			],
			function start()
			{
				if (this.Math.rand(1, 100) <= 60)
				{
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/mustering_troops_situation"), 2, this.Contract.m.Home, this.List);
				}
			}

		});
		this.m.Screens.push({
			ID = "Shortcut",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_22.png[/img] { With the skirmish over. %randombrother% collects weapons from dead bandits while %randombrother2% tends wounded members of your company. When all required medical assistance to your company is complete, any surviving bandits get a little attention. %randombrother% approaches you. %SPEECH_ON% These scum bleeding out might know something. What if we convince them enough to speak up ? I would rather torture these bastards  until they either share their little secrets or die then running around asking peasants for god damn directions. What ya say boss? %SPEECH_OFF% }",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "We are not like that (Increase Morals)",
					function getResult()
					{
						this.World.Assets.addMoralReputation(5);
						return 0;
					}
				},
				{
					Text = "Good idea (Decrease Morals)",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-5);
						this.Contract.setState("TOBATTLE")
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You return to %townname% to meet with %employer%. Claiming your reward for all the troubles your company had to endure is your main priority. While you are being summon to %employer% your mercenaries are already trading away spoils of war acquired though this adventure. You head off to the meeting, accompanied by personal guards of %employer% and local militia captains. Everyone present at meeting with %employer% can clearly sense mixed feelings coming from him. On one side relief with the threat eliminated, but in the other anger due to giving away the small fortune that was promised. Finally you are given the reward. Walking around %townname% you notice it has been well prepared for eventuality of siege. This adventure did not come cheap. }",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Crowns well deserved.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Destroyed a brigand encampment");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] Crowns"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
				this.Contract.m.Home.removeSituationByID("situation.mustering_troops");

				if (this.Math.rand(1, 100) <= 80)
				{
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/disbanded_troops_situation"), 2, this.Contract.m.Home, this.List);
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/well_supplied_situation"), 2, this.Contract.m.Home, this.List);
				}
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"Home",
			this.m.Home.getName()
		]);
		_vars.push([
			"location1",
			this.m.Location1.getName()
		]);
		_vars.push([
			"location2",
			this.m.Location2.getName()
		]);
		_vars.push([
			"shouter",
			this.m.Briber != null ? this.m.Briber.getName() : ""
		]);
		_vars.push([
			"reward",
			this.m.Reward
		]);
		_vars.push([
			"original_reward",
			this.m.OriginalReward
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive() ? "" : this.Const.Strings.Direction8[this.m.Home.getTile().getDirection8To(this.m.Destination.getTile())]
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/ambushed_trade_routes_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Location1.getSprite("selection").Visible = false;
				this.m.Location2.getSprite("selection").Visible = false;
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(4);
			}
		}
	}

	function onIsTileUsed( _tile )
	{
		if (this.m.Location1 != null && !this.m.Location1.isNull() && _tile.ID == this.m.Location1.getTile().ID)
		{
			return true;
		}

		if (this.m.Location2 != null && !this.m.Location2.isNull() && _tile.ID == this.m.Location2.getTile().ID)
		{
			return true;
		}

		return false;
	}

	function onIsValid()
	{
		if (this.m.IsStarted)
		{
			if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive())
			{
				return false;
			}

			if (this.m.Location1 == null || this.m.Location1.isNull() || !this.m.Location1.isAlive())
			{
				return false;
			}

			if (this.m.Location2 == null || this.m.Location2.isNull() || !this.m.Location2.isAlive())
			{
				return false;
			}
		}

		if (this.World.FactionManager.getFaction(this.m.Faction).getSettlements().len() < 3)
		{
			return false;
		}

		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			if (!bro.getSkills().hasSkill(this.m.Perk))
			{
				continue;
			}

			local stats = this.Const.LegendMod.GetFavoriteEnemyStats(bro, this.m.ValidTypes);
			if (stats.Strength >= this.m.MinStrength)
			{
				return true;
			}
		}
		return false;
	}

	function onSerialize( _out )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.Location1 != null)
		{
			_out.writeU32(this.m.Location1.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		if (this.m.Location2 != null)
		{
			_out.writeU32(this.m.Location2.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		local location1 = _in.readU32();

		if (location1 != 0)
		{
			this.m.Location1 = this.WeakTableRef(this.World.getEntityByID(location1));
		}

		local location2 = _in.readU32();

		if (location2 != 0)
		{
			this.m.Location2 = this.WeakTableRef(this.World.getEntityByID(location2));
		}

		this.contract.onDeserialize(_in);
	}

});

