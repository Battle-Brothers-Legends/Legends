this.remove_playerbase_contract <- this.inherit("scripts/contracts/contract", {
	//removes the playerbase by destroying all the contracts, then calling fadeoutanddie on the base
	m = {
		Reward = 0
	},
	function create()
	{
		this.m.DifficultyMult = this.Math.rand(115, 125) * 0.01;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.TempFlags = this.new("scripts/tools/tag_collection");
		this.createStates();
		this.createScreens();
		this.m.Type = "contract.remove_playerbase_contract";
		this.m.Name = "Remove Fort";
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
		return "ui/banners/factions/banner_11s"
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.setScreen("Task");
				this.World.Contracts.showActiveContract();
			}

			function end()
			{
				#add building
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{

				
			}
			function update()
			{
				this.Contract.setScreen("Enough");
				this.World.Contracts.showActiveContract();
			
			}
		
			function end()
			{
			}

		});
		

	}

	function createScreens()
	{	
		this.m.Screens.push({
			ID = "Task",
			Title = "Remove your fort",
			Text = "Do you wish to remove your base? You can't undo this, but you can build it again in another location.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Yes.",
					function getResult()
					{
						return "second_confirm"

					}

				},
				{
					Text = "No.",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						this.World.State.getTownScreen().updateContracts();
						return 0;
					}

				}
			],
			ShowObjectives = true,
			ShowPayment = true,
			ShowDifficulty = false,
			function start()
			{
				this.Contract.m.IsNegotiated = true;
			}
		});
		
		this.m.Screens.push({
			ID = "second_confirm",
			Title = "Remove your fort",
			Text = "Are you sure? You can't undo this!",
			Image = "",
			List = [],
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
						this.World.Contracts.removeContract(this.Contract);
						this.World.State.getTownScreen().updateContracts();
						return 0;
					}

				}
			],
			ShowObjectives = true,
			ShowPayment = true,
			ShowDifficulty = false,
			function start()
			{
				this.Contract.m.IsNegotiated = true;
			}
		});
		
		this.m.Screens.push({
			ID = "Overview_Building",
			Title = "Confirm your choice",
			Text = "LAST CHANCE TO BACK OUT! ARE YOU SURE YOU WANT TO REMOVE YOUR BASE?",
			Image = "",
			List = [],
			Options = [
				{
					Text = "YES",
					function getResult()
					{
						this.Contract.setState("Running");
						return 0;
					}

				},
				{
					Text = "NO STOP.",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						this.World.State.getTownScreen().updateContracts();
						return 0;
					}

				}
			],
			ShowObjectives = true,
			ShowPayment = true,
			ShowDifficulty = false,
			function start()
			{
			}
		});
		
		
		this.m.Screens.push({
			ID = "Enough",
			Title = "Remove your fort",
			Text = "Your fort has been removed.",
			Image = "",
			List = [],
			ShowEmployer = false,
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
	function onSerialize( _out )
	{

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);

	}

});

