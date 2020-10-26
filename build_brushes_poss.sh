mkdir -p "brushes"
cd ../bin
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/entity_blood.brush ../Repo/unpacked/entity_blood
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legend_characters.brush ../Repo/unpacked/legend_characters
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legend_enemies.brush ../Repo/unpacked/legend_enemies
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legend_runed.brush ../Repo/unpacked/legend_runed
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legend_weapons.brush ../Repo/unpacked/legend_weapons
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legend_world.brush ../Repo/unpacked/legend_world
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legends_ui.brush ../Repo/unpacked/legends_ui
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legend_horses.brush ../Repo/unpacked/legend_horses
python ../Repo/unpacked/make_legend_helmets.py
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legend_helmets.brush ../Repo/unpacked/legend_helmets
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legend_helmets_0.brush ../Repo/unpacked/legend_helmets/0
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legend_helmets_1.brush ../Repo/unpacked/legend_helmets/1
python ../Repo/unpacked/make_legend_armor.py
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/legend_armor.brush ../Repo/unpacked/legend_armor
./bbrusher.exe pack --gfxPath "../Repo/" ../Repo/brushes/terrain.brush ../Repo/unpacked/terrain
cd ../Repo
