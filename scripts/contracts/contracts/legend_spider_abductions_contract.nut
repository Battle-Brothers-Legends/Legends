this.legend_spider_abductions_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		SpiderNestTile = null,
		PaymentModifier = 1,
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.legend_spider_abductions";
		this.m.Name = "Webknecht Abductions";
		this.m.Description = "Several townsfolk have been abducted by Webknechts and brought to their nest to feed their hatchlings. Find the nest and rescue any townsfolk you find.";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		if (this.m.SpiderNestTile == null || this.m.SpiderNestTile.IsOccupied)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local excluded = ::Const.World.getAllTerrainTypesExcept([::Const.World.TerrainType.Forest, ::Const.World.TerrainType.LeaveForest, ::Const.World.TerrainType.AutumnForest]);
			this.m.SpiderNestTile = this.getTileToSpawnLocation(playerTile, 6, 12, excluded, false);
		}

		this.m.Payment.Pool = 500 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
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
				// TODO: intermediary steps to investigate site before finding the nest
				// TODO: Special scenarios: Redback / Spider Queen / Kobold Ambush
				this.Contract.m.BulletpointsObjectives = [
					"Find the Webknecht Nest where the the abducted townsfolk from " + this.Contract.m.Home.getName() + " have been taken to"
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
				if (this.Contract.m.SpiderNestTile == null || this.Contract.m.SpiderNestTile.IsOccupied)
				{
					local playerTile = this.World.State.getPlayer().getTile();
					local excluded = ::Const.World.getAllTerrainTypesExcept([::Const.World.TerrainType.Forest, ::Const.World.TerrainType.LeaveForest, ::Const.World.TerrainType.AutumnForest]);
					this.Contract.m.SpiderNestTile = this.Contract.getTileToSpawnLocation(playerTile, 6, 12, excluded, false);
				}

				// Setup Spider Nest
				local tile = this.Contract.m.SpiderNestTile;
				tile.clear();
				this.Contract.m.Destination = this.WeakTableRef(this.World.spawnLocation("scripts/entity/world/locations/legend_spider_nest_location", tile.Coords));
				this.Contract.m.Destination.onSpawned();
				this.Contract.m.Destination.setFaction(::World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).getID());
				this.Contract.m.Destination.setBanner(this.World.FactionManager.getFaction(::Const.FactionType.Beasts).getPartyBanner());
				this.Contract.m.Destination.setDiscovered(true);
				::World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				this.Contract.setScreen("Overview");
				::World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				// if (!this.TempFlags.get("IsNestReached") && !this.TempFlags.get("IsNestEntered") && this.Contract.isPlayerAt(this.Contract.m.Destination))
				// {
				// 	this.TempFlags.set("IsNestReached", true);
				// 	this.Contract.setScreen("Nest1");
				// 	this.World.Contracts.showActiveContract();
				// }

				// TODO: Handle "successful retreat" (player rescued the townsfolk and retreated without destroying the nest)
				
				if (::MSU.isNull(this.Contract.m.Destination))
				{
					this.Contract.setScreen("NestDestroyed");
					::World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}

			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				// if (!this.Flags.get("IsAttackDialogTriggered"))
				// {
				// 	this.Flags.set("IsAttackDialogTriggered", true);
				// 	this.Contract.setScreen("Nest1");
				// 	::World.Contracts.showActiveContract();
				// }
				if (this.Flags.get("IsAttackingNest"))
				{
					local tile = this.Contract.m.Destination.getTile();
					local p = ::Const.Tactical.CombatInfo.getClone();
					p.Music = ::Const.Music.BeastsTracks;
					p.TerrainTemplate = ::Const.World.TerrainTacticalTemplate[tile.TacticalType];
					p.Tile = tile;
					p.CombatID = "SpiderNest";
					p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Custom;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
					::Const.World.Common.addUnitsToCombat(p.Entities, ::Const.World.Spawn.Spiders, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), ::World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());

					// TODO: Balance the fight
					// Maybe also add another "ring" of eggs between the player and the surrounding spiders
					local onPlayerDeployment = function(_frontline)
					{
						// Chance for some of the player's units to start webbed
						foreach (unit in _frontline)
						{
							if (::Math.rand(1,6) == 1)
							{
								unit.getSkills().add(this.new("scripts/skills/effects/legend_web_at_start_effect"));
							}
						}

						local entities = [];
						local eggs = [];
						local abductees = ::Math.rand(3,6);
						this.Flags.set("NumAbductees",abductees);

						for (local i=0; i < abductees; i++)
						{
							local villager = ::World.getGuestRoster().create("scripts/entity/tactical/humans/envoy");
							villager.setName("Abducted Villager");
							villager.setFaction(1);
							villager.setPlaceInFormation(19 + i);
							villager.getSkills().add(this.new("scripts/skills/effects/legend_web_at_start_effect"));
							villager.getFlags().add("IsSpiderAbductee", true);
							entities.push(villager);
						}

						for (local i=0; i < ::Math.rand(4,6); i++)
						{
							local egg = {
								ID = ::Const.EntityType.SpiderEggs,
								Variant = 0,
								Script = "scripts/entity/tactical/enemies/spider_eggs",
								Faction = ::World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID(),
								Callback = this.onEggPlaced.bindenv(this)
							}
							eggs.push(egg);
						}

						entities.extend(_frontline);

						// Spawn player units, abductees and eggs in center
						::Tactical.Entities.spawnEntitiesAtCenter(eggs);
						::Tactical.Entities.placePlayersAtCenter(entities); // this is from the tactical_entity_manager

						// Spawn additional ring of eggs / decorations between center and circle of enemies
						local limit = ::Math.rand(20,30)
						local wc = ::MSU.Class.WeightedContainer([
							[3,"Egg"],
							[5,"CrushedEgg"],
							[2,"BrokenWeb"],
						])
						for( local i=0; i < limit; i++ )
						{
							local x = 0;
							local y = 0;
							local tries = 0;

							while (1)
							{
								x = ::Math.rand(9, 23);
								y = ::Math.rand(9, 23);

								if (x > 13 && x < 19 && y > 13 && y < 19)
								{
									continue;
								}

								if (::Tactical.isValidTileSquare(x, y) && ::Tactical.getTileSquare(x, y).IsEmpty && !::Tactical.Entities.isTileIsolated(::Tactical.getTileSquare(x, y)))
								{
									break;
								}

								tries = ++tries;

								if (tries >= 500)
								{
									break;
								}
							}

							local tile = ::Tactical.getTileSquare(x, y);
							switch(wc.roll())
							{
								case "Egg":
									local egg = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/spider_eggs", tile.Coords);
									egg.setFaction(::World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
									egg.setSpawnDelay(1);

									break;

								case "CrushedEgg":
									tile.spawnDetail("nest_01_dead", this.Const.Tactical.DetailFlag.Corpse, ::Math.rand(1,2) == 1);
									break;

								case "BrokenWeb":
									tile.spawnDetail("web_destroyed");
									break;

								default:
									break;
							}
						}
					}

					p.PlayerDeploymentWithFrontlineCallback = onPlayerDeployment.bindenv(this);
					::World.Contracts.startScriptedCombat(p, false, false, true);
				}
				else
				{
					this.Contract.setScreen("Nest1");
					::World.Contracts.showActiveContract();
				}
				
			}

			function onEggPlaced( _entity, _tag)
			{
				_entity.setSpawnDelay(1); // add a delay so that the eggs don't spawn hatchlings on the very first turn
			}

			function onRetreatedFromCombat( _combatID )
			{
				// if (_combatID == "SpiderNest")
				// {
				// 	this.Contract.setScreen("Retreat");
				// 	this.Contract.m.Destination.onFinish();
				// 	::World.Contracts.removeContract(this.Contract);
				// }
				if (_combatID == "SpiderNest")
				{
					// TODO: different outcomes depending on the number of survivors
					// this.Contract.m.Destination.onFinish();
					this.Contract.m.Destination.die();
					this.Contract.m.Destination = null;
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "SpiderNest")
				{
					// TODO: different outcomes depending on the number of survivors
					this.Contract.m.Destination.die();
					this.Contract.m.Destination = null;
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return with the rescued townsfolk to " + this.Contract.m.Home.getName()
				];

				if (!::MSU.isNull(this.Contract.m.Destination))
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}

				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					local survivorCount = 0;
					foreach ( g in ::World.getGuestRoster().getAll())
					{
						if ( g.getFlags().get("IsSpiderAbductee") )
						{
							survivorCount += 1
						}
					}

					if (survivorCount > 0)
					{
						this.Contract.setScreen("Success1");	
					}
					else
					{
						this.Contract.setScreen("Failure1");
					}
					
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
			Text = "[img]gfx/ui/events/event_43.png[/img]{PLACEHOLDER: Several townsfolk have been abducted by Webknechts and brought to their nest somewhere. Find the nest, rescue the townsfolk, and bring them home safely.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Attacking a Webknecht Nest is dangerous. This better pay well. | How much are their lives worth to you? | We will rescue them if the pay is right.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This isn\'t worth it. | This sounds far too dangerous.}",
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

		// At the Nest
		this.m.Screens.push({
			ID = "Nest1",
			Title = "At the Webknecht Nest...",
			Text = "[img]gfx/ui/events/event_110.png[/img]{PLACEHOLDER: You spot the abductees trapped in webs and surrounded by several pods of Webknecht eggs. You do not see any Webknechts around, but they could return at any moment.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Everyone, rush in and free the townsfolk!}",
					function getResult()
					{
						// this.TempFlags.set("IsNestEntered", true);
						return "Nest2";
					}

				},
				{
					Text = "{We\'ll come back later.}",
					function getResult()
					{
						return 0;
					}
				}
			],
			function start()
			{
			}
		});
		// TODO: Different battle layouts depending on player choice
		this.m.Screens.push({
			ID = "Nest2",
			Title = "At the Webknecht Nest...",
			Text = "[img]gfx/ui/events/event_110.png[/img]{PLACEHOLDER: You and the %companyname% run straight towards the trapped townsfolk, wading through webs and eggs along the way, some getting caught in the webs themselves.\n\nYour movements must have alerted the Webknechts, for their chittering is soon heard all around you, closing in with each second.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Defend the townsfolk! | To arms! | Prepare for battle!}",
					function getResult()
					{
						this.Flags.set("IsAttackingNest", true);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			],
			function start()
			{
			}
		});


		this.m.Screens.push({
			ID = "Retreat",
			Title = "At the Webknecht Nest...",
			Text = "{PLACEHOLDER: You and the %companyname% abandon the townsfolk to their doom.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Better them than us.}",
					function getResult()
					{
						// TODO: clear guest roster of any rescued townsfolk
						return 0;
					}
				}
			],
			function start()
			{
			}
		});
		this.m.Screens.push({
			ID = "NestDestroyed",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_123.png[/img]{PLACEHOLDER: You order the %companyname% to clear out any remaining eggs in the nest, and prepare to bring the survivors back to %townname%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Let\'s get these poor souls back to safety. | We\'ve seen enough here.}",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}
				}
			],
			function start()
			{
			}
		});
		
		// Return home
		// TODO: Different outcomes based on the number of survivors
		this.m.Screens.push({
			ID = "Success1",
			Title = "Upon your return...",
			Text = "[img]gfx/ui/events/event_43.png[/img]{PLACEHOLDER: The townsfolk of %townname% thank you and %employer% expresses %their_employer% heartfelt thanks.%SPEECH_ON%You\'ve done a wonderful job. Here\'s your payment.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{All in a day\'s work. | I hope to never see a spider again for the rest of my life.}",
					function getResult()
					{
						::World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						::World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						::World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Rescued townsfolk from Webknechts");
						::World.Contracts.finishActiveContract();
						return 0;
					}
				}
			],
			function start()
			{
				// Count survivors
				local survivorCount = 0;
				foreach ( g in ::World.getGuestRoster().getAll())
				{
					if ( g.getFlags().get("IsSpiderAbductee") )
					{
						survivorCount += 1
					}
				}

				this.List.push({
					id = 10,
					icon = "ui/icons/relations.png",
					text = format("You rescued %s out of %s Abducted Townsfolk", ::Const.UI.getColorized(survivorCount, survivorCount == 0 ? ::Const.UI.Color.NegativeEventValue : ::Const.UI.Color.PositiveEventValue), ::Const.UI.getColorized(this.Flags.get("NumAbductees"), ::Const.UI.Color.PositiveEventValue))
				})
				// TODO: scale reward based on the number of survivors who made it back?
				if (survivorCount == this.Flags.get("NumAbductees"))
				{
					this.Text += "{The townsfolk you rescued step forward.%SPEECH_ON%They saved all of us! We thought we were all done for, but they kept us safe.\"\n\n\"And not a single one of us was left behind either!\"\n\n\"All shall hear of the %companyname%!\"\n\n\"Hear, hear!%SPEECH_OFF%}";
					this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/legend_word_of_mouth_situation"), 5, this.Contract.m.Home, this.List);
				}
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + ::Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
			}
		});

		this.m.Screens.push({
			ID = "Failure1",
			Title = "Upon your return...",
			Text = "[img]gfx/ui/events/event_43.png[/img]{PLACEHOLDER: %employer% greets you upon your return to %townname%. The hopeful look on %their_employer% face quickly turns concern when %they_employer% notices the lack of rescued townsfolk among the %companyname%.%SPEECH_ON%Wh-where are the people who were abducted? You brought them back with you, yes?%SPEECH_OFF%%randombrother% shifts %their_randombrother% weight comfortably, notably avoiding all eye contact with %employer%.\n\nAs you begin to explain what happened, %employer% cuts you off with a wave of %their_employer% hand.%SPEECH_ON%We hired you to bring those poor folks back. Surely it is not too much to ask for you to have brought at least one person back safely?%SPEECH_OFF%%randombrother% has suddenly taken great interest in the clouds above, %their_randombrother% gaze pointedly fixated towards the sky.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{Next time you try clearing out a Webknecht nest yourself. | It\'s a dangerous world. | At least we made it back alive ourselves. | Whoops.}",
					function getResult()
					{
						::World.Assets.addMoney(::Math.round(this.Contract.m.Payment.getOnCompletion() * this.Contract.m.PaymentModifier));
						::World.Contracts.finishActiveContract();
						return 0;
					}
				}
			],
			function start()
			{
				if (::MSU.isNull(this.Contract.m.Destination))
				{
					this.Text += "\n\n{%employer% lets out a sigh.%SPEECH_ON%Fine, I shall pay half of the agreed payment for at least having destroyed the nest.%SPEECH_OFF%}"
					this.Contract.m.PaymentModifier = 0.5;
				}
				else
				{
					this.Text += "\n\n{After a brief moment of consideration, %employer% hands you a paltry sum of crowns.%SPEECH_ON%I don\'t think you deserve this at all, but having risked your lives for this, perhaps you should get something for the trouble%SPEECH_OFF%}";
					this.Contract.m.PaymentModifier = 0.1;
				}

				this.List.push({
					id = 10,
					icon = "ui/icons/relations.png",
					text = format("You rescued %s out of %s Abducted Townsfolk", ::Const.UI.getColorized(0, ::Const.UI.Color.NegativeEventValue), ::Const.UI.getColorized(this.Flags.get("NumAbductees"), ::Const.UI.Color.PositiveEventValue))
				})

				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + ::Const.UI.Color.PositiveEventValue + "]" + ::Math.round(this.Contract.m.Payment.getOnCompletion() * this.Contract.m.PaymentModifier) + "[/color] Crowns"
				});
			}
		});
		
	}

	function onPrepareVariables( _vars )
	{
		if (::MSU.isNull(this.m.Destination))
		{
			_vars.push([
				"direction",
				this.m.SpiderNestTile == null ? "" : ::Const.Strings.Direction8[::World.State.getPlayer().getTile().getDirection8To(this.m.SpiderNestTile)]
			]);
		}
		else
		{
			_vars.push([
				"direction",
				::MSU.isNull(this.m.Destination) ? "" : ::Const.Strings.Direction8[::World.State.getPlayer().getTile().getDirection8To(this.m.Destination.getTile())]
			]);
		}
	}

	function onHomeSet()
	{
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (!::MSU.isNull(this.m.Destination))
			{
				this.m.Destination.getSprite("selection").Visible = false;
			}

			this.m.Home.getSprite("selection").Visible = false;

			// Instead of calling getGuestRoster().clear(), only remove guest townsfolk for future compatibility with possible other guests
			local survivors = []
			foreach ( g in ::World.getGuestRoster().getAll())
			{
				if ( g.getFlags().get("IsSpiderAbductee") )
				{
					survivors.push(g);
				}
			}
			if (survivors.len() > 0)
			{
				foreach(g in survivors)
				{
					::World.getGuestRoster().remove(g);
				}
			}
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onSerialize( _out )
	{
		if (!::MSU.isNull(this.m.Destination))
		{
			_out.writeU32(this.m.Destination.getID());
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
			this.m.Destination = this.WeakTableRef(::World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}

});