#
# tools
#
tools-clean:
	@rm -f $(D)/tools-*
	@-$(MAKE) -C $(TOOLS_DIR)/aio-grab distclean
	@-$(MAKE) -C $(TOOLS_DIR)/devinit distclean
	@-$(MAKE) -C $(TOOLS_DIR)/eeprom_crenova distclean
	@-$(MAKE) -C $(TOOLS_DIR)/eeprom_dgs distclean
	@-$(MAKE) -C $(TOOLS_DIR)/eeprom_fortis distclean
	@-$(MAKE) -C $(TOOLS_DIR)/eeprom_ipbox distclean
	@-$(MAKE) -C $(TOOLS_DIR)/eeprom_ufs910 distclean
	@-$(MAKE) -C $(TOOLS_DIR)/eeprom_ufs913 distclean
	@-$(MAKE) -C $(TOOLS_DIR)/eeprom_ufs922 distclean
	@-$(MAKE) -C $(TOOLS_DIR)/eplayer3 distclean
	@-$(MAKE) -C $(TOOLS_DIR)/exteplayer3 distclean
	@-$(MAKE) -C $(TOOLS_DIR)/evremote2 distclean
	@-$(MAKE) -C $(TOOLS_DIR)/femon distclean
	@-$(MAKE) -C $(TOOLS_DIR)/fp_control distclean
	@-$(MAKE) -C $(TOOLS_DIR)/gitVCInfo distclean
	@-$(MAKE) -C $(TOOLS_DIR)/hotplug distclean
	@-$(MAKE) -C $(TOOLS_DIR)/infobox distclean
	@-$(MAKE) -C $(TOOLS_DIR)/libeplayer3_org distclean
	@-$(MAKE) -C $(TOOLS_DIR)/libeplayer3 distclean
	@-$(MAKE) -C $(TOOLS_DIR)/libmme_host distclean
	@-$(MAKE) -C $(TOOLS_DIR)/libmme_image distclean
	@-$(MAKE) -C $(TOOLS_DIR)/minimon distclean
	@-$(MAKE) -C $(TOOLS_DIR)/msgbox distclean
	@-$(MAKE) -C $(TOOLS_DIR)/read-edid distclean
	@-$(MAKE) -C $(TOOLS_DIR)/satfind distclean
	@-$(MAKE) -C $(TOOLS_DIR)/showiframe distclean
	@-$(MAKE) -C $(TOOLS_DIR)/spf_tool distclean
	@-$(MAKE) -C $(TOOLS_DIR)/stfbcontrol distclean
	@-$(MAKE) -C $(TOOLS_DIR)/streamproxy distclean
	@-$(MAKE) -C $(TOOLS_DIR)/sysinfo distclean
	@-$(MAKE) -C $(TOOLS_DIR)/tfd2mtd distclean
	@-$(MAKE) -C $(TOOLS_DIR)/tffpctl distclean
	@-$(MAKE) -C $(TOOLS_DIR)/titan-tools distclean
	@-$(MAKE) -C $(TOOLS_DIR)/tuxcom distclean
	@-$(MAKE) -C $(TOOLS_DIR)/ustslave distclean
	@-$(MAKE) -C $(TOOLS_DIR)/vfdctl distclean
	@-$(MAKE) -C $(TOOLS_DIR)/wait4button distclean
ifneq ($(wildcard $(TOOLS_DIR)/own-tools),)
	-$(MAKE) -C $(TOOLS_DIR)/own-tools distclean
endif

#
# aio-grab
#
$(D)/tools-aio-grab: $(D)/bootstrap $(D)/libpng $(D)/libjpeg
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/aio-grab; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) CPPFLAGS="$(CPPFLAGS) -I$(DRIVER_DIR)/bpamem" \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# devinit
#
$(D)/tools-devinit: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/devinit; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# evremote2
#
$(D)/tools-evremote2: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/evremote2; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# eeprom_cuberevo_led
#
$(D)/tools-eeprom-cuberevo_led: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/eeprom_cuberevo_led; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# eeprom_crenova
#
$(D)/tools-eeprom-crenova: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/eeprom_crenova; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# eeprom_dgs
#
$(D)/tools-eeprom-dgs: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/eeprom_dgs; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# eeprom_fortis
#
$(D)/tools-eeprom-fortis: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/eeprom_fortis; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# eeprom_ipbox
#
$(D)/tools-eeprom-ipbox: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/eeprom_ipbox; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# eeprom_ufs910
#
$(D)/tools-eeprom-ufs910: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/eeprom_ufs910; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# eeprom_ufs913
#
$(D)/tools-eeprom-ufs913: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/eeprom_ufs913; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# eeprom_ufs922
#
$(D)/tools-eeprom-ufs922: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/eeprom_ufs922; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# femon
#
$(D)/tools-femon: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/femon; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) CPPFLAGS="$(CPPFLAGS)" \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# fp_control
#
$(D)/tools-fp_control: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/fp_control; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# gitVCInfo
#
$(D)/tools-gitVCInfo: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/gitVCInfo; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) CPPFLAGS="$(CPPFLAGS)" \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# hotplug
#
$(D)/tools-hotplug: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/hotplug; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# infobox
#
$(D)/tools-infobox: $(D)/bootstrap $(D)/freetype $(D)/libjpeg $(D)/libpng $(D)/zlib
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/infobox; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# libeplayer3_org
# CAUTION: name is misleading; builds a library and an executable
$(D)/tools-libeplayer3_org: $(D)/bootstrap $(D)/ffmpeg $(D)/libass
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/libeplayer3_org; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# libeplayer3
#
$(D)/tools-libeplayer3: $(D)/bootstrap $(D)/ffmpeg
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/libeplayer3; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-silent-rules \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# libmme_host
#
$(D)/tools-libmme_host: $(D)/bootstrap $(D)/driver
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/libmme_host; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE) DRIVER_TOPDIR=$(DRIVER_DIR); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) DRIVER_TOPDIR=$(DRIVER_DIR)
	$(TOUCH)

#
# libmme_image
#
$(D)/tools-libmme_image: $(D)/bootstrap $(D)/libjpeg
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/libmme_image; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE) DRIVER_TOPDIR=$(DRIVER_DIR); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) DRIVER_TOPDIR=$(DRIVER_DIR)
	$(TOUCH)

#
# minimon
#
$(D)/tools-minimon: $(D)/bootstrap $(D)/libjpeg $(D)/libusb
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/minimon; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE) KERNEL_DIR=$(KERNEL_DIR) TARGET=$(TARGET) TARGET_DIR=$(TARGET_DIR); \
		$(MAKE) install KERNEL_DIR=$(KERNEL_DIR) TARGET=$(TARGET) TARGET_DIR=$(TARGET_DIR) DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# msgbox
#
$(D)/tools-msgbox: $(D)/bootstrap $(D)/libpng $(D)/freetype
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/msgbox; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
			--with-boxmodel=$(BOXTYPE) \
			--with-boxtype=$(BOXTYPE) \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# read-edid
#
$(D)/tools-read-edid: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/read-edid; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# satfind
#
$(D)/tools-satfind: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/satfind; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# showiframe
#
$(D)/tools-showiframe: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/showiframe; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# spf_tool
#
$(D)/tools-spf_tool: $(D)/bootstrap $(D)/libusb
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/spf_tool; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# stfbcontrol
#
$(D)/tools-stfbcontrol: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/stfbcontrol; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# streamproxy
#
$(D)/tools-streamproxy: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/streamproxy; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# sysinfo
#
$(D)/tools-sysinfo: $(D)/bootstrap $(D)/libpng $(D)/freetype
	$(START_BUILD)
	set -e; cd $(TOOLS_DIR)/sysinfo; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
			--with-boxmodel=$(BOXTYPE) \
			--with-boxtype=$(BOXTYPE) \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# tfd2mtd
#
$(D)/tools-tfd2mtd: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/tfd2mtd; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# tffpctl
#
$(D)/tools-tffpctl: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/tffpctl; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# titan-tools
#
$(D)/tools-titan-tools: $(D)/bootstrap $(D)/enigma2_tuxtxt32bpp $(D)/freetype
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/titan-tools; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
			--with-fontdir=/usr/share/fonts \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# tuxcom
#
$(D)/tools-tuxcom: $(D)/bootstrap $(D)/freetype
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/tuxcom; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
			--with-boxmodel=$(BOXTYPE) \
			--with-boxtype=$(BOXTYPE) \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# ustslave
#
$(D)/tools-ustslave: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/ustslave; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# vfdctl
#
ifeq ($(BOXTYPE), spark7162)
EXTRA_CPPFLAGS=-DHAVE_SPARK7162_HARDWARE
endif

$(D)/tools-vfdctl: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/vfdctl; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE) CPPFLAGS="$(EXTRA_CPPFLAGS)"; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# wait4button
#
$(D)/tools-wait4button: $(D)/bootstrap
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/wait4button; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# eplayer3
# CAUTION: name is misleading; builds a library only
$(D)/tools-eplayer3: $(D)/bootstrap $(D)/ffmpeg
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/eplayer3; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix=/usr\
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)


#
# exteplayer3
#
$(D)/tools-exteplayer3: $(D)/bootstrap $(D)/ffmpeg
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/exteplayer3; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		autoreconf -fi; \
		$(CONFIGURE) \
			--prefix=/usr\
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# own-tools
#
$(D)/tools-own-tools: $(D)/bootstrap $(D)/libcurl
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/own-tools; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# branding-module
#
$(D)/tools-branding-module: $(D)/bootstrap $(D)/enigma2
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/branding-module; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		autoreconf -fi; \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# png_util
#
$(D)/tools-png_util: $(D)/bootstrap $(D)/libpng
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/png_util; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
			--with-boxmodel=$(BOXTYPE) \
			--with-boxtype=$(BOXTYPE) \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)


#
# gst-player
#
GST-PLAYER_CPPFLAGS     = $(shell $(PKG_CONFIG) --cflags --libs gstreamer-1.0)
GST-PLAYER_CPPFLAGS     += $(shell $(PKG_CONFIG) --cflags --libs gstreamer-audio-1.0)
GST-PLAYER_CPPFLAGS     += $(shell $(PKG_CONFIG) --cflags --libs gstreamer-video-1.0)
GST-PLAYER_CPPFLAGS     += $(shell $(PKG_CONFIG) --cflags --libs glib-2.0)
$(D)/tools-gst-player: $(D)/bootstrap $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugins_good \
	$(D)/gst_plugins_bad $(D)/gst_plugins_ugly $(D)/gst_plugin_subsink $(D)/gst_plugins_dvbmediasink
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/gst-player; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			CPPFLAGS="$(GST-PLAYER_CPPFLAGS)" \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)



#
# libemu
#
$(D)/tools-libemu: $(D)/bootstrap $(D)/freetype $(D)/libjpeg $(D)/libpng $(D)/zlib
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/libemu; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# gst-ifdsrc
#
$(D)/tools-gst-ifdsrc: $(D)/bootstrap $(D)/enigma2 $(D)/gstreamer
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/gst-ifdsrc; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		autoreconf -fi; \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# gstplayer
#
$(D)/tools-gstplayer: $(D)/bootstrap $(D)/enigma2 $(D)/gstreamer
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/gstplayer; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		autoreconf -fi; \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)


#
# eplayer4
#
EPLAYER4_CPPFLAGS     = $(shell $(PKG_CONFIG) --cflags --libs gstreamer-1.0)
EPLAYER4_CPPFLAGS     += $(shell $(PKG_CONFIG) --cflags --libs gstreamer-audio-1.0)
EPLAYER4_CPPFLAGS     += $(shell $(PKG_CONFIG) --cflags --libs gstreamer-video-1.0)
EPLAYER4_CPPFLAGS     += $(shell $(PKG_CONFIG) --cflags --libs glib-2.0)
$(D)/tools-eplayer4: $(D)/bootstrap $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugins_good \
	$(D)/gst_plugins_bad $(D)/gst_plugins_ugly $(D)/gst_plugin_subsink $(D)/gst_plugins_dvbmediasink
	$(START_BUILD)
	set -e; cd $(TOOLS_DIR)/eplayer4; \
		$(CONFIGURE_TOOLS) \
			CPPFLAGS="$(EPLAYER4_CPPFLAGS)" \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# turnoff_power
#
$(D)/tools-turnoff_power: $(D)/bootstrap
	$(START_BUILD)
	set -e; cd $(TOOLS_DIR)/turnoff_power; \
		$(CONFIGURE_TOOLS) \
			--prefix= \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

#
# obh-core
#
$(D)/tools-obh-core: $(D)/bootstrap $(D)/enigma2
	$(START_BUILD)
	$(SET) -e; cd $(TOOLS_DIR)/obh-core; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		autoreconf -fi; \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(TOUCH)

TOOLS =
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small size))
TOOLS += $(D)/tools-aio-grab
endif
TOOLS += $(D)/tools-devinit
TOOLS += $(D)/tools-aio-grab
TOOLS += $(D)/tools-femon
#TOOLS += $(D)/tools-libemu
TOOLS += $(D)/tools-msgbox
#TOOLS += $(D)/tools-read-edid
TOOLS += $(D)/tools-satfind
#TOOLS += $(D)/tools-eplayer3
#TOOLS += $(D)/tools-gst-ifdsrc
TOOLS += $(D)/tools-eplayer4
TOOLS += $(D)/tools-exteplayer3
#TOOLS += $(D)/tools-gstplayer
#TOOLS += $(D)/tools-gst-player
TOOLS += $(D)/tools-branding-module
#TOOLS += $(D)/tools-obh-core
TOOLS += $(D)/tools-libeplayer3
#TOOLS += $(D)/tools-libeplayer3_org
TOOLS += $(D)/tools-png_util
#TOOLS += $(D)/tools-libmme_host
#TOOLS += $(D)/tools-libmme_image
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), atemio520 opt9600 opt9600mini opt9600prima))
TOOLS += $(D)/tools-eeprom-crenova
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), cuberevo cuberevo_mini cuberevo_mini2 cuberevo_mini_fta cuberevo_250hd cuberevo_2000hd cuberevo_3000hd))
TOOLS += $(D)/tools-eeprom-dgs
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), hs7110 hs7420 hs7810a hs7119 hs7249 hs7819))
TOOLS += $(D)/tools-eeprom-fortis
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), ipbox55 ipbox99 ipbox9900))
TOOLS += $(D)/tools-eeprom-ipbox
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), ufs910))
TOOLS += $(D)/tools-eeprom-ufs910
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), ufs913))
TOOLS += $(D)/tools-eeprom-ufs913
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), ufs922))
TOOLS += $(D)/tools-eeprom-ufs922
endif
TOOLS += $(D)/tools-evremote2
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), adb_box atemio520 cuberevo cuberevo_mini cuberevo_mini2 cuberevo_mini_fta cuberevo_250hd cuberevo_2000hd cuberevo_3000hd cuberevo_9500hd fs9000 hl101 hs5101 hs7110 hs7420 hs7810a hs7119 hs7429 hs7819 hs8200 hs9510 hchs8100 hchs9100 opt9600 opt9600mini opt9600prima spark spark7162 tf7700hdpvr ufc960 ufs910 ufs912 ufs913 ufs922 vip1_v1 vip1_v2 vip2 vitamin_hd5000))
TOOLS += $(D)/tools-fp_control
endif
TOOLS += $(D)/tools-hotplug
ifeq ($(IMAGE), $(filter $(IMAGE), titan titan-wlandriver))
TOOLS += $(D)/tools-infobox
endif
ifeq ($(IMAGE), $(filter $(IMAGE), enigma2 enigma2-wlandriver titan titan-wlandriver))
TOOLS += $(D)/tools-libmme_host
TOOLS += $(D)/tools-libmme_image
endif
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small size))
ifneq ($(EXTERNAL_LCD), none)
TOOLS += $(D)/tools-minimon
endif
endif
ifeq ($(PLUGINS_NEUTRINO), Yes)
TOOLS += $(D)/tools-msgbox
endif
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small size))
TOOLS += $(D)/tools-read-edid
TOOLS += $(D)/tools-satfind
endif
TOOLS += $(D)/tools-showiframe
TOOLS += $(D)/tools-stfbcontrol
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small))
TOOLS += $(D)/tools-streamproxy
endif
ifeq ($(IMAGE), $(filter $(IMAGE), titan titan-wlandriver))
TOOLS += $(D)/tools-titan-tools
endif
TOOLS += $(D)/tools-ustslave
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), tf7700))
TOOLS += $(D)/tools-tfd2mtd
TOOLS += $(D)/tools-tffpctl
endif
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), ufs910 ufs922))
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small))
TOOLS += $(D)/tools-femon
ifeq ($(IMAGE), $(filter $(IMAGE), neutrino neutrino-wlandriver))
TOOLS += $(D)/tools-sysinfo
endif
ifeq ($(PLUGINS_NEUTRINO), Yes)
TOOLS += $(D)/tools-tuxcom
endif
endif
endif
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), ufs910 ufs912 ufs913 spark7162))
TOOLS += $(D)/tools-vfdctl
endif
TOOLS += $(D)/tools-wait4button
ifneq ($(wildcard $(TOOLS_DIR)/own-tools),)
TOOLS += $(D)/tools-own-tools
endif

$(D)/tools: $(TOOLS)
	$(START_BUILD)
	$(TOUCH)

