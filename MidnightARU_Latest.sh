#!/bin/sh
echo ""
echo "Running MidnightBot with auto restart and updating to latest build!"
root=$(pwd)
youtube-dl -U

sleep 5s
while :; do cd "$root/MidnightBot" && git pull && dotnet restore && dotnet build --configuration Release && cd "$root/MidnightBot/src/NadekoBot" && dotnet run -c Release && cd "$root" && wget -N https://github.com/Midnight-Myth/NadekoBot-BashScript/raw/test2/midnight_installer_latest.sh && bash "$root/midnight_installer_latest.sh"; sleep 5s; done
echo ""
echo "That didn't work? Please report in #NadekoLog Discord Server."
sleep 3s

cd "$root"
bash "$root/linuxAIO.sh"
echo "Done"

rm "$root/MidnightARU_Latest.sh"
exit 0
