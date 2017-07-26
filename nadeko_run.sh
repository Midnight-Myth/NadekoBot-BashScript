#!/bin/sh
echo ""
echo "MidnightBot 1.5+"
root=$(pwd)
youtube-dl -U

if hash dotnet 2>/dev/null
then
	echo "Dotnet installed."
else
	echo "Dotnet is not installed. Please install dotnet."
	exit 1
fi
cd "$root/MidnightBot"
dotnet restore
dotnet build --configuration Release
cd "$root/MidnightBot/src/MidnightBot"
echo "Running MidnightBot. Please wait."
dotnet run --configuration Release
echo "Done"

cd "$root"
rm "$root/nadeko_run.sh"
exit 0
