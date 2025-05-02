#
# enigma2_hotplug_e2_helper
#
HOTPLUG_E2_PATCH = build-enigma2/hotplug-e2-helper.patch

$(D)/enigma2_hotplug_e2_helper: $(D)/bootstrap
	$(START_BUILD)
	$(REMOVE)/hotplug-e2-helper
	$(SET) -e; if [ -d $(ARCHIVE)/hotplug-e2-helper.git ]; \
		then cd $(ARCHIVE)/hotplug-e2-helper.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) https://github.com/OpenPLi/hotplug-e2-helper.git hotplug-e2-helper.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/hotplug-e2-helper.git $(BUILD_TMP)/hotplug-e2-helper
	$(SET) -e; cd $(BUILD_TMP)/hotplug-e2-helper; \
		$(call apply_patches,$(HOTPLUG_E2_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE) all; \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR)
	$(REMOVE)/hotplug-e2-helper
	$(TOUCH)

#
# enigma2_tuxtxtlib
#
TUXTXTLIB_PATCH = build-enigma2/tuxtxtlib-1.0-fix-dbox-headers.patch

$(D)/enigma2_tuxtxtlib: $(D)/bootstrap $(D)/freetype
	$(START_BUILD)
	$(REMOVE)/tuxtxtlib
	$(SILENT)if [ -d $(ARCHIVE)/tuxtxt.git ]; \
		then cd $(ARCHIVE)/tuxtxt.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) https://github.com/OpenPLi/tuxtxt.git tuxtxt.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/tuxtxt.git/libtuxtxt $(BUILD_TMP)/tuxtxtlib
	$(SILENT)cd $(BUILD_TMP)/tuxtxtlib; \
		$(call apply_patches,$(TUXTXTLIB_PATCH)); \
		aclocal; \
		autoheader; \
		autoconf; \
		libtoolize --force $(SILENT_OPT); \
		automake --foreign --add-missing; \
		$(BUILDENV) \
		./configure $(SILENT_CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
			--with-boxtype=generic \
			--with-configdir=/etc \
			--with-datadir=/usr/share/tuxtxt \
			--with-fontdir=/usr/share/fonts \
		; \
		$(MAKE) all; \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/tuxbox-tuxtxt.pc
	$(REWRITE_LIBTOOL)/libtuxtxt.la
	$(REMOVE)/tuxtxtlib
	$(TOUCH)

#
# enigma2_tuxtxt32bpp
#
TUXTXT32BPP_PATCH = tuxtxt32bpp-1.0-fix-dbox-headers.patch

$(D)/enigma2_tuxtxt32bpp: $(D)/bootstrap $(D)/enigma2_tuxtxtlib
	$(START_BUILD)
	$(REMOVE)/tuxtxt
	$(SILENT)cp -ra $(ARCHIVE)/tuxtxt.git/tuxtxt $(BUILD_TMP)/tuxtxt
	$(SET) -e; cd $(BUILD_TMP)/tuxtxt; \
		$(call apply_patches,$(TUXTXT32BPP_PATCH)); \
		aclocal; \
		autoheader; \
		autoconf; \
		libtoolize --force $(SILENT_OPT); \
		automake --foreign --add-missing; \
		$(BUILDENV) \
		./configure $(SILENT_CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
			--with-fbdev=/dev/fb0 \
			--with-boxtype=generic \
			--with-configdir=/etc \
			--with-datadir=/usr/share/tuxtxt \
			--with-fontdir=/usr/share/fonts \
		; \
		$(MAKE) all; \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libtuxtxt32bpp.la
	$(REMOVE)/tuxtxt
	$(TOUCH)

#
# Plugins
#
E2_PLUGIN_DEPS  =
E2_PLUGIN_DEPS += enigma2_servicemp3epl
E2_PLUGIN_DEPS += enigma2_serviceapp
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small))
ifneq ($(BOXTYPE), $(filter $(BOXTYPE), adb_box))
E2_PLUGIN_DEPS += $(D)/enigma2_openwebif
endif
endif
ifneq ($(E2_DIFF), 1)
ifeq ($(MEDIAFW), $(filter $(MEDIAFW), eplayer3 gstreamer gst-eplayer3))
#E2_PLUGIN_DEPS += enigma2_servicemp3
E2_PLUGIN_DEPS += enigma2_servicemp3epl
E2_PLUGIN_DEPS += enigma2_serviceapp
endif
ifeq ($(MEDIAFW), gst-eplayer3-dual)
E2_PLUGIN_DEPS += enigma2_serviceapp
endif
endif
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small))
E2_PLUGIN_DEPS += $(D)/enigma2_networkbrowser
endif
ifneq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small size))
E2_PLUGIN_DEPS += $(D)/enigma2_blurayplayer
endif

$(D)/enigma2-plugins: $(E2_PLUGIN_DEPS)

#
# enigma2-openwebif
#
#OPENWEBIF_PATCH = build-enigma2/enigma2-openwebif.patch

$(D)/enigma2_openwebif: $(D)/bootstrap $(D)/enigma2 $(D)/python_cheetah $(D)/python_ipaddress $(D)/python_pyopenssl
	$(START_BUILD)
	$(REMOVE)/e2openplugin-OpenWebif
	$(SILENT)if [ -d $(ARCHIVE)/e2openplugin-OpenWebif.git ]; \
		then echo -n "Updating OpenWebif.git..."; cd $(ARCHIVE)/e2openplugin-OpenWebif.git; git pull $(MINUS_Q); echo " done."; \
		else echo -n "Cloning OpenWebif.git..."; cd $(ARCHIVE); git clone $(MINUS_Q) https://github.com/E2OpenPlugins/e2openplugin-OpenWebif.git e2openplugin-OpenWebif.git; echo " done."; \
	fi
	$(SILENT)echo -n "Copying source code to build environment..."
	$(SILENT)cp -ra $(ARCHIVE)/e2openplugin-OpenWebif.git $(BUILD_TMP)/e2openplugin-OpenWebif
	$(SILENT)echo " done."
	$(SET) -e; cd $(BUILD_TMP)/e2openplugin-OpenWebif; \
		$(call apply_patches, $(OPENWEBIF_PATCH)); \
		$(BUILDENV) \
		cp -a plugin $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif; \
		python -O -m compileall $(SILENT_OPT) $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/ar/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/bg/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/ca/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/cs/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/da/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/de/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/el/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/es/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/et/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/el/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/fi/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/fr/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/hu/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/it/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/lt/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/nb/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/nl/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/pl/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/pt/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/ru/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/sk/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/sv/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/tr/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/uk/LC_MESSAGES; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/zh_CN/LC_MESSAGES; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/ar/LC_MESSAGES/OpenWebif.mo locale/ar.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/bg/LC_MESSAGES/OpenWebif.mo locale/bg.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/ca/LC_MESSAGES/OpenWebif.mo locale/ca.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/cs/LC_MESSAGES/OpenWebif.mo locale/cs.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/da/LC_MESSAGES/OpenWebif.mo locale/da.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/de/LC_MESSAGES/OpenWebif.mo locale/de.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/el/LC_MESSAGES/OpenWebif.mo locale/el.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/es/LC_MESSAGES/OpenWebif.mo locale/es.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/et/LC_MESSAGES/OpenWebif.mo locale/et.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/fi/LC_MESSAGES/OpenWebif.mo locale/fi.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/fr/LC_MESSAGES/OpenWebif.mo locale/fr.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/hu/LC_MESSAGES/OpenWebif.mo locale/hu.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/it/LC_MESSAGES/OpenWebif.mo locale/it.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/lt/LC_MESSAGES/OpenWebif.mo locale/lt.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/nb/LC_MESSAGES/OpenWebif.mo locale/nb.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/nl/LC_MESSAGES/OpenWebif.mo locale/nl.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/pl/LC_MESSAGES/OpenWebif.mo locale/pl.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/pt/LC_MESSAGES/OpenWebif.mo locale/pt.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/ru/LC_MESSAGES/OpenWebif.mo locale/ru.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/sk/LC_MESSAGES/OpenWebif.mo locale/sk.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/sv/LC_MESSAGES/OpenWebif.mo locale/sv.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/tr/LC_MESSAGES/OpenWebif.mo locale/tr.po; \
		msgfmt -o $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/uk/LC_MESSAGES/OpenWebif.mo locale/uk.po
ifeq ($(OPTIMIZATIONS), $(filter $(OPTIMIZATIONS), small size))
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/ar.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/bg.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/ca.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/cs.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/da.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/de.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/el.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/es.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/et.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/fi.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/fr.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/hu.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/it.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/lt.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/nb.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/nl.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/pl.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/pt.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/ru.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/sk.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/sv.po
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/locale/tr.po
endif
# Remove non-SH4 remote control, box pictures and html files
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{alphatriplehd.png,dm500hd.png,dm520.png,dm7020hd.png,dm7080.png,dm8000.png,dm800.jpg,dm800se.png,dm820.png,dm900.png,dm920.png,e3hd.jpg}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{e4hd.png,elite.jpg,et10000.png,et11000.png,et4x00.png,et5x00.png,et6500.png,et6x00.png,et7000.png,et7500.png,et7x00mini.png,et7x00.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{et8000.png,et8500.png,et8500s.jpg,et9x00.png,formuler1.png,formuler3.png,formuler4.png,formuler4turbo.png,fusionhd.png,fusionhdse.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{galaxy4k.png,gb800ueplus.jpg,gbquad4k.png,gbquad.jpg,gbtrio4k.png,gbue4k.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{h10.2h.png,h10.2s.png,h10.t.png,h11.png,h3.png,h4.png,h5.png,h6.png,h7.png,h8.2h.png,h8.png,h9.2h.png,h9.2s.png,h9combo.png,h9combose.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{h9.png,h9se.2h.png,h9se.2s.png,h9se.s.png,h9.s.png,h9.t.png,h9twin.png,h9twinse.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{h8.2h.png,h8.png,h9.2h.png,h9.2s.png,h9combose.png,h9se.2h.png,h9se.2s.png,h9se.s.png,h9.s.png,h9.t.png,h9twin.png,h9twinse.png,hzero.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{hd1100.png,hd11.png,hd1200.png,hd1265.png,hd1500.png,hd2400.png,hd500c.png,hd51.png,hd530c.png,hd60.png,hzero.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{i55plus.png,i55.png,ini-1000.jpg,ini-3000.jpg,ini-5000.jpg,ini-7000.jpg,ixussone.jpg,ixusszero.jpg,lc.png,lunix3-4k.png,lunix4k.png,lunix.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{mbmicro.png,mbmicrov2.png,mbtwinplus.png,me.jpg,minime.jpg,miraclebox.jpg,multibox.png,multiboxse.jpg}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{optimussos1.jpg,optimussos1plus.jpg,optimussos2.jpg,optimussos2plus.jpg,osmega.png,osmini4k.png,osminiplus.png,osmini.png,osmio4kplus.png,osmio4k.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{osninoplus.png,osnino.png,osninopro.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{premium.jpg,premium+.jpg,pulse4k.png,purehd.png,purehdse.png,revo4k.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{sf4008.png,sf8008c.png,sf8008m.png,sf8008s.png,sf8008t.png,sh1.png,spycat4kmini.png,spycatminiplus.png,spycatmini.png,spycat.png,ultra.jpg}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{vipercombohdd.png,vipercombo.png,viperslim.png,vipert2c.png,vs1000.png,vs1500.png,ustym4kpro.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{vuduo2.png,vuduo4k.png,vuduo4kse.png,vuduo.png,vusolo2.png,vusolo4k.png,vusolo.png,vusolose.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{vuultimo4k.png,vuultimo.png,vuuno4k.png,vuuno4kse.png,vuuno.png,vuzero4k.png,vuzero.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/boxes/{wetekplay.png,xcombo.jpg,xp1000.png,xpeedlx3.jpg,xpeedlx.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/{alphatriplehd.png,amiko1.png,amiko.png,dmm2.png,dm_normal.png,e3hd.png,e4hd.png,edision1.png,edision2.png,edision3.png,edision4.png,elite.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/{et6500.png,et7000mini.png,et7x00.png,et8000.png,et_rc13_normal.png,et_rc5_normal.png,et_rc7_normal.png,formuler1.png,fusionhd.png,fusionhdse.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/{galaxy4k.png,gb7252.png,gbquadplus.png,gigablue_black.png,h3.png,hd1x00.png,hd2400.png,hd60.png,i55.png,ini-1000.png,ini-3000.png,ini-5000.png,ini-7000.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/{ixussone.png,ixusszero.png,lunix4k.png,me.png,miraclebox2.png,miraclebox.png,multibox.png,nbox.png,octagon.png,optimuss.png,osmini.png,premium.png,pulse4k.png,purehd.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/{qviart.png,revo4k.png,sh1.png,spark.png,spycat.png,uclan.png,viperslim.png,vs1x00.png,vu_duo2.png,vu_normal_02.png,vu_normal.png,vu_ultimo.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/{wetekplay.png,xcombo.png,xpeedlx.png,xp_rc14_normal.png}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/static/remotes/{alphatriplehd.html,amiko.html,amiko1.html,dmm.html,dmm1.html,dmm2.html,e3hd.html,e4hd.html}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/static/remotes/{edision1.html,edision2.html,edision3.html,edision4.html,elite.html,et4x00.html,et5x00.html,et6500.html,et7000mini.html,et7x00.html,et8000.html,et9x00.html}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/static/remotes/{formuler1.html,fusionhd.html,fusionhdse.html,galaxy4k.html,gb7252.html,gbquadplus.html,gigablue.html}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/static/remotes/{h3.html,hd1x00.html,hd2400.html,hd60.html,i55.html,ini-1000.html,ini-3000.html,ini-5000.html,ini-7000.html}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/static/remotes/{ixussone.html,ixusszero.html,lunix4k.html,me.html,miraclebox.html,miraclebox2.html,multibox.html}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/static/remotes/{octagon.html,optimuss.html,osmini.html,premium.html,pulse4k.html,purehd.html,qviart.html}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/static/remotes/{revo4k.html,sh1.html,spark.html,spycat.html,uclan.html,ufs913.html,viperslim.html,vs1x00.html}
		$(SILENT)rm -f $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/static/remotes/{vu_duo2.html,vu_normal.html,vu_normal_02.html,vu_ultimo.html,wetekplay.html,xcombo.html,xp1000.html,xpeedlx.html}
#		Link SH4 remote pictures
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_adb_box.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/adb_xmp.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_cuberevo.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/cuberevo.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_cuberevo_uni.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/cuberevo_uni.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_fs9000.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/fs9000.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_hs9510.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/hs9510.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_hs7110.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/hs7110.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_spark.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/spark.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_tf7700.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/tf7700.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_ufs910.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/ufs910.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_ufs912.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/ufs912.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_ufs913.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/ufs913.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_vitamin.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/vitamin.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_pace7241.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/pace7241.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_hl101_1.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/hl101_1.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_vip_1.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/vip_1.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_opt9600.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/opt9600.png
#		$(SILENT)cp -f $(SKEL_ROOT)/release/rc_hchs8100.png $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/Extensions/OpenWebif/public/images/remotes/hchs8100.png
		$(REMOVE)/e2openplugin-OpenWebif
	$(TOUCH)

#
# enigma2-networkbrowser
#
#ENIGMA2_NETWORBROWSER_PATCH = build-enigma2/enigma2-networkbrowser-support-autofs.patch

$(D)/enigma2_networkbrowser: $(D)/bootstrap $(D)/enigma2
	$(START_BUILD)
	$(REMOVE)/enigma2-networkbrowser
	$(SILENT)if [ -d $(ARCHIVE)/enigma2-plugins.git ]; \
		then cd $(ARCHIVE)/enigma2-plugins.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) https://github.com/OpenPLi/enigma2-plugins.git enigma2-plugins.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/enigma2-plugins.git/networkbrowser/ $(BUILD_TMP)/enigma2-networkbrowser
	$(SET) -e; cd $(BUILD_TMP)/enigma2-networkbrowser; \
		$(call apply_patches,$(ENIGMA2_NETWORBROWSER_PATCH))
	$(SET) -e; cd $(BUILD_TMP)/enigma2-networkbrowser/src/lib; \
		$(BUILDENV) \
		sh4-linux-gcc -shared -o netscan.so \
			-I $(TARGET_DIR)/usr/include/python$(PYTHON_VER_MAJOR) \
			-include Python.h \
			errors.h \
			list.c \
			list.h \
			main.c \
			nbtscan.c \
			nbtscan.h \
			range.c \
			range.h \
			showmount.c \
			showmount.h \
			smb.h \
			smbinfo.c \
			smbinfo.h \
			statusq.c \
			statusq.h \
			time_compat.h
	$(SET) -e; cd $(BUILD_TMP)/enigma2-networkbrowser; \
		mkdir -p $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser; \
		cp -a po $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser/; \
		cp -a meta $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser/; \
		cp -a src/* $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser/; \
		cp -a src/lib/netscan.so $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser/; \
		python -O -m compileall $(SILENT_OPT) $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser; \
		rm -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser/lib; \
		rm -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser/Makefile.am; \
		rm -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser/icons/Makefile.am; \
		rm -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser/meta/Makefile.am; \
		rm -rf $(TARGET_DIR)/usr/lib/enigma2/python/Plugins/SystemPlugins/NetworkBrowser/po/Makefile.am
	$(REMOVE)/enigma2-networkbrowser
	$(TOUCH)

#
# enigma2-servicemp3
#
SERVICEMP3_VER       = 0.1
SERVICEMP3_DEPS      = $(D)/bootstrap $(D)/enigma2
SERVICEMP3_CPPFLAGS  = -std=c++11
SERVICEMP3_CPPFLAGS += -I$(TARGET_DIR)/usr/include/python$(PYTHON_VER_MAJOR)
SERVICEMP3_CPPFLAGS += -I$(SOURCE_DIR)/enigma2
SERVICEMP3_CPPFLAGS += -I$(SOURCE_DIR)/enigma2/include
SERVICEMP3_CPPFLAGS += -I$(KERNEL_DIR)/include
SERVICEMP3_PATCH     = build-enigma2/enigma2-servicemp3-$(SERVICEMP3_VER).patch

ifeq ($(MEDIAFW), eplayer3)
SERVICEMP3_DEPS     += $(D)/tools-eplayer3
SERVICEMP3_CONF     += --enable-libeplayer3
endif

ifeq ($(MEDIAFW), gstreamer)
SERVICEMP3_DEPS    += $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugins_multibox_dvbmediasink
SERVICEMP3_DEPS    += $(D)/gst_plugins_good $(D)/gst_plugins_bad $(D)/gst_plugins_ugly
SERVICEMP3_CONF    += --enable-mediafwgstreamer
SERVICEMP3_CONF    += --with-gstversion=1.0
endif

ifeq ($(MEDIAFW), gst-eplayer3)
SERVICEMP3_DEPS    += $(D)/tools-libeplayer3
SERVICEMP3_DEPS    += $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugins_multibox_dvbmediasink
SERVICEMP3_DEPS    += $(D)/gst_plugins_good $(D)/gst_plugins_bad $(D)/gst_plugins_ugly
SERVICEMP3_CONF    += --enable-libeplayer3
SERVICEMP3_CONF    += --enable-mediafwgstreamer
SERVICEMP3_CONF    += --with-gstversion=1.0
endif

$(D)/enigma2_servicemp3: | $(SERVICEMP3_DEPS)
	$(START_BUILD)
	$(REMOVE)/enigma2-servicemp3-$(SERVICEMP3_VER)
	$(SILENT)if [ -d $(ARCHIVE)/enigma2-servicemp3-$(SERVICEMP3_VER).git ]; \
		then cd $(ARCHIVE)/enigma2-servicemp3-$(SERVICEMP3_VER).git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) https://github.com/OpenPLi/servicemp3.git enigma2-servicemp3-$(SERVICEMP3_VER).git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/enigma2-servicemp3-$(SERVICEMP3_VER).git/ $(BUILD_TMP)/enigma2-servicemp3-$(SERVICEMP3_VER)
	$(SET) -e; cd $(BUILD_TMP)/enigma2-servicemp3-$(SERVICEMP3_VER); \
		$(call apply_patches,$(SERVICEMP3_PATCH)); \
		./autogen.sh $(SILENT_OPT); \
		$(BUILDENV) \
		$(CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
			--enable-silent-rules \
			$(SERVICEMP3_CONF) \
			CPPFLAGS="$(SERVICEMP3_CPPFLAGS)" \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/enigma2-servicemp3-$(SERVICEMP3_VER)
	$(TOUCH)

#
# enigma2-servicemp3epl
#
SERVICEMP3EPL_VER       = 0.1
SERVICEMP3EPL_DEPS      = $(D)/bootstrap $(D)/enigma2
SERVICEMP3EPL_DEPS      = $(D)/libsigc
SERVICEMP3EPL_URL       = https://github.com/Audioniek/servicemp3epl.git
#SERVICEMP3EPL_BRANCH    = master
SERVICEMP3EPL_CPPFLAGS  = -std=c++11
SERVICEMP3EPL_CPPFLAGS += -I$(TARGET_DIR)/usr/include/python$(PYTHON_VER_MAJOR)
SERVICEMP3EPL_CPPFLAGS += -I$(SOURCE_DIR)/enigma2
SERVICEMP3EPL_CPPFLAGS += -I$(SOURCE_DIR)/enigma2/include
SERVICEMP3EPL_CPPFLAGS += -I$(KERNEL_DIR)/include
SERVICEMP3EPL_CPPFLAGS += -I$(APPS_DIR)/libeplayer3/include
#SERVICEMP3EPL_PATCH     = build-enigma2/enigma2-servicemp3epl-$(SERVICEMP3EPL_VER).patch

ifeq ($(MEDIAFW), gstreamer)
SERVICEMP3EPL_DEPS     += $(D)/tools-libeplayer3
SERVICEMP3EPL_CONF     += --enable-libeplayer3
endif

ifeq ($(MEDIAFW), gstreamer)
SERVICEMP3EPL_DEPS     += $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugins_multibox_dvbmediasink
SERVICEMP3EPL_DEPS     += $(D)/gst_plugins_good $(D)/gst_plugins_bad $(D)/gst_plugins_ugly
SERVICEMP3EPL_CONF     += --enable-libeplayer3
SERVICEMP3EPL_CONF     += --enable-gstreamer
SERVICEMP3EPL_CONF     += --enable-dual_mediafw
endif

ifeq ($(MEDIAFW), gstreamer)
SERVICEMP3EPL_DEPS     += $(D)/tools-libeplayer3
SERVICEMP3EPL_DEPS     += $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugins_multibox_dvbmediasink
SERVICEMP3EPL_DEPS     += $(D)/gst_plugins_good $(D)/gst_plugins_bad $(D)/gst_plugins_ugly
SERVICEMP3EPL_CONF     += --enable-libeplayer3
SERVICEMP3EPL_CONF     += --enable-gstreamer
endif

#ifeq ($(MEDIAFW), gst-eplayer3-dual)
#SERVICEMP3EPL_DEPS     += $(D)/tools-libeplayer3
#SERVICEMP3EPL_DEPS     += $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugins_multibox_dvbmediasink
#SERVICEMP3EPL_DEPS     += $(D)/gst_plugins_good $(D)/gst_plugins_bad $(D)/gst_plugins_ugly
#SERVICEMP3EPL_CONF     += --enable-dual_mediafw
#endif

$(D)/enigma2_servicemp3epl: | $(SERVICEMP3EPL_DEPS)
	$(START_BUILD)
	$(REMOVE)/enigma2-servicemp3epl-$(SERVICEMP3EPL_VER)
	$(SILENT)if [ -d $(ARCHIVE)/enigma2-servicemp3epl-$(SERVICEMP3EPL_VER).git ]; \
		then cd $(ARCHIVE)/enigma2-servicemp3epl-$(SERVICEMP3EPL_VER).git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) $(SERVICEMP3EPL_URL) -b $(SERVICEMP3EPL_BRANCH) enigma2-servicemp3epl-$(SERVICEMP3EPL_VER).git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/enigma2-servicemp3epl-$(SERVICEMP3EPL_VER).git/ $(BUILD_TMP)/enigma2-servicemp3epl-$(SERVICEMP3EPL_VER)
	$(SET) -e; cd $(BUILD_TMP)/enigma2-servicemp3epl-$(SERVICEMP3EPL_VER); \
		$(call apply_patches,$(SERVICEMP3EPL_PATCH)); \
		./autogen.sh $(SILENT_OPT); \
		$(BUILDENV) \
		$(CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
			--enable-silent-rules \
			$(SERVICEMP3EPL_CONF) \
			CPPFLAGS="$(SERVICEMP3EPL_CPPFLAGS)" \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/enigma2-servicemp3epl-$(SERVICEMP3EPL_VER)
	$(TOUCH)

#
# enigma2-serviceapp
#
SERVICEAPP_VER       = 0.1
SERVICEAPP_CPPFLAGS  = -std=c++11
SERVICEAPP_CPPFLAGS += -I$(TARGET_DIR)/usr/include/python$(PYTHON_VER_MAJOR)
SERVICEAPP_CPPFLAGS += -I$(SOURCE_DIR)/enigma2
SERVICEAPP_CPPFLAGS += -I$(SOURCE_DIR)/enigma2/include
SERVICEAPP_CPPFLAGS += -I$(KERNEL_DIR)/include
#SERVICEAPP_PATCH     = build-enigma2/enigma2-serviceapp-$(SERVICEAPP_VER).patch

$(D)/enigma2_serviceapp: $(D)/bootstrap $(D)/enigma2 $(D)/enigma2_servicemp3epl $(D)/uchardet
	$(START_BUILD)
	$(REMOVE)/enigma2-serviceapp-$(SERVICEAPP_VER)
	$(SILENT)if [ -d $(ARCHIVE)/enigma2-serviceapp-$(SERVICEAPP_VER).git ]; \
		then cd $(ARCHIVE)/enigma2-serviceapp-$(SERVICEAPP_VER).git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) -b develop https://github.com/ostende/serviceapp.git enigma2-serviceapp-$(SERVICEAPP_VER).git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/enigma2-serviceapp-$(SERVICEAPP_VER).git/ $(BUILD_TMP)/enigma2-serviceapp-$(SERVICEAPP_VER)
	$(SET) -e; cd $(BUILD_TMP)/enigma2-serviceapp-$(SERVICEAPP_VER); \
		$(call apply_patches,$(SERVICEAPP_PATCH)); \
		$(BUILDENV) \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
			--enable-silent-rules \
			$(SERVICEAPP_CONF) \
			CPPFLAGS="$(SERVICEAPP_CPPFLAGS)" \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/enigma2-serviceapp-$(SERVICEAPP_VER)
	$(TOUCH)

#
# enigma2-blurayplayer
#
BLURAYPLAYER_VER   = 1.0
BLURAYPLAYER_PATCH =

$(D)/enigma2_blurayplayer: $(D)/bootstrap $(D)/enigma2 $(D)/libudfread $(D)/libbluray $(D)/python $(D)/python_setuptools
	$(START_BUILD)
	$(REMOVE)/enigma2-blurayplayer-$(BLURAYPLAYER_VER)
	$(SILENT)if [ -d $(ARCHIVE)/enigma2-plugin-blurayplayer.git ]; \
		then cd $(ARCHIVE)/enigma2-plugin-blurayplayer.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) -b openpli https://github.com/Taapat/enigma2-plugin-blurayplayer enigma2-plugin-blurayplayer.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/enigma2-plugin-blurayplayer.git/ $(BUILD_TMP)/enigma2-blurayplayer-$(BLURAYPLAYER_VER)
	$(SET) -e; cd $(BUILD_TMP)/enigma2-blurayplayer-$(BLURAYPLAYER_VER); \
		$(call apply_patches,$(BLURAYPLAYER_PATCH)); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/enigma2-blurayplayer-$(BLURAYPLAYER_VER)
	$(TOUCH)

#
# enigma2-fullbackup
#
FULLBACKUP_VER   = 4.2
FULLBACKUP_URL   = https://github.com/Dima73/automatic-full-backup
#FULLBACKUP_PATCH = fullbackup_$(FULLBACKUP_VER)_add_sh4.patch

$(D)/enigma2_fullbackup: $(D)/bootstrap $(D)/enigma2 $(D)/ofgwrite $(D)/python $(D)/python_setuptools
	$(START_BUILD)
	$(REMOVE)/enigma2-plugin-fullbackup-$(FULLBACKUP_VER)
	$(SILENT)if [ -d $(ARCHIVE)/enigma2-plugin-fullbackup.git ]; \
		then cd $(ARCHIVE)/enigma2-plugin-fullbackup.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) $(FULLBACKUP_URL) enigma2-plugin-fullbackup.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/enigma2-plugin-fullbackup.git/ $(BUILD_TMP)/enigma2-plugin-fullbackup-$(FULLBACKUP_VER)
	$(SILENT)if [ ! -d $(BUILD_TMP)/enigma2-plugin-fullbackup-$(FULLBACKUP_VER)/bin/sh4 ]; then \
		mkdir -p $(BUILD_TMP)/enigma2-plugin-fullbackup-$(FULLBACKUP_VER)/bin/sh4; \
	fi
	$(SET) -e; cd $(BUILD_TMP)/enigma2-plugin-fullbackup-$(FULLBACKUP_VER); \
		$(call apply_patches,$(FULLBACKUP_PATCH)); \
		cp $(TARGET_DIR)/usr/bin/ofgwrite_bin $(BUILD_TMP)/enigma2-plugin-fullbackup-$(FULLBACKUP_VER)/bin/sh4/; \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
#	$(REMOVE)/enigma2-plugin-fullbackup-$(FULLBACKUP_VER)
	$(TOUCH)


