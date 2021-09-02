BBDir="${1-"c:\\Steam\\steamapps\\common\\Battle Brothers\\data"}"
RepoDir="${2-"battlebrothers"}"

function checkForCompileError() {
code=0
while read -r line; do
    if [[ $line == *" error"* ]]; then
        #echo "$line"
        code=1
    fi
done <<< "$1"
if [ $code == 1 ]
then
    return 1
else
    return 0
fi
}

function handleExit() {
    # Get exit code of the previous command, instead of echo
    exitCode=$?
    if [ $exitCode -ne "0" ]
    then
        echo "Failed to build Legends!"
        exit 1
    fi
}

./build_brushes.sh "$BBDir" "$RepoDir"
handleExit

echo "Copying sounds to $BBDir\\sounds ..."
cp -R sounds/. "$BBDir\\sounds"
handleExit
echo "Copying gfx to $BBDir\\gfx ..."
cp -R gfx/. "$BBDir\\gfx"
handleExit
echo "Copying mod script files to $BBDir\\scripts ..."
FILES=$(git diff --name-only `git merge-base origin/master HEAD` | grep '.nut\|.txt\|.css\|.js\|.html')
while read -r line; do
    if [[ "$line" == *.sh ]]; then
        :
    elif [[ "$line" == *.md ]]; then
        :
    elif [[ "$line" == *.py ]]; then
        :
    elif [[ "$line" == unpacked* ]]; then
        :
    elif [[ "$line" == gfx/*.png ]]; then
        :
    elif [[ "$line" == gfx/*.jpg ]]; then
        :
    elif [[ "$line" == sounds/*.wav ]]; then
        :
    elif [[ "$line" == *.cnut ]]; then
        :
    elif [ "$line" == ".gitignore" ]; then
        :
    elif [ "$line" == ".editorconfig" ]; then
        :
    elif [ "$line" == "scripts/mapgen/templates/world/worldmap_generator.nut" ]; then
        :
    elif [ "$line" == "scripts/contracts/contract.nut" ]; then
        :
    elif [ "$line" == "scripts/entity/world/combat_manager.nut" ]; then
        :
    elif [ "$line" == "scripts/states/tactical_state.nut" ]; then
        :
    elif [ "$line" == "scripts/entity/tactical/actor.nut" ]; then
        :
    elif [ "$line" == "scripts/entity/tactical/tactical_entity_manager.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_bow.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_crush_armor.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_decapitate.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_default.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_knock_out.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_lash.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_swallow_whole.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_hook.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_boost_stamina.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_charm.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_defend_rotation.nut" ]; then
        :
    elif [ "$line" == "scripts/ai/tactical/behaviors/ai_attack_terror.nut" ]; then
        :
    elif [ "$line" == "scripts/contracts/contracts/barbarian_king_contract" ]; then
        :
    elif [ "$line" == "scripts/factions/faction_action.nut" ]; then
        :
    elif [ "$line" == "scripts/skills/racial/alp_racial.nut" ]; then
        :
    elif [ "$line" == "scripts/events/events/dlc4/cultist_origin_vs_old_gods_event.nut" ]; then
        :
    elif [ "$line" == "scripts/config/world_entity_common.nut" ]; then
        :
    elif [ "$line" == "scripts/!mods_preload/!config/tnf_debugMode_lib.nut" ]; then
        :
    elif [ "$line" == "scripts/!mods_preload/tnf_debugMode.nut" ]; then
        :
    else
        #echo "$line"
        path=$( echo ${line%/*} )
        mkdir -p "$BBDir\\$path"
        handleExit
        cp "$line" "$BBDir\\$line"
        handleExit
    fi
done <<< "$FILES"

echo "Compiling all nut files ..."
cd ../bin
o=$(./masscompile.bat "$BBDir\\scripts")
cd ../"$RepoDir"

checkForCompileError "$o"
resp="$?"
echo $resp
if [ $resp -ne "0" ]
then
    echo "Failed to build Legends!"
    exit 1
else
    echo "Success!"
    exit 0
fi

