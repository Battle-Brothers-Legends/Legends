this.legend_arborthropy_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.legend_arborthropy";
		this.m.Name = "Arborthrope";
		this.m.Description = "This character is cursed with arborthropy and will transform into a schrat ";
		this.m.Icon = "ui/injury/injury_arborthropy.png";
	}

	function getTooltip()
	{
		local day = this.World.getTime().Days;
		local month = day / 28;
		local monthfloor = this.Math.floor(month);
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will randomly transform into a schrat"
			}
		];
		this.addTooltipHint(ret);

		if (month == monthfloor)
		{
			ret.push({
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "it is currently a full moon, the transformation will happen during any battle today"
			});
		}

		return ret;
	}

	function onUpdate( _properties )
	{
	}

	function onApplyAppearance()
	{
	}

function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		if(!actor.getSkills().hasSkill("effect.legend_transformed_wolf") && !actor.getSkills().hasSkill("effect.legend_transformed_bear") && !actor.getSkills().hasSkill("effect.legend_transformed_boar") && !actor.getSkills().hasSkill("effect.legend_transformed_rat") && !actor.getSkills().hasSkill("effect.legend_transformed_tree") && !actor.getSkills().hasSkill("effects.legend_wolfsbane"))
		{
			if (!actor.getSkills().hasSkill("perk.legend_master_anger"))
			{
				local r = this.Math.rand(1,10);
				local day = this.World.getTime().Days;
				local month = day / 28;
				local monthfloor = this.Math.floor(month);

				if (r == 1 && this.World.getTime().IsDaytime && month != monthfloor)
				{

					actor.getSkills().add(this.new("scripts/skills/effects/legend_transformed_tree_effect"));
				}

				if (r <= 2 && !this.World.getTime().IsDaytime && month != monthfloor)
				{

					actor.getSkills().add(this.new("scripts/skills/effects/legend_transformed_tree_effect"));
				}

				if (month == monthfloor)
				{

					actor.getSkills().add(this.new("scripts/skills/effects/legend_transformed_tree_effect"));

				}
			}
			else
			{

				actor.getSkills().add(this.new("scripts/skills/actives/legend_transform_into_tree"));

			}
		}
	}

});

