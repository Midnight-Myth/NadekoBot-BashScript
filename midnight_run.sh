#!/bin/sh
echo ""
echo "MidnightBot 2.0+"
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
rm "$root/midnight_run.sh"
exit 0
