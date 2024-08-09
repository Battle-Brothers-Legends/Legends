this.legends_mod <- {
    m = {
        Configs = null,
        Mod = null  // Add this line to store the Mod instance
    },
    function create()
    {
        ::logInfo("Starting legends_mod create function");
        
        this.m.Configs = this.new("scripts/mods/legends_configs");
        
        if (!("Legends" in getroottable()))
        {
            ::logError("Legends not found in root table in legends_mod");
            return;
        }

        ::logInfo("Legends found in root table in legends_mod");

        if (!("Mod" in ::Legends))
        {
            ::logError("Legends.Mod not found in legends_mod");
            return;
        }

        ::logInfo("Legends.Mod found in legends_mod");

        this.m.Mod = ::Legends.Mod;
        ::logInfo("legends_mod: Legends.Mod assigned: " + (this.m.Mod != null));
    },
    function Configs() 
    {
        return this.m.Configs;
    },
    function Mod()  // Add this getter for the Mod instance
    {
        return this.m.Mod;
    },
    function onDevConsole(_command, _args)
    {
        switch(_command)
        {
        case "event":
            this.doDevConsoleEvent(_args);
            break;
        }
    },
    function doDevConsoleEvent(_args)
    {
        if (!this.World.Events.canFireEvent())
        {
            this.logInfo("Can not fire event " + _args +" at this time");
            return;
        }
        this.World.Events.fire(_args);
    }
};
