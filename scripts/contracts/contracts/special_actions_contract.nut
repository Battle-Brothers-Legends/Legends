this.special_actions_contract <- this.inherit("scripts/contracts/contract", {
	//Add special actions that are unlocked by completing special contracts. Checks for flags in the player base and certain conditions.
	//an absolutely convoluted mess of a file
	m = {
		Reward = 0,
		Title = "Perform a special action",
		Cost = 0,
		Text = ""
	},
	function create()
	{
		this.m.DifficultyMult = 130;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.TempFlags = this.new("scripts/tools/tag_collection");
		this.createStates();
		this.createScreens();
		this.m.Type = "contract.special_actions_contract";
		this.m.Name = "Perform special actions";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 1500.0;
	}

	function onImportIntro()
	{
		#this.importSettlementIntro();
	}

	function start()
	{
		this.contract.start();
	}
	
	function getBanner()
	{
		return "ui/banners/factions/banner_06s"
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.Contract.setScreen("Overview_Building");
			}

		});
	}

	function createScreens()
	{	
		this.m.Screens.push({
			ID = "Task",
			Title = this.m.Title,
			Text = "Do you wish to perform a special action?",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "What are my options?",
					function getResult()
					{
						
						return "Negotiation_Building";
					}

				},
				{
					Text = "I don't want to do a special action right now",
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
		
		//screen to choose the action
		this.m.Screens.push({
			ID = "Negotiation_Building",
			Title = this.m.Title,
			Text = "Which action do you want to do?",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = this.getOptions()
		});
		
		//universial not enough screen
		this.m.Screens.push({
			ID = "Not_Enough",
			Title = this.m.Title,
			Text = "[img]gfx/ui/events/event_04.png[/img]{You don't have enough crowns! Try again later.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{Oh well.}",
					function getResult()
					{
						this.Contract.removeThisContract()
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
	}
	
	function getOptions(){
		//special action options to be chosen
		local contract_options = [];
		
		//waterskin
		contract_options.push(
		{
			Text = "Buy a Water Skin.",
			function getResult()
			{
				if (!this.getPlayerBase().m.Flags.get("Waterskin"))
				{
					this.Contract.m.Screens.push
					({
						ID = "Recipe_Not_found",
						Title = "Requirements not met",
						Text = "You need to find the recipe for the Waterskin before you can buy it!",
						Image = "",
						List = [],
						ShowEmployer = true,
						Options = [
							{
								Text = "Alright.",
								function getResult()
								{
									this.Contract.removeThisContract()
									return 0;
								}

							}
						],
					})
					return "Recipe_Not_found";
				}
				else
				{
					this.Contract.addNegScreen("Waterskin")
					return "Overview_Building";
				}
			}
		})
		
		
		local has_mercs = false;
		foreach ( unit in this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player).m.Units){
			if (unit.getDescription() == "A band of mercenaries following you around."){
				this.m.Flags.set("has_mercs", true)
			}
		}
		
		//hire mercenaries
		contract_options.push(
		{
			Text = "Hire mercenaries.",
			function getResult()
			{
				if (!this.getPlayerBase().m.Flags.get("Mercenaries"))
				{
					this.Contract.m.Screens.push
					({
						ID = "Mercs_Not_Freed",
						Title = "Requirements not met",
						Text = "You need to free the mercenaries before you can hire them!",
						Image = "",
						List = [],
						ShowEmployer = true,
						Options = [
							{
								Text = "Alright.",
								function getResult()
								{
									this.Contract.removeThisContract()
									return 0;
								}

							}
						],
					})
					return "Mercs_Not_Freed";
				}
				else if (this.Contract.m.Flags.get("has_mercs"))
				{
					this.Contract.m.Screens.push
					({
						ID = "Mercs_Already_Hired",
						Title = "Requirements not met",
						Text = "You already hired a group of mercenaries!",
						Image = "",
						List = [],
						ShowEmployer = true,
						Options = [
							{
								Text = "Alright.",
								function getResult()
								{
									this.Contract.removeThisContract()
									return 0;
								}

							}
						],
					})
					return "Mercs_Already_Hired";
				}
				else
				{
					this.Contract.addNegScreen("Mercenaries")
					return "Overview_Building";
				}
			}
		})
		
		//Special training
		contract_options.push(
		{
			Text = "Provide special training to one of your recruits",
			function getResult()
			{
				if (!this.getPlayerBase().m.Flags.get("Teacher"))
				{
					this.Contract.m.Screens.push
					({
						ID = "Teacher_Not_Freed",
						Title = "Requirements not met",
						Text = "You need to free the legendary swordmaster before he can train anyone!",
						Image = "",
						List = [],
						ShowEmployer = true,
						Options = [
							{
								Text = "Alright.",
								function getResult()
								{
									this.Contract.removeThisContract()
									return 0;
								}

							}
						],
					})
					return "Teacher_Not_Freed";
				}
				else
				{
					this.Contract.m.Screens.push
					({
						ID = "Teacher_Choice",
						Title = "Choose a brother",
						Text = "Which brother should receive training?",
						Image = "",
						List = [],
						ShowEmployer = true,
						Options = this.Contract.getTeacherOptions()
					})
					this.Contract.addNegScreen("Teacher")
					return "Teacher_Choice";
				}
			}
		})
		
		//send a gift to a faction
		contract_options.push(
		{
			Text = "Send gifts to a faction",
			function getResult()
			{
				if (this.Contract.isGiftValid(true))
				{
					this.Contract.m.Screens.push
					({
						ID = "Send_Gift",
						Title = "Choose a faction",
						Text = "Which faction should receive the gifts?",
						Image = "",
						List = [],
						ShowEmployer = true,
						Options = this.Contract.getGiftOptions()
					})
					this.Contract.addNegScreen("Gift")
					return "Send_Gift";
				}
				else
				{
					this.Contract.m.Screens.push
					({
						ID = "Send_Gift_Failed",
						Title = "Requirements not met",
						Text = "You need to connect your settlement to the world with a road, have at least two trophies in your inventory, have at least 5000 crowns, and not already be friendly with every noble faction to send a gift.",
						Image = "",
						List = [],
						ShowEmployer = true,
						Options = [
							{
								Text = "Alright.",
								function getResult()
								{
									this.Contract.removeThisContract()
									return 0;
								}

							}
						],
					})
					return "Send_Gift_Failed";
				}
			}
		})
		
		contract_options.push(
		{
			Text = "Remove your base",
			function getResult()
			{
				this.Contract.m.Screens.push
				({
					ID = "Confirm_Remove",
					Title = "Confirm your choice",
					Text = "Are you sure you want to remove your base? This is free, but can't be undone.",
					Image = "",
					List = [],
					ShowEmployer = true,
					Options = [
						{
							Text = "Yes.",
							function getResult()
							{
								return "Overview_Building"

							}

						},
						{
							Text = "No.",
							function getResult()
							{
								this.Contract.removeThisContract()
								return 0
							}

						}
					],
				})
				this.Contract.addNegScreen("Remove_Base")
				return "Confirm_Remove";
			}
		})
		
		
		contract_options.push(
			{
				Text = "Not right now.",
				function getResult()
				{
					this.Contract.removeThisContract()
					return 0;
				}
			})
		return contract_options;
	}
	
	function addNegScreen(_text)
	{
		// adds the different screens and effects after you've chosen an option
		if (_text == "Waterskin")
		{
			this.m.Cost = 40 * this.Const.World.StrongholdPriceMult;
			this.m.Text = "You choose to buy a Water Skin. This will cost " + this.m.Cost + " crowns."
			this.m.Title = "Buy a Water Skin"
			this.addOverviewScreen()
			
			this.m.Screens.push
			({
				ID = "Enough",
				Title = this.m.Title,
				Text = "You bought a Water Skin.",
				Image = "",
				List = [],
				ShowEmployer = true,
				Options = [
					{
						Text = "Good.",
						function getResult()
						{
							this.World.Assets.getStash().makeEmptySlots(1);
							this.World.Assets.addMoney(-this.Contract.m.Cost);
							local item = this.new("scripts/items/special/fountain_of_youth_item");
							this.World.Assets.getStash().add(item);
							this.Contract.removeThisContract()
							return 0;
						}

					}
				],
				function start()
				{
					this.List.push({
						id = 10,
						icon = "ui/items/consumables/youth_01.png",
						text = "You lose " +this.Contract.m.Cost + " crowns."
					});
				}
			})
		}
		else if (_text == "Mercenaries")
		{
			this.m.Cost = 20 * this.Const.World.StrongholdPriceMult;
			this.m.Text = "You choose to hire mercenaries. This will cost " + this.m.Cost + " crowns."
			this.m.Title = "Hire mercenaries"
			this.addOverviewScreen()
			
			this.m.Screens.push({
				ID = "Enough",
				Title = this.m.Title,
				Text = "You hired a group of mercenaries.",
				Image = "",
				List = [],
				ShowEmployer = true,
				Options = [
					{
						Text = "Good.", 
						function getResult()
						{
							this.World.Assets.addMoney(-this.Contract.m.Cost);
							local player_faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player);
							local player_base =  player_faction.m.Settlements[0];
							local mercenary_size = 200
							if (player_base.hasAttachedLocation("attached_location.militia_trainingcamp"))
							{
								mercenary_size += 100
							}
							local party = player_faction.spawnEntity(player_base.getTile(), "Mercenary band of " + player_base.getName(), true, this.Const.World.Spawn.Mercenaries, mercenary_size);
							party.getSprite("body").setBrush("figure_mercenary_01");
							party.setDescription("A band of mercenaries following you around.");
							party.setFootprintType(this.Const.World.FootprintsType.CityState);
							party.setMovementSpeed(150)
							party.getFlags().set("IsRandomlySpawned", true);
							local c = party.getController();
							c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false)
							c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false)
							local follow = this.new("scripts/ai/world/orders/mod_follow_order");
							follow.setDuration(7);
							c.addOrder(follow);
							this.Contract.removeThisContract()
							return 0;
						}

					}
				],
				function start()
				{
					this.List.push({
						id = 10,
						icon = "ui/events/event_134.png",
						text = "You lose " +this.Contract.m.Cost + " crowns."
					});
				}
			});
		}
		
			
		else if (_text == "Teacher")
		{
			//except for this one because it needs to be dynamic
			this.m.Cost = 10 * this.Const.World.StrongholdPriceMult;
			this.m.Text = "Choose a brother to receive special training by the swordmaster. This will cost " + this.m.Cost + " crowns."
			this.m.Title = "Train a brother"			
		}
		else if (_text == "Gift")
		{
			this.m.Cost = 0 * this.Const.World.StrongholdPriceMult;
			this.m.Text = "Choose a faction to send gifts to. This will consume the valuables you have in your inventory, and give you positive reputation with that faction depending on their value. The caravan will demand 5000 crowns to transport the goods."
			this.m.Title = "Send gifts"			
		}
		else if (_text == "Remove_Base")
		{
			this.m.Cost = 0 * this.Const.World.StrongholdPriceMult;
			this.m.Text = "FINAL WARNING! Are you really sure you want to remove your base?"
			this.m.Title = "Remove your base"
			this.addOverviewScreen()
			
			this.m.Screens.push
			({
				ID = "Enough",
				Title = this.m.Title,
				Text = "You removed your base.",
				Image = "",
				List = [],
				ShowEmployer = true,
				Options = [
					{
						Text = "Good.",
						function getResult()
						{
							this.World.Contracts.finishActiveContract();
							this.World.Contracts.removeContract(this.Contract)
							local player_faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player)
							local player_base = player_faction.m.Settlements[0]
							local contracts = player_faction.getContracts()
							foreach (contract in contracts)
							{
								this.World.Contracts.removeContract(contract)
							}
							foreach (unit in player_faction.m.Units)
							{
								unit.fadeOutAndDie()
							}
							
							foreach( h in player_base.m.HousesTiles )
							{
								local tile = this.World.getTileSquare(h.X, h.Y);
								tile.clear(this.Const.World.DetailType.Houses | this.Const.World.DetailType.Lighting);
								local d = tile.spawnDetail("world_houses_0" + player_base.m.HousesType + "_0" + h.V + "_ruins", this.Const.World.ZLevel.Object - 3, this.Const.World.DetailType.Houses);
								d.Scale = 0.85;
								player_base.spawnFireAndSmoke(tile.Pos);
							}
							player_base.spawnFireAndSmoke(player_base.getTile().Pos)
							foreach (location in player_base.m.AttachedLocations)
							{
								player_base.spawnFireAndSmoke(location.getTile().Pos)
								location.die()
							}
							player_base.die()
							return 0;
						}

					}
				],
				function start()
				{
				}
			})
		}
	}

	function getTeacherOptions()
	{
		local roster = this.World.getPlayerRoster().getAll();
		local options = []
		foreach (bro in roster)
		{
			if (bro.getLevel() < 11 && !bro.getSkills().hasSkill("effects.trained") && options.len() < 11)
			{
				options.push(
				{
					Text = bro.getName(),
					function getResult()
					{
						// if only I learned this before
						this.Contract.m.Teacher_Option <- this.Text
						this.Contract.m.Text = " The brother to be trained is " + this.Text;
						this.Contract.addOverviewScreen()
						this.Contract.addTeacherEnoughScreen()
						return "Overview_Building";
					}
				})
			}
		}
		options.push(
			{
				Text = "Not right now.",
				function getResult()
				{
					this.Contract.removeThisContract()
					return 0;
				}
			})
		
		return options
	}
	
	function addTeacherEnoughScreen()
	{
		this.m.Screens.push({
			ID = "Enough",
			Title = this.m.Title,
			Text = this.m.Text,
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Good.",
					function getResult()
					{
						this.World.Assets.addMoney(-this.Contract.m.Cost);							
						local effect = this.new("scripts/skills/effects_world/new_trained_effect");
						effect.m.Duration = 10;
						effect.m.XPGainMult = 1.5;
						effect.m.Icon = "skills/status_effect_75.png";
						foreach(bro in this.World.getPlayerRoster().getAll())
						{
							if (bro.getName() == this.Contract.m.Teacher_Option && bro.getLevel() < 11 && !bro.getSkills().hasSkill("effects.trained") )
							{
								bro.getSkills().add(effect)
								break;
							}
						}
						
						this.Contract.removeThisContract()
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/events/event_134.png",
					text = "You lose " +this.Contract.m.Cost + " crowns."
				});
			}
		});
	}
	
	function isGiftValid( _set = false)
	{
		local player_base = this.getPlayerBase()
		if (player_base.getSize() < 2)
		{
			return false;
		}
		if (this.World.Assets.getMoney() < 5000)
		{
			return false;
		}
		local numGifts = 0
		local stash = this.World.Assets.getStash().getItems();
		foreach( i, item in stash )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Loot))
			{
				numGifts++
			}
		}
		if (numGifts < 1)
		{
			return false
		}
		local factions = [];
		factions.extend(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse));
		factions.extend(this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState));
		local validFactions = []
		foreach (faction in factions)
		{
			if (faction.getPlayerRelation() > 80)
			{
				continue
			}
			local militarySettlements = [];
			foreach (settlement in faction.getSettlements())
			{
				if (faction.m.Type == this.Const.FactionType.OrientalCityState)
				{
					if (settlement.isConnectedToByRoads(player_base))
					{
						militarySettlements.push(settlement);
					}
				}
				else
				{
					if (settlement.isMilitary() && settlement.isConnectedToByRoads(player_base))
					{
						militarySettlements.push(settlement);

					}
				}
			}
			if (militarySettlements.len() > 0)
			{
				local chosenSettlement = null;
				if (militarySettlements.len() > 1)
				{
					//randoms one of the settlements, can be cheesed but oh well
					chosenSettlement = militarySettlements[this.Math.rand(0, militarySettlements.len()-1)]
				}
				else{
					chosenSettlement = militarySettlements[0]
				}
					
				validFactions.push
				({
					"Faction" : faction
					"Town" : chosenSettlement
				})
			}
		}
		if (validFactions.len() < 1)
		{
			return false;
		}
		else
		{
			if (_set)
			{
				this.setGiftFactions(validFactions);
			}
			return true
		}
	}
	
	function setGiftFactions(_factions)
	{
		this.m.ValidFactionsForGift <- _factions
	}
	
	function getGiftOptions()
	{
		local options = []
		foreach (entry in this.m.ValidFactionsForGift)
		{
			options.push(
			{
				Text = entry.Faction.getName(),
				function getResult()
				{
					foreach (entry in this.Contract.m.ValidFactionsForGift)
					{
						if (entry.Faction.getName() == this.Text)
						{
							this.Contract.m.ValidFactionsForGift = entry
							break
						}
					}
					this.Contract.m.Text = " The faction you're sending a gift to is " + this.Text;
					this.Contract.addGiftEnoughScreen()
					this.Contract.addOverviewScreen()
					return "Overview_Building";
				}
			})
		}
		options.push(
			{
				Text = "Not right now.",
				function getResult()
				{
					this.Contract.removeThisContract()
					return 0;
				}
			})
		if (options.len() > 0)
		{
			return options
		}
	}
	
	function addGiftEnoughScreen()
	{
		this.m.Screens.push({
			ID = "Enough",
			Title = this.m.Title,
			Text = "Your caravan is on their way to " +  this.m.ValidFactionsForGift.Town.getName() + " Protect it!",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Good.", 
					function getResult()
					{
						this.World.Assets.addMoney(-5000);	
						local player_faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player);
						local player_base =  player_faction.m.Settlements[0];
						local destination_faction = this.Contract.m.ValidFactionsForGift.Faction
						local destination_town = this.Contract.m.ValidFactionsForGift.Town
						
						local patrol_strength = 100 * (player_base.getSize()-1)
						if (player_base.hasAttachedLocation("attached_location.militia_trainingcamp"))
						{
							patrol_strength += 100
						}
						local party = player_faction.spawnEntity(player_base.getTile(), "Caravan of " + player_base.getName(), true, this.Const.World.Spawn.Caravan, 50);
						this.Const.World.Common.assignTroops(party, this.Const.World.Spawn.Mercenaries, patrol_strength);
						party.setDescription("A caravan bringing gifts to " + destination_town.getName() );
						party.setFootprintType(this.Const.World.FootprintsType.Caravan);
						party.getSprite("body").setBrush("cart_02")
						party.setMovementSpeed(5 * this.Const.World.MovementSettings.Speed);
						party.setVisibilityMult(1.0);
						party.setVisionRadius(this.Const.World.Settings.Vision * 0.25);
						party.getSprite("base").Visible = false;
						party.setVisibleInFogOfWar(true)
						party.setMirrored(true);
						party.getFlags().set("IsCaravan", true);
						party.getFlags().set("IsRandomlySpawned", true);
						
						
						local totalReputation = 0
						local stash = this.World.Assets.getStash().getItems();
						
						//remove treasure from player inventory and add 0.1x their value as reputation on arrival
						foreach( i, item in stash )
						{
							if (item != null && item.isItemType(this.Const.Items.ItemType.Loot))
							{
								totalReputation += this.Math.abs(item.m.Value / 100)
								stash[i] = null;
							}
						}
						
						//add orders to move to destination, 'unload' the gifts and get reputation, despawn
						local c = party.getController();
						c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
						c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
						
						local move = this.new("scripts/ai/world/orders/move_order");
						move.setDestination(destination_town.getTile());
						move.setRoadsOnly(true);
						
						local unload = this.new("scripts/ai/world/orders/mod_unload_gifts_order");
						unload.m.Flags.set("DestinationFaction", destination_faction.getID())
						unload.m.Flags.set("Destination", destination_town.getName())
						unload.m.Flags.set("Reputation", totalReputation)
						
						local despawn = this.new("scripts/ai/world/orders/despawn_order");
						
						c.addOrder(move)
						c.addOrder(unload)
						c.addOrder(despawn)
						this.Contract.removeThisContract()
						return 0;
					}

				}
			],
			function start()
			{
				local stash = this.World.Assets.getStash().getItems();
				foreach( i, item in stash )
				{
					if (item != null && item.isItemType(this.Const.Items.ItemType.Loot))
					{
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
					}
				}
				this.List.push({
						id = 10,
						icon = "ui/events/event_134.png",
						text = "You lose 5000 crowns."
					});
			}
		});
	}
			
			
	
	function addOverviewScreen()
	{
		this.m.Screens.push
		({
			ID = "Overview_Building",
			Title = this.m.Title,
			Text = this.m.Text,
			Image = "",
			List = [],
			Options = [
				{
					Text = "Yes.",
					function getResult()
					{
						if (this.World.Assets.getMoney() >= this.Contract.m.Cost)
						{
							return "Enough"

						}
						else
						{
							return "Not_Enough"
						}
					}

				},
				{
					Text = "No.",
					function getResult()
					{
						this.Contract.removeThisContract()
						return 0;
					}

				}
			],
			ShowObjectives = true,
			ShowPayment = true,
			ShowEmployer = true,
			ShowDifficulty = false,
		});
	}
	
	function onPrepareVariables( _vars )
	{
	}

	function onHomeSet()
	{
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.World.FactionManager.getFaction(this.getFaction()).setActive(true);
			this.m.Home.getSprite("selection").Visible = false;

		}

	}

	function onIsValid()
	{
		return true;
	}
	function cancel()
	{
		this.onCancel();
	}
	function removeThisContract()
	{
		this.World.Contracts.removeContract(this);
		this.m.Home.updateQuests()
		this.World.State.getTownScreen().updateContracts();
	}

	function onSerialize( _out )
	{

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);

	}

});

