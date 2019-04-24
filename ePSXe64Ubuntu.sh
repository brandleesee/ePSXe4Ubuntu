#!/bin/bash

# ePSXe emulator is property of ePSXe team, http://epsxe.com/, under Proprietary license.
# ePSXe64Ubuntu.sh and formerly e64u.sh scripts are property of Brandon Lee Camilleri ( blc / brandleesee / Yrvyne , https://twitter.com/brandleesee , https://www.reddit.com/user/Yrvyne/ )
# ePSXe64Ubuntu.sh and formerly e64u.sh scripts are protected under the vestiges of the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License.
# Disclaimer: Brandon Lee Camilleri ( blc / brandleesee / Yrvyne ) does not assume any responsibilities and shall not be held liable should ePSXe64Ubuntu.sh, e64u.sh, shaders.zip, .ePSXe.svg CHANGELOG.md and/or README.md fail in their intended purpose, attempt and usage and/or break the system/s being used on.
# Brandon Lee Camilleri ( blc / brandleesee / Yrvyne ) can be reached on brandon.camilleri.90@gmail.com
# ePSXe64Ubuntu repository can be found at https://github.com/brandleesee/ePSXe64Ubuntu

ver="12"
ins="ePSXe205linux_x64.zip"
hme="/home/$USER"
hid="/home/$USER/.epsxe"
bkp="/home/$USER/ePSXe_backups/$(date "+%F-%T-%Z")"
cor="/usr/share/applications"
exe="/home/$USER/ePSXe"
dls="https://raw.githubusercontent.com/brandleesee/ePSXe64Ubuntu/master"
opt=("Download" "Restore from backup")
PS3="Choose from 1 to 3 above. "

tput setaf 2; echo "Welcome to ePSXe64Ubuntu.sh script, $ver."; tput sgr0
tput setaf 1; echo "When ePSXe GUI appears on screen:"; tput sgr0
tput setaf 1; echo "  Right click on icon in Dash/Dock/Panel"; tput sgr0
tput setaf 1; echo "  Add to Favorites/Lock"; tput sgr0
tput setaf 1; echo "  CLOSE ePSXe GUI to continue with the script."; tput sgr0
tput setaf 2; echo "Script started."; tput sgr0

# Installs required packages per OS
if apt-cache show libcurl4 2>/dev/null|grep '^Package: libcurl4$'
then
	sudo apt-get -y install libncurses5 libsdl-ttf2.0-0 libssl1.0.0 ecm unzip
	wget http://archive.ubuntu.com/ubuntu/pool/main/c/curl3/libcurl3_7.58.0-2ubuntu2_amd64.deb -O /tmp/libcurl3_7.58.0-2ubuntu2_amd64.deb
	sudo mkdir /tmp/libcurl3
	sudo dpkg-deb -x /tmp/libcurl3_7.58.0-2ubuntu2_amd64.deb /tmp/libcurl3
	sudo cp -vn /tmp/libcurl3/usr/lib/x86_64-linux-gnu/libcurl.so.4.5.0 /usr/lib/x86_64-linux-gnu/libcurl.so.3
	sudo rm -rf /tmp/libcurl3
	rm -rf /tmp/libcurl3_7.58.0-2ubuntu2_amd64.deb
else
	sudo apt-get -y install libcurl3 libsdl-ttf2.0-0 libssl1.0.0 ecm unzip
fi

# Back-up function
	if [ -d "$hid" ]; then
	  mkdir -p "$bkp"
	  mv "$hid" "$bkp"
	fi

# Removes duplicate of ePSXe executable
	if [ -e "$exe" ]; then
	  sudo rm -rf "$exe"
	fi

# Downloads Icon
	wget "$dls/.ePSXe.svg" -P "$hme"

# Checks and creates icon data for Dash/Dock/Panel
	if [ -e "$cor/ePSXe.desktop" ]; then
	  sudo rm -rf "$cor/ePSXe.desktop"
	fi
	echo "[Desktop Entry]" > "/tmp/ePSXe.desktop"
	{
	  echo "Type=Application"
	  echo "Terminal=false"
	  echo "Exec=/home/$USER/ePSXe"
	  echo "Name=ePSXe"
	  echo "Comment=Created using ePSXe64Ubuntu from https://github.com/brandleesee"
	  echo "Icon=$hme/.ePSXe.svg"
	  echo "Categories=Game;Emulator;"
	} >> "/tmp/ePSXe.desktop"
	sudo mv "/tmp/ePSXe.desktop" "$cor/ePSXe.desktop"
	
# Sets up ePSXe
	wget "http://www.epsxe.com/files/$ins" -P "/tmp"
	unzip "/tmp/$ins" -d "/tmp"
	if apt-cache show libcurl4 2>/dev/null|grep '^Package: libcurl4$'
	then
	  xxd /tmp/epsxe_x64 /tmp/epsxe_x64.xxd
	  patch /tmp/epsxe_x64.xxd <(echo "6434c
00019210: 2e73 6f2e 3300 6375 726c 5f65 6173 795f  .so.3.curl_easy_
.")
	  xxd -r /tmp/epsxe_x64.xxd "/home/$USER/ePSXe"
	  rm -f /tmp/epsxe_x64.xxd
	  if ! sha256sum -c <(echo "45fb1ee4cb21a5591de64e1a666e4c3cacb30fcc308f0324dc5b2b57767e18ee  /home/$USER/ePSXe")
	  then
	    tput setaf 1; echo "WARNING: patched /home/$USER/ePSXe did not match checksum, using original executable instead"; tput sgr0
	    cp -f /tmp/epsxe_x64 "/home/$USER/ePSXe"
	  fi
	  rm -f /tmp/epsxe_x64
	else
	  mv "/tmp/epsxe_x64" "/home/$USER/ePSXe"
	fi
	chmod +x "/home/$USER/ePSXe"
	"/home/$USER/ePSXe"

# Transfers docs folder to .epsxe
	mv "/tmp/docs" "$hid"

# Activates BIOS HLE 
	sed -i '11s/.*/BiosPath = /' "$hid/epsxerc"
	sed -i '14s/.*/BiosHLE = 1/' "$hid/epsxerc"

# Restores Back-Up 
	if [ -d "$bkp/.epsxe" ]; then
	  cp -r "$bkp/.epsxe/bios/." "$hid/bios"
	  cp -r "$bkp/.epsxe/cheats/." "$hid/cheats"
	  cp -r "$bkp/.epsxe/config/." "$hid/config"
	  cp -r "$bkp/.epsxe/configs/." "$hid/configs"
	  cp -r "$bkp/.epsxe/covers/." "$hid/covers"
	  cp -r "$bkp/.epsxe/docs/." "$hid/docs"
	  cp -r "$bkp/.epsxe/idx/." "$hid/idx"
	  cp -r "$bkp/.epsxe/info/." "$hid/info"
	  cp -r "$bkp/.epsxe/memcards/." "$hid/memcards"
	  cp -r "$bkp/.epsxe/patches/." "$hid/patches"
	  cp -r "$bkp/.epsxe/plugins/." "$hid/plugins"
	  cp -r "$bkp/.epsxe/sstates/." "$hid/sstates"  
	fi

# Function for Shaders
tput setaf 2; echo "Shaders Menu"; tput sgr0
	select opt in "${opt[@]}" "Do nothing"; do 
	  case "$REPLY" in
	    1 ) 
	      wget "$dls/shaders.zip" -P "/tmp"
	      unzip "/tmp/shaders.zip" -d "$hid/shaders"
	      echo "This choice has downloaded shaders from ePSXe64Ubuntu repository.";
	      break
	    ;;
	    2 ) 
	      cp -r "$bkp/.epsxe/shaders/." "$hid/shaders"
	      break
	    ;;
	    $(( ${#opt[@]}+1 )) ) echo "This choice has left the shaders folder empty."; break;;
	    *) echo "Invalid option. Choose from 1 to 3.";continue;;
	  esac
	done

# Removes clutter
	rm -rf "/tmp/$ins"
	rm -rf "/tmp/shaders.zip"
	
tput setaf 2; echo "Script finished."; tput sgr0
