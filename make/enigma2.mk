#
# enigma2
#
ENIGMA2_DEPS  = $(D)/bootstrap
ENIGMA2_DEPS += $(D)/opkg
ENIGMA2_DEPS += $(D)/ncurses
ENIGMA2_DEPS += $(D)/module_init_tools
ENIGMA2_DEPS += $(LIRC)
ENIGMA2_DEPS += $(D)/libpng
ENIGMA2_DEPS += $(D)/libjpeg
ENIGMA2_DEPS += $(D)/giflib
ENIGMA2_DEPS += $(D)/libfribidi
ENIGMA2_DEPS += $(D)/libglib2
ENIGMA2_DEPS += $(D)/libdvbsi
ENIGMA2_DEPS += $(D)/libxml2
ENIGMA2_DEPS += $(D)/openssl
ENIGMA2_DEPS += $(D)/enigma2_tuxtxt32bpp
ENIGMA2_DEPS += $(D)/enigma2_hotplug_e2_helper
ENIGMA2_DEPS += $(D)/avahi
ENIGMA2_DEPS += python-all
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small))
ENIGMA2_DEPS += $(D)/ethtool
ENIGMA2_DEPS += $(D)/alsa_utils
ENIGMA2_DEPS += $(D)/libdreamdvd
ENIGMA2_DEPS += $(D)/libmad
ENIGMA2_DEPS += $(D)/libusb
ENIGMA2_DEPS += $(D)/libid3tag
ENIGMA2_DEPS += $(D)/minidlna
ENIGMA2_DEPS += $(D)/sdparm
#ENIGMA2_DEPS += $(D)/oscam
ENIGMA2_DEPS += $(D)/parted $(D)/a52dec $(D)/dvb-apps $(D)/libgcrypt $(D)/mpg123 $(D)/harfbuzz
ENIGMA2_DEPS += $(D)/tools-libmme_host
ENIGMA2_DEPS += $(D)/tools-libmme_image
ENIGMA2_DEPS += $(D)/libxmlccwrap $(D)/libcurl 
ENIGMA2_DEPS += $(D)/libsigc_e2
endif
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small size))
# required for DVDBurn plugin (adds ? Mbyte to image)
#ENIGMA2_DEPS += $(D)/dvd+rw-tools $(D)/dvdauthor $(D)/mjpegtools $(D)/cdrkit $(D)/replex $(D)/python_imaging
endif
ifeq ($(IMAGE), enigma2-wlandriver)
ENIGMA2_DEPS += $(D)/wpa_supplicant $(D)/wireless_tools
endif

ifeq ($(BOXTYPE), $(filter $(BOXTYPE), hs7110 hs7119 hs7420 hs7429 hs7810a hs7819 hchs8100 opt9600 opt9600mini opt9600prima vitamin_hd5000))
ifeq ($(DESTINATION), USB)
E_CONFIG_OPTS += --enable-run_from_usb
endif
endif

# determine libsigc++ version
#ifeq ($(E2_DIFF), $(filter $(E2_DIFF), 1))
#ENIGMA2_DEPS  += $(D)/libsigc_e2
#else
#ENIGMA2_DEPS  += $(D)/libsigc
#endif

# determine requirements for media framework
# Note: for diffs 0, 2, 3, 4 & 5 there are no extra dependencies;
# these are part of enigma2-plugins
#ifeq ($(E2_DIFF), $(filter $(E2_DIFF), 1)) # diff 1 (local)
#ifeq ($(MEDIAFW), eplayer3)
ENIGMA2_DEPS  += $(D)/tools-libeplayer3
E_CONFIG_OPTS += --enable-libeplayer3
#endif
ifeq ($(MEDIAFW), gstreamer)
ENIGMA2_DEPS  += $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugins_multibox_dvbmediasink
ENIGMA2_DEPS  += $(D)/gst_plugins_good $(D)/gst_plugins_bad $(D)/gst_plugins_ugly
E_CONFIG_OPTS += --with-gstversion=1.0 --enable-mediafwgstreamer --enable-libeplayer3
endif
ifeq ($(MEDIAFW), gst-eplayer3)
ENIGMA2_DEPS  += $(D)/tools-libeplayer3
ENIGMA2_DEPS  += $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugins_multibox_dvbmediasink
ENIGMA2_DEPS  += $(D)/gst_plugins_good $(D)/gst_plugins_bad $(D)/gst_plugins_ugly
E_CONFIG_OPTS += --with-gstversion=1.0 --enable-mediafwgstreamer --enable-libeplayer3
endif
#endif

ifeq ($(EXTERNAL_LCD), graphlcd)
E_CONFIG_OPTS += --with-graphlcd
ENIGMA2_DEPS_ += $(D)/graphlcd
endif

ifeq ($(EXTERNAL_LCD), lcd4linux)
E_CONFIG_OPTS += --with-lcd4linux
ENIGMA2_DEPS += $(D)/lcd4linux
endif

ifeq ($(EXTERNAL_LCD), both)
E_CONFIG_OPTS += --with-graphlcd
ENIGMA2_DEPS += $(D)/graphlcd
E_CONFIG_OPTS += --with-lcd4linux
ENIGMA2_DEPS += $(D)/lcd4linux
endif

#E_CONFIG_OPTS += --enable-$(BOXTYPE)

E_CONFIG_OPTS +=$(LOCAL_ENIGMA2_BUILD_OPTIONS)

E_CPPFLAGS    = -I$(DRIVER_DIR)/include
E_CPPFLAGS   += -I$(TARGET_DIR)/usr/include
E_CPPFLAGS   += -I$(KERNEL_DIR)/include
E_CPPFLAGS   += -I$(TOOLS_DIR)
ifeq ($(E2_DIFF), $(filter $(E2_DIFF), 1))
E_CPPFLAGS   += -I$(TOOLS_DIR)/libeplayer3/include
endif
E_CPPFLAGS   += $(LOCAL_ENIGMA2_CPPFLAGS)
E_CPPFLAGS   += $(PLATFORM_CPPFLAGS)
E_CPPFLAGS   += -Wno-missing-field-initializers
E_CPPFLAGS   += -Wno-unused-parameter

#
# yaud-enigma2
#
yaud-enigma2: yaud-none $(D)/enigma2 $(D)/enigma2-plugins $(D)/enigma2_release
	$(TUXBOX_YAUD_CUSTOMIZE)
	@echo "***************************************************************"
	@echo -e "\033[01;32m"
	@echo " Build of Enigma2 for $(BOXTYPE) successfully completed."
	@echo -e "\033[00m"
	@echo "***************************************************************"
	@touch $(D)/build_complete

#
# enigma2
#
REPO_OPENPLI="https://github.com/OpenPLi/enigma2.git"
#REPO_REPLY_1="ssh://gituser@192.168.178.17/volume1//git/audioniek-openpli.git"
#REPO_REPLY_1="https://github.com/ainouna/GraterliaOS-OpenPLi-1.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma2-openpli-fulan_king.git"
#REPO_REPLY_1="https://github.com/kingvuplus/enigma2-1.git"
#REPO_REPLY_1="https://github.com/ainouna/b-psh4.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma2-openpli-fulan-king.git"
#REPO_REPLY_1="https://github.com/OpenSH4/enigma2-pli-arp.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma2-atv.git"
#REPO_REPLY_1="https://github.com/Ednaz/enigma2-openpli-sh4.git"
#REPO_REPLY_1="https://github.com/vuteam/spa.git"
#REPO_REPLY_1="https://github.com/momi133/dvbapp2.git"
#REPO_REPLY_1="https://github.com/popazerty/enigma2-2.git"
#REPO_REPLY_1="https://github.com/popazerty/SDG-gui.git"
#REPO_REPLY_1="https://github.com/popazerty/beyonwiz-stb.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma2-2-DRD.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma2-pli-arp.git"
#REPO_REPLY_1="https://github.com/Taapat/enigma2-openpli-fulan.git"
#REPO_REPLY_1="https://github.com/ainouna/openpli-enigma2.git"
#REPO_REPLY_1="https://github.com/ainouna/openNFR-gui2.git"
#REPO_REPLY_1="https://github.com/popazerty/openNFR-gui2.git"
#REPO_REPLY_1="https://github.com/ainouna/openatv-ts.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma2-atv-5.3.git"
#REPO_REPLY_1="https://github.com/ainouna/openpli-release4.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma2-openpli-vuplus.git"
#REPO_REPLY_1="https://github.com/ainouna/openhdf-enigma2.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma2-atv-6.1.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma-2.3-openplus.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma2-pli-arp.git"
#REPO_REPLY_1="https://github.com/atefganm/openpli-enigma2-sh4.git"
#REPO_REPLY_1="https://github.com/OpenSH4/enigma2-pli-arp.git"
#REPO_REPLY_1="https://bitbucket.org/beyonwiz/easy-ui-4.gi"
#REPO_REPLY_1="https://github.com/popazerty/openpli-enigma2-sh4"
#REPO_REPLY_1="https://github.com/Vasiliks/enigma2-openpli-sh4.git"
#REPO_REPLY_1="https://github.com/ainouna/enigma2-openpli-fulan-SI2.git"
#REPO_REPLY_1="https://github.com/ainouna/GraterliaOS-OpenPLi-herpoi.git"


$(D)/enigma2.do_prepare: | $(ENIGMA2_DEPS)
	REPO_0=$(REPO_OPENPLI); \
	REPO_1=$(REPO_REPLY_1); \
	REVISION=$(E2_REVISION); \
	HEAD_0="develop"; \
	HEAD_1="master"; \
	DIFF=$(E2_DIFF); \
	rm -rf $(SOURCE_DIR)/enigma2; \
	rm -rf $(SOURCE_DIR)/enigma2.org; \
	clear; \
	echo "Starting OpenPLi Enigma2 build"; \
	echo "=============================="; \
	echo; \
	if [ "$$DIFF" != "1" ]; then \
		echo "Repository : "$$REPO_0; \
		echo "Revision   : "$$REVISION; \
		echo "Diff       : "$$DIFF; \
		echo; \
		[ -d "$(ARCHIVE)/enigma2-pli-nightly.git" ] && \
		(cd $(ARCHIVE)/enigma2-pli-nightly.git; echo -n "Updating archived OpenPLi git..."; git pull -q; echo -e -n " done.\nChecking out HEAD..."; git checkout -q HEAD; echo " done."; cd "$(BUILD_TMP)";); \
		[ -d "$(ARCHIVE)/enigma2-pli-nightly.git" ] || \
		(echo -n "Cloning remote OpenPLi git..."; git clone -q -b $$HEAD_0 $$REPO_0 $(ARCHIVE)/enigma2-pli-nightly.git; echo " done."); \
		echo -n "Copying local git content to build environment..."; cp -ra $(ARCHIVE)/enigma2-pli-nightly.git $(SOURCE_DIR)/enigma2; echo " done."; \
		if [ "$$REVISION" != "newest" ]; then \
			cd $(SOURCE_DIR)/enigma2; echo -n "Checking out revision $$REVISION..."; git checkout -q "$$REVISION"; echo " done."; echo; \
		fi; \
		cp -ra $(SOURCE_DIR)/enigma2 $(SOURCE_DIR)/enigma2.org; \
		echo "Applying diff-$$DIFF patch..."; \
		set -e; cd $(SOURCE_DIR)/enigma2 && patch -p1 $(SILENT_PATCH) < "$(PATCHES)/build-enigma2/enigma2-pli-nightly.$$DIFF.diff"; \
		if [ "$(MEDIAFW)" == "eplayer3" ]; then \
			set -e; cd $(SOURCE_DIR)/enigma2 && patch -p1 $(SILENT_PATCH) < "$(PATCHES)/build-enigma2/enigma2-eplayer3.$$DIFF.patch"; \
		fi; \
		if [ "$(E2_DIFF)" != "1" ]; then \
			if [ "$(BOXTYPE)" == "fs9000" ] || [ "$(BOXTYPE)" == "hs9510" ] || [ "$(BOXTYPE)" == "cuberevo" ] || [ "$(BOXTYPE)" == "cuberevo_250hd" ] || [ "$(BOXTYPE)" == "cuberevo_mini_fta" ] || [ "$(BOXTYPE)" == "cuberevo_mini" ] || [ "$(BOXTYPE)" == "cuberevo_mini2" ] || [ "$(BOXTYPE)" == "hchs8100" ] || [ "$(BOXTYPE)" == "tf7700" ]; then \
				patch -p1 $(SILENT_PATCH) < "$(PATCHES)/build-enigma2/enigma2-no_hdmi_cec.$$DIFF.patch"; \
			fi; \
		fi; \
		echo "Patching to diff-$$DIFF completed."; \
		cd $(SOURCE_DIR)/enigma2; \
		echo -n "Unpacking VFD-Icons plugins..."; \
		patch -p1 -s -i "$(PATCHES)/build-enigma2/vfd-icons.patch"; echo " done."; \
		rm -rf $(TARGET_DIR)/usr/share/enigma2/rc_models; \
		echo; \
		echo -n "Patching remote control files..."; \
		patch -p1 -s -i "$(PATCHES)/build-enigma2/rc-models.patch"; \
		echo -e " done.\nBuild preparation for OpenPLi complete."; echo; \
	else \
		echo "Repository : "$$REPO_1; \
		echo; \
		[ -d "$(SOURCE_DIR)/enigma2" ] ; \
		echo "Cloning local git content to build environment..."; \
		git clone -b $$HEAD_1 $$REPO_1 $(SOURCE_DIR)/enigma2; \
		echo; \
	fi
	@touch $@

$(SOURCE_DIR)/enigma2/config.status:
	$(SILENT)cd $(SOURCE_DIR)/enigma2; \
		./autogen.sh $(SILENT_OPT); \
		sed -e 's|#!/usr/bin/python|#!$(HOST_DIR)/bin/python|' -i po/xml2po.py; \
		$(BUILDENV) \
		./configure $(SILENT_CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			$(E_CONFIG_OPTS) \
			--with-libsdl=no \
			--datadir=/usr/share \
			--libdir=/usr/lib \
			--bindir=/usr/bin \
			--prefix=/usr \
			--sysconfdir=/etc \
			--with-boxtype=$(BOXTYPE) \
			$(ENIGMA_OPT_OPTION) \
			PKG_CONFIG=$(PKG_CONFIG) \
			PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) \
			PY_PATH=$(TARGET_DIR)/usr \
			CPPFLAGS="$(E_CPPFLAGS)"

$(D)/enigma2.do_compile: $(SOURCE_DIR)/enigma2/config.status
	$(SILENT)cd $(SOURCE_DIR)/enigma2; \
		$(MAKE) all
	@touch $@

$(D)/enigma2: $(D)/enigma2.do_prepare $(D)/enigma2.do_compile
	$(MAKE) -C $(SOURCE_DIR)/enigma2 install DESTDIR=$(TARGET_DIR)
	if [ -e $(TARGET_DIR)/usr/bin/enigma2 ]; then \
		$(TARGET)-strip $(TARGET_DIR)/usr/bin/enigma2; \
	fi
	if [ -e $(TARGET_DIR)/usr/bin/enigma2 ]; then \
		$(TARGET)-strip $(TARGET_DIR)/usr/bin/enigma2; \
	fi
	$(TOUCH)

	
enigma2-clean:
	rm -f $(D)/enigma2
	rm -f $(D)/enigma2.do_compile
	cd $(SOURCE_DIR)/enigma2; \
		$(MAKE) distclean

enigma2-distclean:
	rm -f $(D)/enigma2
	rm -f $(D)/enigma2.do_compile
	rm -f $(D)/enigma2.do_prepare
	rm -rf $(SOURCE_DIR)/enigma2
	rm -rf $(SOURCE_DIR)/enigma2.org

