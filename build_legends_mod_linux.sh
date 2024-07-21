#!/bin/bash

BBDir="${1:-../build}"
RepoDir="${2:-../Legends}"

function checkForCompileError() {
    code=0
    while read -r line; do
        if [[ $line == *" error"* ]]; then
            #echo "$line"
            code=1
        fi
    done <<< "$1"
    if [ $code == 1 ]; then
        return 1
    else
        return 0
    fi
}

function handleExit() {
    exitCode=$?
    if [ $exitCode -ne 0 ]; then
        echo "Failed to build Legends!"
        exit 1
    fi
}

# Ensure base directories exist
mkdir -p "$BBDir/sounds"
mkdir -p "$BBDir/gfx"
mkdir -p "$BBDir/scripts"

echo "Copying sounds to $BBDir/sounds ..."
cp -R sounds/. "$BBDir/sounds"
handleExit
echo "Copying gfx to $BBDir/gfx ..."
cp -R gfx/. "$BBDir/gfx"
handleExit
echo "Copying mod script files to $BBDir/scripts ..."
FILES=$(git diff --name-only $(git merge-base origin/master HEAD) | grep '.nut\|.txt\|.css\|.js\|.html')

while read -r line; do
    case "$line" in
        *.sh|*.md|*.py|documentation/*.txt|unpacked*|gfx/*.png|gfx/*.jpg|sounds/*.wav|*.cnut|.gitignore|.editorconfig|scripts/mapgen/templates/world/worldmap_generator.nut|scripts/contracts/contract.nut|scripts/entity/world/combat_manager.nut|scripts/states/tactical_state.nut|scripts/entity/tactical/actor.nut|scripts/entity/tactical/tactical_entity_manager.nut|scripts/ai/tactical/behaviors/ai_attack_bow.nut|scripts/ai/tactical/behaviors/ai_attack_crush_armor.nut|scripts/ai/tactical/behaviors/ai_attack_decapitate.nut|scripts/ai/tactical/behaviors/ai_attack_default.nut|scripts/ai/tactical/behaviors/ai_attack_knock_out.nut|scripts/ai/tactical/behaviors/ai_attack_lash.nut|scripts/ai/tactical/behaviors/ai_attack_swallow_whole.nut|scripts/ai/tactical/behaviors/ai_hook.nut|scripts/ai/tactical/behaviors/ai_boost_stamina.nut|scripts/ai/tactical/behaviors/ai_charm.nut|scripts/ai/tactical/behaviors/ai_defend_rotation.nut|scripts/ai/tactical/behaviors/ai_attack_terror.nut|scripts/contracts/contracts/barbarian_king_contract|scripts/factions/faction_action.nut|scripts/skills/racial/alp_racial.nut|scripts/events/events/dlc4/cultist_origin_vs_old_gods_event.nut|scripts/config/world_entity_common.nut|scripts/!mods_preload/!config/tnf_debugMode_lib.nut|scripts/!mods_preload/tnf_debugMode.nut|scripts/crafting/blueprints/paint_black_blueprint.nut|scripts/crafting/blueprints/paint_orange_red_blueprint.nut|scripts/crafting/blueprints/paint_red_blueprint.nut|scripts/crafting/blueprints/paint_remover_blueprint.nut|scripts/crafting/blueprints/paint_set_blueprint.nut|scripts/crafting/blueprints/paint_white_blue_blueprint.nut|scripts/crafting/blueprints/paint_white_green_yellow_blueprint.nut)
            # Skip these files
            ;;
        *)
            path=$(echo "${line%/*}")
            mkdir -p "$BBDir/$path"
            handleExit
            cp "$line" "$BBDir/$line"
            handleExit
            ;;
    esac
done <<< "$FILES"

echo "Compiling all nut files ..."
cd "$RepoDir"
o=$(../bin/masscompile.sh "$BBDir/scripts")
cd -

checkForCompileError "$o"
resp="$?"
echo $resp
if [ $resp -ne 0 ]; then
    echo "Failed to build Legends!"
    exit 1
else
    echo "Success!"
    exit 0
fi

