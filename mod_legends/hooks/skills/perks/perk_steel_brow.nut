::mods_hookExactClass("skills/perks/perk_steel_brow", function(o) {
	o.onAdded <- function ()
	{
		if (!this.m.Container.hasSkill("effects.legend_steel_brow"))
		{
			this.m.Container.add(this.new("scripts/skills/effects/legend_steel_brow_effect"));
		}
	}

	o.onRemoved <- function ()
	{
		this.m.Container.removeByID("effects.legend_steel_brow");
	}

	// 		//if (effect) -> remove and replace with diff. effect
    // function onUse( _user, _targetTile )
    // {
    //     local bonk = this.attackEntity(_user, _targetTile.getEntity());

    //     if (bonk)
    //     {
    //         local target = _targetTile.getEntity();

    //         if (target.getCurrentProperties().IsStunned)
    //         {
    //             // target.getSprite("status_stunned").Visible = false; //Not needed - is managed by dazed_effect.nut
    //             target.getSkills().removeByID("effects.stunned");
    //             target.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
    //         }
    //     }

    //     return success;
    // }
});