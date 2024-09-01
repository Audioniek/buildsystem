# buildsystem
Build system for Audioniek's Development Toolchain

Instructions
------------

1. If your Linux installation does not support git, either install it, or
   download the file prepare-for-bs.sh, make it executable and execute it
   with superuser rights.

2. Create a directory in which you want to have your build environment.
   From here on this directory will be referred to as X. 

3. In directory X, open a terminal.

4. Execute: "git clone https://github.com/Audioniek/buildsystem ." Note
   the period at the end.

5. The remaining repositories that are needed will be cloned automatically
   during the first build (see point 8).

6. If not done previously, execute sudo ./prepare-for-bs.sh. This will install
   the missing packages, depending on your Linux distribution.
   Notes: 
   * Package list is recommended to be updated before running the script (`apt update` for Ubuntu/Debian)
   * `lsb-release` is required for the script (`apt install -y lsb-release` for Ubuntu/Debian)

7. Download and extract a ready built image for the receiver you want to build
   for and extract the files audio.elf and video.elf from its /boot directory.
   Copy the files to the directory X/root/boot using the following names
   (so 4 copies each):
   audio.elf to audio_7100.elf, audio_7105.elf, audio_7109.elf and audio_7111.elf,
   video.elf to video_7100.elf, video_7105.elf, video_7109.elf and video_7111.elf.

8. Change to the directory X, execute ./make.sh and follow the
   on screen instructions to start the build process.
   The first build can take up to a few hours depending on your
   computer and internet speeds. Subsequent builds for the same
   target will be much quicker.

9. After the build is complete change to the directory X/flash and
   execute "fakeroot ./flash.sh" to create the image to run on your
   receiver. When the script completes and there were no errors,
   the file(s) required will be in the directory X/flash/out.
   Follow the instructions shown in green to move the image to
   the receiver and run it.

To update your build environment, execute "make update" in
directory X. To update one repository, go to the corresponding directory
X/apps, X/driver, X/flash or X itself and execute a "git pull".

