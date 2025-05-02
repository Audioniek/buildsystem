#
# auxiliary targets for model-specific builds
#

#
# release_cube_common
#
enigma2_release_cube_common:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_cuberevo $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)install -m 0777 $(SKEL_ROOT)/release/reboot_cuberevo $(RELEASE_DIR)/etc/init.d/reboot
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx24116.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_cube.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# release_cube_common_tuner
#
enigma2_release_cube_common_tuner:
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/multituner/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/media/dvb/frontends/dvb-pll.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_9500hd
#
enigma2_release_cuberevo_9500hd: enigma2_release_cube_common enigma2_release_cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_2000hd
#
enigma2_release_cuberevo_2000hd: enigma2_release_cube_common enigma2_release_cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_250hd
#
enigma2_release_cuberevo_250hd: enigma2_release_cube_common enigma2_release_cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_mini_fta
#
enigma2_release_cuberevo_mini_fta: enigma2_release_cube_common enigma2_release_cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_mini2
#
enigma2_release_cuberevo_mini2: enigma2_release_cube_common enigma2_release_cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_mini
#
enigma2_release_cuberevo_mini: enigma2_release_cube_common enigma2_release_cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo
#
enigma2_release_cuberevo: enigma2_release_cube_common enigma2_release_cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/
#
# cuberevo_3000hd
#
enigma2_release_cuberevo_3000hd: enigma2_release_cube_common enigma2_release_cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/

#
# release_common_ipbox
#
enigma2_release_common_ipbox:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ipbox $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/siinfo/siinfo.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_ipbox $(RELEASE_DIR)/etc/fstab
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_ipbox.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)rm -f $(RELEASE_DIR)/lib/firmware/*
	$(SILENT)rm -f $(RELEASE_DIR)/lib/modules/boxtype.ko
	$(SILENT)rm -f $(RELEASE_DIR)/lib/modules/stmvbi.ko
	$(SILENT)rm -f $(RELEASE_DIR)/lib/modules/stmvout.ko
	$(SILENT)rm -f $(RELEASE_DIR)/etc/network/interfaces
	$(SILENT)echo "config.usage.hdd_standby=0" >> $(RELEASE_DIR)/etc/enigma2/settings

#
# ipbox9900
#
enigma2_release_ipbox9900: enigma2_release_common_ipbox
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox99xx/micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/rmu/rmu.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/fan_ipbox99xx/ipbox_fan.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp -p $(SKEL_ROOT)/release/tvmode_ipbox $(RELEASE_DIR)/usr/bin/tvmode
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_ipbox.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# ipbox99
#
enigma2_release_ipbox99: enigma2_release_common_ipbox
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox99xx/micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/fan_ipbox99xx/ipbox_fan.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp -p $(SKEL_ROOT)/release/tvmode_ipbox $(RELEASE_DIR)/usr/bin/tvmode
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_ipbox.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# ipbox55
#
enigma2_release_ipbox55: enigma2_release_common_ipbox
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox55/front.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp -p $(SKEL_ROOT)/release/tvmode_ipbox55 $(RELEASE_DIR)/usr/bin/tvmode
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_ipbox.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# ufs910
#
enigma2_release_ufs910:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ufs910_fp/ufs910_fp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7100.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7100.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx21143.fw $(RELEASE_DIR)/lib/firmware/dvb-fe-cx24116.fw
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_ufs910.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_ufs910.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml
ifeq ($(DESTINATION), flash)
	$(MAKE) $(D)/ufs910installer
endif

#
# ufs912
#
enigma2_release_ufs912:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_ufs912.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml
	$(SILENT)touch $(RELEASE_DIR)/etc/.rccode
	$(SILENT)echo "1" > $(RELEASE_DIR)/etc/.rccode

#
# ufs913
#
enigma2_release_ufs913:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/multituner/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_ufs913.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml
	$(SILENT)touch $(RELEASE_DIR)/etc/.rccode
	$(SILENT)echo "1" > $(RELEASE_DIR)/etc/.rccode

#
# ufs922
#
enigma2_release_ufs922:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx21143.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/ufs9xxVFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_ufs910.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml
	$(SILENT)touch $(RELEASE_DIR)/etc/.rccode
	$(SILENT)echo "1" > $(RELEASE_DIR)/etc/.rccode
ifeq ($(DESTINATION), flash)
	$(MAKE) $(D)/ufs922installer
endif

#
# ufc960
#
enigma2_release_ufc960:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx21143.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_ufs910.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# spark
#
enigma2_release_spark:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_spark $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/aotom_spark/aotom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_spark.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/sparkVFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/leddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/sparkVFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/sparkVFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/sparkVFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_spark.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml
	$(SILENT)touch $(RELEASE_DIR)/etc/.rccode
	$(SILENT)echo "1" > $(RELEASE_DIR)/etc/.rccode

#
# spark7162
#
enigma2_release_spark7162:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_spark7162 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/aotom_spark/aotom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
#	$(SILENT)cp -f $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/i2c_spi/i2s.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp -f $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/rfmod/rfmod.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_spark7162.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_spark.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# fs9000
#
enigma2_release_fs9000:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_fs9000 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/fs9000VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/fs9000VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/fs9000VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/fs9000VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_fortis.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# hs8200
#
enigma2_release_hs8200:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_fs9000 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/multituner/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)rm -f $(RELEASE_DIR)/lib/modules/boxtype.ko
	$(SILENT)rm -f $(RELEASE_DIR)/lib/modules/mpeg2hw.ko
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs8200VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs8200VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs8200VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs8200VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_fortis.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# hs9510
#
enigma2_release_hs9510:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs9510 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs9510VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs9510VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs9510VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs9510VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_fortis.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# hs7110
#
enigma2_release_hs7110:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs7110 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_fortis.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# hs7420
#
enigma2_release_hs7420:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs742x $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs742xVFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs742xVFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs742xVFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs742xVFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_fortis.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# hs7429
#
enigma2_release_hs7429:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs742x $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs742xVFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs742xVFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs742xVFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs742xVFD; \
	fi
#	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_fortis.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# hs7810a
#
enigma2_release_hs7810a:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs7810a $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_fortis.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# hs7119
#
enigma2_release_hs7119:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs7119 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_fortis.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# hs7819
#
enigma2_release_hs7819:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs7819 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hs7810aVFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_fortis.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# atemio520
#
enigma2_release_atemio520:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_atemio520 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cn_micom/cn_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_opt9600.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# hl101
#
enigma2_release_hl101:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hl101 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/proton/proton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)rm -f $(RELEASE_DIR)/lib/firmware/dvb-fe-{avl2108,avl6222,cx24116,cx21143,stv6306}.fw
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_vip2 $(RELEASE_DIR)/etc/fstab
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_hl101.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_hl101.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# vip1_v1
#
enigma2_release_vip1_v1:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hl101 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)chmod 755 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/proton/proton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)rm -f $(RELEASE_DIR)/lib/firmware/dvb-fe-{avl2108,avl6222,cx24116,cx21143,stv6306}.fw
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_vip2 $(RELEASE_DIR)/etc/fstab
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_vip_rc12.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)cp -f $(TARGET_DIR)/sbin/shutdown $(RELEASE_DIR)/sbin/
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_vip.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml
	$(SILENT)touch $(RELEASE_DIR)/etc/.rccode
	$(SILENT)echo "1" > $(RELEASE_DIR)/etc/.rccode

#
# vip1_v2
#
enigma2_release_vip1_v2:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_vip2 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)chmod 755 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/aotom_vip/aotom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)rm -f $(RELEASE_DIR)/lib/firmware/dvb-fe-{avl2108,avl6222,cx24116,cx21143,stv6306}.fw
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_vip2 $(RELEASE_DIR)/etc/fstab
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_vip_rc12.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)cp -f $(TARGET_DIR)/sbin/shutdown $(RELEASE_DIR)/sbin/
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/spark7162VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_vip.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml
	$(SILENT)touch $(RELEASE_DIR)/etc/.rccode
	$(SILENT)echo "1" > $(RELEASE_DIR)/etc/.rccode

#
# vip2
#
enigma2_release_vip2: enigma2_release_vip1_v2
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_vip_rc12.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_vip.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# adb_box
#
enigma2_release_adb_box:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_adb_box $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/adb_5800_fp/adb_5800_fp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7100.ko $(RELEASE_DIR)/lib/modules/
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/fan_adb_box/fan_adb_box.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cec_adb_box/cec_ctrl.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/dvbt/as102/dvb-as102.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7100.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)rm -f $(RELEASE_DIR)/lib/firmware/dvb-fe-{avl2108,avl6222,cx24116,cx21143,stv6306}.fw
	$(SILENT)cp $(SKEL_ROOT)/firmware/as102_data1_st.hex $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/as102_data2_st.hex $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_adb_box $(RELEASE_DIR)/etc/fstab
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_adb_box.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/adb_5800VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/adb_5800VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/adb_5800VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/adb_5800VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_adb_box.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# adb2850
#
enigma2_release_adb_2850:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_adb2850 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/adb_2850_fp/adb_2850_fp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)rm -f $(RELEASE_DIR)/lib/firmware/dvb-fe-{avl2108,avl6222,cx24116,cx21143,stv6306}.fw
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_adb_box $(RELEASE_DIR)/etc/fstab
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_adb_box.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/adb_5800VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/adb_5800VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/adb_5800VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/adb_5800VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_adb_box.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# tf7700
#
enigma2_release_tf7700:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_tf7700 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/tffp/tffp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx24116.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_tf7700 $(RELEASE_DIR)/etc/fstab
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_tf7700.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml
ifeq ($(DESTINATION), flash)
	$(MAKE) $(D)/tfinstaller
endif

#
# vitamin_hd5000
#
enigma2_release_vitamin_hd5000:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_vitamin_hd5000 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/vitamin_hd5000/vitamin_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/smartcard/smartcard.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_vitamin_hd5000.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# sagemcom88
#
enigma2_release_sagemcom88:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/front_led/front_led.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/front_vfd/front_vfd.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/sagemcomtype/boxtype.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)[ -e $(SKEL_ROOT)/release/fe_core_sagemcom88$(KERNEL_STM_LABEL).ko ] && cp $(SKEL_ROOT)/release/fe_core_sagemcom88$(KERNEL_STM_LABEL).ko $(RELEASE_DIR)/lib/modules/fe_core.ko || true
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_sagemcom88.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_sagemcom88.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# arivalink200
#
enigma2_release_arivalink200:
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/front_ArivaLink200/vfd.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/front_ArivaLink200/vfd.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx24116.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_arivalink200.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_arivalink200.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# pace7241
#
enigma2_release_pace7241:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/pace_7241_fp/pace_7241_fp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)[ -e $(SKEL_ROOT)/release/fe_core_pace7241$(KERNEL_STM_LABEL).ko ] && cp $(SKEL_ROOT)/release/fe_core_space7241$(KERNEL_STM_LABEL).ko $(RELEASE_DIR)/lib/modules/fe_core.ko || true
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/lib/firmware/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/lib/firmware/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_pace7241.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/pace7241VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/pace7241VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/pace7241VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/pace7241VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_sagemcom88.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# opt9600
#
enigma2_release_opt9600:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_opt9600 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/opt9600_fp/opt9600_fp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_vip2 $(RELEASE_DIR)/etc/fstab
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/opt9600VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/opt9600VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/opt9600VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/opt9600VFD; \
	fi
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_opt9600.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# opt9600mini
#
enigma2_release_opt9600mini:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_atemio520 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cn_micom/cn_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_opt9600.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml

#
# opt9600prima
#
enigma2_release_opt9600prima:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_atemio520 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cn_micom/cn_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_opt9600.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml
ifeq ($(DESTINATION), flash)
	$(MAKE) $(D)/opt9600primainstaller
endif

#
# hchs8100 series
#
enigma2_release_hchs8100:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_opt9600 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/hchs8100_fp/hchs8100_fp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx24116.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_homecast.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hchsxx00VFD/plugin.py ]; then \
		rm -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons/*; \
		cp -f $(SKEL_ROOT)/release/vfddisplay.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hchsxx00VFD; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hchsxx00VFD/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VFD-Icons; \
		rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/hchsxx00VFD; \
	fi
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/keymap_hchs8100.xml $(RELEASE_DIR)/usr/share/enigma2/keymap.xml
ifeq ($(DESTINATION), flash)
	$(MAKE) $(D)/hchs8100installer
endif

#
# release_base
#
# the following target creates the common file base
enigma2_release_base:
	@echo "=============================================================="
	@echo
	@echo -e "Start build of $(TERM_GREEN_BOLD)enigma2_release$(TERM_NORMAL)."
	$(SILENT)rm -rf $(RELEASE_DIR) || true
	@echo -n "Copying image to release directory..."
	$(SILENT)install -d $(RELEASE_DIR)
	$(SILENT)install -d $(RELEASE_DIR)/{autofs,bin,boot,dev,dev.static,etc,lib,media,mnt,proc,ram,root,sbin,share,sys,tmp,usr,var,home}
	$(SILENT)install -d $(RELEASE_DIR)/autofs/{sda1,sda2,sda3,sda4,sdb1,sdb2,sdb3,sdb4,sdc1,sdc2,sdc3,sdc4,sdd1,sdd2,sdd3,sdd4}
	$(SILENT)install -d $(RELEASE_DIR)/etc/{enigma2,init.d,network,mdev,tuxbox,tuxtxt}
	$(SILENT)install -d $(RELEASE_DIR)/etc/network/if-{post-{up,down},pre-{up,down},up,down}.d
	$(SILENT)install -d $(RELEASE_DIR)/lib/{modules,udev,firmware}
	$(SILENT)install -d $(RELEASE_DIR)/media/{dvd,hdd,net}
	$(SILENT)ln -sf /media/hdd $(RELEASE_DIR)/hdd
	$(SILENT)install -d $(RELEASE_DIR)/mnt/{hdd,nfs,usb}
	$(SILENT)install -d $(RELEASE_DIR)/usr/{bin,lib,sbin,share}
	$(SILENT)install -d $(RELEASE_DIR)/usr/{bin,share,keys,camscript,script,uninstall}
	$(SILENT)ln -sf /etc $(RELEASE_DIR)/usr/etc
	$(SILENT)install -d $(RELEASE_DIR)/usr/share/{enigma2,keymaps}
	$(SILENT)ln -s /usr/share/keymaps $(RELEASE_DIR)/usr/share/keymaps
	$(SILENT)install -d $(RELEASE_DIR)/usr/share/{fonts,udhcpc,zoneinfo}
	$(SILENT)install -d $(RELEASE_DIR)/var/{etc,lib,backups}
	$(SILENT)install -d $(RELEASE_DIR)/var/lib/opkg
	$(SILENT)ln -fs halt $(RELEASE_DIR)/sbin/reboot
	$(SILENT)ln -fs halt $(RELEASE_DIR)/sbin/poweroff
	$(SILENT)mkdir -p $(RELEASE_DIR)/etc/rc.d/rc0.d
	$(SILENT)ln -s ../init.d/sendsigs $(RELEASE_DIR)/etc/rc.d/rc0.d/S20sendsigs
	$(SILENT)ln -s ../init.d/umountfs $(RELEASE_DIR)/etc/rc.d/rc0.d/S40umountfs
	$(SILENT)ln -s ../init.d/halt $(RELEASE_DIR)/etc/rc.d/rc0.d/S90halt
	$(SILENT)mkdir -p $(RELEASE_DIR)/etc/rc.d/rc6.d
	$(SILENT)ln -s ../init.d/sendsigs $(RELEASE_DIR)/etc/rc.d/rc6.d/S20sendsigs
	$(SILENT)ln -s ../init.d/umountfs $(RELEASE_DIR)/etc/rc.d/rc6.d/S40umountfs
	$(SILENT)ln -s ../init.d/reboot $(RELEASE_DIR)/etc/rc.d/rc6.d/S90reboot
	$(SILENT)touch $(RELEASE_DIR)/var/etc/.firstboot
	$(SILENT)cp -a $(TARGET_DIR)/bin/* $(RELEASE_DIR)/bin/
	$(SILENT)cp -a $(TARGET_DIR)/usr/bin/* $(RELEASE_DIR)/usr/bin/
	$(SILENT)cp -a $(TARGET_DIR)/sbin/* $(RELEASE_DIR)/sbin/
	$(SILENT)cp -a $(TARGET_DIR)/usr/sbin/* $(RELEASE_DIR)/usr/sbin/
	$(SILENT)cp $(SKEL_ROOT)/etc/image-version $(RELEASE_DIR)/etc/
	$(SILENT)cp $(TARGET_DIR)/boot/uImage $(RELEASE_DIR)/boot/
	$(SILENT)ln -sf /proc/mounts $(RELEASE_DIR)/etc/mtab
	$(SILENT)cp -dp $(SKEL_ROOT)/sbin/MAKEDEV $(RELEASE_DIR)/sbin/
	$(SILENT)ln -sf ../sbin/MAKEDEV $(RELEASE_DIR)/dev/MAKEDEV
	$(SILENT)ln -sf ../../sbin/MAKEDEV $(RELEASE_DIR)/lib/udev/MAKEDEV
	$(SILENT)cp -aR $(SKEL_ROOT)/etc/mdev/* $(RELEASE_DIR)/etc/mdev/
	$(SILENT)cp -aR $(SKEL_ROOT)/usr/share/udhcpc/* $(RELEASE_DIR)/usr/share/udhcpc/
	$(SILENT)cp -aR $(SKEL_ROOT)/usr/share/zoneinfo/* $(RELEASE_DIR)/usr/share/zoneinfo/
	$(SILENT)cp $(SKEL_ROOT)/bin/autologin $(RELEASE_DIR)/bin/
	$(SILENT)cp $(SKEL_ROOT)/bin/vdstandby $(RELEASE_DIR)/bin/
	$(SILENT)cp $(SKEL_ROOT)/usr/sbin/fw_printenv $(RELEASE_DIR)/usr/sbin/
	$(SILENT)cp -aR $(TARGET_DIR)/etc/init.d/* $(RELEASE_DIR)/etc/init.d/
	$(SILENT)cp -aR $(TARGET_DIR)/etc/* $(RELEASE_DIR)/etc/
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/boot/bootlogo.mvi $(RELEASE_DIR)/usr/share/
	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/boot/small.mp4 $(RELEASE_DIR)/usr/share/
#	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/boot/firstboot.mvi $(RELEASE_DIR)/usr/share/
#	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/boot/small.mp4 $(RELEASE_DIR)/usr/share/
	$(SILENT)echo "720p50" > $(RELEASE_DIR)/etc/videomode
	$(SILENT)echo "$(BOXTYPE)" > $(RELEASE_DIR)/etc/hostname
	$(SILENT)date +%Y%m%d > $(RELEASE_DIR)/etc/version
	$(SILENT)ln -sf ../../bin/showiframe $(RELEASE_DIR)/usr/bin/showiframe
	$(SILENT)ln -sf ../../usr/sbin/fw_printenv $(RELEASE_DIR)/usr/sbin/fw_setenv
	$(SILENT)ln -sf ../../bin/grab $(RELEASE_DIR)/usr/bin/grab
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), hs8200 fs9000 hs9510 hchs8100 ufs910 ufs912 ufs913 ufs922 ufc960 opt9600 opt9600prima spark spark7162 ipbox55 ipbox99 ipbox9900 cuberevo cuberevo_mini cuberevo_mini2 cuberevo_250hd cuberevo_2000hd cuberevo_3000hd adb_box tf7700 vip1_v1 vitamin_hd5000))
	$(SILENT)cp $(SKEL_ROOT)/release/fw_env.config_$(BOXTYPE) $(RELEASE_DIR)/etc/fw_env.config
endif
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/rcS_enigma2_$(BOXTYPE) $(RELEASE_DIR)/etc/init.d/rcS
#
# player
#
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stm_v4l2.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stm_v4l2.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmfb.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmfb.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmvbi.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmvbi.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmvout.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmvout.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)cd $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra && \
	for mod in \
		sound/pseudocard/pseudocard.ko \
		sound/silencegen/silencegen.ko \
		stm/mmelog/mmelog.ko \
		stm/monitor/stm_monitor.ko \
		media/dvb/stm/dvb/stmdvb.ko \
		sound/ksound/ksound.ko \
		media/dvb/stm/mpeg2_hard_host_transformer/mpeg2hw.ko \
		media/dvb/stm/backend/player2.ko \
		media/dvb/stm/h264_preprocessor/sth264pp.ko \
		media/dvb/stm/allocator/stmalloc.ko \
		stm/platform/platform.ko \
		stm/platform/p2div64.ko \
		media/sysfs/stm/stmsysfs.ko \
	;do \
		if [ -e player2/linux/drivers/$$mod ]; then \
			cp player2/linux/drivers/$$mod $(RELEASE_DIR)/lib/modules/; \
			$(TARGET)-strip --strip-unneeded $(RELEASE_DIR)/lib/modules/`basename $$mod`; \
		else \
			touch $(RELEASE_DIR)/lib/modules/`basename $$mod`; \
		fi; \
	done
#
# modules
#
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/avs/avs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/avs/avs.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/bpamem/bpamem.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/bpamem/bpamem.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/boxtype/boxtype.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/boxtype/boxtype.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/compcache/ramzswap.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/compcache/ramzswap.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/e2_proc/e2_proc.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/e2_proc/e2_proc.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/net/ipv6/ipv6.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/net/ipv6/ipv6.ko $(RELEASE_DIR)/lib/modules/ || true
#
# multicom 324
#
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshell/embxshell.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshell/embxshell.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxmailbox/embxmailbox.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxmailbox/embxmailbox.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshm/embxshm.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshm/embxshm.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/mme/mme_host.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/mme/mme_host.ko $(RELEASE_DIR)/lib/modules/ || true
#
#
#
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/simu_button/simu_button.ko $(RELEASE_DIR)/lib/modules/
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), cuberevo_mini_fta cuberevo_250hd vip2 spark spark7162 adb_box adb_2850 sagemcom88 pace7241))
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cic/*.ko $(RELEASE_DIR)/lib/modules/
endif
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/button/button.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/button/button.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cec/cec.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cec/cec.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cpu_frequ/cpu_frequ.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cpu_frequ/cpu_frequ.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/led/led.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/led/led.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/pti/pti.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/pti/pti.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/pti_np/pti.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/pti_np/pti.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/smartcard/smartcard.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/smartcard/smartcard.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/sata_switch/sata.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/sata_switch/sata.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/mini_fo/mini_fo.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/mini_fo/mini_fo.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/autofs4/autofs4.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/autofs4/autofs4.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/net/tun.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/net/tun.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/fuse/fuse.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/fuse/fuse.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/ntfs/ntfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/ntfs/ntfs.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/cifs/cifs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/cifs/cifs.ko $(RELEASE_DIR)/lib/modules/ || true
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), ufs910 ufs922))
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/jfs/jfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/jfs/jfs.ko $(RELEASE_DIR)/lib/modules/ || true
endif
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfsd/nfsd.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfsd/nfsd.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/exportfs/exportfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/exportfs/exportfs.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs_common/nfs_acl.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs_common/nfs_acl.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs/nfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs/nfs.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/usbserial.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/usbserial.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/ftdi_sio.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/ftdi_sio.ko $(RELEASE_DIR)/lib/modules/ftdi.ko || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/pl2303.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/pl2303.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/ch341.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/ch341.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/rtc/*.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/rtc/*.ko $(RELEASE_DIR)/lib/modules/ || true
#
# wlan
#
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/mt7601u/mt7601Usta.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/mt7601u/mt7601Usta.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt2870sta/rt2870sta.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt2870sta/rt2870sta.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt3070sta/rt3070sta.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt3070sta/rt3070sta.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt5370sta/rt5370sta.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rt5370sta/rt5370sta.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl871x/8712u.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl871x/8712u.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8188eu/8188eu.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8188eu/8188eu.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8192cu/8192cu.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8192cu/8192cu.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8192du/8192du.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8192du/8192du.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8192eu/8192eu.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/wireless/rtl8192eu/8192eu.ko $(RELEASE_DIR)/lib/modules/ || true
#
# wlan firmware
#
ifeq ($(IMAGE), $(filter $(IMAGE), enigma2-wlandriver))
	$(SILENT)install -d $(RELEASE_DIR)/etc/Wireless
	$(SILENT)cp -aR $(SKEL_ROOT)/firmware/Wireless/* $(RELEASE_DIR)/etc/Wireless/
	$(SILENT)cp -aR $(SKEL_ROOT)/firmware/rtlwifi $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -aR $(SKEL_ROOT)/firmware/*.bin $(RELEASE_DIR)/lib/firmware/
	$(SILENT)[ -e $(SKEL_ROOT)/etc/wpa_supplicant.wlan0.conf ] && cp -aR $(SKEL_ROOT)/etc/wpa_supplicant.wlan0.conf $(RELEASE_DIR)/etc/ || true
endif
#
# lib usr/lib
#
	$(SILENT)cp -R $(TARGET_DIR)/lib/* $(RELEASE_DIR)/lib/
	$(SILENT)rm -f $(RELEASE_DIR)/lib/*.{a,o,la}
	$(SILENT)chmod 755 $(RELEASE_DIR)/lib/*
	$(SILENT)cp -R $(TARGET_DIR)/usr/lib/* $(RELEASE_DIR)/usr/lib/
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/{engines,enigma2,gconv,libxslt-plugins,pkgconfig,python$(PYTHON_VER),sigc++-1.2,sigc++-2.0}
	$(SILENT)mkdir -p $(RELEASE_DIR)/usr/lib/pkgconfig
	$(SILENT)[ -e $(TARGET_DIR)/usr/lib/pkgconfig/gstreamer-1.0.pc ] && cp $(TARGET_DIR)/usr/lib/pkgconfig/gstreamer-1.0.pc $(RELEASE_DIR)/usr/lib/pkgconfig/ || true
	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/*.{a,o,la}
	$(SILENT)chmod 755 $(RELEASE_DIR)/usr/lib/*
#
# fonts
#
	$(SILENT)cp $(SKEL_ROOT)/root_enigma2/usr/share/fonts/* $(RELEASE_DIR)/usr/share/fonts/
	$(SILENT)cp $(TARGET_DIR)/usr/share/fonts/* $(RELEASE_DIR)/usr/share/fonts/
	$(SILENT)rm -f $(RELEASE_DIR)/usr/share/fonts/wqy-microhei.ttc
	$(SILENT)rm -f $(RELEASE_DIR)/usr/share/fonts/fallback.font
	$(SILENT)ln -s /usr/share/fonts $(RELEASE_DIR)/usr/share/fonts
#
# enigma2
#
	$(SILENT)if [ -e $(TARGET_DIR)/usr/bin/enigma2 ]; then \
		cp -f $(TARGET_DIR)/usr/bin/enigma2 $(RELEASE_DIR)/usr/bin/enigma2; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/usr/bin/enigma2 ]; then \
		cp -f $(TARGET_DIR)/usr/bin/enigma2 $(RELEASE_DIR)/usr/bin/enigma2; \
	fi
	$(SILENT)cp -a $(TARGET_DIR)/usr/share/enigma2/* $(RELEASE_DIR)/usr/share/enigma2
#	$(SILENT)cp -f $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/skin_default/spinner/* $(RELEASE_DIR)/usr/share/enigma2/skin_default/spinner/
	$(SILENT)cp $(SKEL_ROOT)/root_enigma2/etc/enigma2/* $(RELEASE_DIR)/etc/enigma2
	$(SILENT)ln -s /usr/share/enigma2 $(RELEASE_DIR)/usr/share/enigma2
	$(SILENT)ln -sf /etc/timezone.xml $(RELEASE_DIR)/etc/tuxbox/timezone.xml
	$(SILENT)install -d $(RELEASE_DIR)/usr/lib/enigma2
	$(SILENT)cp -a $(TARGET_DIR)/usr/lib/enigma2/* $(RELEASE_DIR)/usr/lib/enigma2/
	$(SILENT)if test -d $(TARGET_DIR)/usr/lib/enigma2; then \
		cp -a $(TARGET_DIR)/usr/lib/enigma2/* $(RELEASE_DIR)/usr/lib/enigma2; \
	fi
	$(SILENT)if test -d $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/Extensions; then \
		cp -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/Extensions/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions; \
		rmdir --ignore-fail-on-non-empty $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/Extensions/; \
	fi
#
# copy root_enigma2
#
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/etc/* $(RELEASE_DIR)/etc/
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/home/* $(RELEASE_DIR)/home/
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/etc/enigma2/weather_icons_special/* $(RELEASE_DIR)/etc/enigma2/weather_icons_special/
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/var/* $(RELEASE_DIR)/var/
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/bin/* $(RELEASE_DIR)/usr/bin/
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/lib/* $(RELEASE_DIR)/usr/lib/
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/etc/enigma2/skin_default/* $(RELEASE_DIR)/etc/enigma2/skin_default/
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/camscript/* $(RELEASE_DIR)/usr/camscript/	
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/var/lib/opkg/info/* $(RELEASE_DIR)/var/lib/opkg/info/
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/var/lib/opkg/status $(RELEASE_DIR)/var/lib/opkg/status
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/lib/libcrypto.so.1.0.0 $(RELEASE_DIR)/usr/lib/libcrypto.so.1.0.0
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/lib/libssl.so.1.0.0 $(RELEASE_DIR)/usr/lib/libssl.so.1.0.0
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/bin/* $(RELEASE_DIR)/usr/bin/
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/bin/opkg $(RELEASE_DIR)/usr/bin/opkg	
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/script/* $(RELEASE_DIR)/usr/script/
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/keys/* $(RELEASE_DIR)/usr/keys/
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/uninstall/* $(RELEASE_DIR)/usr/uninstall/
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/var/backups/* $(RELEASE_DIR)/var/backups/
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/share/ca-certificates/* $(RELEASE_DIR)/usr/share/ca-certificates/
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/* $(RELEASE_DIR)/usr/share/enigma2/	
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/share/* $(RELEASE_DIR)/usr/share/	
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/share/enigma2/menu.xml2 $(RELEASE_DIR)/usr/share/enigma2/menu.xml
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/lib/enigma2/python/* $(RELEASE_DIR)/usr/lib/enigma2/python/
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/lib/python2.7/site-packages/* $(RELEASE_DIR)/usr/lib/python2.7/site-packages/
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/lib/enigma2/python/Components/* $(RELEASE_DIR)/usr/lib/enigma2/python/Components/
	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/lib/enigma2/python/Plugins/* $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/
	$(SILENT)if [[ ! -d $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif ]]; then \
		rmdir --ignore-fail-on-non-empty $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/; \
	fi
#
# python2.7
#
	$(SILENT)if [ $(PYTHON_VERSION) == $(PYTHON2_VER_MAJOR) ]; then \
		install -d $(RELEASE_DIR)/usr/include; \
		install -d $(RELEASE_DIR)/$(PYTHON_INCLUDE_DIR); \
		cp $(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)/pyconfig.h $(RELEASE_DIR)/$(PYTHON_INCLUDE_DIR); \
	fi
#
# hotplug
#
	$(SILENT)if [ -e $(TARGET_DIR)/usr/bin/hotplug_e2_helper ]; then \
		cp -dp $(TARGET_DIR)/usr/bin/hotplug_e2_helper $(RELEASE_DIR)/sbin/hotplug; \
		cp -dp $(TARGET_DIR)/usr/bin/bdpoll $(RELEASE_DIR)/sbin/; \
	else \
		cp -dp $(TARGET_DIR)/sbin/hotplug $(RELEASE_DIR)/sbin/; \
	fi
#
# alsa
#
	$(SILENT)if [ -e $(TARGET_DIR)/usr/share/alsa ]; then \
		mkdir -p $(RELEASE_DIR)/usr/share/alsa/; \
		mkdir $(RELEASE_DIR)/usr/share/alsa/cards/; \
		mkdir $(RELEASE_DIR)/usr/share/alsa/pcm/; \
		cp -dp $(TARGET_DIR)/usr/share/alsa/alsa.conf $(RELEASE_DIR)/usr/share/alsa/alsa.conf; \
		cp $(TARGET_DIR)/usr/share/alsa/cards/aliases.conf $(RELEASE_DIR)/usr/share/alsa/cards/; \
		cp $(TARGET_DIR)/usr/share/alsa/pcm/default.conf $(RELEASE_DIR)/usr/share/alsa/pcm/; \
		cp $(TARGET_DIR)/usr/share/alsa/pcm/dmix.conf $(RELEASE_DIR)/usr/share/alsa/pcm/; \
	fi
#
# directfb
#
	$(SILENT)if [ -d $(RELEASE_DIR)/usr/lib/directfb-1.4-5 ]; then \
		rm -rf $(RELEASE_DIR)/usr/lib/directfb-1.4-5/gfxdrivers/*.{a,o,la}; \
		rm -rf $(RELEASE_DIR)/usr/lib/directfb-1.4-5/inputdrivers/*; \
		cp -a $(TARGET_DIR)/usr/lib/directfb-1.4-5/inputdrivers/libdirectfb_enigma2remote.so $(RELEASE_DIR)/usr/lib/directfb-1.4-5/inputdrivers/; \
		cp -a $(TARGET_DIR)/usr/lib/directfb-1.4-5/inputdrivers/libdirectfb_linux_input.so $(RELEASE_DIR)/usr/lib/directfb-1.4-5/inputdrivers/; \
		rm -rf $(RELEASE_DIR)/usr/lib/directfb-1.4-5/systems/*.{a,o,la}; \
		rm -rf $(RELEASE_DIR)/usr/lib/directfb-1.4-5/systems/libdirectfb_dummy.so; \
		rm -rf $(RELEASE_DIR)/usr/lib/directfb-1.4-5/systems/libdirectfb_fbdev.so; \
		rm -rf $(RELEASE_DIR)/usr/lib/directfb-1.4-5/wm/*.{a,o,la}; \
		rm -rf $(RELEASE_DIR)/usr/lib/directfb-1.4-5/interfaces/IDirectFBFont/*.{a,o,la}; \
		rm -rf $(RELEASE_DIR)/usr/lib/directfb-1.4-5/interfaces/IDirectFBImageProvider/*.{a,o,la}; \
		rm -rf $(RELEASE_DIR)/usr/lib/directfb-1.4-5/interfaces/IDirectFBVideoProvider/*.{a,o,la}; \
	fi
	$(SILENT)if [ -d $(RELEASE_DIR)/usr/lib/icu ]; then \
		rm -rf $(RELEASE_DIR)/usr/lib/icu; \
	fi
	$(SILENT)if [ -d $(RELEASE_DIR)/usr/lib/glib-2.0 ]; then \
		rm -rf $(RELEASE_DIR)/usr/lib/glib-2.0; \
	fi
	$(SILENT)if [ -d $(RELEASE_DIR)/usr/lib/enchant ]; then \
		rm -rf $(RELEASE_DIR)/usr/lib/enchant; \
	fi
#
# DVB-T USB
#
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/media/dvb/frontends/dvb-pll.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/media/dvb/frontends/dvb-pll.ko $(RELEASE_DIR)/lib/modules/; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/dvbt/as102/dvb-as102.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/dvbt/as102/dvb-as102.ko $(RELEASE_DIR)/lib/modules/; \
		cp $(SKEL_ROOT)/firmware/as102_data1_st.hex $(RELEASE_DIR)/lib/firmware/; \
		cp $(SKEL_ROOT)/firmware/as102_data2_st.hex $(RELEASE_DIR)/lib/firmware/; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/dvbt/siano/ ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/dvbt/siano/* $(RELEASE_DIR)/lib/modules/; \
		cp $(SKEL_ROOT)/firmware/dvb_nova_12mhz_b0.inp $(RELEASE_DIR)/lib/firmware/; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/dvbt/it913x/dvb-it913x.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/dvbt/it913x/dvb-it913x.ko $(RELEASE_DIR)/lib/modules/; \
		cp $(SKEL_ROOT)/firmware/dvb-usb-it9135-01.fw $(RELEASE_DIR)/lib/firmware/; \
		cp $(SKEL_ROOT)/firmware/dvb-usb-it9135-02.fw $(RELEASE_DIR)/lib/firmware/; \
		cp $(SKEL_ROOT)/firmware/dvb-usb-it9137-01.fw $(RELEASE_DIR)/lib/firmware/; \
	fi
#
# Complete the videomode selection picture set
#
	$(SILENT)if [ -e $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/Videomode/YPbPr.png ]; then \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/Videomode/YPbPr.png $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/Videomode/Component.png; \
		cp -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/Videomode/lcd_YPbPr.png $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/Videomode/lcd_Component.png; \
	fi
	@echo " done."
#
# delete unnecessary files
#
	@echo -n "Cleaning up..."
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), ufs910 ufs922))
	$(SILENT)rm -f $(RELEASE_DIR)/sbin/jfs_fsck
	$(SILENT)rm -f $(RELEASE_DIR)/sbin/fsck.jfs
	$(SILENT)rm -f $(RELEASE_DIR)/sbin/jfs_mkfs
	$(SILENT)rm -f $(RELEASE_DIR)/sbin/mkfs.jfs
	$(SILENT)rm -f $(RELEASE_DIR)/sbin/jfs_tune
endif
	$(SILENT)rm -f $(RELEASE_DIR)/usr/bin/avahi-*
	$(SILENT)rm -f $(RELEASE_DIR)/usr/bin/easy_install*
	$(SILENT)rm -f $(RELEASE_DIR)/usr/bin/glib-*
	$(SILENT)rm -f $(addprefix $(RELEASE_DIR)/usr/bin/,dvdnav-config gio-querymodules gobject-query gtester gtester-report)
	$(SILENT)rm -f $(addprefix $(RELEASE_DIR)/usr/bin/,livestreamer mailmail manhole opkg-check-config opkg-cl)
	$(SILENT)rm -rf $(RELEASE_DIR)/lib/autofs
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/m4-nofpu/
	$(SILENT)rm -rf $(RELEASE_DIR)/lib/modules/$(KERNEL_VER)
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/gcc
	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/libc.so
	$(SILENT)rm -f $(addprefix $(RELEASE_DIR)/usr/share/,skin_display_dm800se.xml skin_display_e4hd.xml skin_display_et10000.xml skin_display_et8500.xml skin_display_gbquad4k.xml skin_display_gbu4k.xml skin_display_hd2400.xml skin_display_vuduo2.xml skin_display_vuduo4k.xml skin_display_vusolo4k.xml skin_display_vuultimo4k.xml skin_display_vuuno4kse.xml skin_text_formuler1.xml)
	$(SILENT)if [ -d $(RELEASE_DIR)/usr/share/hwinfo ]; then \
		rm -rf $(RELEASE_DIR)/usr/share/hwinfo; \
	fi
	$(SILENT)if [ -d $(RELEASE_DIR)/usr/share/skin_default/LCDIcons ]; then \
		rm -rf $(RELEASE_DIR)/usr/share/skin_default/LCDIcons; \
	fi
#
# delete unnecessary files python
#
	$(SILENT)install -d $(RELEASE_DIR)/$(PYTHON_DIR)
	$(SILENT)cp -a $(TARGET_DIR)/$(PYTHON_DIR)/* $(RELEASE_DIR)/$(PYTHON_DIR)/
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/{bsddb,compiler,curses,distutils,lib-old,lib-tk,plat-linux3,test}
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/ctypes/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/email/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/json/tests
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/lib2to3/tests
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/sqlite3/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/unittest/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/{test,conch,mail,names,news,words,flow,lore,pair,runner}
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/Cheetah/Tests
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/livestreamer_cli
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/lxml
	$(SILENT)rm -f $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/libxml2mod.so
	$(SILENT)rm -f $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/libxsltmod.so
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/OpenSSL/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/setuptools
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/zope/interface/tests
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/application/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/conch/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/internet/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/lore/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/mail/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/manhole/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/names/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/news/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/pair/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/persisted/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/protocols/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/python/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/runner/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/scripts/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/trial/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/web/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/twisted/words/test
	$(SILENT)rm -rf $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/*-py$(PYTHON_VER_MAJOR).egg-info
	$(SILENT)if [ -e $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/_cffi_backend.so.sh4 ]; then \
		if [ -e $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/_cffi_backend.so ];then \
			rm -f $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/_cffi_backend.so ]; \
		fi; \
		mv -fT $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/_cffi_backend.so.sh4 $(RELEASE_DIR)/$(PYTHON_DIR)/site-packages/_cffi_backend.so; \
	fi
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/DemoPlugins
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/FrontprocessorUpgrade
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NFIFlash
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/FileManager
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/TuxboxPlugins
ifeq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small size))
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/DVDBurn
endif
#
# Remove WirelessLAN plugin if no wlan built
#
ifneq ($(IMAGE), $(filter $(IMAGE), enigma2-wlandriver))
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/WirelessLAN
endif
#
# delete unnecessary remote control files and VFD plugins
#
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), cuberevo cuberevo_mini_fta cuberevo_250hd cuberevo_mini cuberevo_mini2 cuberevo_2000hd cuberevo_3000hd cuberevo_9500hd))
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/CuberevoVFD
endif
#
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_adb_box.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/adb_xmp.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_atemio520.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/atemio520.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_cuberevo.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/cuberevo.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_cuberevo_uni.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/cuberevo_uni.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_fs9000.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/fs9000.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_hs9510.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/hs9510.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_hs7110.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/hs7110.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_spark.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/spark.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_tf7700.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/tf7700.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_ufs910.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/ufs910.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_ufs912.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/ufs912.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_ufs913.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/ufs913.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_vitamin.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/vitamin.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_pace7241.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/pace7241.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_hl101_1.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/hl101_1.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_vip_1.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/vip_1.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_opt9600.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/opt9600.png
	$(SILENT)cp -f $(SKEL_ROOT)/release/rc_hchs8100.png $(RELEASE_DIR)/usr/share/enigma2/rc_models/hchs8100.png
# delete mips remote control files
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/et4x00.*
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/et6x00.*
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/et7x00.*
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/et8000.*
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/et9x00.*
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/et9500.*
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/formuler1.*
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/hd1100.*
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/hd2400.*
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/vu*.*
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/share/enigma2/rc_models/xp1000.*
#
# delete unnecessary OpenWebif files
#
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/adb2849.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/arivalink200.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/dm800.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/dreamone.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/dreamtwo.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/dsi87.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/dual.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/e3hd.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/elite.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/esi88.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/et8500s.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/gb800ueplus.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/gbquad.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/h11.s.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/h9.2h.se.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/h9.2s.se.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/h9se.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/h9.s.se.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/hd66se.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/ini-1000.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/ini-3000.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/ini-5000.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/ini-7000.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/ixussone.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/ixusszero.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/me.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/minime.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/miraclebox.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/multiboxse.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/optimussos1plus.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/optimussos1.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/optimussos2plus.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/optimussos2.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/premium.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/premium+.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/pulse4kmini.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/sfx6008.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/sfx6008wl.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/sfx6018.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/uhd88.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/ultra.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/xcombo.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/xpeedlx3.png
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), adb_box))
	$(SILENT)mv -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/nbox.png \
		$(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/adb_box.png
	$(SILENT)mv -f $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/topf.png \
		$(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/tf7700.png
endif
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/alphatriplehd.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/amiko1.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/amiko.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/dmm1.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/dmm2.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/dmm3.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/dm_normal.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/dual.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/dm_normal.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/e3hd.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/e4hd.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/edision1.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/edision2.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/edision3.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/edision4.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/elite.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/et6500.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/et7000mini.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/et7x00.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/et8000.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/et_rc13_normal.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/et_rc5_normal.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/et_rc7_normal.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/formuler1.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/fusionhd.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/fusionhdse.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/galaxy4k.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/gb7252.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/gbquadplus.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/gigablue_black.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/h3.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/hd1x00.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/hd2400.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/hd60.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/hd66se.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/i55.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/ini-1000.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/ini-3000.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/ini-5000.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/ini-7000.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/ixussone.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/ixusszero.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/lunix4k.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/me.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/miraclebox2.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/miraclebox.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/multibox.png
#	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/nbox.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/octagon.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/octagon3.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/optimuss.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/osmini.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/premium.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/pulse4k.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/purehd.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/qviart.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/revo4k.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/sh1.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/spark.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/spycat.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/uclan.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/viperslim.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/vs1x00.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/vu_duo2.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/vu_normal_02.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/vu_normal.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/vu_ultimo.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/wetekplay.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/xcombo.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/xpeedlx.png
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/xp_rc14_normal.png
#
# Do not remove pyo files, remove pyc instead
#
	$(SILENT)find $(RELEASE_DIR)/usr/lib/enigma2/ -name '*.pyc' -exec rm -f {} \;
ifeq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small size))
ifeq ($(E2_DIFF), $(filter $(E2_DIFF), 0 2))
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), adb_box hs8200 ufs912 ufs913))
	$(SILENT)find $(RELEASE_DIR)/usr/lib/enigma2/ -not -name 'StartEnigma.py' -name '*.py' -exec rm -f {} \;
else
	$(SILENT)find $(RELEASE_DIR)/usr/lib/enigma2/ -not -name 'StartEnigma.py' -not -name 'Language.py' -name '*.py' -exec rm -f {} \;
endif
else
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), adb_box hs8200 ufs912 ufs913))
	$(SILENT)find $(RELEASE_DIR)/usr/lib/enigma2/ -not -name 'mytest.py' -name '*.py' -exec rm -f {} \;
else
	$(SILENT)find $(RELEASE_DIR)/usr/lib/enigma2/ -not -name 'mytest.py' -not -name 'Language.py' -name '*.py' -exec rm -f {} \;
endif
endif
endif
	$(SILENT)find $(RELEASE_DIR)/usr/lib/enigma2/ -name '*.a' -exec rm -f {} \;
	$(SILENT)find $(RELEASE_DIR)/usr/lib/enigma2/ -name '*.o' -exec rm -f {} \;
	$(SILENT)find $(RELEASE_DIR)/usr/lib/enigma2/ -name '*.la' -exec rm -f {} \;
	$(SILENT)find $(RELEASE_DIR)/$(PYTHON_DIR)/ -name '*.pyc' -exec rm -f {} \;
ifeq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small size))
	$(SILENT)find $(RELEASE_DIR)/$(PYTHON_DIR)/ -name '*.py' -exec rm -f {} \;
endif
	$(SILENT)find $(RELEASE_DIR)/$(PYTHON_DIR)/ -name '*.a' -exec rm -f {} \;
	$(SILENT)find $(RELEASE_DIR)/$(PYTHON_DIR)/ -name '*.c' -exec rm -f {} \;
	$(SILENT)find $(RELEASE_DIR)/$(PYTHON_DIR)/ -name '*.pyx' -exec rm -f {} \;
	$(SILENT)find $(RELEASE_DIR)/$(PYTHON_DIR)/ -name '*.o' -exec rm -f {} \;
	$(SILENT)find $(RELEASE_DIR)/$(PYTHON_DIR)/ -name '*.la' -exec rm -f {} \;
#
# Remove non-working plugins
	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/VideoEnhancement/*
	@echo " done."
#
# The main target depends on the model.
#
$(D)/enigma2_release: \
$(D)/%enigma2_release: enigma2_release_base enigma2_release_$(BOXTYPE)
	$(TUXBOX_CUSTOMIZE)
	$(TOUCH)
#
# FOR YOUR OWN CHANGES use this folder in /own_build/enigma2
#
#	default for all receivers
	@echo -n "Processing own_build..."
	$(SILENT)find $(OWN_BUILD)/enigma2/ -mindepth 1 -maxdepth 1 -exec cp -at$(RELEASE_DIR)/ -- {} +
	@echo " done."
#	receiver specific (only if directory exists)
	@echo -n "Processing receiver specific own build for $(BOXTYPE)..."
	$(SILENT)[ -d "$(OWN_BUILD)/enigma2.$(BOXTYPE)" ] && find $(OWN_BUILD)/enigma2.$(BOXTYPE)/ -mindepth 1 -maxdepth 1 -exec cp -at$(RELEASE_DIR)/ -- {} + || true
	@echo " done."
	$(SILENT)echo $(BOXTYPE) > $(RELEASE_DIR)/etc/model
	@rm -f $(RELEASE_DIR)/for_your_own_changes
#
# sh4-linux-strip all
#
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), kerneldebug debug))
	@echo -n "Stripping...";
	$(SILENT)find $(RELEASE_DIR)/ -name '*' -exec $(TARGET)-strip --strip-unneeded {} &>/dev/null \;
	@echo -e " done.\n";
endif
#
# release-clean
#
enigma2-release-clean:
	$(SILENT)rm -f $(D)/enigma2_release

