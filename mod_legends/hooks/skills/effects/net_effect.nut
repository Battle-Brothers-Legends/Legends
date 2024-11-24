::mods_hookExactClass("skills/effects/net_effect", function(o) {

	o.m.DropNet <- false; // Net item will be dropped in battle if it was thrown with Net Mastery
	o.m.IsReinforced <- false;

	o.onDeath <- function ( _fatalityType )
	{
		if (this.m.DropNet)
		{
			local net;
			if (this.m.IsReinforced)
			{
				net = this.new("scripts/items/tools/reinforced_throwing_net");
			}
			else
			{
				net = this.new("scripts/items/tools/throwing_net");
			}
			net.drop(this.getContainer().getActor().getTile());
		}
	}
});
