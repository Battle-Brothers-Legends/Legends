this.getroottable().Const.LegendMod.hookAlpRacial <- function()
{
    ::mods_hookExactClass("skills/racial/alp_racial", function(o) 
    {
        local onBeforeDamageReceived = o.onBeforeDamageReceived
        o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
        {
            if (_skill == null)
            {
                return;
            }
            onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
        }
    })
    delete this.Const.LegendMod.hookAlpRacial;
}