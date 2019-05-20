#!/bin/bash

# ePSXe emulator is property of ePSXe team, http://epsxe.com/, under Proprietary license.
# ePSXe64Ubuntu.sh and formerly e64u.sh scripts are property of Brandon Lee Camilleri ( blc / brandleesee / Yrvyne , https://twitter.com/brandleesee , https://www.reddit.com/user/Yrvyne/ , https://www.facebook.com/brandleesee )
# ePSXe64Ubuntu.sh and formerly e64u.sh scripts are protected under the vestiges of the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License.
# Disclaimer: Brandon Lee Camilleri ( blc / brandleesee / Yrvyne ) does not assume any responsibilities and shall not be held liable should ePSXe64Ubuntu.sh, e64u.sh, shaders.zip, ePSXe.svg, CHANGELOG.md, README.md and/or LICENSE.md fail in their intended purpose, attempt and usage and/or break the system/s being used on.
# Brandon Lee Camilleri ( blc / brandleesee / Yrvyne ) can be reached on brandon.camilleri.90@gmail.com
# ePSXe64Ubuntu repository can be found at https://github.com/brandleesee/ePSXe64Ubuntu

bkp="/home/$USER/ePSXe_backups/$(date "+%F-%T-%Z")"
ops=("Download" "Restore from backup")
PS3="Choose from 1 to 3 above. "

tput setaf 2; echo "Welcome to ePSXe64Ubuntu.sh script, version 12."; tput sgr0
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
	if [ -d "/opt/ePSXe/.epsxe" ]; then
	  mkdir -p "$bkp"
	  mv "/opt/ePSXe/.epsxe" "$bkp"
	fi

# Removes duplicate of ePSXe executable
	if [ -e "/opt/ePSXe/ePSXe" ]; then
	  sudo rm -rf "/opt/ePSXe/ePSXe"
	fi

# Downloads Icon
	wget "https://raw.githubusercontent.com/brandleesee/ePSXe64Ubuntu/master/ePSXe.svg" -P "/tmp"
	sudo mv "/tmp/ePSXe.svg" "/usr/share/icons/hicolor/scalable/ePSXe.svg"

# Creates shorcut for Dash/Dock/Panel
	if [ -e "/usr/share/applications/ePSXe.desktop" ]; then
	  sudo rm -rf "/usr/share/applications/ePSXe.desktop"
	fi
	echo "[Desktop Entry]" > "/tmp/ePSXe.desktop"
	{
	  echo "Type=Application"
	  echo "Terminal=false"
	  echo "Exec=/ops/ePSXe/ePSXe"
	  echo "Name=ePSXe"
	  echo "Comment=Created using ePSXe64Ubuntu from https://github.com/brandleesee"
	  echo "Icon=/usr/share/icons/hicolor/scalable/ePSXe.svg"
	  echo "Categories=Game;Emulator;"
	} >> "/tmp/ePSXe.desktop"
	sudo mv "/tmp/ePSXe.desktop" "/usr/share/applications/ePSXe.desktop"
	sudo update-desktop-database
	
# Sets up ePSXe
	sudo mkdir -p "/opt/ePSXe/"
	wget "http://www.epsxe.com/files/ePSXe205linux_x64.zip" -P "/tmp"
	unzip "/tmp/ePSXe205linux_x64.zip" -d "/tmp"
	if apt-cache show libcurl4 2>/dev/null|grep '^Package: libcurl4$'
	then
	  xxd /tmp/epsxe_x64 /tmp/epsxe_x64.xxd
	  patch /tmp/epsxe_x64.xxd <(echo "6434c
00019210: 2e73 6f2e 3300 6375 726c 5f65 6173 795f  .so.3.curl_easy_
.")
	  xxd -r /tmp/epsxe_x64.xxd "/opt/ePSXe/ePSXe"
	  rm -f /tmp/epsxe_x64.xxd
	  if ! sha256sum -c <(echo "45fb1ee4cb21a5591de64e1a666e4c3cacb30fcc308f0324dc5b2b57767e18ee  "/opt/ePSXe/ePSXe")
	  then
	    tput setaf 1; echo "WARNING: patched /opt/ePSXe/ePSXe did not match checksum, using original executable instead"; tput sgr0
	    sudo cp -f "/tmp/epsxe_x64" "/opt/ePSXe/epsxe_x64"
	  fi
	  rm -f "/tmp/epsxe_x64"
	else
	  sudo mv "/tmp/epsxe_x64" "/opt/ePSXe/epsxe_x64"
	fi
	sudo chmod +x "/opt/ePSXe/epsxe_x64"

##############################################
## Creates symlink
#	cd "/usr/local/bin"
#	sudo ln -sf "/opt/ePSXe/epsxe_x64"
#	sudo mv epsxe_x64 "/opt/ePSXe/ePSXe"
#	cd ~
##############################################

# Runs ePSXe to create directories
	"/opt/ePSXe/ePSXe"

# Transfers docs folder to .epsxe
	mv "/tmp/docs" "/opt/ePSXe/.epsxe"

# Activates BIOS HLE 
	sed -i '11s/.*/BiosPath = /' "/opt/ePSXe/.epsxe/epsxerc"
	sed -i '14s/.*/BiosHLE = 1/' "/opt/ePSXe/.epsxe/epsxerc"

# Restores Back-Up 
	if [ -d "$bkp/.epsxe" ]; then
	  cp -r "$bkp/.epsxe/bios/." "/opt/ePSXe/.epsxe/bios"
	  cp -r "$bkp/.epsxe/cheats/." "/opt/ePSXe/.epsxe/cheats"
	  cp -r "$bkp/.epsxe/config/." "/opt/ePSXe/.epsxe/config"
	  cp -r "$bkp/.epsxe/configs/." "/opt/ePSXe/.epsxe/configs"
	  cp -r "$bkp/.epsxe/covers/." "/opt/ePSXe/.epsxe/covers"
	  cp -r "$bkp/.epsxe/docs/." "/opt/ePSXe/.epsxe/docs"
	  cp -r "$bkp/.epsxe/idx/." "/opt/ePSXe/.epsxe/idx"
	  cp -r "$bkp/.epsxe/info/." "/opt/ePSXe/.epsxe/info"
	  cp -r "$bkp/.epsxe/memcards/." "/opt/ePSXe/.epsxe/memcards"
	  cp -r "$bkp/.epsxe/patches/." "/opt/ePSXe/.epsxe/patches"
	  cp -r "$bkp/.epsxe/plugins/." "/opt/ePSXe/.epsxe/plugins"
	  cp -r "$bkp/.epsxe/sstates/." "/opt/ePSXe/.epsxe/sstates"  
	fi

# Function for Shaders
tput setaf 2; echo "Shaders Menu"; tput sgr0
	select ops in "${ops[@]}" "Do nothing"; do 
	  case "$REPLY" in
	    1 ) 
	      wget "https://raw.githubusercontent.com/brandleesee/ePSXe64Ubuntu/master/shaders.zip" -P "/tmp"
	      unzip "/tmp/shaders.zip" -d "/opt/ePSXe/.epsxe/shaders"
	      echo "This choice has downloaded shaders from ePSXe64Ubuntu repository.";
	      break
	    ;;
	    2 ) 
	      cp -r "$bkp/.epsxe/shaders/." "/opt/ePSXe/.epsxe/shaders"
	      break
	    ;;
	    $(( ${#ops[@]}+1 )) ) echo "This choice has left the shaders folder empty."; break;;
	    *) echo "Invalid option. Choose from 1 to 3.";continue;;
	  esac
	done

# Removes clutter
	rm -rf "/tmp/ePSXe205linux_x64.zip"
	rm -rf "/tmp/shaders.zip"
	
tput setaf 2; echo "Script finished."; tput sgr0
