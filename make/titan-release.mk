#
# auxiliary targets for model-specific builds
#

#
# release_cube_common
#
titan-release-cube_common:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_cuberevo $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)install -m 0777 $(SKEL_ROOT)/release/reboot_cuberevo $(RELEASE_DIR)/etc/init.d/reboot
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx24116.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/

#
# release_cube_common_tuner
#
titan-release-cube_common_tuner:
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/multituner/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/media/dvb/frontends/dvb-pll.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_9500hd
#
titan-release-cuberevo_9500hd: titan-release-cube_common titan-release-cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_2000hd
#
titan-release-cuberevo_2000hd: titan-release-cube_common titan-release-cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_250hd
#
titan-release-cuberevo_250hd: titan-release-cube_common titan-release-cube_common_tuner
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko $(RELEASE_DIR)/lib/modules/micom.ko; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/micom.ko; \
	fi

#
# cuberevo_mini_fta
#
titan-release-cuberevo_mini_fta: titan-release-cube_common titan-release-cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/

#
# cuberevo_mini2
#
titan-release-cuberevo_mini2: titan-release-cube_common titan-release-cube_common_tuner
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko $(RELEASE_DIR)/lib/modules/micom.ko; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/micom.ko; \
	fi

#
# cuberevo_mini
#
titan-release-cuberevo_mini: titan-release-cube_common titan-release-cube_common_tuner
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko $(RELEASE_DIR)/lib/modules/micom.ko; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/micom.ko; \
	fi

#
# cuberevo
#
titan-release-cuberevo: titan-release-cube_common titan-release-cube_common_tuner
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox/micom.ko $(RELEASE_DIR)/lib/modules/micom.ko; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/micom.ko; \
	fi

#
# cuberevo_3000hd
#
titan-release-cuberevo_3000hd: titan-release-cube_common titan-release-cube_common_tuner
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cuberevo_micom/cuberevo_micom.ko $(RELEASE_DIR)/lib/modules/

#
# common_ipbox
#
titan-release-common_ipbox:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ipbox $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/siinfo/siinfo.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_ipbox $(RELEASE_DIR)/var/etc/fstab
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/as102_data1_st.hex $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/as102_data2_st.hex $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_ipbox.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)rm -f $(RELEASE_DIR)/lib/firmware/*
	$(SILENT)rm -f $(RELEASE_DIR)/lib/modules/boxtype.ko
	$(SILENT)rm -f $(RELEASE_DIR)/etc/network/interfaces

#
# ipbox9900
#
titan-release-ipbox9900: titan-release-common_ipbox
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox99xx/micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/rmu/rmu.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/fan_ipbox99xx/ipbox_fan.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp -p $(SKEL_ROOT)/release/tvmode_ipbox $(RELEASE_DIR)/usr/bin/tvmode

#
# ipbox99
#
titan-release-ipbox99: titan-release-common_ipbox
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox99xx/micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/fan_ipbox99xx/ipbox_fan.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp -p $(SKEL_ROOT)/release/tvmode_ipbox $(RELEASE_DIR)/usr/bin/tvmode

#
# ipbox55
#
titan-release-ipbox55: titan-release-common_ipbox
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ipbox55/front.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp -p $(SKEL_ROOT)/release/tvmode_ipbox55 $(RELEASE_DIR)/usr/bin/tvmode

#
# ufs910
#
titan-release-ufs910: $(D)/uboot-utils
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs $(RELEASE_DIR)/etc/init.d/halt
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/ufs910_fp/ufs910_fp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/vfd/vfd.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7100.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7100.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx21143.fw $(RELEASE_DIR)/lib/firmware/dvb-fe-cx24116.fw
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_ufs910.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)cp $(TARGET_DIR)/usr/bin/fw_setenv $(RELEASE_DIR)/usr/bin/
	$(SILENT)ln -sf $(RELEASE_DIR)/usr/bin/fw_setenv $(RELEASE_DIR)/usr/bin/fw_printenv

#
# ufs912
#
titan-release-ufs912:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko $(RELEASE_DIR)/lib/modules/micom.ko ; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/; \
	fi
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/ 
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# ufs913
#
titan-release-ufs913:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko $(RELEASE_DIR)/lib/modules/micom.ko ; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/; \
	fi
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/multituner/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/

#
# ufs922
#
titan-release-ufs922:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs $(RELEASE_DIR)/etc/init.d/halt
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko $(RELEASE_DIR)/lib/modules/micom.ko ; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/; \
	fi
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/fan_ufs922/fan_ctrl.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx21143.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)touch $(RELEASE_DIR)/var/etc/.rccode
	$(SILENT)echo "1" > $(RELEASE_DIR)/var/etc/.rccode
#ifeq ($(DESTINATION), flash)
#	$(MAKE) $(D)/ufsinstaller
#endif

#
# ufc960
#
titan-release-ufc960:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs $(RELEASE_DIR)/etc/init.d/halt
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/kathrein_micom/kathrein_micom.ko $(RELEASE_DIR)/lib/modules/micom.ko ; \
	fi
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/micom/micom.ko $(RELEASE_DIR)/lib/modules/; \
	fi
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx21143.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/

#
# spark
#
titan-release-spark:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_spark $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/aotom_spark/aotom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_spark.conf $(RELEASE_DIR)/etc/lircd.conf

#
# spark7162
#
titan-release-spark7162:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_spark7162 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/aotom_spark/aotom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_spark7162.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)cp $(SKEL_ROOT)/release/fw_env.config_$(BOXTYPE)_titan $(RELEASE_DIR)/etc/fw_env.config

#
# fs9000
#
titan-release-fs9000:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_fs9000 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf

#
# hs8200
#
titan-release-hs8200:
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
	$(SILENT)rm  -f $(RELEASE_DIR)/lib/modules/mpeg2hw.ko
	$(SILENT)echo "9" > $(RELEASE_DIR)/etc/.board

#
# hs9510
#
titan-release-hs9510:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs9510 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/

#
# hs7110
#
titan-release-hs7110:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs7110 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# hs7119
#
titan-release-hs7119:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs7119 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# hs7420
#
titan-release-hs7420:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs742x $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)chmod 755 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# hs7429
#
titan-release-hs7429:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs742x $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)chmod 755 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# hs7810a
#
titan-release-hs7810a:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs7810a $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# hs7819
#
titan-release-hs7819:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hs7819 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/nuvoton/nuvoton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# atemio520
#
titan-release-atemio520:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_atemio520 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/cn_micom/cn_micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/lnb/lnb.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# adb_box
#
titan-release-adb_box:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_adb_box $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/adb_5800_fp/adb_5800_fp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7100.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cec_adb_box/cec_ctrl.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/dvbt/as102/dvb-as102.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7100.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/as102_data1_st.hex $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/as102_data2_st.hex $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_adb_box $(RELEASE_DIR)/var/etc/fstab
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_adb_box.conf $(RELEASE_DIR)/etc/lircd.conf

#
# tf7700
#
titan-release-tf7700:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_tf7700 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/tffp/tffp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx24116.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_tf7700 $(RELEASE_DIR)/var/etc/fstab
ifeq ($(DESTINATION), flash)
	$(MAKE) $(D)/tfinstaller
endif

#
# vitamin_hd5000
#
titan-release-vitamin_hd5000:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7111.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/vitamin_hd5000/micom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/smartcard/smartcard.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7111.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7111.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7111_mb618.fw $(RELEASE_DIR)/lib/firmware/component.fw

#
# sagemcom88
#
titan-release-sagemcom88:
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

#
# arivalink200
#
titan-release-arivalink200:
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/front_ArivaLink200/vfd.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/front_ArivaLink200/vfd.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7100.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-cx24116.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_arivalink200.conf $(RELEASE_DIR)/etc/lircd.conf

#
# hl101
#
titan-release-hl101:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hl101 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/proton/proton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/as102_data1_st.hex $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/as102_data2_st.hex $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_hl101.conf $(RELEASE_DIR)/etc/lircd.conf

#
# vip1_v1
#
titan-release-vip1_v1:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_hl101 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/proton/proton.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-stv6306.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/as102_data1_st.hex $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/as102_data2_st.hex $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_vip_rc12.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)touch $(RELEASE_DIR)/var/etc/.rccode
	$(SILENT)echo "1" > $(RELEASE_DIR)/var/etc/.rccode

#
# vip1_v2
#
titan-release-vip1_v2:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_vip2 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/aotom_vip/aotom.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
#	$(SILENT)rm -f $(RELEASE_DIR)/lib/firmware/dvb-fe-{avl2108,avl6222,cx24116,cx21143,stv6306}.fw
#	$(SILENT)cp -f $(SKEL_ROOT)/release/fstab_vip2 $(RELEASE_DIR)/var/etc/fstab
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_vip_rc12.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)cp -f $(TARGET_DIR)/sbin/shutdown $(RELEASE_DIR)/sbin/
	$(SILENT)mkdir -p $(RELEASE_DIR)/var/run/lirc
	$(SILENT)rm -f $(RELEASE_DIR)/bin/vdstandby
	$(SILENT)touch $(RELEASE_DIR)/var/etc/.rccode
	$(SILENT)echo "1" > $(RELEASE_DIR)/var/etc/.rccode

#
# vip2
#
titan-release-vip2: titan-release-vip1_v2
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_vip_rc12.conf $(RELEASE_DIR)/etc/lircd.conf
	$(SILENT)touch $(RELEASE_DIR)/var/etc/.rccode
	$(SILENT)echo "1" > $(RELEASE_DIR)/var/etc/.rccode

#
# pace7241
#
titan-release-pace7241:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_ufs912 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-sti7105.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/pace_7241_fp/pace_7241_fp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)[ -e $(SKEL_ROOT)/release/fe_core_pace7241$(KERNEL_STM_LABEL).ko ] && cp $(SKEL_ROOT)/release/fe_core_space7241$(KERNEL_STM_LABEL).ko $(RELEASE_DIR)/lib/modules/fe_core.ko || true
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7105.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7105.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl6222.fw $(RELEASE_DIR)/lib/firmware/
	$(SILENT)cp $(SKEL_ROOT)/firmware/component_7105_pdk7105.fw $(RELEASE_DIR)/lib/firmware/component.fw
	$(SILENT)cp -dp $(SKEL_ROOT)/release/lircd_pace7241.conf $(RELEASE_DIR)/etc/lircd.conf

#
# opt9600
#
titan-release-opt9600:
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/halt_opt9600 $(RELEASE_DIR)/etc/init.d/halt
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontcontroller/opt9600_fp/opt9600_fp.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/frontends/*.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/stgfb/stmfb/stmcore-display-stx7109c3.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)cp $(SKEL_ROOT)/boot/video_7109.elf $(RELEASE_DIR)/boot/video.elf
	$(SILENT)cp $(SKEL_ROOT)/boot/audio_7109.elf $(RELEASE_DIR)/boot/audio.elf
	$(SILENT)cp $(SKEL_ROOT)/firmware/dvb-fe-avl2108.fw $(RELEASE_DIR)/lib/firmware/

#
# titan-release-base
#
# the following target creates the common file base
titan-release-base:
	$(SILENT)echo "=============================================================="
	$(SILENT)echo
	$(SILENT)echo -e "Start build of $(TERM_GREEN_BOLD)titan_release$(TERM_NORMAL)."
	$(SILENT)rm -rf $(RELEASE_DIR) || true
	$(SILENT)echo -n "Copying image to release directory..."
	$(SILENT)install -d $(RELEASE_DIR)
	$(SILENT)install -d $(RELEASE_DIR)/{bin,boot,dev,dev.static,etc,home,lib,mnt,proc,ram,sbin,swap,sys,tmp,usr,var}
	$(SILENT)install -d $(RELEASE_DIR)/etc/{init.d,mdev,ssl,titan.restore,tpk.restore,tuxtxt}
	$(SILENT)install -d $(RELEASE_DIR)/etc/titan.restore/mnt/{config,network,settings}
	$(SILENT)install -d $(RELEASE_DIR)/etc/titan.restore/var/etc/{autostart,boot,ipkg,network,titan,tuxbox}
	$(SILENT)install -d $(RELEASE_DIR)/lib/{autofs,firmware,gio,lsb,modules,titan,udev}
#	$(SILENT)install -d $(RELEASE_DIR)/lib/titan/default/skin
	$(SILENT)install -d $(RELEASE_DIR)/mnt/{bin,config,logs,network,script,settings,swapextensions,tpk}
	$(SILENT)install -d $(RELEASE_DIR)/mnt/swapextensions/{bin,boot,etc,keys,lib,usr}
	$(SILENT)install -d $(RELEASE_DIR)/mnt/swapextensions/lib/modules
	$(SILENT)install -d $(RELEASE_DIR)/tmp/{bsubsys,tithek}
	$(SILENT)install -d $(RELEASE_DIR)/usr/{bin,local,sbin,share,tuxtxt}
	$(SILENT)install -d $(RELEASE_DIR)/usr/local/{bin,sbin}
	$(SILENT)install -d $(RELEASE_DIR)/usr/share/{udhcpc,zoneinfo}
	$(SILENT)install -d $(RELEASE_DIR)/var/{bin,boot,etc,lib,media,root,update,usr}
	$(SILENT)install -d $(RELEASE_DIR)/var/etc/{autostart,boot,codepages,ipkg,network,titan,tuxbox,Wireless}
	$(SILENT)install -d $(RELEASE_DIR)/var/lib/{init,modules,nfs}
	$(SILENT)install -d $(RELEASE_DIR)/var/media/{autofs,hdd,net}
	$(SILENT)install -d $(RELEASE_DIR)/var/usr/{lib,local,share}
	$(SILENT)install -d $(RELEASE_DIR)/var/usr/lib/{directfb-1.4-5,ipkg,locale}
	$(SILENT)install -d $(RELEASE_DIR)/var/usr/local/share
	$(SILENT)install -d $(RELEASE_DIR)/var/usr/local/share/titan
	$(SILENT)install -d $(RELEASE_DIR)/var/usr/local/share/titan/{help,netsurf,picons,plugins,po}
	$(SILENT)install -d $(RELEASE_DIR)/var/usr/share/fonts
	$(SILENT)ln -sf /var/media/hdd $(RELEASE_DIR)/hdd
# /
	$(SILENT)ln -s /media/autofs $(RELEASE_DIR)/autofs
	$(SILENT)ln -s /var/media $(RELEASE_DIR)/media
	$(SILENT)ln -s /var/root $(RELEASE_DIR)/root
#	$(SILENT)ln -s /usr/share $(RELEASE_DIR)/share
#	$(SILENT)ln -s /usr/share $(RELEASE_DIR)/usr/local/share
#	$(SILENT)ln -s /etc $(RELEASE_DIR)/usr/local/etc
	$(SILENT)mkdir -p $(RELEASE_DIR)/etc/rc.d/rc0.d
	$(SILENT)ln -s ../init.d/sendsigs $(RELEASE_DIR)/etc/rc.d/rc0.d/S20sendsigs
	$(SILENT)ln -s ../init.d/umountfs $(RELEASE_DIR)/etc/rc.d/rc0.d/S40umountfs
	$(SILENT)ln -s ../init.d/halt $(RELEASE_DIR)/etc/rc.d/rc0.d/S90halt
	$(SILENT)mkdir -p $(RELEASE_DIR)/etc/rc.d/rc6.d
	$(SILENT)ln -s ../init.d/sendsigs $(RELEASE_DIR)/etc/rc.d/rc6.d/S20sendsigs
	$(SILENT)ln -s ../init.d/umountfs $(RELEASE_DIR)/etc/rc.d/rc6.d/S40umountfs
	$(SILENT)ln -s ../init.d/reboot $(RELEASE_DIR)/etc/rc.d/rc6.d/S90reboot
#	$(SILENT)ln -sf /usr/share/tuxbox/titan/icons/logo $(RELEASE_DIR)/logos
#	$(SILENT)ln -sf /usr/share/tuxbox/titan/icons/logo $(RELEASE_DIR)/var/httpd/logos
#
# /bin
	$(SILENT)cp -a $(TARGET_DIR)/bin/* $(RELEASE_DIR)/bin/
##	$(SILENT)cp -aR $(SKEL_ROOT)/root_titan/bin/* $(RELEASE_DIR)/bin
# /etc
##	$(SILENT)cp -aR $(SKEL_ROOT)/root_titan/etc/* $(RELEASE_DIR)/etc
	$(SILENT)echo "sh4" > $(RELEASE_DIR)/etc/.arch
	$(SILENT)echo "openAAF" > $(RELEASE_DIR)/etc/.buildgroup
	$(SILENT)touch $(RELEASE_DIR)/etc/.firstboot
	$(SILENT)touch $(RELEASE_DIR)/etc/.player3
	$(SILENT)touch $(RELEASE_DIR)/etc/.sh4
#	$(SILENT)touch $(RELEASE_DIR)/etc/.stable
# /etc/titan.restore
##	$(SILENT)cp -f $(SKEL_ROOT)/root_titan/mnt/config/* $(RELEASE_DIR)/etc/titan.restore/mnt/config/
##	$(SILENT)cp -f $(SKEL_ROOT)/root_titan/mnt/settings/* $(RELEASE_DIR)/etc/titan.restore/mnt/settings/
##	$(SILENT)cp -f $(SKEL_ROOT)/root_titan/var/etc/autostart/* $(RELEASE_DIR)/etc/titan.restore/var/etc/autostart/
##	$(SILENT)cp -f $(SKEL_ROOT)/root_titan/var/etc/boot/* $(RELEASE_DIR)/etc/titan.restore/var/etc/boot/
##	$(SILENT)cp -f $(SKEL_ROOT)/root_titan/var/etc/ipkg/* $(RELEASE_DIR)/etc/titan.restore/var/etc/ipkg/
# /lib
	$(SILENT)cp -R $(TARGET_DIR)/lib/* $(RELEASE_DIR)/lib/
	$(SILENT)rm -f $(TARGET_DIR)/usr/lib/libdl.so
	$(SILENT)rm -f $(TARGET_DIR)/usr/lib/libm.so
	$(SILENT)rm -f $(TARGET_DIR)/usr/lib/libresolv.so
	$(SILENT)rm -f $(TARGET_DIR)/usr/lib/librt.so
	$(SILENT)rm -f $(TARGET_DIR)/usr/lib/libutil.so
	$(SILENT)cp -a $(TARGET_DIR)/usr/lib/* $(RELEASE_DIR)/lib/
	$(SILENT)cp -a $(TARGET_DIR)/usr/lib/autofs/* $(RELEASE_DIR)/lib/autofs/
#	$(SILENT)ln -sf $(RELEASE_DIR)/lib/libjpeg.so.62.3.0 $(RELEASE_DIR)/lib/libjpeg.so.8
# /mnt
	$(SILENT)cp -f $(SKEL_ROOT)/etc/{auto.misc,hostname,hosts,passwd,resolv.conf} $(RELEASE_DIR)/mnt/network
	$(SILENT)touch $(RELEASE_DIR)/mnt/network/wpa_supplicant.conf
##	$(SILENT)cp -f $(SKEL_ROOT)/root_titan/mnt/default_gw $(RELEASE_DIR)/mnt/network
	$(SILENT)cp -f $(SKEL_ROOT)/etc/network/* $(RELEASE_DIR)/mnt/network
# /mnt/config
##	$(SILENT)cp -f $(SKEL_ROOT)/root_titan/mnt/config/* $(RELEASE_DIR)/mnt/config/
# /mnt/settings
##	$(SILENT)cp -f $(SKEL_ROOT)/root_titan/mnt/settings/* $(RELEASE_DIR)/mnt/settings/
# /sbin
	$(SILENT)cp -a $(TARGET_DIR)/sbin/* $(RELEASE_DIR)/sbin/
##	$(SILENT)cp -aR $(SKEL_ROOT)/root_titan/sbin/* $(RELEASE_DIR)/sbin
# /usr/bin
	$(SILENT)cp -a $(TARGET_DIR)/usr/bin/* $(RELEASE_DIR)/usr/bin/
# /usr/lib
#	$(SILENT)ln -sf /usr/lib $(RELEASE_DIR)/var/usr/lib/
# /usr/sbin
	$(SILENT)cp -a $(TARGET_DIR)/usr/sbin/* $(RELEASE_DIR)/usr/sbin/
# /var/bin
	$(SILENT)cp -f $(TARGET_DIR)/usr/bin/curl $(RELEASE_DIR)/var/bin
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), ufs910 ufs922))
	$(SILENT)cp -f $(TARGET_DIR)/sbin/jfs_fsck $(RELEASE_DIR)/var/bin
endif
# /var/etc
	$(SILENT)touch $(RELEASE_DIR)/var/etc/.first
	$(SILENT)touch $(RELEASE_DIR)/var/etc/inadyn.conf
	$(SILENT)touch $(RELEASE_DIR)/var/etc/inetd.conf
	$(SILENT)echo "4" > $(RELEASE_DIR)/var/etc/sleep
	$(SILENT)cp -f $(SKEL_ROOT)/etc/fstab $(RELEASE_DIR)/var/etc/fstab
	$(SILENT)cp -f $(SKEL_ROOT)/etc/samba/smb.conf $(RELEASE_DIR)/var/etc/
	$(SILENT)cp -f $(TARGET_DIR)/etc/{auto.hotplug,auto.master,group,host.conf,localtime,passwd,profile,protocols,resolv.conf,services,shells,shells.conf,timezone.xml,vdstandby.cfg,vsftpd.conf} $(RELEASE_DIR)/var/etc/
	$(SILENT)echo "576i50" > $(RELEASE_DIR)/var/etc/videomode
# /var/etc/network
	$(SILENT)cp -f $(SKEL_ROOT)/etc/network/options $(RELEASE_DIR)/var/etc/network/
	$(SILENT)cp -f $(SKEL_ROOT)/etc/network/interfaces $(RELEASE_DIR)/var/etc/network
	$(SILENT)mkdir $(RELEASE_DIR)/var/etc/network/{if-down.d,if-post-down.d,if-post-up.d,if-pre-down.d,if-pre-up.d,if-up.d}
# /var/usr/lib
##ifeq ($(MEDIAFW), $(filter $(MEDIAFW), eplayer3 gst-eplayer3 gst-eplayer3-dual))
##	$(SILENT)mv $(RELEASE_DIR)/lib/libavcodec* $(RELEASE_DIR)/var/usr/lib/
##endif
##	$(SILENT)mv $(RELEASE_DIR)/lib/libdvdnav* $(RELEASE_DIR)/var/usr/lib/
##	$(SILENT)mv $(RELEASE_DIR)/lib/libdvdread* $(RELEASE_DIR)/var/usr/lib/
##ifeq ($(MEDIAFW), $(filter $(MEDIAFW), eplayer3 gst-eplayer3 gst-eplayer3-dual))
##	$(SILENT)mv $(RELEASE_DIR)/lib/libeplayer3* $(RELEASE_DIR)/var/usr/lib/
##endif
# /var/usr/local/share/titan/help
	$(SILENT)cp -rf $(SOURCE_DIR)/svn/titan/help/ $(RELEASE_DIR)/var/usr/local/share/titan/
# /var/usr/local/share/titan/po
	$(SILENT)cp -rf $(SOURCE_DIR)/svn/titan/po/ $(RELEASE_DIR)/var/usr/local/share/titan/
# uImage
	$(SILENT)cp $(TARGET_DIR)/boot/$(KERNELNAME) $(RELEASE_DIR)/boot/
	$(SILENT)ln -sf /proc/mounts $(RELEASE_DIR)/etc/mtab
	$(SILENT)cp -dp $(SKEL_ROOT)/sbin/MAKEDEV $(RELEASE_DIR)/sbin/
	$(SILENT)ln -sf ../sbin/MAKEDEV $(RELEASE_DIR)/dev/MAKEDEV
	$(SILENT)ln -sf ../../sbin/MAKEDEV $(RELEASE_DIR)/lib/udev/MAKEDEV
	$(SILENT)cp -aR $(SKEL_ROOT)/etc/mdev/* $(RELEASE_DIR)/etc/mdev/
	$(SILENT)cp -aR $(SKEL_ROOT)/etc/mdev.conf $(RELEASE_DIR)/etc/mdev.conf
	$(SILENT)cp -aR $(SKEL_ROOT)/usr/share/udhcpc/* $(RELEASE_DIR)/usr/share/udhcpc/
	$(SILENT)cp -aR $(SKEL_ROOT)/usr/share/zoneinfo/* $(RELEASE_DIR)/usr/share/zoneinfo/
	$(SILENT)cp $(SKEL_ROOT)/bin/autologin $(RELEASE_DIR)/bin/
	$(SILENT)cp $(SKEL_ROOT)/bin/vdstandby $(RELEASE_DIR)/bin/
	$(SILENT)cp $(SKEL_ROOT)/usr/sbin/fw_printenv $(RELEASE_DIR)/usr/sbin/
	$(SILENT)cp -aR $(TARGET_DIR)/etc/init.d/* $(RELEASE_DIR)/etc/init.d/
	$(SILENT)cp -aR $(TARGET_DIR)/etc/* $(RELEASE_DIR)/etc/
	$(SILENT)rmdir --ignore-fail-on-non-empty $(RELEASE_DIR)/etc/network
	$(SILENT)echo "$(BOXTYPE)" > $(RELEASE_DIR)/etc/model
	$(SILENT)echo "$(BOXTYPE)" > $(RELEASE_DIR)/mnt/network/hostname
	$(SILENT)ln -sf ../../bin/busybox $(RELEASE_DIR)/usr/bin/ether-wake
#	$(SILENT)ln -sf ../../bin/showiframe $(RELEASE_DIR)/usr/bin/showiframe
	$(SILENT)ln -sf ../../usr/sbin/fw_printenv $(RELEASE_DIR)/usr/sbin/fw_setenv
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), hs8200 fs9000 hs9510 ufs910 ufs912 ufs913 ufs922 ufc960 spark ipbox55 ipbox99 ipbox9900 cuberevo cuberevo_mini cuberevo_mini2 cuberevo_250hd cuberevo_2000hd cuberevo_3000hd adb_box tf7700 vitamin_hd5000))
	$(SILENT)cp $(SKEL_ROOT)/release/fw_env.config_$(BOXTYPE) $(RELEASE_DIR)/var/etc/fw_env.config
endif
	$(SILENT)install -m 0755 $(SKEL_ROOT)/release/rcS_titan_$(BOXTYPE) $(RELEASE_DIR)/etc/init.d/rcS
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
# multicom
#
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshell/embxshell.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshell/embxshell.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxmailbox/embxmailbox.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxmailbox/embxmailbox.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshm/embxshm.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/embxshm/embxshm.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/mme/mme_host.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/multicom/mme/mme_host.ko $(RELEASE_DIR)/lib/modules/ || true
#
#
#
	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/simu_button/simu_button.ko $(RELEASE_DIR)/lib/modules/
	$(SILENT)if [ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cic ]; then \
		cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cic/*.ko $(RELEASE_DIR)/lib/modules/ ; \
	fi
#ifneq ($(BOXTYPE), $(filter $(BOXTYPE), cuberevo_mini_fta cuberevo_250hd vip2 spark spark7162 adb_box adb_2850 sagemcom88 pace7241))
#	$(SILENT)cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra/cic/*.ko $(RELEASE_DIR)/lib/modules/
#endif
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
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/jfs/jfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/jfs/jfs.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfsd/nfsd.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfsd/nfsd.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/exportfs/exportfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/exportfs/exportfs.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs_common/nfs_acl.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs_common/nfs_acl.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs/nfs.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/fs/nfs/nfs.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/usbserial.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/usbserial.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/ftdi_sio.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/ftdi_sio.ko $(RELEASE_DIR)/lib/modules/ftdi.ko || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/pl2303.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/pl2303.ko $(RELEASE_DIR)/lib/modules/ || true
	$(SILENT)[ -e $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/ch341.ko ] && cp $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/kernel/drivers/usb/serial/ch341.ko $(RELEASE_DIR)/lib/modules/ || true
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
ifeq ($(IMAGE), titan-wlandriver)
	$(SILENT)install -d $(RELEASE_DIR)/etc/Wireless
	$(SILENT)cp -aR $(SKEL_ROOT)/firmware/Wireless/* $(RELEASE_DIR)/var/etc/Wireless/
	$(SILENT)cp -aR $(SKEL_ROOT)/firmware/rtlwifi $(RELEASE_DIR)/var/lib/firmware/
	$(SILENT)cp -aR $(SKEL_ROOT)/firmware/*.bin $(RELEASE_DIR)/var/lib/firmware/
endif
#
# /lib, /var/usr/lib
#
#	$(SILENT)cp -R $(TARGET_DIR)/lib/* $(RELEASE_DIR)/lib/
	$(SILENT)rm -f $(RELEASE_DIR)/lib/*.{a,o,la}
#	$(SILENT)cp -f $(TARGET_DIR)/usr/lib/libav* $(RELEASE_DIR)/lib
	$(SILENT)chmod 755 $(RELEASE_DIR)/lib/*
#	$(SILENT)ln -s /var/tuxbox/plugins/libfx2.so $(RELEASE_DIR)/lib/libfx2.so
#	$(SILENT)cp -R $(TARGET_DIR)/usr/lib/* $(RELEASE_DIR)/var/usr/lib/
	$(SILENT)rm -rf $(RELEASE_DIR)/var/usr/lib/{engines,gconv,libxslt-plugins,pkgconfig,python$(PYTHON_VER),sigc++-2.0}
	$(SILENT)rm -f $(RELEASE_DIR)/var/usr/lib/*.{a,o,la}
##ifeq ($(MEDIAFW), $(filter $(MEDIAFW), eplayer3 gst-eplayer3 gst-eplayer3-dual))
##	$(SILENT)ln -sf /var/usr/lib/libavcodec.so.57.107.100 $(RELEASE_DIR)/lib/libavcodec.so
##	$(SILENT)ln -sf /var/usr/lib/libavcodec.so.57.107.100 $(RELEASE_DIR)/lib/libavcodec.so.57
##	$(SILENT)ln -sf /var/usr/lib/libavcodec.so.57.107.100 $(RELEASE_DIR)/lib/libavcodec.so.57.100
##endif
##	$(SILENT)ln -sf /var/usr/lib/libdvdnav.so.4.1.2 $(RELEASE_DIR)/lib/libdvdnav.so
##	$(SILENT)ln -sf /var/usr/lib/libdvdnav.so.4.1.2 $(RELEASE_DIR)/lib/libdvdnav.so.4
##	$(SILENT)ln -sf /var/usr/lib/libdvdnav.so.4.1.2 $(RELEASE_DIR)/lib/libdvdnav.so.4.1.2
##	$(SILENT)ln -sf /var/usr/lib/libdvdnavmini.so.4.1.2 $(RELEASE_DIR)/lib/libdvdnavmini.so
##	$(SILENT)ln -sf /var/usr/lib/libdvdnavmini.so.4.1.2 $(RELEASE_DIR)/lib/libdvdnavmini.so.4
##	$(SILENT)ln -sf /var/usr/lib/libdvdnavmini.so.4.1.2 $(RELEASE_DIR)/lib/libdvdnavmini.so.4.1.2
##	$(SILENT)ln -sf /var/usr/lib/libdvdread.so.4.1.2 $(RELEASE_DIR)/lib/libdvdread.so
##	$(SILENT)ln -sf /var/usr/lib/libdvdread.so.4.1.2 $(RELEASE_DIR)/lib/libdvdread.so.4
##	$(SILENT)ln -sf /var/usr/lib/libdvdread.so.4.1.2 $(RELEASE_DIR)/lib/libdvdread.so.4.1.2
##ifeq ($(MEDIAFW), $(filter $(MEDIAFW), eplayer3 gst-eplayer3 gst-eplayer3-dual))
##	$(SILENT)ln -sf /var/usr/lib/libeplayer3.so.0.0.0 $(RELEASE_DIR)/lib/libeplayer3.so
##	$(SILENT)ln -sf /var/usr/lib/libeplayer3.so.0.0.0 $(RELEASE_DIR)/lib/libeplayer3.so.0
##	$(SILENT)ln -sf /var/usr/lib/libeplayer3.so.0.0.0 $(RELEASE_DIR)/lib/libeplayer3.so.0.0.0
##endif
#	$(SILENT)chmod 755 $(RELEASE_DIR)/var/usr/lib/*
#
# fonts
#
#	if [ -e $(TARGET_DIR)/usr/share/fonts/titan.ttf ]; then \
#		cp -aR $(TARGET_DIR)/usr/share/fonts/titan.ttf $(RELEASE_DIR)/usr/share/fonts; \
#	fi; \
#	if [ -e $(TARGET_DIR)/usr/share/fonts/micron.ttf ]; then \
#		cp -aR $(TARGET_DIR)/usr/share/fonts/micron.ttf $(RELEASE_DIR)/usr/share/fonts; \
#	fi; \
#	if [ -e $(TARGET_DIR)/usr/share/fonts/DejaVuLGCSansMono-Bold.ttf ]; then \
#		cp -aR $(TARGET_DIR)/usr/share/fonts/DejaVuLGCSansMono-Bold.ttf $(RELEASE_DIR)/usr/share/fonts; \
#		ln -s /usr/share/fonts/DejaVuLGCSansMono-Bold.ttf $(RELEASE_DIR)/usr/share/fonts/tuxtxt.ttf; \
#	else \
#		cp -aR $(TARGET_DIR)/usr/share/fonts/tuxtxt.ttf $(RELEASE_DIR)/usr/share/fonts; \
#	fi
	$(SILENT)cp -aR $(SKEL_ROOT)/usr/share/fonts/lcd.ttf $(RELEASE_DIR)/var/usr/share/fonts
	$(SILENT)cp -aR $(SKEL_ROOT)/usr/share/fonts/Symbols.ttf $(RELEASE_DIR)/var/usr/share/fonts
	$(SILENT)cp -aR $(SKEL_ROOT)/usr/share/fonts/tuxtxt.ttf $(RELEASE_DIR)/var/usr/share/fonts
#	$(SILENT)ln -s /var/usr/share/fonts/default.tff $(RELEASE_DIR)/var/usr/share/fonts/FreeSans.ttf
#
# titan
#
	$(SILENT)if [ -e $(TARGET_DIR)/usr/local/bin/titan ]; then \
		cp $(TARGET_DIR)/usr/local/bin/titan $(RELEASE_DIR)/usr/local/bin/; \
	fi
#	$(SILENT)if [ -e $(TARGET_DIR)/usr/local/bin/pzapit ]; then \
#		cp $(TARGET_DIR)/usr/local/bin/pzapit $(RELEASE_DIR)/usr/bin/; \
#	fi
#	$(SILENT)if [ -e $(TARGET_DIR)/usr/local/bin/sectionsdcontrol ]; then \
#		cp $(TARGET_DIR)/usr/local/bin/sectionsdcontrol $(RELEASE_DIR)/usr/bin/; \
#	fi
#	$(SILENT)if [ -e $(TARGET_DIR)/usr/local/bin/install.sh ]; then \
#		cp $(TARGET_DIR)/usr/local/bin/install.sh $(RELEASE_DIR)/bin/; \
#	fi
#
# channellist / tuxtxt
#
#	$(SILENT)cp -aR $(TARGET_DIR)/var/tuxbox/config/* $(RELEASE_DIR)/var/tuxbox/config
#
#
#
	$(SILENT)rm -fRd $(RELEASE_DIR)/etc/network
#
# copy root_titan
#
# /bin
##	$(SILENT)cp -aR $(SKEL_ROOT)/root_titan/bin/* $(RELEASE_DIR)/bin
#	$(SILENT)ln -sf /sbin/abfrage $(RELEASE_DIR)/bin/abfrage
#	$(SILENT)ln -sf /sbin/backup.sh $(RELEASE_DIR)/bin/backup.sh
#	$(SILENT)ln -sf /sbin/bitrate $(RELEASE_DIR)/bin/bitrate
#	$(SILENT)ln -sf /sbin/checknet $(RELEASE_DIR)/bin/checknet
#	$(SILENT)ln -sf /sbin/cmd.sh $(RELEASE_DIR)/bin/cmd.sh
#	$(SILENT)ln -sf /sbin/create_mvi.sh $(RELEASE_DIR)/bin/create_mvi.sh
#	$(SILENT)ln -sf /sbin/curlftpfs $(RELEASE_DIR)/bin/curlftpfs
#	$(SILENT)ln -sf /sbin/djmount $(RELEASE_DIR)/bin/djmount
#	$(SILENT)ln -sf /sbin/emu.sh $(RELEASE_DIR)/bin/emu.sh
#	$(SILENT)ln -sf /sbin/ether-wake.sh $(RELEASE_DIR)/bin/ether-wake.sh
#	$(SILENT)ln -sf /sbin/flashcp $(RELEASE_DIR)/bin/flashcp
#	$(SILENT)ln -sf /sbin/flash_eraseall $(RELEASE_DIR)/bin/flash_eraseall
#	$(SILENT)ln -sf /sbin/flashutil $(RELEASE_DIR)/bin/flashutil
#	$(SILENT)ln -sf /sbin/getfreespace $(RELEASE_DIR)/bin/getfreespace
#	$(SILENT)ln -sf /sbin/getip $(RELEASE_DIR)/bin/getip
#	$(SILENT)ln -sf /sbin/gotnetlink $(RELEASE_DIR)/bin/gotnetlink
#	$(SILENT)ln -sf /sbin/grab $(RELEASE_DIR)/bin/grab
#	$(SILENT)ln -sf /sbin/grab.sh $(RELEASE_DIR)/bin/grab.sh
#	$(SILENT)ln -sf /sbin/hd-idle $(RELEASE_DIR)/bin/hd-idle
#	$(SILENT)ln -sf /sbin/hotplug $(RELEASE_DIR)/bin/hotplug
#	$(SILENT)ln -sf /sbin/hotplug.sh $(RELEASE_DIR)/bin/hotplug.sh
#	$(SILENT)ln -sf /sbin/ifmetric $(RELEASE_DIR)/bin/ifmetric
#	$(SILENT)ln -sf /sbin/inadyn $(RELEASE_DIR)/bin/inadyn
#	$(SILENT)ln -sf /sbin/jpegtran $(RELEASE_DIR)/bin/jpegtran
#	$(SILENT)ln -sf /sbin/mkfs.info $(RELEASE_DIR)/bin/mkfs.info
#	$(SILENT)ln -sf /sbin/mount.sh $(RELEASE_DIR)/bin/mount.sh
#	$(SILENT)ln -sf /sbin/nandwrite $(RELEASE_DIR)/bin/nandwrite
#	$(SILENT)ln -sf /sbin/netspeed $(RELEASE_DIR)/bin/netspeed
#	$(SILENT)ln -sf /sbin/netspeed2 $(RELEASE_DIR)/bin/netspeed2
#	$(SILENT)ln -sf /sbin/ntfsmount $(RELEASE_DIR)/bin/ntfsmount
#	$(SILENT)ln -sf /sbin/parter.sh $(RELEASE_DIR)/bin/parter.sh
#	$(SILENT)ln -sf /sbin/pin $(RELEASE_DIR)/bin/pin
#	$(SILENT)ln -sf /sbin/pmap_dump $(RELEASE_DIR)/bin/pmap_dump
#	$(SILENT)ln -sf /sbin/pmap_set $(RELEASE_DIR)/bin/pmap_set
#	$(SILENT)ln -sf /sbin/rarfs $(RELEASE_DIR)/bin/rarfs
#	$(SILENT)ln -sf /sbin/repairjffs2.sh $(RELEASE_DIR)/bin/repairjffs2.sh
#	$(SILENT)ln -sf /sbin/reset.sh $(RELEASE_DIR)/bin/reset.sh
#	$(SILENT)ln -sf /sbin/sdparm $(RELEASE_DIR)/bin/sdparm
#	$(SILENT)ln -sf /sbin/settings.sh $(RELEASE_DIR)/bin/settings.sh
#	$(SILENT)ln -sf /sbin/sleepms $(RELEASE_DIR)/bin/sleepms
#	$(SILENT)ln -sf /sbin/smbclient $(RELEASE_DIR)/bin/smbclient
#	$(SILENT)ln -sf /sbin/start-function $(RELEASE_DIR)/bin/start-function
#	$(SILENT)ln -sf /sbin/start_sec.sh $(RELEASE_DIR)/bin/start_sec.sh
#	$(SILENT)ln -sf /sbin/swap.sh $(RELEASE_DIR)/bin/swap.sh
#	$(SILENT)ln -sf /sbin/sync-rcconfig.sh $(RELEASE_DIR)/bin/sync-rcconfig.sh
#	$(SILENT)ln -sf /sbin/sync-start-config.sh $(RELEASE_DIR)/bin/sync-start-config.sh
#	$(SILENT)ln -sf /sbin/sync-titan-config.sh $(RELEASE_DIR)/bin/sync-titan-config.sh
#	$(SILENT)ln -sf /sbin/sysinfo.sh $(RELEASE_DIR)/bin/sysinfo.sh
#	$(SILENT)ln -sf /sbin/tar.info $(RELEASE_DIR)/bin/tar.info
#	$(SILENT)ln -sf /sbin/tuxtxt.sh $(RELEASE_DIR)/bin/tuxtxt.sh
#	$(SILENT)ln -sf /sbin/update.sh $(RELEASE_DIR)/bin/update.sh
#	$(SILENT)ln -sf /sbin/usbspeed.sh $(RELEASE_DIR)/bin/usbspeed.sh
#	$(SILENT)ln -sf /sbin/wget.info $(RELEASE_DIR)/bin/wget.info
#	$(SILENT)mv -f $(RELEASE_DIR)/usr/bin/eplayer3 $(RELEASE_DIR)/bin
# /etc
#	$(SILENT)ln -sf /var/etc/Wireless $(RELEASE_DIR)/etc/Wireless
#	$(SILENT)ln -sf /var/etc/ddsubt $(RELEASE_DIR)/etc/ddsubt
#	$(SILENT)ln -sf /mnt/network/default_gw $(RELEASE_DIR)/etc/default_gw
#	$(SILENT)ln -sf /mnt/config/exports $(RELEASE_DIR)/etc/exports
#	$(SILENT)ln -sf /var/etc/fstab $(RELEASE_DIR)/etc/fstab
#	$(SILENT)ln -sf /var/etc/fw_env.config $(RELEASE_DIR)/etc/fw_env.config
#	$(SILENT)ln -sf /var/etc/group $(RELEASE_DIR)/etc/group
#	$(SILENT)ln -sf /var/etc/host.conf $(RELEASE_DIR)/etc/host.conf
#	$(SILENT)ln -sf /mnt/network/hostname $(RELEASE_DIR)/etc/hostname
#	$(SILENT)ln -sf /mnt/network/etc/hosts $(RELEASE_DIR)/etc/hosts
#	$(SILENT)ln -sf /var/etc/inetd.conf $(RELEASE_DIR)/etc/inetd.conf
#	$(SILENT)ln -sf /var/etc/ipkg $(RELEASE_DIR)/etc/ipkg
#	$(SILENT)ln -sf /var/etc/localtime $(RELEASE_DIR)/etc/localtime
#	$(SILENT)ln -sf /proc/mounts $(RELEASE_DIR)/etc/mtab
#	$(SILENT)ln -sf /var/etc/network $(RELEASE_DIR)/etc/network
#	$(SILENT)ln -sf /mnt/network/passwd $(RELEASE_DIR)/etc/passwd
#	$(SILENT)ln -sf /var/etc/profile $(RELEASE_DIR)/etc/profile
#	$(SILENT)ln -sf /var/etc/protocols $(RELEASE_DIR)/etc/protocols
#	$(SILENT)ln -sf /mnt/network/resolv.conf $(RELEASE_DIR)/etc/resolv.conf
#	$(SILENT)ln -sf /var/etc/services $(RELEASE_DIR)/etc/services
#	$(SILENT)ln -sf /var/etc/shells $(RELEASE_DIR)/etc/shells
#	$(SILENT)ln -sf /var/etc/shells.conf $(RELEASE_DIR)/etc/shells.conf
#	$(SILENT)ln -sf /var/etc/timezone.xml $(RELEASE_DIR)/etc/timezone.xml
#	$(SILENT)ln -sf /var/etc/vdstandby.cfg $(RELEASE_DIR)/etc/vdstandby.cfg
#	$(SILENT)ln -sf /var/etc/videomode $(RELEASE_DIR)/etc/videomode
#	$(SILENT)ln -sf /mnt/network/wpa_supplicant.conf $(RELEASE_DIR)/etc/wpa_supplicant.conf
# /sbin
#	$(SILENT)ln -sf /sbin/fsck.info $(RELEASE_DIR)/sbin/fsck.ext2.gui
#	$(SILENT)ln -sf /sbin/fsck.info $(RELEASE_DIR)/sbin/fsck.ext3.gui
#	$(SILENT)ln -sf /sbin/fsck.info $(RELEASE_DIR)/sbin/fsck.ext4,gui
#	$(SILENT)ln -sf /sbin/fsck.info $(RELEASE_DIR)/sbin/fsck.fat.gui
#	$(SILENT)ln -sf /sbin/fsck.info $(RELEASE_DIR)/sbin/fsck.jfs.gui
#	$(SILENT)ln -sf /sbin/fw_printenv $(RELEASE_DIR)/sbin/fw_setenv
#	$(SILENT)ln -sf /sbin/mkfs.info $(RELEASE_DIR)/sbin/mkfs.ext2.gui
#	$(SILENT)ln -sf /sbin/mkfs.info $(RELEASE_DIR)/sbin/mkfs.ext3.gui
#	$(SILENT)ln -sf /sbin/mkfs.info $(RELEASE_DIR)/sbin/mkfs.ext4.gui
#	$(SILENT)ln -sf /sbin/mkfs.info $(RELEASE_DIR)/sbin/mkfs.fat.gui
#	$(SILENT)ln -sf /sbin/mkfs.info $(RELEASE_DIR)/sbin/mkfs.jfs.gui
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_titan/boot/* $(RELEASE_DIR)/boot
# /lib
##	$(SILENT)cp -aR $(SKEL_ROOT)/root_titan/lib/* $(RELEASE_DIR)/lib
#	$(SILENT)ln -sf /tmp $(RELEASE_DIR)/lib/init
#	$(SILENT)ln -sf /usr/share/fonts $(RELEASE_DIR)/lib/fonts
# /etc
##	$(SILENT)cp -aR $(SKEL_ROOT)/root_titan/sbin/* $(RELEASE_DIR)/sbin
#	echo "oops"
#	$(SILENT)ln -sf /usr/share $(RELEASE_DIR)/usr/local/share
#	echo "oops"
#	$(SILENT)ln -sf /var/etc/codepages $(RELEASE_DIR)/usr/codepages
	$(SILENT)ln -sf /var/lib/splash $(RELEASE_DIR)/lib/splash
#	$(SILENT)ln -sf /var/usr/lib $(RELEASE_DIR)/usr/lib
	$(SILENT)ln -sf /var/usr/lib/ipkg $(RELEASE_DIR)/lib/ipkg
	$(SILENT)ln -sf /var/lib/lsb $(RELEASE_DIR)/lib/lsb/lsb
	$(SILENT)ln -sf /usr/share/fonts $(RELEASE_DIR)/lib/fonts
#	$(SILENT)ln -sf /var/usr/share/fonts $(RELEASE_DIR)/usr/share/fonts
#	$(SILENT)ln -sf /var/usr/share/gmediarender $(RELEASE_DIR)/usr/share/gmediarender
#	$(SILENT)ln -sf /var/usr/share/netsurf $(RELEASE_DIR)/usr/share/netsurf
##	$(SILENT)cp -aR $(SKEL_ROOT)/root_titan/var/* $(RELEASE_DIR)/var/
#ifeq ($(BOXTYPE), $(filter $(BOXTYPE), hs8200 spark7162 cuberevo cuberevo_mini cuberevo_mini2 cuberevo_3000hd))
#	$(SILENT)rm -f $(RELEASE_DIR)/var/tuxbox/config/cables.xml
#	$(SILENT)rm -f $(RELEASE_DIR)/var/tuxbox/config/terrestrial.xml
#endif
# spinner
#	$(SILENT)cp -aR $(SKEL_ROOT)/root_enigma2/usr/local/share/enigma2/skin_default/spinner/* $(RELEASE_DIR)/lib/titan/default/skin/
#
# iso-codes
#
	$(SILENT)[ -e $(TARGET_DIR)/usr/share/iso-codes ] && cp -aR $(TARGET_DIR)/usr/share/iso-codes $(RELEASE_DIR)/usr/share/ || true
	$(SILENT)[ -e $(TARGET_DIR)/usr/share/tuxbox/iso-codes ] && cp -aR $(TARGET_DIR)/usr/share/tuxbox/iso-codes $(RELEASE_DIR)/usr/share/tuxbox/ || true
#
# httpd/icons/locale/themes
#
#	$(SILENT)cp -aR $(TARGET_DIR)/usr/share/tuxbox/titan/* $(RELEASE_DIR)/usr/share/tuxbox/titan
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
		mkdir -p $(RELEASE_DIR)/var/usr/lib/alsa-lib; \
	fi
#
# xupnpd
#
	$(SILENT)if [ -e $(TARGET_DIR)/usr/bin/xupnpd ]; then \
		cp -aR $(TARGET_DIR)/usr/share/xupnpd $(RELEASE_DIR)/usr/share; \
		mkdir -p $(RELEASE_DIR)/usr/share/xupnpd/playlists; \
	fi
#
# mc
#
	$(SILENT)if [ -e $(TARGET_DIR)/usr/bin/mc ]; then \
		cp -aR $(TARGET_DIR)/usr/share/mc $(RELEASE_DIR)/usr/share/; \
		cp -af $(TARGET_DIR)/usr/libexec $(RELEASE_DIR)/usr/; \
	fi
#
# lua
#
	$(SILENT)if [ -d $(TARGET_DIR)/usr/share/lua ]; then \
		cp -aR $(TARGET_DIR)/usr/share/lua $(RELEASE_DIR)/usr/share; \
	fi
#
# plugins
#
	$(SILENT)if [ -d $(TARGET_DIR)/var/tuxbox/plugins ]; then \
		cp -af $(TARGET_DIR)/var/tuxbox/plugins $(RELEASE_DIR)/var/tuxbox/; \
	fi
	$(SILENT)if [ -d $(TARGET_DIR)/lib/tuxbox/plugins ]; then \
		cp -af $(TARGET_DIR)/lib/tuxbox/plugins $(RELEASE_DIR)/lib/tuxbox/; \
	fi
	$(SILENT)if [ -e $(RELEASE_DIR)/var/tuxbox/plugins/tuxwetter.so ]; then \
		cp -rf $(TARGET_DIR)/var/tuxbox/config/tuxwetter $(RELEASE_DIR)/var/tuxbox/config; \
	fi
	$(SILENT)if [ -e $(RELEASE_DIR)/var/tuxbox/plugins/sokoban.so ]; then \
		cp -rf $(TARGET_DIR)/usr/share/tuxbox/sokoban $(RELEASE_DIR)/var/tuxbox/plugins; \
		ln -s /var/tuxbox/plugins/sokoban $(RELEASE_DIR)/usr/share/tuxbox/sokoban; \
	fi
#
# shairport
#
	$(SILENT)if [ -e $(TARGET_DIR)/usr/bin/shairport ]; then \
		cp -f $(TARGET_DIR)/usr/bin/shairport $(RELEASE_DIR)/usr/bin; \
		cp -f $(TARGET_DIR)/usr/bin/mDNSPublish $(RELEASE_DIR)/usr/bin; \
		cp -f $(TARGET_DIR)/usr/bin/mDNSResponder $(RELEASE_DIR)/usr/bin; \
		cp -f $(SKEL_ROOT)/etc/init.d/shairport $(RELEASE_DIR)/etc/init.d/shairport; \
		chmod 755 $(RELEASE_DIR)/etc/init.d/shairport; \
		cp -f $(TARGET_DIR)/usr/lib/libhowl.so* $(RELEASE_DIR)/usr/lib; \
		cp -f $(TARGET_DIR)/usr/lib/libmDNSResponder.so* $(RELEASE_DIR)/usr/lib; \
	fi
#
# Titan HD2 Workaround Built-in Player
#
	$(SILENT)if [ -e $(TARGET_DIR)/usr/local/bin/eplayer3 ]; then \
		cp -f $(TARGET_DIR)/usr/local/bin/eplayer3 $(RELEASE_DIR)/bin/; \
		cp -f $(TARGET_DIR)/usr/local/bin/meta $(RELEASE_DIR)/bin/; \
	fi
	$(SILENT)echo " done."
#
# delete unnecessary files
#
	$(SILENT)echo -n "Cleaning up..."
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), ufs910 ufs922))
	$(SILENT)rm -f $(RELEASE_DIR)/sbin/jfs_fsck
	$(SILENT)rm -f $(RELEASE_DIR)/sbin/fsck.jfs
	$(SILENT)rm -f $(RELEASE_DIR)/sbin/jfs_mkfs
	$(SILENT)rm -f $(RELEASE_DIR)/sbin/mkfs.jfs
	$(SILENT)rm -f $(RELEASE_DIR)/sbin/jfs_tune
	$(SILENT)rm -f $(RELEASE_DIR)/etc/ssl/certs/ca-certificates.crt
endif
	$(SILENT)if [ -e $(RELEASE_DIR)/etc/cron.d ]; then \
		rmdir --ignore-fail-on-non-empty $(RELEASE_DIR)/etc/cron.d; \
	fi
	$(SILENT)if [ -e $(RELEASE_DIR)/lib/e2fsprogs ]; then \
		rmdir --ignore-fail-on-non-empty $(RELEASE_DIR)/lib/e2fsprogs; \
	fi
#	$(SILENT)rmdir --ignore-fail-on-non-empty $(RELEASE_DIR)/lib/glib-2.0
#	$(SILENT)rmdir --ignore-fail-on-non-empty $(RELEASE_DIR)/etc/inittab.d
#	$(SILENT)rmdir --ignore-fail-on-non-empty $(RELEASE_DIR)/etc/network
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/lua/5.2/*.la
#	$(SILENT)rm -rf $(RELEASE_DIR)/lib/autofs
#	$(SILENT)rm -f $(RELEASE_DIR)/lib/libSegFault*
#	$(SILENT)rm -f $(RELEASE_DIR)/lib/libstdc++.*-gdb.py
#	$(SILENT)rm -f $(RELEASE_DIR)/lib/libthread_db*
#	$(SILENT)rm -f $(RELEASE_DIR)/lib/libanl*
	$(SILENT)rm -rf $(RELEASE_DIR)/lib/modules/$(KERNEL_VER)
#	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/alsa
#	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/glib-2.0
#	$(SILENT)rm -rf $(RELEASE_DIR)/usr/lib/cmake
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/*.py
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/libc.so
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/xml2Conf.sh
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/libfontconfig*
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/libdvdcss*
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/libdvdnav*
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/libdvdread*
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/libcurses.so
#	$(SILENT)[ ! -e $(RELEASE_DIR)/usr/bin/mc ] && rm -f $(RELEASE_DIR)/usr/lib/libncurses* || true
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/libthread_db*
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/libanl*
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/lib/libopkg*
	$(SILENT)rm -f $(RELEASE_DIR)/bin/gitVCInfo
	$(SILENT)rm -f $(RELEASE_DIR)/bin/evtest
#	$(SILENT)rm -f $(RELEASE_DIR)/bin/meta
#	$(SILENT)rm -f $(RELEASE_DIR)/bin/streamproxy
#	$(SILENT)rm -f $(RELEASE_DIR)/bin/libstb-hal-test
#	$(SILENT)rm -f $(RELEASE_DIR)/sbin/ldconfig
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/bin/pic2m2v
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/bin/{gdbus-codegen,glib-*,gtester-report}
	$(SILENT)echo " done."
#
# The main target depends on the model.
# IMPORTANT: it is assumed that only one variable is set. Otherwise the target name won't be resolved.
#
$(D)/titan_release: titan-release-base titan-release-$(BOXTYPE)
	$(TUXBOX_CUSTOMIZE)
	@touch $@
#
# FOR YOUR OWN CHANGES use these folder in own_build/titan
#
#	default for all receivers
	@echo -n "Processing own_build..."
	$(SILENT)find $(OWN_BUILD)/titan/ -mindepth 1 -maxdepth 1 -exec cp -at$(RELEASE_DIR)/ -- {} +
	@echo " done."
#	receiver specific (only if directory exists)
	@echo -n "Processing receiver specific own build for $(BOXTYPE)..."
	$(SILENT)[ -d "$(OWN_BUILD)/titan.$(BOXTYPE)" ] && find $(OWN_BUILD)/titan.$(BOXTYPE)/ -mindepth 1 -maxdepth 1 -exec cp -at$(RELEASE_DIR)/ -- {} + || true
#	$(SILENT)echo $(BOXTYPE) > $(RELEASE_DIR)/var/etc/model
	@echo " done."
	$(SILENT)rm  -f $(RELEASE_DIR)/for_your_own_changes
#
# nicht die feine Art, aber funktioniert ;)
#
	$(SILENT)cp -dpfr $(RELEASE_DIR)/etc $(RELEASE_DIR)/var
	$(SILENT)rm -fr $(RELEASE_DIR)/etc
	$(SILENT)ln -sf /var/etc $(RELEASE_DIR)

	$(SILENT)ln -s /tmp $(RELEASE_DIR)/lib/init
	$(SILENT)ln -s /tmp $(RELEASE_DIR)/var/lib/urandom
	$(SILENT)ln -s /tmp $(RELEASE_DIR)/var/lock
	$(SILENT)ln -s /tmp $(RELEASE_DIR)/var/log
	$(SILENT)ln -s /tmp $(RELEASE_DIR)/var/run
	$(SILENT)ln -s /tmp $(RELEASE_DIR)/var/tmp
#
#	$(SILENT)mv -f $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/scan.jpg $(RELEASE_DIR)/var/boot/
#	$(SILENT)ln -s /var/boot/scan.jpg $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/
#	$(SILENT)mv -f $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/mp3.jpg $(RELEASE_DIR)/var/boot/
#	$(SILENT)ln -s /var/boot/mp3.jpg $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/
#	$(SILENT)rm -f $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/mp3-?.jpg
#	$(SILENT)mv -f $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/shutdown.jpg $(RELEASE_DIR)/var/boot/
#	$(SILENT)ln -s /var/boot/shutdown.jpg $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/
#	$(SILENT)mv -f $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/radiomode.jpg $(RELEASE_DIR)/var/boot/
#	$(SILENT)ln -s /var/boot/radiomode.jpg $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/
#	$(SILENT)mv -f $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/start.jpg $(RELEASE_DIR)/var/boot/
#	$(SILENT)ln -s /var/boot/start.jpg $(RELEASE_DIR)/usr/share/tuxbox/titan/icons/
#
# linux-strip all
#
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), kerneldebug debug))
	@echo -n "Stripping...";
	$(SILENT)find $(RELEASE_DIR)/ -name '*' -exec $(TARGET)-strip --strip-unneeded {} &>/dev/null \;
	@echo -e " done.\n";
endif

#
#
# titan-release-clean
#
titan-release-clean:
	rm -f $(D)/titan-release
