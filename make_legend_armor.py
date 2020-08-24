
from string import Template
from shutil import copyfile
import os
layers = [
{"name": "legend_armor_ancient_double_mail",              "layer": "chain", "min": 1, "max": 1, "value" : 750, "con" : 80, "stam" : -14, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Ancient Double Layer Mail", \
    "desc" :  "Includes A heavy and rotten double-layered mail of ancient design.", \
    "adesc" :""
},
{"name": "legend_armor_ancient_mail",                     "layer": "chain", "min": 1, "max": 1, "value" : 300, "con" : 35, "stam" : -6, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Ancient Mail", \
    "desc" :  "Includes an old and crusted heavy mail of ancient design.", \
    "adesc" :""
},
{"name": "legend_armor_basic_mail",                       "layer": "chain", "min": 1, "max": 1, "value" : 800, "con" : 85, "stam" : -12, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Basic Mail", \
    "desc" :  "A long and heavy chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_hauberk",                          "layer": "chain", "min": 1, "max": 1, "value" : 1750, "con" : 95, "stam" : -11, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Hauberk", \
    "desc" :  "A long and heavy chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_hauberk_full",                     "layer": "chain", "min": 1, "max": 1, "value" : 2500, "con" : 115, "stam" : -14, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Full Hauberk", \
    "desc" :  "A long and heavy chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_hauberk_full_named",               "layer": "chain", "min": 1, "max": 1, "value" : 5000, "con" : 120, "stam" : -15, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "Truly fit for a knight, this mail hauberk is made from the highest quality materials and boasts precious decorations and ornaments.", \
    "adesc" : "Includes a mail hauberk made from the highest quality materials and boasts precious decorations and ornaments.", \
    "named" : True, "rminStam" : 9, "rmaxStam": 13, "rminCond" : 125, "rmaxCond" : 150,  "names" : ['Heraldic Mail', "Splendor", "Grandiosity", "Pageantry", "Swank", "Full Mail", "Mail Hauberk", "Chainmail", "Surcoat", "Duty", "Honor", "Noble Mail"]
},
{"name": "legend_armor_hauberk_sleevless",                "layer": "chain", "min": 1, "max": 1, "value" : 1250, "con" : 65, "stam" : -7, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Sleeveless Hauberk", \
    "desc" :  "A long and heavy chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_mail_shirt",                       "layer": "chain", "min": 1, "max": 1, "value" : 350, "con" : 50, "stam" : -6, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Basic Mail Shirt", \
    "desc" :  "A basic mail shirt. Offers decent and affordable protection against slashing and piercing attacks.", \
    "adesc" : "Includes a basic mail shirt that offers good protection against slashing and piercing attacks."
},
{"name": "legend_armor_mail_shirt_simple",                "layer": "chain", "min": 1, "max": 1, "value" : 250, "con" : 25, "stam" : -3, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Simple Mail Shirt", \
    "desc" :  "A simple mail shirt. Offers decent and affordable protection against slashing and piercing attacks.", \
    "adesc" : "Includes a simple mail shirt that offers good protection against slashing and piercing attacks."
},
{"name": "legend_armor_reinforced_mail",                  "layer": "chain", "min": 1, "max": 1, "value" : 1750, "con" : 110, "stam" : -15, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Reinforced Mail", \
    "desc" :  "A long and heavy reinforced chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy reinforced chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_reinforced_mail_shirt",            "layer": "chain", "min": 1, "max": 1, "value" : 1000, "con" : 80, "stam" : -10, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Reinforced Mail Shirt", \
    "desc" :  "A reinforced mail shirt with shoulder guards providing excellent protection against most weapons.", \
    "adesc" : "Includes a reinforced mail shirt in excellent condition."
},
{"name": "legend_armor_reinforced_rotten_mail_shirt",     "layer": "chain", "min": 1, "max": 1, "value" : 200, "con" : 45, "stam" : -7, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Rotten Reinforced Mail Shirt", \
    "desc" :  "A reinforced mail shirt that is rotting at the seams.", \
    "adesc" : "Includes a reinforced mail shirt that has seen better days."
},
{"name": "legend_armor_reinforced_worn_mail",             "layer": "chain", "min": 1, "max": 1, "value" : 1250, "con" : 105, "stam" : -17, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Reinforced Worn Mail", \
    "desc" :  "A long and heavy reinforced chainmail that offers good protection but is very fatiguing to wear.", \
    "adesc" : "Includes a long and heavy reinforced chainmail that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_reinforced_worn_mail_shirt",       "layer": "chain", "min": 1, "max": 1, "value" : 350, "con" : 65, "stam" : -11, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Worn Reinforced Mail Shirt", \
    "desc" :  "A reinforced mail shirt that lost some parts over the years.", \
    "adesc" : "Includes a reinforced mail shirt that has seen better days."
},
{"name": "legend_armor_rusty_mail_shirt",                 "layer": "chain", "min": 1, "max": 11, "value" : 125, "con" : 20, "stam" : -4, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Patched Mail Shirt", \
    "desc" :  "This light mail shirt has seen better times but still grants decent protection.", \
    "adesc" : "Includes a rusty and patched mail shirt that offers decent protection."
},
{"name": "legend_armor_short_mail",                       "layer": "chain", "min": 1, "max": 1, "value" : 500, "con" : 60, "stam" : -8, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Light Mail", \
    "desc" :  "A shorter and lighter chainmail that offers good protection and is fatiguing to wear.", \
    "adesc" : "Includes a shorter and lighter chainmail that offers good protection but is fatiguing to wear."
},
# {"name": "legend_armor_cloak",                            "layer": "cloak", "min": 1, "max": 1, "value" : 350, "con" : 3, "stam" : -1, "impactSound" : "leather", "invSound" : "leather", \
#     "title" :  "Cloak", \
#     "desc" :  "The Cloak. Everyone needs a good cloak. Offers minimal protection and small boost to moral.", \
#     "adesc" : "Has a flowing cloth cloak"
# },
# {"name": "legend_armor_cloak_common",                     "layer": "cloak", "min": 8, "max": 34, "value" : 100, "con" : 10, "stam" : -2, "impactSound" : "leather", "invSound" : "leather", \
#     "title" :  "Simple Cloak", \
#     "desc" :  "A rustic cloak made of strong warm wool, provides some small protection, from the weather if nothing else ", \
#     "adesc" : "Has a stout wool cloak"
# },
# {"name": "legend_armor_cloak_crusader",                   "layer": "cloak", "min": 36, "max": 36, "value" : 1000, "con" : 35, "stam" : -5, "impactSound" : "leather", "invSound" : "leather", \
#     "title" :  "Crusader Cloak", \
#     "desc" :  "A holy cloak made of thick layered strong warm wool, provides protection from some blows but is quite hefty. ", \
#     "adesc" : "Has a holy thick cloak"
# },
# {"name": "legend_armor_cloak_heavy",                      "layer": "cloak", "min": 3, "max": 35, "value" : 1000, "con" : 30, "stam" : -4, "impactSound" : "leather", "invSound" : "leather", \
#     "title" :  "Heavy Cloak", \
#     "desc" :  "A rustic cloak made of thick layered strong warm wool, provides protection from some blows but is quite hefty. ", \
#     "adesc" : "Has a heavy thick cloak"
# },
# {"name": "legend_armor_cloak_noble",                      "layer": "cloak", "min": 1, "max": 25, "value" : 3000, "con" : 25, "stam" : -2, "impactSound" : "leather", "invSound" : "leather", \
#     "title" :  "Noble Cloak", \
#     "desc" :  "A fine cloak made of light foreign silk, provides protection and looks great. ", \
#     "adesc" : "Has a flowing light cloak"
# },
# {"name": "legend_armor_cloak_rich",                       "layer": "cloak", "min": 1, "max": 5, "value" : 10000, "con" : 35, "stam" : -2, "impactSound" : "leather", "invSound" : "leather", \
#     "title" :  "", \
#     "desc" :  "A silk embroidered cloak made with the finest clothes. Those who wear it feel as if a king", \
#     "adesc" : "Has a flowing embroidered cloak", \
#     "named" : True, "rminStam" : 0, "rmaxStam": 0, "rminCond" : 30, "rmaxCond" : 40,  "names" : ["Kingly", "Splendor", "Pageantry", "Swank", "Noble", "Undead"]
# },
# {"name": "legend_armor_hexe_leader_cloak_upgrade",        "layer": "cloak", "min": 1, "max": 1, "value" : 12000, "con" : 20, "stam" : 0, "impactSound" : "leather", "invSound" : "leather", \
#     "title" :  "Hexen Redback Silk Cloak", \
#     "desc" :  "This flowing cloak is made from spider web, and offers excellent protection against ranged attacks.", \
#     "adesc" : "A cloak of spider silk offers extra protection"
# },
# {"name": "legend_armor_redback_cloak_upgrade",            "layer": "cloak", "min": 1, "max": 1, "value" : 7500, "con" : 35, "stam" : -3, "impactSound" : "leather", "invSound" : "leather", \
#     "title" :  "Redback Silk Cloak", \
#     "desc" :  "This flowing cloack is made from spider web, and offers excellent protection against ranged attacks.", \
#     "adesc" : "A cloak of spider silk offers extra protection"
# },
# {"name": "legend_armor_sash",                             "layer": "cloak", "min": 1, "max": 1, "value" : 150, "con" : 3, "stam" : -1, "impactSound" : "leather", "invSound" : "leather", \
#     "title" :  "Sash", \
#     "desc" :  "Sash.", \
#     "adesc" : "Has a flowing cloth sash"
# },
{"name": "legend_ancient_cloth",                          "layer": "cloth", "min": 1, "max": 1, "value" : 20, "con" : 30, "stam" : -5, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Ancient Cloth", \
    "desc" :  "An ancient cloth wrap, heavy and offering little protection", \
    "adesc" :""
},
{"name": "legend_ancient_cloth_restored",                 "layer": "cloth", "min": 1, "max": 5, "value" : 40, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Ancient Cloth", \
    "desc" :  "A cloth wrap, heavy and offering small protection", \
    "adesc" :""
},
{"name": "legend_apron_butcher",                          "layer": "cloth", "min": 7, "max": 10, "value" : 50, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Butcher\'s Apron", \
    "desc" :  "A rugged apron worn by butchers to protect against accidental cuts.", \
    "adesc" :""
},
{"name": "legend_apron",                            "layer": "cloth", "min": 1, "max": 6, "value" : 60, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Blacksmith Apron", \
    "desc" :  "A leather apron usually worn by a blacksmith", \
    "adesc" :""
},
{"name": "legend_dark_tunic",                             "layer": "cloth", "min": 1, "max": 2, "value" : 50, "con" : 35, "stam" : -4, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Dark Tunic", \
    "desc" :  "A heavy cloth tunic. bulky but offering some protection.", \
    "adesc" :""
},
{"name": "legend_gambeson",                               "layer": "cloth", "min": 0, "max": 64, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Gambeson", \
    "desc" :  "A sturdy and heavy padded tunic that offers decent protection.", \
    "adesc" :""
},
{"name": "legend_gambeson_common_color",                  "layer": "cloth", "min": 0, "max": 39, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "cloth", "inherit" : "legend_gambeson", \
    "title" :  "Gambeson", \
    "desc" :  "A sturdy and heavy padded tunic that offers decent protection.", \
    "adesc" :""
},
{"name": "legend_gambeson_named",                         "layer": "cloth", "min": 1, "max": 1, "value" : 1500, "con" : 70, "stam" : -7, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "", \
    "desc" :  "A master crafted heavy padded tunic that offers excellent protection.", \
    "adesc" :"", \
    "named" : True, "rminStam" : 4, "rmaxStam": 6, "rminCond" : 75, "rmaxCond" : 90,  "names" : ["Heraldic Gambeson", "Splendor", "Grandiosity", "Pageantry", "Swank", "Noble Surcoat", "Duty", "Honor"]
},
{"name": "legend_gambeson_plain",                         "layer": "cloth", "min": 0, "max": 39, "value" : 250, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "leather", "inherit" : "legend_gambeson",\
    "title" :  "Gambeson", \
    "desc" :  "A sturdy and heavy padded tunic that offers decent protection.", \
    "adesc" :""
},
{"name": "legend_gambeson_rare_color",                    "layer": "cloth", "min": 4, "max": 12, "value" : 400, "con" : 65, "stam" : -7, "impactSound" : "leather", "invSound" : "cloth", "inherit" : "legend_gambeson",\
    "title" :  "Gambeson", \
    "desc" :  "A sturdy and heavy padded tunic that offers decent protection.", \
    "adesc" :""
},
{"name": "legend_gambeson_wolf",                          "layer": "cloth", "min": 1, "max": 1, "value" : 300, "con" : 70, "stam" : -9, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Wolf Gambeson", \
    "desc" :  "A sturdy and heavy padded tunic that offers decent protection.", \
    "adesc" :""
},
{"name": "legend_padded_surcoat",                         "layer": "cloth", "min": 40, "max": 64, "value" : 150, "con" : 55, "stam" : -6, "impactSound" : "leather", "invSound" : "cloth", "inherit" : "legend_gambeson", \
    "title" :  "Padded Surcoat", \
    "desc" :  "A sturdy and heavy padded coat that offers decent protection.", \
    "adesc" :""
},
{"name": "legend_peasant_dress",                          "layer": "cloth", "min": 1, "max": 11, "value" : 25, "con" : 25, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Peasant\'s Dress", \
    "desc" :  "A simple dress of rough fabric and common dye", \
    "adesc" :""
},
{"name": "legend_robes",                                  "layer": "cloth", "min": 9, "max": 18, "value" : 25, "con" : 25, "stam" : -2, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Monk\'s Robe", \
    "desc" :  "A rugged, large robe made of simple cloth usually worn by monks and similar individuals who don\'t care for fashion.", \
    "adesc" :""
},
{"name": "legend_robes_magic",                            "layer": "cloth", "min": 1, "max": 1, "value" : 100, "con" : 40, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Magician\'s Robe", \
    "desc" :  "A soft shiny robe worn by practictioners of the arcane arts", \
    "adesc" :""
},
{"name": "legend_robes_wizard",                            "layer": "cloth", "min": 1, "max": 12, "value" : 50, "con" : 30, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Wizard\'s Robe", \
    "desc" :  "A soft shiny robe worn by practictioners of the arcane arts", \
    "adesc" :""
},
{"name": "legend_robes_nun",                              "layer": "cloth", "min": 1, "max": 2, "value" : 25, "con" : 22, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth",\
    "title" :  "Nun\'s Robe", \
    "desc" :  "A rugged, large robe made of simple cloth usually worn by young nuns.", \
    "adesc" :""
},
{"name": "legend_sackcloth_tattered",                     "layer": "cloth", "min": 12, "max": 18, "value" : 5, "con" : 5, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Tattered Sackcloth", \
    "desc" :  "Barely better than running naked.", \
    "adesc" :""
},
{"name": "legend_sackcloth",                              "layer": "cloth", "min": 3, "max": 12, "value" : 15, "con" : 10, "stam" : 0, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Sackcloth", \
    "desc" :  "Better than running naked.", \
    "adesc" :""
},
{"name": "legend_sackcloth_patched",                      "layer": "cloth", "min": 1, "max": 8, "value" : 25, "con" : 15, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Leather Wraps", \
    "desc" :  "Various patches of rough leather sewn together.", \
    "adesc" :""
},
{"name": "legend_thick_tunic",                            "layer": "cloth", "min": 1, "max": 24, "value" : 40, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Thick Tunic", \
    "desc" :  "A heavy cloth tunic, bulky but offering some protection.", \
    "adesc" :""
},
{"name": "legend_tunic",                                  "layer": "cloth", "min": 1, "max": 34, "value" : 25, "con" : 20, "stam" : -1, "impactSound" : "leather", "invSound" : "cloth", \
    "title" :  "Linen Tunic", \
    "desc" :  "A simple cloth tunic. Fashionable but offering little in protection.", \
    "adesc" :""
},
{"name": "legend_tunic_noble",                            "layer": "cloth", "min": 2, "max": 28, "value" : 500, "con" : 40, "stam" : -2, "impactSound" : "leather", "invSound" : "leather", "inherit" : "legend_tunic", \
    "title" :  "Noble Tunic", \
    "desc" :  "A fine linen tunic of exquisite material, embroided with pleasing patterns. Fashionable but offering little in protection.", \
    "adesc" :""
},
{"name": "legend_armor_leather_brigandine",               "layer": "plate", "min": 1, "max": 1, "value" : 750, "con" : 65, "stam" : -8, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Leather Brigandine Armor", \
    "desc" :  "A thick leather brigandine studded with steel rivets for added protection.", \
    "adesc" : "Includes leather brigandine armor."
},
{"name": "legend_armor_leather_brigandine_hardened",      "layer": "plate", "min": 1, "max": 1, "value" : 1250, "con" : 110, "stam" : -15, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Hardened Leather Brigandine Armor", \
    "desc" :  "A boiled and hardened leather brigandine studded with steel rivets for added protection.", \
    "adesc" : "Includes leather brigandine armor."
},
{"name": "legend_armor_leather_brigandine_hardened_full", "layer": "plate", "min": 1, "max": 1, "value" : 3000, "con" : 140, "stam" : -19, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Reinforced Hardened Leather Brigandine Armor", \
    "desc" :  "A boiled and hardened brigandine studded with steel rivets and reinforced with steel padded shoulders for added protection.", \
    "adesc" : "Includes hardened brigandine armor."
},
{"name": "legend_armor_leather_brigandine_named",         "layer": "plate", "min": 1, "max": 5, "value" : 2500, "con" : 75, "stam" : -6, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "A rare thick leather brigandine studded with steel rivets for added protection. A piece of true craftsmanship!", \
    "adesc" : "Includes rare leather brigandine armor.", \
    "named" : True, "rminStam" : 5, "rmaxStam": 7, "rminCond" : 80, "rmaxCond" : 100,  "names" : ["Harness", "Ward", "Defense", "Barrier", "Studded Vest", "Lifesaver", "Skin", "Peel", "Guard", "Tarnished Harness", "Duty", "Honor"]
},
{"name": "legend_armor_leather_jacket",                   "layer": "plate", "min": 1, "max": 9, "value" : 75, "con" : 25, "stam" : -3, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Leather Jacket", \
    "desc" :  "A leather jacket for minimal protection.", \
    "adesc" : "Includes a leather jacket for added protection."
},
{"name": "legend_armor_leather_jacket_named",             "layer": "plate", "min": 1, "max": 1, "value" : 750, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "A well-crafted and hardened leather armor. Light to wear but very sturdy.", \
    "adesc" : "Includes a well-crafted and hardened leather armor. Light to wear but very sturdy.", \
    "named" : True, "rminStam" : 1, "rmaxStam": 2, "rminCond" : 35, "rmaxCond" : 45,  "names" : ["Leather Cuirass", "Leather Armor", "Skin", "Peel", "Guard", "Coat", "Nightcloak", "Black", "Dark Omen", "Toadskin", "Ogreskin"]
},
{"name": "legend_armor_leather_jacket_named_02",             "layer": "plate", "min": 1, "max": 17, "value" : 750, "con" : 30, "stam" : -3, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "A well-crafted leather coated jacket. Light to wear but very sturdy.", \
    "adesc" : "Includes a well-crafted leather jacket. Light to wear but very sturdy.", \
    "named" : True, "rminStam" : 1, "rmaxStam": 2, "rminCond" : 35, "rmaxCond" : 45,  "names" : ["Leather Cuirass", "Leather Armor", "Skin", "Peel", "Guard", "Coat", "Nightcloak", "Black", "Dark Omen", "Toadskin", "Ogreskin"]
},

{"name": "legend_armor_leather_jacket_simple",            "layer": "plate", "min": 1, "max": 6, "value" : 30, "con" : 15, "stam" : -2, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Simple Leather Jacket", \
    "desc" :  "A simple leather jacket for minimal protection.", \
    "adesc" : "Includes a simple leather jacket for added protection."
},
{"name": "legend_armor_leather_lamellar",                 "layer": "plate", "min": 1, "max": 1, "value" : 250, "con" : 50, "stam" : -6, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Leather Lamellar Armor", \
    "desc" :  "Numerous overlapping leather plates provide decent protection for most of the upper body.", \
    "adesc" : "Includes armor of overlapping leather plates."
},
{"name": "legend_armor_leather_lamellar_harness_heavy",   "layer": "plate", "min": 1, "max": 1, "value" : 1750, "con" : 130, "stam" : -20, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Lamellar Harness", \
    "desc" :  "A body armor made of thick overlapping metal plates that cover most of the upper body.", \
    "adesc" : "Includes body armor made of thick overlapping metal plates that cover most of the upper body."
},
{"name": "legend_armor_leather_lamellar_harness_reinforced", "layer": "plate", "min": 1, "max": 1, "value" : 2500, "con" : 150, "stam" : -23, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Reinforced Lamellar Harness", \
    "desc" :  "A body armor made of thick overlapping metal plates that cover most of the upper body.", \
    "adesc" : "Includes body armor made of thick overlapping metal plates that cover most of the upper body."
},
{"name": "legend_armor_leather_lamellar_heavy",           "layer": "plate", "min": 1, "max": 1, "value" : 4750, "con" : 165, "stam" : -24, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Heavy Lamellar Armor", \
    "desc" :  "A heavy lamellar armor that covers most parts of the body with thick, overlapping metal plates for maximum protection.", \
    "adesc" : "Includes heavy lamellar armor that covers most parts of the body with thick, overlapping metal plates."
},
{"name": "legend_armor_leather_lamellar_heavy_named",     "layer": "plate", "min": 1, "max": 1, "value" : 7500, "con" : 140, "stam" : -23, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "An extraordinarily well-crafted piece of lamellar armor. It is covered with beaten gold, which makes it truly stand out.", \
    "adesc" : "Includes an extraordinarily well-crafted piece of lamellar armor. It is covered with beaten gold, which makes it truly stand out.", \
    "named" : True, "rminStam" : 19, "rmaxStam": 23, "rminCond" : 175, "rmaxCond" : 195,  "names" : ["Harness", "Ward", "Defense", "Splendor", "Golden Lamellar"]
},
{"name": "legend_armor_leather_lamellar_reinforced",      "layer": "plate", "min": 1, "max": 1, "value" : 350, "con" : 55, "stam" : -7, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Reinforced Leather Lamellar Armor", \
    "desc" :  "Numerous overlapping metal reinforced leather plates that provides excellent protection for most of the upper body but is very heavy.", \
    "adesc" : "Includes armor of overlapping reinforced metal leather plates."
},
{"name": "legend_armor_leather_noble",                    "layer": "plate", "min": 1, "max": 6, "value" : 1500, "con" : 65, "stam" : -6, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Noble Leather Armor", \
    "desc" :  "A truly masterfully crafted set of leather armor. Very light and flexible to reduce encumberance while still offering good protection.", \
    "adesc" : "Includes masterfully crafted leather armor."
},
{"name": "legend_armor_leather_padded",                   "layer": "plate", "min": 1, "max": 1, "value" : 175, "con" : 40, "stam" : -5, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Padded Leather Armor", \
    "desc" :  "Padded leather reinforced with fittings for added protection.", \
    "adesc" : "Includes padded leather armor."
},
{"name": "legend_armor_leather_riveted",                  "layer": "plate", "min": 1, "max": 9, "value" : 900, "con" : 95, "stam" : -13, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Sellsword\'s Leather Armor", \
    "desc" :  "A long leather armor coat reinforced with metal plates.", \
    "adesc" : "Includes a long leather coat reinforced with metal plates that offers good protection but is very fatiguing to wear."
},
{"name": "legend_armor_leather_riveted_light",            "layer": "plate", "min": 1, "max": 1, "value" : 700, "con" : 80, "stam" : -11, "impactSound" : "chain", "invSound" : "leather", \
    "title" :  "Footman\'s Leather Armor", \
    "desc" :  "A light leather armor reinforced with metal rivets.", \
    "adesc" : "Includes a leather armor coat rivetted with with metal plates."
},
{"name": "legend_armor_leather_scale",                    "layer": "plate", "min": 1, "max": 1, "value" : 600, "con" : 70, "stam" : -9, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Leather Scale Armor", \
    "desc" :  "A thick leather scale armor for added protection.", \
    "adesc" : "Includes scaled leather armor."
},
{"name": "legend_armor_plate_ancient_chest",              "layer": "plate", "min": 1, "max": 1, "value" : 750, "con" : 105, "stam" : -18, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Breastplate", \
    "desc" :  "A tarnished thick breastplate of ancient origin.", \
    "adesc" : "Includes a tarnished thick breastplate of ancient origin."
},
{"name": "legend_armor_plate_ancient_chest_restored",     "layer": "plate", "min": 1, "max": 1, "value" : 1500, "con" : 110, "stam" : -15, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Restored Ancient Breastplate", \
    "desc" :  "A restored thick breastplate of ancient origin.", \
    "adesc" : "Includes a restoredd thick breastplate of ancient origin."
},
{"name": "legend_armor_plate_ancient_gladiator",          "layer": "plate", "min": 1, "max": 1, "value" : 100, "con" : 35, "stam" : -6, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Restored Ancient Breastplate", \
    "desc" :  "A tarnished gladiator outfit of ancient origin.", \
    "adesc" : "Includes a tarnished gladiator outfit of ancient origin."
},
{"name": "legend_armor_plate_ancient_harness",            "layer": "plate", "min": 1, "max": 1, "value" : 1500, "con" : 115, "stam" : -19, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Plate Harness", \
    "desc" :  "Made of thick metal plates and mail, this heavy ancient armor still offers great protection after countless years. It\'s crusted and rotten in parts, however, severely limiting the mobility of the wearer.", \
    "adesc" : "Includes an ancient plate harness of thick metal plates and mail."
},
{"name": "legend_armor_plate_ancient_mail",               "layer": "plate", "min": 1, "max": 1, "value" : 300, "con" : 45, "stam" : -7, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Plated Mail", \
    "desc" :  "An ancient mail armor with plated arm guards. Very heavy and severely limiting the mobility of the wearer.", \
    "adesc" : "Includes an ancient mail armor with plated arm guards."
},
{"name": "legend_armor_plate_ancient_scale",              "layer": "plate", "min": 1, "max": 1, "value" : 1000, "con" : 105, "stam" : -17, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Plated Scale", \
    "desc" :  "A heavy coat of scales, partly reinforced with a layer of plated metal on top. It\'s a massive armor of ancient origin that didn\'t age well.", \
    "adesc" : "Includes an ancient heavy coat of scales."
},
{"name": "legend_armor_plate_ancient_scale_coat",         "layer": "plate", "min": 1, "max": 1, "value" : 2000, "con" : 140, "stam" : -24, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Scale Coat", \
    "desc" :  "A heavy and tarnished scale coat of ancient design that belongs into a collection, not on the battlefield.", \
    "adesc" : "Includes an ancient heavy and tarnished scale coat."
},
{"name": "legend_armor_plate_ancient_scale_harness",      "layer": "plate", "min": 1, "max": 1, "value" : 500, "con" : 75, "stam" : -12, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Ancient Scale Harness", \
    "desc" :  "A sturdy, but heavy and partly decayed ancient scale harness.", \
    "adesc" : "Includes an heavy and partly decayed ancient scale harness."
},
{"name": "legend_armor_plate_chest",                      "layer": "plate", "min": 1, "max": 1, "value" : 2250, "con" : 125, "stam" : -17, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Breastplate Armor", \
    "desc" :  "A breastplate of solid plated steel.", \
    "adesc" : "Includes a breastplate of solid plated steel."
},
{"name": "legend_armor_plate_chest_rotten",               "layer": "plate", "min": 1, "max": 1, "value" : 1250, "con" : 100, "stam" : -16, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Decayed Breastplate Armor", \
    "desc" :  "A breastplate of solid plated steel that is worn and decayed.", \
    "adesc" : "Includes a breastplate of decaying plated steel."
},
{"name": "legend_armor_plate_cuirass",                    "layer": "plate", "min": 1, "max": 1, "value" : 3500, "con" : 150, "stam" : -21, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Plate Cuirass Armor", \
    "desc" :  "A body vest of solid plated steel.", \
    "adesc" : "Includes a body vest of solid plated steel."
},
{"name": "legend_armor_plate_full",                       "layer": "plate", "min": 1, "max": 1, "value" : 4500, "con" : 160, "stam" : -22, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Coat of Plate Armor", \
    "desc" :  "A full set of solid plated steel.", \
    "adesc" : "Includes a full set of solid plated steel."
},
{"name": "legend_armor_plate_full_greaves",               "layer": "plate", "min": 1, "max": 1, "value" : 5000, "con" : 170, "stam" : -26, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Coat of Heavy Plate Armor", \
    "desc" :  "A full set of solid plated steel with greaves.", \
    "adesc" : "Includes a full set of solid plated steel with greaves."
},
{"name": "legend_armor_plate_full_greaves_named",         "layer": "plate", "min": 1, "max": 3, "value" : 10000, "con" : 170, "stam" : -26, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Coat Heavy Plate Armor", \
    "desc" :  "A full set of painted solid plated steel with greaves.", \
    "adesc" : "A masterfully crafted full set of painted solid plated steel with greaves.", \
    "named" : True, "rminStam" : 23, "rmaxStam": 25, "rminCond" : 185, "rmaxCond" : 225,  "names" : ["Glory", "Triumph", "Victory", "Joy"]
},
{"name": "legend_armor_plate_full_greaves_painted",       "layer": "plate", "min": 1, "max": 1, "value" : 10000, "con" : 170, "stam" : -26, "impactSound" : "leather", "invSound" : "leather", \
    "title" :  "Full Coat of Painted Heavy Plate Armor", \
    "desc" :  "A full set of painted solid plated steel with greaves.", \
    "adesc" : "A masterfully crafted full set of painted solid plated steel with greaves.", \
    "named" : True, "rminStam" : 23, "rmaxStam": 25, "rminCond" : 185, "rmaxCond" : 225,  "names" : ["Ward", "Death", "Barrier", "Plate Armor", "Dark Plated Armor", "Life Stealer"]
},
{"name": "legend_armor_scale",                            "layer": "plate", "min": 1, "max": 1, "value" : 2250, "con" : 100, "stam" : -12, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Scale Armor", \
    "desc" :  "A body vest with overlapping scales.", \
    "adesc" : "Includes body vest with overlapping scales."
},
{"name": "legend_armor_scale_coat",                       "layer": "plate", "min": 1, "max": 1, "value" : 2500, "con" : 120, "stam" : -15, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Coat of Scales", \
    "desc" :  "A heavy armor made of thick, overlapping metal scales covering most of the body.", \
    "adesc" : "Includes heavy armor made of thick, overlapping metal scales."
},
{"name": "legend_armor_scale_coat_named",                 "layer": "plate", "min": 1, "max": 1, "value" : 5000, "con" : 160, "stam" : -22, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "", \
    "desc" :  "A scale armor made of small, interlocking metal scales. The style and craftsmanship hint at the armor coming from a far-away region.", \
    "adesc" : "Includes a scale armor made of small, interlocking metal scales. The style and craftsmanship hint at the armor coming from a far-away region.", \
    "named" : True, "rminStam" : 10, "rmaxStam": 14, "rminCond" : 130, "rmaxCond" : 160,  "names" : ["Scale Shirt", "Scale Armor", "Dragonskin", "Snakeskin", "Scales", "Wyrmskin", "Goldskin", "Scale Tunic", "Golden Armor", "Golden Reminder"]
},
{"name": "legend_armor_scale_coat_rotten",                "layer": "plate", "min": 1, "max": 1, "value" : 600, "con" : 60, "stam" : -9, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Decayed Coat of Scales", \
    "desc" :  "This coat of scales is worn and parts have come lose or are missing. It still offers very good protection if you don\'t mind the smell.", \
    "adesc" : "Includes worn and smelly heavy armor made of thick, overlapping metal scales."
},
{"name": "legend_armor_scale_shirt",                      "layer": "plate", "min": 1, "max": 1, "value" : 1750, "con" : 85, "stam" : -10, "impactSound" : "plate", "invSound" : "leather", \
    "title" :  "Light Scale Armor", \
    "desc" :  "A sturdy yet flexible armor composed of small, overlapping metal scales.", \
    "adesc" : "Includes body vest with small overlapping metal scales."
},
{"name": "legend_animal_hide_armor",                      "layer": "plate", "min": 90, "max": 90, "value" : 100, "con" : 30, "stam" : -4, "impactSound" : "leather", "invSound" : "leather", "vanilla" : True,\
    "title" :  "Animal Hide Armor", \
    "desc" :  "Heavy hides patched together to create a decent makeshift armor.", \
    "adesc" : "Includes heavy hides patched together to create a decent makeshift armor."
},
{"name": "legend_heavy_iron_armor",                       "layer": "plate", "min": 95, "max": 95, "value" : 1000, "con" : 120, "stam" : -18, "impactSound" : "plate", "invSound" : "leather",  "vanilla" : True, \
    "title" :  "Heavy Iron Armor", \
    "desc" :  "This armor is made from heavy metal plates, scales and pieces of chainmal. The true armor of a northern warrior.", \
    "adesc" : "Includes is made from heavy metal plates, scales and pieces of chainmal. The true armor of a northern warrior."
},
{"name": "legend_hide_and_bone_armor",                    "layer": "plate", "min": 92, "max": 92, "value" : 350, "con" : 80, "stam" : -11, "impactSound" : "bone", "invSound" : "leather", "vanilla" : True,\
    "title" :  "Hide and Bone Armor", \
    "desc" :  "Hide and bone are common materials in the northern regions. This armor is using both for decent protection.", \
    "adesc" : "Includes hide and bone armor that is decent protection."
},
{"name": "legend_reinforced_animal_hide_armor",           "layer": "plate", "min": 97, "max": 97, "value" : 175, "con" : 55, "stam" : -9, "impactSound" : "leather", "invSound" : "leather", "vanilla" : True,\
    "title" :  "Reinforced Animal Hide Armor", \
    "desc" :  "A reinforced animal hide armor fashioned from thick leather pieces with added mail and metal scales.", \
    "adesc" : "Includes A reinforced animal hide armor fashioned from thick leather pieces with added mail and metal scales."
},
{"name": "legend_rugged_scale_armor",                     "layer": "plate", "min": 93, "max": 93, "value" : 700, "con" : 95, "stam" : -15, "impactSound" : "plate", "invSound" : "leather", "vanilla" : True,\
    "title" :  "Rugged Scale Armor", \
    "desc" :  "A heavy body armor made from thick iron scales.", \
    "adesc" : "Includes A heavy body armor made from thick iron scales."
},
{"name": "legend_scrap_metal_armor",                      "layer": "plate", "min": 94, "max": 94, "value" : 250, "con" : 65, "stam" : -10, "impactSound" : "chain", "invSound" : "leather", "vanilla" : True,\
    "title" :  "Scrap Metal Armor", \
    "desc" :  "This armor is pieced together from scavenged metal parts that are fixed to a crude leather tunic.", \
    "adesc" : "Includes armor that is pieced together from scavenged metal parts that are fixed to a crude leather tunic."
},
{"name": "legend_thick_furs_armor",                       "layer": "plate", "min": 91, "max": 91, "value" : 15, "con" : 10, "stam" : -1, "impactSound" : "leather", "invSound" : "leather", "vanilla" : True,\
    "title" :  "Thick Furs", \
    "desc" :  "Thick furs that are crudely dried and tied together to protect from both the cold and any incoming blows.", \
    "adesc" : "Includes Thick furs that are crudely dried and tied together to protect from both the cold and any incoming blows."
},
{"name": "legend_thick_plated_barbarian_armor",           "layer": "plate", "min": 96, "max": 96, "value" : 1500, "con" : 155, "stam" : -26, "impactSound" : "plate", "invSound" : "leather", "vanilla" : True,\
    "title" :  "Thick Plated Barbarian Armor", \
    "desc" :  "A heavy armor that is made from mostly metal. Only one chosen by the ancestors will own a set like this.", \
    "adesc" : "Includes A heavy armor that is made from mostly metal. Only one chosen by the ancestors will own a set like this."
}
]


BaseNut = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "$brush" + "_" + variant;
		this.m.SpriteDamaged = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "$brush" + "_" + variant + "_dead";
		this.m.IconLarge ="legend_helmets/$overlayLarge" + "_" + variant + ".png"
		this.m.Icon = "legend_helmets/$overlay" + "_" + variant + ".png"
	}
});
'''

BaseNutInherit = '''
this.$name <- this.inherit("scripts/items/legend_armor/cloth/$inherit", {
	m = {},
	function create()
	{
		this.$inherit.create();
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
	}
});
'''

UpgradeNut = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.$type;
		this.m.ID = "$id";
		this.m.Name = "$title";
		this.m.Description = "$desc";
		this.m.ArmorDescription = "$adesc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "$brush" + "_" + variant;
		this.m.SpriteDamagedBack = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "$brush" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/$icon" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/$overlay" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/$overlayLarge" + "_" + variant + ".png";
	}
});
'''

NamedUpgradeNut = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.$type;
		this.m.ID = "$id";
		this.m.Name = "$title";
        this.m.NameList = $names;
		this.m.Description = "$desc";
		this.m.ArmorDescription = "$adesc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "$brush" + "_" + variant;
		this.m.SpriteDamagedBack = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "$brush" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/$icon" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/$overlay" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/$overlayLarge" + "_" + variant + ".png";
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.rand($rminStam, $rmaxStam) * -1;
		this.m.Condition = this.Math.rand($rminCond, $rmaxCond);
		this.m.ConditionMax = this.m.Condition;
	}
});
'''

BaseNamedNut = '''
this.$name <- this.inherit("scripts/items/legend_armor/legend_cloth_named", {
	m = {},
	function create()
	{
		this.legend_cloth_named.create();
		this.m.ID = "$id";
		this.m.Name = "$title";
        this.m.NameList = $names;
		this.m.Description = "$desc";
		this.m.Variants = $variants;
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = $impactSound;
		this.m.InventorySound = $invSound;
		this.m.Value = $value;
		this.m.Condition = $condition;
		this.m.ConditionMax = $condition;
		this.m.StaminaModifier = $stamina;
        this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "$brush" + "_" + variant;
		this.m.SpriteDamaged = "$brush" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "$brush" + "_" + variant + "_dead";
		this.m.IconLarge ="legend_helmets/$overlayLarge" + "_" + variant + ".png"
		this.m.Icon = "legend_helmets/$overlay" + "_" + variant + ".png"
	}

	function randomizeValues()
	{
		this.m.StaminaModifier = this.Math.rand($rminStam, $rmaxStam) * -1;
		this.m.Condition = this.Math.rand($rminCond, $rmaxCond);
		this.m.ConditionMax = this.m.Condition;
	}
});
'''

Layer = '<sprite id="$name" offsetY="35" ic="FF242D3A" width="104" height="142" img="$name_path" left="-44" right="50" top="-53" bottom="13" />\n'
LayerDamaged = '<sprite id="$damaged" offsetY="35" ic="FF242C39" width="104" height="142" img="$damaged_path" left="-47" right="45" top="-64" bottom="14" />\n'
LayerDead = '<sprite id="$dead" offsetX="6" offsetY="10" f="64FE" ic="FF222933" width="131" height="125" img="$dead_path" left="-57" right="59" top="-53" bottom="55" />\n'
LayerArrow = '<sprite id="$arrow" offsetX="6" offsetY="10" f="64FB" ic="FF495055" width="131" height="114" img="$arrow_path" left="0" right="28" top="-8" bottom="30" />\n'
LayerJavelin = '<sprite id="$javelin" offsetX="6" offsetY="10" f="64FB" ic="FF151C29" width="131" height="134" img="$javelin_path" left="-11" right="35" top="-5" bottom="67" />\n'



def main():
    #Build Nuts
    for d in layers:

        inherit = ""
        if "inherit"in d:
            inherit = d["inherit"]
        layer = d["layer"]

        temp = UpgradeNut
        if layer == "cloth":
            temp = BaseNut
            if "named" in d:
                temp = BaseNamedNut
            elif inherit != "":
                temp = BaseNutInherit
        elif "named" in d:
            temp = NamedUpgradeNut

        fname = d["name"]
        dirpath = os.path.join(os.path.dirname(os.path.abspath(__file__)),  "legend_armor", layer)
        if not os.path.exists(dirpath):
            os.makedirs(dirpath)

        filepath = os.path.join(dirpath, fname + ".nut")
        F = open(filepath, "w")
        variants = []
        for x in range(d["min"], d["max"] + 1):
            variants.append(x)


        impactsound = "this.Const.Sound.ArmorLeatherImpact"
        invsound = "this.Const.Sound.ArmorLeatherImpact"
        if d["invSound"] == 'cloth':
            invsound = "this.Const.Sound.ClothEquip"
        elif d["invSound"] == 'chain':
            invsound = "this.Const.Sound.ArmorChainmailImpact"

        if d["impactSound"] == 'chain':
            impactsound = "this.Const.Sound.ArmorChainmailImpact"
        elif d["impactSound"] == 'plate':
            impactsound = "this.Const.Sound.ArmorHalfplateImpact"
        elif d["impactSound"] == 'bone':
            impactsound = "this.Const.Sound.ArmorBoneImpact"


        brush = "bust_" + d["name"].replace("legend_armor", "legend")
        if "vanilla" in d:
            brush = "bust_body"

        namesL = []
        if "names" in d:
            namesL = "["
            for n in d["names"]:
                namesL += '"' + n + '", '
            namesL += "]"
        opts = dict(
            test="true",
            inherit=inherit,
            name=fname,
            title=d["title"],
            desc=d["desc"],
            adesc=d["adesc"],
            condition = d["con"],
            value = d["value"],
            stamina = d["stam"],
            id="legend_armor.body." + fname,
            variants = variants,
            layer = layer,
            type= d["layer"].capitalize(),
            brush = brush,
            overlayLarge = layer + "/inventory_" + d["name"],
            overlay = layer + "/icon_" + d["name"],
            icon = layer + "/" + d["name"],
            impactSound = impactsound,
            invSound = invsound,
            names = namesL,
            rminStam = d["rminStam"] if "rminStam" in d else 0,
            rmaxStam = d["rmaxStam"] if "rmaxStam" in d else 0,
            rminCond = d["rminCond"] if "rminCond" in d else 0,
            rmaxCond = d["rmaxCond"] if "rmaxCond" in d else 0,
        )
        s = Template(temp)
        text = s.substitute(opts)
        F.write(text)
        F.close()

        #print('[0, " + layer + '/' + fname + "],')


    #Build Brushes
    mfile = os.path.join(os.path.dirname(os.path.abspath(__file__)), "unpacked/legend_armor/metadata.xml")
    F = open(mfile, "w")
    F.write('<brush name="gfx/legend_armor.png" version="17">\n')
    L = [Layer, LayerDamaged, LayerDead]
    LBase = [Layer, LayerDamaged, LayerDead, LayerArrow, LayerJavelin]
    for d in layers:
        R = L

        if "inherit" in d:
            continue

        if "vanilla" in d:
            continue

        if d["layer"] == "cloth":
            R = LBase

        names = [d["name"]]
        if "min" in d:
            names = []
            for i in range(d["min"], d["max"] + 1):
                ind = "0" + str(i) if i < 10 else str(i)
                names.append(d["name"] + "_" + ind)

        for t in R:
            for name in names:
                name = "bust_" + name.replace("legend_armor", "legend")
                opts = dict(
                    name=name,
                    damaged=name + "_damaged",
                    dead=name + "_dead",
                    arrow=name + "_dead_arrows",
                    javelin=name + "_dead_javelin",
                    name_path=os.path.join("entity", "legend_armor", d["layer"], name + ".png"),
                    damaged_path=os.path.join("entity", "legend_armor", d["layer"], name + "_damaged.png"),
                    dead_path=os.path.join("entity", "legend_armor", d["layer"],  name + "_dead.png"),
                    arrow_path=os.path.join("..",  "dead_arrows.png"),
                    javelin_path=os.path.join("..", "dead_javelin.png")
                )
                s = Template(t)
                text = s.substitute(opts)
                text.replace("/", "\\")
                F.write(text)

                # if d["layer"] == "cloth":
                #     srcF = os.path.join(os.path.dirname(os.path.abspath(__file__)), "unpacked", "dead_arrows.png")
                #     destF = os.path.join(os.path.dirname(os.path.abspath(__file__)), "unpacked", "legend_armor", opts["arrow_path"])
                #     if not os.path.exists(destF):
                #         copyfile(srcF, destF)
                #     srcF = os.path.join(os.path.dirname(os.path.abspath(__file__)), "unpacked", "dead_javelin.png")
                #     destF = os.path.join(os.path.dirname(os.path.abspath(__file__)), "unpacked", "legend_armor", opts["javelin_path"])
                #     if not os.path.exists(destF):
                #         copyfile(srcF, destF)

    F.write('</brush>\n')
    F.close()


main()
