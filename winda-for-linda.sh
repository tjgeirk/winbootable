#!/bin/bash
#
 usbdirectory="/dev/disk5"
 windowsversion="WIN11"
 isodirectory="~/Downloads/*win*.iso"; clear
#
if [ brew ]; then
    brew install wimlib
else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)
    PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
    echo "PATH=$PATH" >> ~/.bashrc
    echo "PATH=$PATH" >> ~/.shrc
    echo "PATH=$PATH" >> ~/.zshrc
    brew install wimlib
fi; clear
diskutil eraseDisk MS-DOS "$windowsversion" GPT $usbdirectory; clear
if [ -f $isodirectory ]; then
    hdiutil mount $isodirectory
else
    echo "error: no ISO found at $isodirectory"
    exit
fi; clear
rsync -vha --exclude=sources/install.wim /Volumes/CCCOMA_X64FRE_EN-US_DV9/* /Volumes/$windowsversion; clear
mkdir /Volumes/$windowsversion/sources; clear
wimlib-imagex split /Volumes/CCCOMA_X64FRE_EN-US_DV9/sources/install.wim /Volumes/$windowsversion/sources/install.swm 3800; clear
echo "Done"