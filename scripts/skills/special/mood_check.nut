this.mood_check <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.mood_check";
		this.m.Name = "Mood Check";
		this.m.Icon = "skills/status_effect_02.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.Order = this.Const.SkillOrder.Trait + 600;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = true;
	}

	function getTooltip()
	{
		local ret;

		switch(this.getContainer().getActor().getMoodState())
		{
		case this.Const.MoodState.Neutral:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "This character is content with how things are going. Could be better, could be worse.\n\nMood will always trend towards this state over time."
				}
			];
			break;

		case this.Const.MoodState.Concerned:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "Not uncommon for someone living the hardships of mercenary life, this character isn\'t quite satisfied and is hoping for things to improve."
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Can only have [color=" + this.Const.UI.Color.NegativeValue + "]steady[/color] morale or worse"
				}
			];
			break;

		case this.Const.MoodState.Disgruntled:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "Recent events have left this character disgruntled and disappointed how things are going. It may fade, or it may get a lot worse if other events tip him over the edge."
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Can only have [color=" + this.Const.UI.Color.NegativeValue + "]wavering[/color] morale or worse"
				}
			];
			break;

		case this.Const.MoodState.Angry:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "Recent events have left this character angry and vengeful towards those around them. If things don\'t improve very quickly, this character may decide to desert the company!"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Can only have [color=" + this.Const.UI.Color.NegativeValue + "]breaking[/color] morale or worse"
				}
			];
			break;

		case this.Const.MoodState.InGoodSpirit:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "Recent events have left this character in good spirit. It will probably pass as reality takes a grip again, but for now, things are looking well."
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] chance to start battle at confident morale"
				}
			];
			break;

		case this.Const.MoodState.Eager:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "Recent events have left this character eager to fight with the company, pleased with how things are going and motivating to those around them"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] chance to start battle at confident morale"
				}
			];
			break;

		case this.Const.MoodState.Euphoric:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "Recent events have left this character in a state of euphoria, happy to spend their time in service of the company and sure of victory against any foe. It\'s bordering on the annoying, really."
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]75%[/color] chance to start battle at confident morale"
				}
			];
			break;
		}

		local changes = this.getContainer().getActor().getMoodChanges();

		foreach( change in changes )
		{
			if (change.Positive)
			{
				ret.push({
					id = 11,
					type = "hint",
					icon = "ui/tooltips/positive.png",
					text = "" + change.Text + ""
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "hint",
					icon = "ui/tooltips/negative.png",
					text = "" + change.Text + ""
				});
			}
		}

		return ret;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		local mood = actor.getMoodState();
		local morale = actor.getMoraleState();
		local isDastard = this.getContainer().hasSkill("trait.dastard");

		switch(mood)
		{
		case this.Const.MoodState.Concerned:
			actor.setMaxMoraleState(this.Const.MoraleState.Steady);
			actor.setMoraleState(this.Const.MoraleState.Steady);
			break;

		case this.Const.MoodState.Disgruntled:
			actor.setMaxMoraleState(this.Const.MoraleState.Wavering);
			actor.setMoraleState(this.Const.MoraleState.Wavering);
			break;

		case this.Const.MoodState.Angry:
			actor.setMaxMoraleState(this.Const.MoraleState.Breaking);
			actor.setMoraleState(this.Const.MoraleState.Breaking);
			break;

		case this.Const.MoodState.Neutral:
			actor.setMaxMoraleState(this.Const.MoraleState.Confident);
			break;

		case this.Const.MoodState.InGoodSpirit:
			actor.setMaxMoraleState(this.Const.MoraleState.Confident);

			if (morale < this.Const.MoraleState.Confident && this.Math.rand(1, 100) <= 25 && !isDastard)
			{
				actor.setMoraleState(this.Const.MoraleState.Confident);
			}

			break;

		case this.Const.MoodState.Eager:
			actor.setMaxMoraleState(this.Const.MoraleState.Confident);

			if (morale < this.Const.MoraleState.Confident && this.Math.rand(1, 100) <= 50 && !isDastard)
			{
				actor.setMoraleState(this.Const.MoraleState.Confident);
			}

			break;

		case this.Const.MoodState.Euphoric:
			actor.setMaxMoraleState(this.Const.MoraleState.Confident);

			if (morale < this.Const.MoraleState.Confident && this.Math.rand(1, 100) <= 75 && !isDastard)
			{
				actor.setMoraleState(this.Const.MoraleState.Confident);
			}

			break;
		}
	}

	function onUpdate( _properties )
	{
		local mood = this.getContainer().getActor().getMoodState();
		local p = this.Math.round(this.getContainer().getActor().getMood() / (this.Const.MoodState.len() - 0.05) * 100.0);
		this.m.Name = this.Const.MoodStateName[mood] + " (" + p + "%)";

		switch(mood)
		{
		case this.Const.MoodState.Neutral:
			this.m.Icon = "skills/status_effect_64.png";
			break;

		case this.Const.MoodState.Concerned:
			this.m.Icon = "skills/status_effect_46.png";
			break;

		case this.Const.MoodState.Disgruntled:
			this.m.Icon = "skills/status_effect_45.png";
			break;

		case this.Const.MoodState.Angry:
			this.m.Icon = "skills/status_effect_44.png";
			break;

		case this.Const.MoodState.InGoodSpirit:
			this.m.Icon = "skills/status_effect_47.png";
			break;

		case this.Const.MoodState.Eager:
			this.m.Icon = "skills/status_effect_48.png";
			break;

		case this.Const.MoodState.Euphoric:
			this.m.Icon = "skills/status_effect_49.png";
			break;
		}
	}

});

