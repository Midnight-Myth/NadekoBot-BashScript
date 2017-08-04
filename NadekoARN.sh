#!/bin/sh
echo ""
echo "Running MidnightBot with auto restart normally! (without updating)"
root=$(pwd)
youtube-dl -U

sleep 5s
cd "$root/TestBot"
dotnet restore && dotnet build --configuration Release

while :; do cd "$root/TestBot/src/NadekoBot" && dotnet run -c Release; sleep 5s; done
echo ""
echo "That didn't work? Please report in #NadekoLog Discord Server."
sleep 3s

cd "$root"
bash "$root/linuxTEST.sh"
echo "Done"

exit 0
