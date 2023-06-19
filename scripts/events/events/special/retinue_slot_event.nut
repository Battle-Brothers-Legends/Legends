this.retinue_slot_event <- this.inherit("scripts/events/event", {
	m = {
		LastSlotsUnlocked = 0
	},
	function create()
	{
		this.m.ID = "event.retinue_slot";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 33.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{The prestige and renown of the %companyname% is growing. Everywhere you go, people are looking to join - and not just sellswords, but followers who may be of other use! | With every battle your sellswords fight, the renown of the company grows. As this fame rises, more people, and not just sellswords, will be looking to join the %companyname%. Perhaps it is time the company invests in some special equipment? | Followers of the %companyname% need tools to fill their roles, and said tools would prove helpful to the survival of those around them...}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I\'ll take a look at our retinue!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local unlocked = this.World.Retinue.getNumberOfUnlockedSlots();

		if (unlocked > this.m.LastSlotsUnlocked && this.World.Retinue.getNumberOfCurrentFollowers() < unlocked)
		{
			this.m.Score = 400;
		}
	}

	function onPrepare()
	{
		this.m.LastSlotsUnlocked = this.World.Retinue.getNumberOfUnlockedSlots();
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

	function onSerialize( _out )
	{
		this.event.onSerialize(_out);
		_out.writeU8(this.m.LastSlotsUnlocked);
	}

	function onDeserialize( _in )
	{
		this.event.onDeserialize(_in);
		this.m.LastSlotsUnlocked = _in.readU8();
	}

});

