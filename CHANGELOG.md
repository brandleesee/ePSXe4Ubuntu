<h1 align="center">ePSXe64Ubuntu</h1>

<p align="center"><a href="https://chrismartinphotography.files.wordpress.com/2013/01/2012-landscapes-c2a9-christopher-martin-93441.jpg">Background</a> | <a href="http://xenlism.github.io/minimalism/">Minimalism GTK3 Theme</a> | <a href="https://github.com/xenlism/Storm">Storm Icon Set</a> | <a href="https://b00merang.weebly.com/windows-10.html">Windows 10 GTK Pack</a></p>

<h2 align="center">changelog</h2>
  
<table>
<tbody>
  <tr>
   <td><img src="https://i.imgur.com/2DlxMw4.png" /></td>
  </tr>
</tbody>
</table>

<h3 align="center">11</h3>

- 11.4
  - Simplify libcurl4 conflict detection by adding generic code that looks for the package instead of adding specific lines per affected distribution - https://pkgs.org/download/libcurl4

- 11.3
  - Added support for Debian Sid testing branch, Debian 9 and Debian 10 and KDE neon. This because libcurl 4 was replacing libcurl 3 on updating - https://github.com/brandleesee/ePSXe64Ubuntu/issues/7.
  - https://github.com/brandleesee/ePSXe64Ubuntu/commit/5f3b1bda3873336591b151178a90400ae2b11212
  
<table>
<tbody>
  <tr>
   <td><img src="https://i.imgur.com/FiBbK8w.png" /></td>
  </tr>
</tbody>
</table>

- 11.2
  - Consolidated code blocks as per this comment: https://github.com/brandleesee/ePSXe64Ubuntu/commit/68a031d9800b308ebdc9f55046dc7f2286267e7c#commitcomment-32485422

- 11.1
  - Linux Mint: apt-get Legacy Utility Command
    - Linux Mint still uses apt-get out-of-the-box instead of Apt.
	- issue: https://github.com/cromat/ePSXe64Ubuntu/commit/9deb4bc17ea5e53d30c6023faca060ac612be6e4
  - Libcurl 3 - 4 issue on Linux Mint 19 (https://forums.linuxmint.com/viewtopic.php?t=274477)
  
  - https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php - to make sure *elif* statement is used correctly
  - https://forums.linuxmint.com/viewtopic.php?t=263277 - checked where packages are downloaded from - resulted to be from ubuntu
  - https://www.rootusers.com/check-which-linux-mint-version/
  - https://www.tldp.org/LDP/abs/html/comparison-ops.html
  - https://stackoverflow.com/a/4277753
  - https://stackoverflow.com/questions/2237080/how-to-compare-strings-in-bash
  
<table>
<tbody>
  <tr>
   <td><img src="https://user-images.githubusercontent.com/12674437/52143698-6bdcf400-265c-11e9-99dd-79090db2bb39.png" /></td>
  </tr>
</tbody>
</table>

- 11
  - easier install (one-liner in terminal kicks up the script)
  - removed quiet mode so as to have visible any errors while installing dependencies
  - fixes the problem where recent versions of ubuntu can't have libcurl3 installed at the same time as libcurl4 or in the case of 18.10, it's not available at all. It does this by downloading the 18.04 version of libcurl3 and installing it with the name libcurl.so.3 instead of libcurl.so.4. It then patches the ePSXe executable to look for libcurl.so.3 instead of libcurl.so.4.
  - Libcurl 3 is installed alongside libcurl4 so things like kodi should work regardless of whether the checksum matches or not.
  - patch: https://github.com/brandleesee/ePSXe64Ubuntu/pull/5
  - issue: http://ngemu.com/threads/ubuntu-bionic-libcurl-so-4-curl_openssl_3-not-found.204577/
  - previous workaround: https://launchpad.net/~xapienz/+archive/ubuntu/curl34
  
<table>
<tbody>
  <tr>
   <td><img src="https://i.imgur.com/jJyFe8b.gif" /></td>
  </tr>
</tbody>
</table>

<h3 align="center">10</h3>

- 10.3
  - Fixed script running from git cloned repo.
  - Fixed script running from Steam's Big Picture Mode.

- 10.2
  - Added Debian support by adding libssl1.0.0.

- 10.1
  - Renamed icon to become hidden by default.
  - Fixed removal of icon. Consequence of v10's restructuring.

- 10
  - Optimized for Ubuntu 18.04.
    - Prior to 18.04 libcurl3 was installed only for Xubuntu / xfce.
	  - Now installed by default.
	  - http://ngemu.com/threads/ubuntu-bionic-libcurl-so-4-curl_openssl_3-not-found.204577/
	- Restructured script to first download icon then create the .desktop file effectively removing any instances of a blank Dash/Dock/Panel placeholder on first install.

<h3 align="center">9</h3>

<table>
<tbody>
  <tr>
   <td align="center"><img src="http://i.imgur.com/cSqEyXC.gif" /></td>
  </tr>
</tbody>
</table>

- 9.2
  - Changed text colour output.
  - Wrote clearer GUI instructions.
  - Removed most titles as they were misleading and did not promulgate useful information.
  - Commented sections and skipped lines for easier reference.
  
- 9.1
  - Corrected 1st line. Missing `/`.

- 9
  - Major revision.
  - Proper back up functionality.
  - Interactive SHADERS menu.
  - Prints terminal entries in color.
  - Installs required packages silently.
  - Moves and copies silently.
  - Makes effective use of system `/tmp`.
  - Added disclaimer.
  - Credit given.

<h3 align="center">8</h3>

<table>
<tbody>
  <tr>
   <td align="center"><img src="http://i.imgur.com/kfMSU17.png" /></td>
   <td align="center"><img src="http://i.imgur.com/W1zggGH.gif" /></td>
  </tr>
</tbody>
</table>

- 8.1
  - Proper branding of ePSXe64Ubuntu.
  - Added ecm tools.
  
- 8
  - Partial backup function.

<h3 align="center">7</h3>

<table>
<tbody>
  <tr>
   <td align="center"><img src="http://i.imgur.com/2Bw3iLS.png" /></td>
   <td align="center"><img src="http://i.imgur.com/fRardY8.gif" /></td>
  </tr>
</tbody>
</table>

- 7.3
  - Added `libcurl3` for Xubuntu's xfce.

- 7.2
  - Changed `apt` to `apt-get` for better support on Linux Mint 13.3.

- 7.1
  - Removed redundant line.

- 7
  - Added Icon for Dash / Dock / Panel.
  - General Re-write with if/then statements.

<h3 align="center">6</h3>

<table>
<tbody>
  <tr>
   <td align="center"><img src="http://i.imgur.com/2mT7smo.png" /></td>
   <td align="center"><img src="http://i.imgur.com/ZBFCUva.png" /></td>
  </tr>
  <tr>
   <td align="center"><img src="http://i.imgur.com/57kdpJR.png" /></td>
   <td align="left">
    <ul>
     <li><strong>Removed questionable source for BIOS.</strong></li>
     <li>Built-in BIOS HLE now used by default.</li>
    </ul>
   </td>
  </tr>
</tbody>
</table>

<h3 align="center">5</h3>

- 5.1
  - Repackaged shaders from ePSXe.com.
  - Changes from original:
    - duplicate shaders removed
    - super-eagle had different content in files there for kept and both added number
	
- 5
  - Replaced Shaders from Pete's Domain with the pack in ePSXe.com
  - Improved script
  - Removed redundant code
  - When using Pete's GPU & SPU plugins and selecting `Config --> Plugins --> Video/Audio/etc` ePSXe closes.
    - Reason: Plugins are only compiled for x32 architecture.
    - Terminal output: `/home/blc/.epsxe/plugins//libgpuPeopsMesaGL.so.1.0.78: wrong ELF class: ELFCLASS32`
    - http://www.pbernert.com/html/gpu.htm
    - http://www.pbernert.com/html/spu.htm
    - https://www.youtube.com/watch?v=Ru49bfyXijw
    - http://ngemu.com/threads/v2-0-5-linux-x64.188425/

<h3 align="center">4</h3>

<table>
<tbody>
  <tr >
   <td colspan="2"><img src="https://camo.githubusercontent.com/66f9d39d7a5274a0c8e7e0e5ff353eba364160c2/687474703a2f2f692e696d6775722e636f6d2f5534514e6b584c2e706e67" /></td>
  </tr>
  <tr>
   <td align="center"><img src="http://i.imgur.com/Ja5u4Dg.png" /></td>
   <td align="center"><img src="http://i.imgur.com/p8vMQDt.png" /></td>
  </tr>
  <tr>
   <td align="center"><img src="http://i.imgur.com/w4Ua94W.png" /></td>
   <td align="center"><img src="http://i.imgur.com/MDQabuy.png" /></td>
  </tr>
</tbody>
</table>

- Installs directly to HOME directory - no more sub-directories - for easier terminal operation.
- Executable renamed to `epsxe` for easier terminal operation.
- `docs` folder is now located in .epsxe.
- All text files from shaders are housed in docs (their name suitably changed).
- All shaders including guest shaders are in .epsxe/shaders - no more sub-directories.
- Some bloat text removed in script.
- Obsolete script commands removed.
