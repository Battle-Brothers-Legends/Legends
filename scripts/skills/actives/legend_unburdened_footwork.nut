// this.legend_unburdened_footwork <- ::inherit("scripts/skills/actives/footwork", {
// 	m = {
// 		Stacks = 1;
// 	},
// 	function create()
// 	{
// 		this.m.ID = "actives.unburdened_footwork";
// 		this.m.Name = "Unburdened Footwork";
// 		this.m.Description = "Use skillful footwork to leave a Zone of Control without triggering free attacks.";

// 		this.m.ActionPointCost = 0;
// 	}

// 	function getTooltip()
// 	{
// 		local ret = [
// 			{
// 				id = 1,
// 				type = "title",
// 				text = this.getName()
// 			},
// 			{
// 				id = 2,
// 				type = "description",
// 				text = this.getDescription()
// 			},
// 			{
// 				id = 3,
// 				type = "text",
// 				text = this.getCostString()
// 			}
// 		];

// 		if (this.Tactical.isActive() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
// 		{
// 			ret.push({
// 				id = 9,
// 				type = "text",
// 				icon = "ui/tooltips/warning.png",
// 				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can only be used when in an opponent\'s Zone of Control[/color]"
// 			});
// 		}

// 		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
// 		{
// 			ret.push({
// 				id = 9,
// 				type = "text",
// 				icon = "ui/tooltips/warning.png",
// 				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used while rooted[/color]"
// 			});
// 		}

// 		if (this.m.Stacks <= 0)
// 		{
// 			ret.push({
// 				id = 10,
// 				type = "text",
// 				icon = "ui/tooltips/warning.png",
// 				text = "[color=" + this.Const.UI.Color.Negative + "]Skill already used up.[/color]"
// 			});
// 		}

// 		return ret;
// 	}

// 	function isUsable()
// 	{
// 		if (this.m.Stacks <= 0) return false;
// 		if (this.skill.isUsable() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && !this.getContainer().getActor().getCurrentProperties().IsRooted)
// 		{
// 			local myTile = this.getContainer().getActor().getTile();

// 			for( local i = 0; i < 6; i = ++i )
// 			{
// 				if (!myTile.hasNextTile(i))
// 				{
// 				}
// 				else
// 				{
// 					local nextTile = myTile.getNextTile(i);

// 					if (!nextTile.IsOccupiedByActor || this.Math.abs(nextTile.Level - myTile.Level) > 1)
// 					{
// 					}
// 					else
// 					{
// 						local entity = nextTile.getEntity();

// 						if (!entity.getCurrentProperties().IsStunned && !entity.isAlliedWith(this.getContainer().getActor()))
// 						{
// 							return true;
// 						}
// 					}
// 				}
// 			}
// 		}
// 		else
// 		{
// 			return false;
// 		}
// 	}

// 	function onUse( _user, _targetTile )
// 	{
// 		this.Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
// 		this.m.Stacks -= 1;
// 		return true;
// 	}

// });
