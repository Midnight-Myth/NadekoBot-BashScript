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
tempdir=TestInstall_Temp

rm -r "$tempdir" 1>/dev/null 2>&1
mkdir "$tempdir"
cd "$tempdir"

echo ""
echo "Downloading MidnightBot, please wait."
git clone -b testing --recursive --depth 1 https://github.com/Midnight-Myth/Mitternacht-NEW.git TestBot
echo ""
echo "MidnightBot downloaded."

echo ""
echo "Downloading MidnightBot dependencies"
cd "$root/$tempdir/TestBot"
dotnet restore
echo ""
echo "Download done"

echo ""
echo "Building MidnightBot"
dotnet build --configuration Release
echo ""
echo "Building done. Moving MidnightBot"

cd "$root"

if [ ! -d TestBot ]
then
    mv "$tempdir"/TestBot TestBot
else
    rm -rf TestBot_old 1>/dev/null 2>&1
    mv -fT TestBot TestBot_old 1>/dev/null 2>&1
    mv "$tempdir"/TestBot TestBot
    cp -f "$root/TestBot_old/src/NadekoBot/credentials.json" "$root/TestBot/src/NadekoBot/credentials.json" 1>/dev/null 2>&1
    echo ""
    echo "credentials.json copied to the new version"
    cp -RT "$root/TestBot_old/src/NadekoBot/bin/" "$root/TestBot/src/NadekoBot/bin/" 1>/dev/null 2>&1
    cp -RT "$root/TestBot/src/NadekoBot/bin/Release/netcoreapp1.0/data/NadekoBot.db" "$root/TestBot/src/NadekoBot/bin/Release/netcoreapp1.1/data/NadekoBot.db" 1>/dev/null 2>&1
    mv -f "$root/TestBot/src/NadekoBot/bin/Release/netcoreapp1.0/data/NadekoBot.db" "$root/TestBot/src/NadekoBot/bin/Release/netcoreapp1.0/data/NadekoBot_old.db" 1>/dev/null 2>&1
    echo ""
    echo "Database copied to the new version"
    cp -RT "$root/TestBot_old/src/NadekoBot/data/" "$root/TestBot/src/NadekoBot/data/" 1>/dev/null 2>&1
    echo ""
    echo "Other data copied to the new version"
fi

rm -r "$tempdir"
echo ""
echo "Installation Complete."

cd "$root"
rm "$root/nadeko_installer_latest_test.sh"
exit 0
