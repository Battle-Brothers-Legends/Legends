this.getroottable().Const.LegendMod.loadTacticalTooltip <- function()
{
	local modTacticalTooltip = function ( tooltip, _targetedWithSkill )
	{
		if (!this.isPlayerControlled() && !this.LegendsMod.Configs().EnemeyTooltips())
		{
			return tooltip;
		}

		if (tooltip.len() < 3)
		{
			return tooltip;
		}

		local shownPerks = {};
		local stackEffects = function ( effects )
		{
			local stacks = {};

			foreach( _, effect in effects )
			{
				local name = effect.getName();

				if (name in stacks)
				{
					stacks[name] += 1;
				}
				else
				{
					stacks[name] <- 1;
				}
			}

			return stacks;
		};
		local pushSectionName = function ( items, title, startID )
		{
			if (items.len() && title)
			{
				tooltip.push({
					id = startID,
					type = "text",
					text = "[u][size=14]" + title + "[/size][/u]"
				});
			}
		};
		local isPerk = @( _, _skill ) _skill.isType(this.Const.SkillType.Perk)
		local isInjury = @( _, _skill ) _skill.isType(this.Const.SkillType.TemporaryInjury);
		local isTextRow = @( _, row ) ("type" in row) && row.type == "text";

		local pushSection = function ( items, title, startID, filter = 0, prependIcon = "", stackInOneLine = false )
		{
			if (!items)
			{
				return;
			}

			if (filter == 1)
			{
				items = items.filter(isPerk);
			}
			else if (filter == 2)
			{
				items = items.filter(function ( i, item )
				{
					return !isPerk(i, item);
				});
			}

			local stacks = {};

			if (stackInOneLine)
			{
				stacks = stackEffects(items);
				local newItems = [];
				local added = {};

				foreach( i, item in items )
				{
					local name = item.getName();

					if (!(name in added))
					{
						newItems.push(item);
						added[name] <- 1;
					}
				}

				items = newItems;
			}

			pushSectionName(items, title, startID);
			startID = startID + 1;

			foreach( i, item in items )
			{
				local name = item.getName();
				local text = name;

				if (filter != 0)
				{
					shownPerks[name] <- 1;
				}

				if (stackInOneLine && stacks[name] > 1)
				{
					text = text + (" [color=" + this.Const.UI.Color.NegativeValue + "]" + "x" + stacks[name] + "[/color]");
				}

				tooltip.push({
					id = startID + i,
					type = "text",
					icon = prependIcon + item.getIcon(),
					text = text
				});
			}
		};
		local removeDuplicates = function ( items )
		{
			if (!items)
			{
				return items;
			}

			return items.filter(function ( i, item )
			{
				return !(item.getName() in shownPerks);
			});
		};
		local getPlural = function ( items )
		{
			if (!items)
			{
				return "";
			}

			return items.len() > 1 ? "s" : "";
		};
		local patchedPerkIcons = {};
		patchedPerkIcons[this.Const.Strings.PerkName.BatteringRam] <- "ui/settlement_status/settlement_effect_13.png";
		local getRealPerkIcon = function ( perk )
		{
			local realPerk = this.Const.Perks.findById(perk.getID());

			if (realPerk)
			{
				return realPerk.Icon;
			}

			local name = perk.getName();

			if (name in patchedPerkIcons)
			{
				return patchedPerkIcons[name];
			}

			return perk.getIcon();
		};

		if (!this.isKindOf(this, "player"))
		{
			local _type = "progressbar";

			foreach( i, row in tooltip )
			{
				if (("type" in row) && row.type == _type && ("id" in row) && "icon" in row)
				{
					if (row.id == 5 && row.icon == "ui/icons/armor_head.png")
					{
						row.text <- "" + this.getArmor(this.Const.BodyPart.Head) + " / " + this.getArmorMax(this.Const.BodyPart.Head) + "";
					}
					else if (row.id == 6 && row.icon == "ui/icons/armor_body.png")
					{
						row.text <- "" + this.getArmor(this.Const.BodyPart.Body) + " / " + this.getArmorMax(this.Const.BodyPart.Body) + "";
					}
					else if (row.id == 7 && row.icon == "ui/icons/health.png")
					{
						row.text <- "" + this.getHitpoints() + " / " + this.getHitpointsMax() + "";
					}
					else if (row.id == 9 && row.icon == "ui/icons/fatigue.png")
					{
						row.text <- "" + this.getFatigue() + " / " + this.getFatigueMax() + "";
					}
				}
			}
		}

		if (_targetedWithSkill != null && this.isKindOf(_targetedWithSkill, "skill"))
		{
			local tile = this.getTile();

			if (tile.IsVisibleForEntity && _targetedWithSkill.isUsableOn(tile))
			{
				tooltip.push({
					id = 2048,
					type = "hint",
					icon = "ui/icons/mouse_right_button.png",
					text = "Expand tooltip"
				});
				return tooltip;
			}
		}

		local statusEffects = this.getSkills().query(this.Const.SkillType.StatusEffect | this.Const.SkillType.TemporaryInjury, false, true);
		local count = tooltip.len() - statusEffects.len();

		if (statusEffects.len() && count > 0)
		{
			if (tooltip[count].text == statusEffects[0].getName())
			{
				tooltip.resize(count);
				statusEffects = statusEffects.filter(function ( _, item )
				{
					return !isInjury(_, item);
				});
				statusEffects = removeDuplicates(statusEffects);
				pushSection(statusEffects, null, 100, 2, "", true);
				local injuries = this.getSkills().query(this.Const.SkillType.TemporaryInjury, false, true);

				foreach( i, injury in injuries )
				{
					local children = injury.getTooltip().filter(function ( _, row )
					{
						return isTextRow(_, row);
					});
					local addedTooltipHints = [];
					injury.addTooltipHint(addedTooltipHints);
					addedTooltipHints = addedTooltipHints.filter(function ( _, row )
					{
						return isTextRow(_, row);
					});
					local added_count = addedTooltipHints.len();

					if (added_count)
					{
						children.resize(children.len() - added_count);
					}

					local isUnderIronWill = function ()
					{
						local pattern = this.regexp("Iron Will");

						foreach( _, row in addedTooltipHints )
						{
							if (("text" in row) && pattern.search(row.text))
							{
								return true;
							}
						}

						return false;
					}();
					local injuryRow = {
						id = 133 + i,
						type = "text",
						icon = injury.getIcon(),
						text = injury.getName()
					};

					if (!isUnderIronWill)
					{
						injuryRow.children <- children;
					}
					else
					{
						injuryRow.text += "[color=" + this.Const.UI.Color.PositiveValue + "]" + " (Iron Will)[/color]";
					}

					tooltip.push(injuryRow);
					  // [309]  OP_CLOSE          0     20    0    0
				}

				statusEffects = removeDuplicates(statusEffects);
				pushSection(statusEffects, "Status perks", 150, 1);
			}
			else
			{
				foreach( _, row in tooltip )
				{
					if (("type" in row) && row.type == "text" && "text" in row)
					{
						shownPerks[row.text] <- 1;
					}
				}
			}
		}

		local activePerks = this.getSkills().query(this.Const.SkillType.Active, false, true);
		activePerks = removeDuplicates(activePerks);
		pushSection(activePerks, "Usable perks", 200, 1);
		local thresholdToCompact = 7;
		local perks = this.getSkills().query(this.Const.SkillType.Perk, false, true);
		perks = removeDuplicates(perks);
		pushSectionName(perks, "Perks", 300);

		if (perks.len() < thresholdToCompact)
		{
			foreach( i, perk in perks )
			{
				tooltip.push({
					id = 301 + i,
					type = "text",
					icon = getRealPerkIcon(perk),
					text = perk.getName()
				});
			}
		}
		else
		{
			local texts = "";

			foreach( _, perk in perks )
			{
				local name = perk.getName();

				if (name && name.len() > 1)
				{
					texts = texts + ("[color=" + this.Const.UI.Color.NegativeValue + "]" + name.slice(0, 1) + "[/color]" + name.slice(1) + ", ");
				}
			}

			if (texts.len() > 2)
			{
				texts = texts.slice(0, -2);
			}

			tooltip.push({
				id = 301,
				type = "text",
				icon = "ui/perks/selection_frame.png",
				text = texts
			});
		}

		local accessories = this.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Accessory);
		pushSection(accessories, "Accessory", 400, 0, "ui/items/");
		local ammos = this.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Ammo);
		pushSection(ammos, "Ammo", 500, 0, "ui/items/");
		local items = this.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag);
		local itemsTitle = "Item" + getPlural(items) + " in bags";
		pushSection(items, itemsTitle, 600, 0, "ui/items/", true);
		local itemsOnGround = this.getTile().Items;
		pushSection(itemsOnGround, "Item" + getPlural(itemsOnGround) + " on ground", 700, 0, "ui/items/", true);
		return tooltip;
	};

	::mods_hookExactClass("entity/tactical/actor", function (o)
	{
		local getTooltip = o.getTooltip;
		o.getTooltip = function ( _targetedWithSkill = null )
		{
			return modTacticalTooltip(getTooltip(_targetedWithSkill), _targetedWithSkill);
		};
	});
	delete this.Const.LegendMod.loadTacticalTooltip;
}