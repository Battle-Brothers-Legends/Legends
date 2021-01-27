this.remove_playerbase_building_contract <- this.inherit("scripts/contracts/contract", {
	//custom quest to add player base building. Is created when entering the base, if not already there. Gives you a list of options for the relevant building. Requires modified CSS file
	//will probably make it nicer with a proper function to add the options
	m = {
		Reward = 0,
		Building = "",
		Options = []
	},
	function create()
	{
		this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.TempFlags = this.new("scripts/tools/tag_collection");
		this.createStates();
		this.createScreens();
		this.m.Type = "contract.remove_playerbase_building_contract";
		this.m.Name = "Remove Building";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 1500.0;
	}

	function onImportIntro()
	{
	}

	function start()
	{
		this.contract.start();
	}
	
	function getBanner()
	{
		return "ui/banners/factions/banner_11s"
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
				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview_Building");
			}

		});
	}

	function createScreens()
	{
		
		this.m.Screens.push({
			ID = "Task",
			Title = "Remove a building",
			Text = "Do you wish to remove a building? This costs nothing, and will free up a slot for a new building.",
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
					Text = "I won't remove a building right now.",
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
		
		this.m.Screens.push({
			ID = "Negotiation_Building",
			Title = "Remove a building",
			Text = "Which building would you like to remove?",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = this.getOptions()
			});
		
		this.m.Screens.push({
			ID = "Enough",
			Title = "Remove a building",
			Text = "You removed the building.",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Good.",
					function getResult()
					{
						local result = this.Contract.m.Building
						local home = this.Contract.m.Home
						foreach(i, building in home.m.Buildings){
							if(home.m.Buildings[i] != null && home.m.Buildings[i].m.ID == result){
								home.m.Buildings[i] = null;
								break;
							}
						}
						this.Contract.removeThisContract()
						this.World.State.m.WorldTownScreen.show()
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "This was free."
				});
			}

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
	
	function getOptions(){
		local home = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0].m.Settlements[0];
		local contract_options = [];
		if (home.hasBuilding("building.weaponsmith"))
		{
			contract_options.push(
			{
				Text = "Remove a weaponsmith.",
				function getResult()
				{
					this.Contract.m.Building = "building.weaponsmith";
					this.Contract.addNegScreen("Weaponsmith")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.weaponsmith_oriental"))
		{
			contract_options.push(
			{
				Text = "Remove a weaponsmith.",
				function getResult()
				{
					this.Contract.m.Building = "building.weaponsmith_oriental";
					this.Contract.addNegScreen("Weaponsmith")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.armorsmith"))
		{
			contract_options.push(
			{
				Text = "Remove an armorsmith.",
				function getResult()
				{
					this.Contract.m.Building = "building.armorsmith";
					this.Contract.addNegScreen("Armorsmoth")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.armorsmith_oriental"))
		{
			contract_options.push(
			{
				Text = "Remove an armorsmith.",
				function getResult()
				{
					this.Contract.m.Building = "building.armorsmith_oriental";
					this.Contract.addNegScreen("Armorsmoth")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.fletcher"))
		{
			contract_options.push(
			{
				Text = "Remove a fletcher.",
				function getResult()
				{
					this.Contract.m.Building = "building.fletcher";
					this.Contract.addNegScreen("Fletcher")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.training_hall"))
		{
			contract_options.push(
			{
				Text = "Remove a training hall.",
				function getResult()
				{
					this.Contract.m.Building = "building.training_hall";
					this.Contract.addNegScreen("Training Hall")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.kennel"))
		{
			contract_options.push(
			{
				Text = "Remove a kennel.",
				function getResult()
				{
					this.Contract.m.Building = "building.kennel";
					this.Contract.addNegScreen("Kennel")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.taxidermist"))
		{
			contract_options.push(
			{
				Text = "Remove a taxidermist.",
				function getResult()
				{
					this.Contract.m.Building = "building.taxidermist";
					this.Contract.addNegScreen("Taxidermist")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.taxidermist_oriental"))
		{
			contract_options.push(
			{
				Text = "Remove a taxidermist.",
				function getResult()
				{
					this.Contract.m.Building = "building.taxidermist_oriental";
					this.Contract.addNegScreen("Taxidermist")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.temple"))
		{
			contract_options.push(
			{
				Text = "Remove a temple.",
				function getResult()
				{
					this.Contract.m.Building = "building.temple";
					this.Contract.addNegScreen("Temple")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.temple_oriental"))
		{
			contract_options.push(
			{
				Text = "Remove a temple.",
				function getResult()
				{
					this.Contract.m.Building = "building.temple_oriental";
					this.Contract.addNegScreen("Temple")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.mod_alchemist"))
		{
			contract_options.push(
			{
				Text = "Remove an alchemist.",
				function getResult()
				{
					this.Contract.m.Building = "building.mod_alchemist";
					this.Contract.addNegScreen("Alchemist")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.port"))
		{
			contract_options.push(
			{
				Text = "Remove a port.",
				function getResult()
				{
					this.Contract.m.Building = "building.port";
					this.Contract.addNegScreen("Port")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.mod_tavern"))
		{
			contract_options.push(
			{
				Text = "Remove a tavern (crowd).",
				function getResult()
				{
					this.Contract.m.Building = "building.mod_tavern";
					this.Contract.addNegScreen("Tavern")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.tavern"))
		{
			contract_options.push(
			{
				Text = "Remove a tavern.",
				function getResult()
				{
					this.Contract.m.Building = "building.tavern";
					this.Contract.addNegScreen("Tavern")
					return "Overview_Building";
				}
			})
		}
		if (home.hasBuilding("building.arena"))
		{
			contract_options.push(
			{
				Text = "Remove an arena.",
				function getResult()
				{
					this.Contract.m.Building = "building.arena";
					this.Contract.addNegScreen("Arena")
					return "Overview_Building";
				}
			})
		}
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
	
	function addNegScreen(_text){
		this.m.Screens.push({
			ID = "Overview_Building",
			Title = "Confirm your choice",
			Text = "You selected a " + _text +". Do you wish to remove this?",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Yes.",
					function getResult()
					{
						return "Enough"
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
			ShowEmployer = false,
			ShowDifficulty = false,
			function start()
			{
				this.Contract.m.IsNegotiated = true;
			}
		});
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

