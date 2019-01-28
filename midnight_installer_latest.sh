#!/bin/sh
echo ""
echo "MidnightBot Installer started."

if hash git 1>/dev/null 2>&1
then
    echo ""
    echo "Git Installed."
else
    echo ""    
    echo "Git is not installed. Please install Git."
    exit 1
fi


if hash dotnet 1>/dev/null 2>&1
then
    echo ""
    echo "Dotnet installed."
else
    echo ""
    echo "Dotnet is not installed. Please install dotnet."
    exit 1
fi

root=$(pwd)
tempdir=MidnightInstall_Temp

rm -rf "$tempdir" 1>/dev/null 2>&1
mkdir "$tempdir"
cd "$tempdir"

echo ""
echo "Downloading MidnightBot, please wait."
git clone -b testing --recursive --depth 1 https://github.com/Midnight-Myth/Mitternacht-NEW.git MidnightBot
echo ""
echo "MidnightBot downloaded."

echo ""
echo "Downloading Midnight dependencies"
cd "$root/$tempdir/MidnightBot"
dotnet restore
echo ""
echo "Download done"

echo ""
echo "Building MidnightBot"
dotnet build --configuration Release
echo ""
echo "Building done. Moving Midnight"

cd "$root"

if [ ! -d MidnightBot ]
then
    mv "$tempdir"/MidnightBot MidnightBot
else
    rm -rf MidnightBot_old 1>/dev/null 2>&1
    mv -fT MidnightBot MidnightBot_old 1>/dev/null 2>&1
    mv "$tempdir"/MidnightBot MidnightBot
    cp -f "$root/MidnightBot_old/src/NadekoBot/credentials.json" "$root/MidnightBot/src/NadekoBot/credentials.json" 1>/dev/null 2>&1
    echo ""
    echo "credentials.json copied to the new version"
    cp -RT "$root/MidnightBot_old/src/NadekoBot/bin/" "$root/MidnightBot/src/MidnightBot/bin/" 1>/dev/null 2>&1
    cp -RT "$root/MidnightBot/src/NadekoBot/bin/Release/netcoreapp1.0/data/MidnightBot.db" "$root/MidnightBot/src/NadekoBot/bin/Release/netcoreapp2.0/data/MidnightBot.db" 1>/dev/null 2>&1
	cp -RT "$root/MidnightBot/src/NadekoBot/bin/Release/netcoreapp1.1/data/MidnightBot.db" "$root/MidnightBot/src/NadekoBot/bin/Release/netcoreapp2.0/data/MidnightBot.db" 1>/dev/null 2>&1
    mv -f "$root/MidnightBot/src/NadekoBot/bin/Release/netcoreapp1.0/data/MidnightBot.db" "$root/MidnightBot/src/NadekoBot/bin/Release/netcoreapp1.0/data/MidnightBot_old.db" 1>/dev/null 2>&1
	mv -f "$root/MidnightBot/src/NadekoBot/bin/Release/netcoreapp1.1/data/MidnightBot.db" "$root/MidnightBot/src/NadekoBot/bin/Release/netcoreapp1.1/data/MidnightBot_old.db" 1>/dev/null 2>&1
    echo ""
    echo "Database copied to the new version"
    cp -RT "$root/MidnightBot_old/src/NadekoBot/data/" "$root/MidnightBot/src/NadekoBot/data/" 1>/dev/null 2>&1
    echo ""
    echo "Other data copied to the new version"
fi

rm -rf "$tempdir"
echo ""
echo "Installation Complete."

cd "$root"
rm "$root/midnight_installer_latest.sh"
exit 0
