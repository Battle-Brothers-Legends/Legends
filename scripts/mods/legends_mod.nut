this.legends_mod <- {
	m = {
        Configs = null
        //BrotherStats = null
    },
	function create()
	{
        this.m.Configs = this.new("scripts/mods/legends_configs");
        // this.m.BrotherStats = this.new("scripts/statistics/legends_brother_statistics_manager");
	}

    function Configs() {
        return this.m.Configs;
    }

    // function BroStats()
    // {
    //     return this.m.BrotherStats;
    // }

    function onDevConsole(_command, _args)
    {
        switch(_command)
        {
        case "event":
            this.doDevConsoleEvent(_args);
            break;
        case "relation":
            this.doDevConsoleRelation(_args);
            break;
        case "factioninfo":
            this.doDevConsoleFactionInfo(_args);
            break;
        }
    }

    function doDevConsoleEvent(_args)
    {
        if (!this.World.Events.canFireEvent())
        {
            this.logInfo("Theoretically cannot fire event " + _args +" at this time, but doing it anyways");
        }

        this.World.Events.fire(_args);
    }

    function doDevConsoleRelation(_args)
    {
        local value = _args.tointeger();
        for(local i = 0; i < this.World.FactionManager.getFactions().len(); i++) {
            local f = this.World.FactionManager.getFaction(i);
            if(f != null) {
		        this.World.FactionManager.getFaction(i).setPlayerRelation(value);
            }
        }
    }

    function doDevConsoleFactionInfo(_args)
    {
        for(local i = 0; i < this.World.FactionManager.getFactions().len(); i++) {
            local f = this.World.FactionManager.getFaction(i);
            if(f != null) {
		        this.logInfo("Faction #" + i + ": " + f.getName() + ", relation = " + f.getPlayerRelation());
            }
        }
    }

    function onSerialize(_out)
    {
        this.m.Configs.onSerialize(_out);
    }

    function onDeserialize(_in)
    {
        this.m.Configs.onDeserialize(_in);
    }


}