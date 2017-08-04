#!/bin/sh
echo ""
echo "Running MidnightBot with auto restart and updating to latest build!"
root=$(pwd)
youtube-dl -U

sleep 5s
while :; do cd "$root/TestBot" && dotnet restore && dotnet build --configuration Release && cd "$root/TestBot/src/NadekoBot" && dotnet run -c Release && cd "$root" && wget -N https://github.com/Midnight-Myth/NadekoBot-BashScript/raw/test/nadeko_installer_latest_test.sh && bash "$root/nadeko_installer_latest_test.sh"; sleep 5s; done
echo ""
echo "That didn't work? Please report in #NadekoLog Discord Server."
sleep 3s

cd "$root"
bash "$root/linuxTEST.sh"
echo "Done"

rm "$root/NadekoARU_Latest.sh"
exit 0
