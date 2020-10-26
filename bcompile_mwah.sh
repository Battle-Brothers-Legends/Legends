FILES=$(git diff --name-only `git merge-base origin/master HEAD`)
while read -r line; do
    if [[ "$line" == *.sh ]]; then
        echo "skipping $line"
    elif [[ "$line" == *.py ]]; then
        echo "skipping $line"
    elif [[ "$line" == *.md ]]; then
        echo "skipping $line"
    elif [[ "$line" == unpacked* ]]; then
        echo "skipping $line"
    elif [[ "$line" == gfx/*.png ]]; then
        echo "skipping $line"
    elif [[ "$line" == gfx/*.jpg ]]; then
        echo "skipping $line"
    elif [[ "$line" == sounds/*.wav ]]; then
        echo "skipping $line"
    elif [[ "$line" == *.cnut ]]; then
        echo "skipping $line"
    elif [ "$line" == ".gitignore" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/mapgen/templates/world/worldmap_generator.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/contracts/contract.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/entity/world/combat_manager.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/states/tactical_state.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/entity/tactical/actor.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/entity/tactical/tactical_entity_manager.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_bow.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_crush_armor.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_decapitate.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_default.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_knock_out.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_lash.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_swallow_whole.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_hook.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_boost_stamina.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_charm.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_defend_rotation.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/contracts/contracts/barbarian_king_contract" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/factions/faction_action.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/skills/racial/alp_racial.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/events/events/dlc4/cultist_origin_vs_old_gods_event.nut" ]; then
        echo "skipping $line"
    elif [ "$line" == "scripts/config/world_entity_common.nut" ]; then
        echo "skipping $line"
    else
        echo "$line"
        path=$( echo ${line%/*} )
        mkdir -p "c:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data\\$path"
        cp "$line" "c:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data\\$line"
    fi
done <<< "$FILES"

echo "Building helmets..."
rm -rf helmets
mkdir -p "helmets"
python make_legend_helmets.py
cp -R helmets/. "c:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data\scripts\items\legend_helmets"

echo "Building armors..."
rm -rf legend_armor
mkdir -p "legend_armor"
python make_legend_armor.py
cp -R legend_armor/. "c:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data\scripts\items\legend_armor"


mkdir -p "brushes"
cd ../bin
 echo "Building brushes..."
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/entity_blood.brush ../battlebrothers/unpacked/entity_blood
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_characters.brush ../battlebrothers/unpacked/legend_characters
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_enemies.brush ../battlebrothers/unpacked/legend_enemies
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_runed.brush ../battlebrothers/unpacked/legend_runed
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_weapons.brush ../battlebrothers/unpacked/legend_weapons
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_world.brush ../battlebrothers/unpacked/legend_world
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legends_ui.brush ../battlebrothers/unpacked/legends_ui
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_horses.brush ../battlebrothers/unpacked/legend_horses
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/terrain.brush ../battlebrothers/unpacked/terrain
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_objects.brush ../battlebrothers/unpacked/legend_objects

 echo "Building Legend Helmets brush..."
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_helmets.brush ../battlebrothers/unpacked/legend_helmets
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_helmets.brush ../battlebrothers/unpacked/legend_helmets/0
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_helmets.brush ../battlebrothers/unpacked/legend_helmets/1

 echo "Building Legend Armor brush..."
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_armor_0.brush ../battlebrothers/unpacked/legend_armor/0
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_armor_1.brush ../battlebrothers/unpacked/legend_armor/1
./bbrusher.exe pack --gfxPath "../battlebrothers/" ../battlebrothers/brushes/legend_armor_2.brush ../battlebrothers/unpacked/legend_armor/2


 echo "Compiling all nut files..."
./masscompile.bat "c:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data\scripts"

cd ../battlebrothers

echo "cp sounds"
cp -R sounds/. "c:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data\sounds"

echo "cp gfx"
cp -R gfx/. "c:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data\gfx"

echo "cp brushes"
cp -R brushes/. "c:\Program Files (x86)\Steam\steamapps\common\Battle Brothers\data\brushes"

read -p "Enter"