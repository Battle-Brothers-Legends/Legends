::mods_hookExactClass("items/supplies/cured_venison_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. A cured chunk of venison preserved by salt. Fine food for a travelling sellsword. Can be eaten in battle to provide healing and fatigue recovery over ten turns. Will be used as provisions if left in the company stash";
		this.m.Value = 100;
		this.m.Amount = 30.0;
		this.m.GoodForDays = 8;
	}

	o.onPutIntoBag <- function ()
	{
		this.onEquip();
	}

	o.onEquip <- function ()
	{
		this.food_item.onEquip();
		local skill = this.new("scripts/skills/actives/legend_eat_rations_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}
});