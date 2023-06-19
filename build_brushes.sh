BBDir="${1-"c:\\Steam\\steamapps\\common\\Battle Brothers\\data"}"
RepoDir="${2-"battlebrothers"}"


function handleExit() {
    # Get exit code of the previous command, instead of echo
    exitCode=$?
    if [ $exitCode -ne "0" ]
    then
        echo "Failed to build Legends!"
        exit 1
    fi
}

function checkForError() {
if [[ $1 == *"ERROR"* ]]; then
    while read -r line; do
        echo "$line"
    done <<< "$1"
    echo "Failed to build Legends brush $2"
    exit 1;
fi
}


echo "Building helmets..."
rm -rf helmet_scripts
handleExit
mkdir -p "helmet_scripts"
handleExit
python make_legend_helmets.py
handleExit
mkdir -p "$BBDir\\scripts\\items\\legend_helmets"
cp -R helmet_scripts/. "$BBDir\\scripts\\items\\legend_helmets"
handleExit

echo "Building armors..."
rm -rf legend_armor_scripts
handleExit
mkdir -p "legend_armor_scripts"
handleExit
python make_legend_armor.py
handleExit
mkdir -p "$BBDir\scripts\\items\\legend_armor"
cp -R legend_armor_scripts/. "$BBDir\\scripts\\items\\legend_armor"
handleExit

echo "Building enemies..."
python make_legend_enemies.py
handleExit

declare -a BRUSHES=(
"entity_blood"
"legend_characters"
"legend_enemies"
"legend_weapons"
"legend_world"
"legends_ui"
"legend_horses"
"terrain"
"legend_objects"
"legend_helmets"
"legend_helmets/0"
"legend_helmets/1"
"legend_helmets/2"
"legend_armor/0"
"legend_armor/1"
)

mkdir -p brushes

for i in "${BRUSHES[@]}"
do
    echo "Building $i brush..."
    cd ../bin
    brush=${i//[\/]/_}
    o=$(./bbrusher.exe pack --gfxPath "../$RepoDir/" ../$RepoDir/brushes/$brush.brush ../$RepoDir/unpacked/$i)
    cd ../"$RepoDir"
    checkForError "$o" "$i"
done

echo "Copying brushes to $BBDir\\brushes ..."
mkdir -p "$BBDir\\brushes"
cp -R brushes/. "$BBDir\\brushes"
handleExit
mkdir -p "$BBDir\\gfx"
cp -R gfx/*.png "$BBDir\\gfx"
handleExit