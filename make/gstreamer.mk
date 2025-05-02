#
# gstreamer
#
GSTREAMER_VER = 1.16.3
GSTREAMER_SOURCE = gstreamer-$(GSTREAMER_VER).tar.xz
GSTREAMER_PATCH  = gstreamer-$(GSTREAMER_VER)-fix-crash-with-gst-inspect.patch
GSTREAMER_PATCH += gstreamer-$(GSTREAMER_VER)-revert-use-new-gst-adapter-get-buffer.patch

$(ARCHIVE)/$(GSTREAMER_SOURCE):
	$(WGET) https://gstreamer.freedesktop.org/src/gstreamer/$(GSTREAMER_SOURCE)

$(D)/gstreamer: $(D)/bootstrap $(D)/libglib2 $(D)/libxml2 $(D)/glib_networking $(ARCHIVE)/$(GSTREAMER_SOURCE)
	$(START_BUILD)
	$(REMOVE)/gstreamer-$(GSTREAMER_VER)
	$(UNTAR)/$(GSTREAMER_SOURCE)
	$(CH_DIR)/gstreamer-$(GSTREAMER_VER); \
		$(call apply_patches, $(GSTREAMER_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--libexecdir=/usr/lib \
			--datarootdir=/.remove \
			--disable-dependency-tracking \
			--disable-check \
			--disable-gst-debug \
			--disable-examples \
			--disable-benchmarks \
			--disable-tests \
			--disable-debug \
			--disable-gtk-doc \
			--disable-gtk-doc-html \
			--disable-gtk-doc-pdf \
			--enable-introspection=no \
			ac_cv_header_valgrind_valgrind_h=no \
			ac_cv_header_sys_poll_h=no \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-base-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-controller-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-net-1.0.pc
	$(REWRITE_LIBTOOL)/libgstreamer-1.0.la
	$(REWRITE_LIBTOOL)/libgstbase-1.0.la
	$(REWRITE_LIBTOOL)/libgstcontroller-1.0.la
	$(REWRITE_LIBTOOL)/libgstnet-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstbase-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstcontroller-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstnet-1.0.la
	$(REMOVE)/gstreamer-$(GSTREAMER_VER)
	$(TOUCH)

#
# gst_plugins_base
#
GST_PLUGINS_BASE_VER = $(GSTREAMER_VER)
GST_PLUGINS_BASE_SOURCE = gst-plugins-base-$(GST_PLUGINS_BASE_VER).tar.xz
GST_PLUGINS_BASE_PATCH  = gst-plugins-base-$(GST_PLUGINS_BASE_VER)-riff-media-added-fourcc-to-all-mpeg4-video-caps.patch
GST_PLUGINS_BASE_PATCH += gst-plugins-base-$(GST_PLUGINS_BASE_VER)-riff-media-added-fourcc-to-all-ffmpeg-mpeg4-video-ca.patch
GST_PLUGINS_BASE_PATCH += gst-plugins-base-$(GST_PLUGINS_BASE_VER)-subparse-avoid-false-negatives-dealing-with-UTF-8.patch
GST_PLUGINS_BASE_PATCH += gst-plugins-base-$(GST_PLUGINS_BASE_VER)-taglist-not-send-to-down-stream-if-all-the-frame-cor.patch

$(ARCHIVE)/$(GST_PLUGINS_BASE_SOURCE):
	$(WGET) https://gstreamer.freedesktop.org/src/gst-plugins-base/$(GST_PLUGINS_BASE_SOURCE)

$(D)/gst_plugins_base: $(D)/bootstrap $(D)/libglib2 $(D)/orc $(D)/gstreamer $(D)/alsa_lib $(D)/libogg $(D)/libvorbis $(ARCHIVE)/$(GST_PLUGINS_BASE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/gst-plugins-base-$(GST_PLUGINS_BASE_VER)
	$(UNTAR)/$(GST_PLUGINS_BASE_SOURCE)
	$(CH_DIR)/gst-plugins-base-$(GST_PLUGINS_BASE_VER); \
		$(call apply_patches, $(GST_PLUGINS_BASE_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--datarootdir=/.remove \
			--disable-libvisual \
			--disable-valgrind \
			--disable-debug \
			--disable-examples \
			--disable-debug \
			--disable-gtk-doc \
			--disable-gtk-doc-html \
			--disable-gtk-doc-pdf \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(SILENT)for i in `cd $(TARGET_DIR)/usr/lib/gstreamer-1.0; echo *.la`; do \
		$(REWRITE_LIBTOOL_NQ)/gstreamer-1.0/$$i; done
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-allocators-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-app-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-audio-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-fft-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-pbutils-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-riff-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-rtp-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-rtsp-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-sdp-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-tag-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-video-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-plugins-base-1.0.pc
	$(REWRITE_LIBTOOL)/libgstallocators-1.0.la
	$(REWRITE_LIBTOOL)/libgstapp-1.0.la
	$(REWRITE_LIBTOOL)/libgstaudio-1.0.la
	$(REWRITE_LIBTOOL)/libgstfft-1.0.la
	$(REWRITE_LIBTOOL)/libgstpbutils-1.0.la
	$(REWRITE_LIBTOOL)/libgstriff-1.0.la
	$(REWRITE_LIBTOOL)/libgstrtp-1.0.la
	$(REWRITE_LIBTOOL)/libgstrtsp-1.0.la
	$(REWRITE_LIBTOOL)/libgstsdp-1.0.la
	$(REWRITE_LIBTOOL)/libgsttag-1.0.la
	$(REWRITE_LIBTOOL)/libgstvideo-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstallocators-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstapp-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstaudio-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstfft-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstpbutils-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstriff-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstrtp-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstrtsp-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstsdp-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgsttag-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstvideo-1.0.la
	$(REMOVE)/gst-plugins-base-$(GST_PLUGINS_BASE_VER)
	$(TOUCH)

#
# gst_plugins_good
#
GST_PLUGINS_GOOD_VER = $(GSTREAMER_VER)
GST_PLUGINS_GOOD_SOURCE = gst-plugins-good-$(GST_PLUGINS_GOOD_VER).tar.xz
GST_PLUGINS_GOOD_PATCH =

$(ARCHIVE)/$(GST_PLUGINS_GOOD_SOURCE):
	$(WGET) https://gstreamer.freedesktop.org/src/gst-plugins-good/$(GST_PLUGINS_GOOD_SOURCE)

$(D)/gst_plugins_good: $(D)/bootstrap $(D)/gstreamer $(D)/gst_plugins_base $(D)/orc $(D)/libsoup $(D)/flac $(D)/mpg123 $(ARCHIVE)/$(GST_PLUGINS_GOOD_SOURCE)
	$(START_BUILD)
	$(REMOVE)/gst-plugins-good-$(GST_PLUGINS_GOOD_VER)
	$(UNTAR)/$(GST_PLUGINS_GOOD_SOURCE)
	$(CH_DIR)/gst-plugins-good-$(GST_PLUGINS_GOOD_VER); \
		$(call apply_patches, $(GST_PLUGINS_GOOD_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--datarootdir=/.remove \
			--enable-oss \
			--enable-gst_v4l2 \
			--without-libv4l2 \
			--disable-aalib \
			--disable-examples \
			--disable-debug \
			--disable-gtk-doc \
			--disable-gtk-doc-html \
			--disable-gtk-doc-pdf \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(SILENT)for i in `cd $(TARGET_DIR)/usr/lib/gstreamer-1.0; echo *.la`; do \
		$(REWRITE_LIBTOOL_NQ)/gstreamer-1.0/$$i; done
	$(REMOVE)/gst-plugins-good-$(GST_PLUGINS_GOOD_VER)
	$(TOUCH)

#
# gst_plugins_bad
#
GST_PLUGINS_BAD_VER = $(GSTREAMER_VER)
GST_PLUGINS_BAD_SOURCE = gst-plugins-bad-$(GST_PLUGINS_BAD_VER).tar.xz
GST_PLUGINS_BAD_PATCH  = gst-plugins-bad-$(GST_PLUGINS_BAD_VER)-hls-use-max-playlist-quality.patch
GST_PLUGINS_BAD_PATCH += gst-plugins-bad-$(GST_PLUGINS_BAD_VER)-rtmp-fix-seeking-and-potential-segfault.patch
GST_PLUGINS_BAD_PATCH += gst-plugins-bad-$(GST_PLUGINS_BAD_VER)-mpegtsdemux-only-wait-for-PCR-when-PCR-pid.patch
GST_PLUGINS_BAD_PATCH += gst-plugins-bad-$(GST_PLUGINS_BAD_VER)-dvbapi5-fix-old-kernel.patch

$(ARCHIVE)/$(GST_PLUGINS_BAD_SOURCE):
	$(WGET) https://gstreamer.freedesktop.org/src/gst-plugins-bad/$(GST_PLUGINS_BAD_SOURCE)

$(D)/gst_plugins_bad: $(D)/bootstrap $(D)/gstreamer $(D)/gst_plugins_base $(D)/orc $(D)/libglib2 $(ARCHIVE)/$(GST_PLUGINS_BAD_SOURCE)
	$(START_BUILD)
	$(REMOVE)/gst-plugins-bad-$(GST_PLUGINS_BAD_VER)
	$(UNTAR)/$(GST_PLUGINS_BAD_SOURCE)
	$(CH_DIR)/gst-plugins-bad-$(GST_PLUGINS_BAD_VER); \
		$(call apply_patches, $(GST_PLUGINS_BAD_PATCH)); \
		$(BUILDENV) \
		autoreconf --force --install $(SILENT_OPT); \
		$(CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
			--datarootdir=/.remove \
			--disable-gtk-doc \
			--disable-gtk-doc-html \
			--disable-gtk-doc-pdf \
			--disable-fatal-warnings \
			--enable-dvb \
			--enable-shm \
			--enable-fbdev \
			--enable-decklink \
			--enable-dts \
			--enable-mpegdemux \
			--disable-android_media \
			--disable-apple_media \
			--disable-avc \
			--disable-chromaprint \
			--disable-dc1394 \
			--disable-direct3d \
			--disable-directsound \
			--disable-gme \
			--disable-gsm \
			--disable-kate \
			--disable-ladspa \
			--disable-lv2 \
			--disable-mpeg2enc \
			--disable-mplex \
			--disable-musepack \
			--disable-ofa \
			--disable-opencv \
			--disable-openjpeg \
			--disable-opensles \
			--disable-resindvd \
			--disable-soundtouch \
			--disable-spandsp \
			--disable-srtp \
			--disable-teletextdec \
			--disable-vdpau \
			--disable-voaacenc \
			--disable-voamrwbenc \
			--disable-wasapi \
			--disable-wayland \
			--disable-wildmidi \
			--disable-winscreencap \
			--disable-x265 \
			--disable-zbar \
			--disable-examples \
			--disable-debug \
			--enable-orc \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(SILENT)for i in `cd $(TARGET_DIR)/usr/lib/gstreamer-1.0; echo *.la`; do \
		$(REWRITE_LIBTOOL_NQ)/gstreamer-1.0/$$i; done
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-codecparsers-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-bad-audio-1.0.pc
#	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-bad-video-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-insertbin-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-mpegts-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-player-1.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gstreamer-plugins-bad-1.0.pc
	$(REWRITE_LIBTOOL)/libgstbasecamerabinsrc-1.0.la
	$(REWRITE_LIBTOOL)/libgstcodecparsers-1.0.la
	$(REWRITE_LIBTOOL)/libgstphotography-1.0.la
	$(REWRITE_LIBTOOL)/libgstadaptivedemux-1.0.la
	$(REWRITE_LIBTOOL)/libgstbadaudio-1.0.la
#	$(REWRITE_LIBTOOL)/libgstbadvideo-1.0.la
	$(REWRITE_LIBTOOL)/libgstinsertbin-1.0.la
	$(REWRITE_LIBTOOL)/libgstmpegts-1.0.la
	$(REWRITE_LIBTOOL)/libgstplayer-1.0.la
	$(REWRITE_LIBTOOL)/libgsturidownloader-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstbadaudio-1.0.la
	$(REWRITE_LIBTOOLDEP)/libgstadaptivedemux-1.0.la
#	$(REWRITE_LIBTOOLDEP)/libgstbadvideo-1.0.la
	$(REMOVE)/gst-plugins-bad-$(GST_PLUGINS_BAD_VER)
	$(TOUCH)

#
# gst_plugins_ugly
#
GST_PLUGINS_UGLY_VER = $(GSTREAMER_VER)
GST_PLUGINS_UGLY_SOURCE = gst-plugins-ugly-$(GST_PLUGINS_UGLY_VER).tar.xz
GST_PLUGINS_UGLY_PATCH =

$(ARCHIVE)/$(GST_PLUGINS_UGLY_SOURCE):
	$(WGET) https://gstreamer.freedesktop.org/src/gst-plugins-ugly/$(GST_PLUGINS_UGLY_SOURCE)

$(D)/gst_plugins_ugly: $(D)/bootstrap $(D)/gstreamer $(D)/orc $(D)/libglib2 $(D)/gst_plugins_base $(ARCHIVE)/$(GST_PLUGINS_UGLY_SOURCE)
	$(START_BUILD)
	$(REMOVE)/gst-plugins-ugly-$(GST_PLUGINS_UGLY_VER)
	$(UNTAR)/$(GST_PLUGINS_UGLY_SOURCE)
	$(CH_DIR)/gst-plugins-ugly-$(GST_PLUGINS_UGLY_VER); \
		$(call apply_patches, $(GST_PLUGINS_UGLY_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--datarootdir=/.remove \
			--disable-fatal-warnings \
			--disable-amrnb \
			--disable-amrwb \
			--disable-sidplay \
			--disable-debug \
			--disable-gtk-doc \
			--disable-gtk-doc-html \
			--disable-gtk-doc-pdf \
			--enable-orc \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(SILENT)for i in `cd $(TARGET_DIR)/usr/lib/gstreamer-1.0; echo *.la`; do \
		$(REWRITE_LIBTOOL_NQ)/gstreamer-1.0/$$i; done
	$(REMOVE)/gst-plugins-ugly-$(GST_PLUGINS_UGLY_VER)
	$(TOUCH)

#
# gst_libav
#
GST_LIBAV_VER = $(GSTREAMER_VER)
GST_LIBAV_SOURCE = gst-libav-$(GST_LIBAV_VER).tar.xz
GST_LIBAV_PATCH  = gst-libav-$(GST_LIBAV_VER)-disable-yasm-for-libav-when-disable-yasm.patch
GST_LIBAV_PATCH += gst-libav-$(GST_LIBAV_VER)-fix-sh4-compile-gcc48.patch
GST_LIBAV_PATCH += gst-libav-$(GST_LIBAV_VER)-fix_aclocal_version.patch
GST_LIBAV_CONF   = --enable-gpl
GST_LIBAV_CONF  += --enable-static
GST_LIBAV_CONF  += --enable-pic
GST_LIBAV_CONF  += --disable-protocols
GST_LIBAV_CONF  += --disable-devices
GST_LIBAV_CONF  += --disable-network
GST_LIBAV_CONF  += --disable-hwaccels
GST_LIBAV_CONF  += --disable-filters
GST_LIBAV_CONF  += --disable-doc
GST_LIBAV_CONF  += --disable-gtk-doc
GST_LIBAV_CONF  += --disable-gtk-doc-html
GST_LIBAV_CONF  += --disable-gtk-doc-pdf
GST_LIBAV_CONF  += --enable-optimizations
GST_LIBAV_CONF  += --enable-cross-compile
GST_LIBAV_CONF  += --target-os=linux
GST_LIBAV_CONF  += --disable-x86asm
GST_LIBAV_CONF  += --arch=sh4
GST_LIBAV_CONF  += --cross-prefix=$(TARGET)-
GST_LIBAV_CONF  += --disable-muxers
GST_LIBAV_CONF  += --disable-encoders
GST_LIBAV_CONF  += --disable-decoders
GST_LIBAV_CONF  += --enable-decoder=ogg
GST_LIBAV_CONF  += --enable-decoder=vorbis
GST_LIBAV_CONF  += --enable-decoder=flac
GST_LIBAV_CONF  += --disable-demuxers
GST_LIBAV_CONF  += --enable-demuxer=ogg
GST_LIBAV_CONF  += --enable-demuxer=vorbis
GST_LIBAV_CONF  += --enable-demuxer=flac
GST_LIBAV_CONF  += --enable-demuxer=mpegts
GST_LIBAV_CONF  += --disable-debug
GST_LIBAV_CONF  += --disable-bsfs
GST_LIBAV_CONF  += --enable-pthreads
GST_LIBAV_CONF  += --enable-bzlib

$(ARCHIVE)/$(GST_LIBAV_SOURCE):
	$(WGET) https://gstreamer.freedesktop.org/src/gst-libav/$(GST_LIBAV_SOURCE)

$(D)/gst_libav: $(D)/bootstrap $(D)/gstreamer $(D)/gst_plugins_base $(D)/libglib2 $(D)/bzip2 $(D)/orc $(ARCHIVE)/$(GST_LIBAV_SOURCE)
	$(START_BUILD)
	$(REMOVE)/gst-libav-$(GST_LIBAV_VER)
	$(UNTAR)/$(GST_LIBAV_SOURCE)
	$(CH_DIR)/gst-libav-$(GST_LIBAV_VER); \
		if [ -e configure ]; then rm -f configure; fi; \
		$(call apply_patches, $(GST_LIBAV_PATCH)); \
		echo $(GST_LIBAV_CONF); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-fatal-warnings \
			--enable-yasm=no \
			--with-libav-extra-configure=" \
			--enable-gpl \
			--enable-static \
			--enable-pic \
			--disable-protocols \
			--disable-devices \
			--disable-network \
			--disable-hwaccels \
			--disable-filters \
			--disable-doc \
			--enable-optimizations \
			--enable-cross-compile \
			--target-os=linux \
			--disable-x86asm \
			--arch=sh4 \
			--cross-prefix=sh4-linux- \
			\
			--disable-muxers \
			--disable-encoders \
			\
			--disable-decoders \
			--enable-decoder=ogg \
			--enable-decoder=vorbis \
			--enable-decoder=flac \
			\
			--disable-demuxers \
			--enable-demuxer=ogg \
			--enable-demuxer=vorbis \
			--enable-demuxer=flac \
			--enable-demuxer=mpegts \
			\
			--disable-debug \
			--disable-bsfs \
			--enable-pthreads \
			--enable-bzlib" \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/gst-libav-$(GST_LIBAV_VER)
	$(TOUCH)
#			--with_libav_extra_configure=$(GST_LIBAV_CONF)

#
# gmediarender
#
GST_GMEDIARENDER_VER = 0.0.6
GST_GMEDIARENDER_SOURCE = gmediarender-$(GST_GMEDIARENDER_VER).tar.bz2
GST_GMEDIARENDER_PATCH =

$(ARCHIVE)/$(GST_GMEDIARENDER_SOURCE):
	$(WGET) http://savannah.nongnu.org/download/gmrender/$(GST_GMEDIARENDER_SOURCE)

$(D)/gst_gmediarender: $(D)/bootstrap $(D)/gst_plugins_multibox_dvbmediasink $(D)/libupnp $(D)/libglib2
	$(START_BUILD)
	$(REMOVE)/gmrender-resurrect
	$(SET) -e; if [ -d $(ARCHIVE)/gmrender-resurrect.git ]; \
		then cd $(ARCHIVE)/gmrender-resurrect.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) https://github.com/hzeller/gmrender-resurrect.git gmrender-resurrect.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/gmrender-resurrect.git $(BUILD_TMP)/gmrender-resurrect
	$(CH_DIR)/gmrender-resurrect; \
		$(call apply_patches, $(GST_GMEDIARENDER_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--with-gstreamer \
			--with-libupnp=$(TARGET_DIR)/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/gmrender-resurrect
	$(TOUCH)

#
# orc
#
#ORC_VER = 0.4.31
ORC_VER = 0.4.29
ORC_SOURCE = orc-$(ORC_VER).tar.xz
ORC_PATCH =

$(ARCHIVE)/$(ORC_SOURCE):
	$(WGET) https://gstreamer.freedesktop.org/src/orc/$(ORC_SOURCE)

$(D)/orc: $(D)/bootstrap $(ARCHIVE)/$(ORC_SOURCE)
	$(START_BUILD)
	$(REMOVE)/orc-$(ORC_VER)
	$(UNTAR)/$(ORC_SOURCE)
	$(CH_DIR)/orc-$(ORC_VER); \
		$(call apply_patches, $(ORC_PATCH)); \
		$(CONFIGURE) \
			--datarootdir=/.remove \
			--prefix=/usr \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/orc-0.4.pc
	$(REWRITE_LIBTOOL)/liborc-0.4.la
	$(REWRITE_LIBTOOL)/liborc-test-0.4.la
	$(REWRITE_LIBTOOLDEP)/liborc-test-0.4.la
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,orc-bugreport orcc)
	$(REMOVE)/orc-$(ORC_VER)
	$(TOUCH)

#
# libdca
#
LIBDCA_VER = 0.0.6
LIBDCA_SOURCE = libdca-$(LIBDCA_VER).tar.bz2
LIBDCA_PATCH =

$(ARCHIVE)/$(LIBDCA_SOURCE):
	$(WGET) http://download.videolan.org/pub/videolan/libdca/$(LIBDCA_VER)/$(LIBDCA_SOURCE)

$(D)/libdca: $(D)/bootstrap $(ARCHIVE)/$(LIBDCA_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libdca-$(LIBDCA_VER)
	$(UNTAR)/$(LIBDCA_SOURCE)
	$(CH_DIR)/libdca-$(LIBDCA_VER); \
		$(call apply_patches, $(LIBDCA_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libdca.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libdts.pc
	$(REWRITE_LIBTOOL)/libdca.la
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,extract_dca extract_dts)
	$(REMOVE)/libdca-$(LIBDCA_VER)
	$(TOUCH)

#
# gst_plugin_subsink
#
GST_PLUGIN_SUBSINK_VER = 1.0
GST_PLUGIN_SUBSINK_PATCH = gst-subsink.patch
GST_PLUGIN_SUBSINK_URL = https://github.com/mx3L/gst-plugin-subsink

$(D)/gst_plugin_subsink: $(D)/bootstrap $(D)/gstreamer $(D)/gst_plugins_base
	$(START_BUILD)
	$(REMOVE)/gstreamer-$(GST_PLUGIN_SUBSINK_VER)-plugin-subsink
	$(SET) -e; if [ -d $(ARCHIVE)/gstreamer$(GST_PLUGIN_SUBSINK_VER)-plugin-subsink.git ]; \
		then cd $(ARCHIVE)/gstreamer$(GST_PLUGIN_SUBSINK_VER)-plugin-subsink.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) $(GST_PLUGIN_SUBSINK_URL) gstreamer$(GST_PLUGIN_SUBSINK_VER)-plugin-subsink.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/gstreamer$(GST_PLUGIN_SUBSINK_VER)-plugin-subsink.git $(BUILD_TMP)/gstreamer$(GST_PLUGIN_SUBSINK_VER)-plugin-subsink
	$(CH_DIR)/gstreamer$(GST_PLUGIN_SUBSINK_VER)-plugin-subsink; \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		if [ ! -d libltdl/m4 ]; then mkdir -p libltdl/m4; fi; \
		$(call apply_patches, $(GST_PLUGIN_SUBSINK_PATCH)); \
		aclocal --force -I m4; \
		libtoolize --copy --ltdl --force $(SILENT_OPT); \
		autoconf --force $(SILENT_OPT); \
		autoheader --force; \
		automake --add-missing --copy --force-missing --foreign; \
		$(CONFIGURE) \
			--prefix=/usr \
			--with-gstversion=$(GST_PLUGIN_SUBSINK_VER) \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(SILENT)for i in `cd $(TARGET_DIR)/usr/lib/gstreamer-1.0; echo *.la`; do \
		$(REWRITE_LIBTOOL_NQ)/gstreamer-1.0/$$i; done
	$(REMOVE)/gstreamer$(GST_PLUGIN_SUBSINK_VER)-plugin-subsink
	$(TOUCH)

#
# gst_plugins_dvbmediasink
#
GST_PLUGINS_DVBMEDIASINK_VER = 1.0
GST_PLUGINS_DVBMEDIASINK_PATCH = gst-plugins-dvbmediasink-$(GST_PLUGINS_DVBMEDIASINK_VER)-add-support-for-gamma-curve.patch

$(D)/gst_plugins_dvbmediasink: $(D)/bootstrap $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugin_subsink $(D)/libdca
	$(START_BUILD)
	$(REMOVE)/gstreamer$(GST_PLUGINS_DVBMEDIASINK_VER)-plugin-dvbmediasink
	$(SET) -e; if [ -d $(ARCHIVE)/gstreamer$(GST_PLUGINS_DVBMEDIASINK_VER)-plugin-dvbmediasink.git ]; \
		then cd $(ARCHIVE)/gstreamer$(GST_PLUGINS_DVBMEDIASINK_VER)-plugin-dvbmediasink.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) -b gst-1.0 https://github.com/OpenPLi/gst-plugin-dvbmediasink.git gstreamer$(GST_PLUGINS_DVBMEDIASINK_VER)-plugin-dvbmediasink.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/gstreamer$(GST_PLUGINS_DVBMEDIASINK_VER)-plugin-dvbmediasink.git $(BUILD_TMP)/gstreamer$(GST_PLUGINS_DVBMEDIASINK_VER)-plugin-dvbmediasink
	$(CH_DIR)/gstreamer$(GST_PLUGINS_DVBMEDIASINK_VER)-plugin-dvbmediasink; \
		$(call apply_patches, $(GST_PLUGINS_DVBMEDIASINK_PATCH)); \
		aclocal --force -I m4; \
		libtoolize --copy --force $(SILENT_OPT); \
		autoconf --force $(SILENT_OPT); \
		autoheader --force; \
		automake --add-missing --copy --force-missing --foreign; \
		$(CONFIGURE) \
			--prefix=/usr \
			--with-wma \
			--with-wmv \
			--with-pcm \
			--with-eac3 \
			--with-dtsdownmix \
			--with-mpeg4v2 \
			--with-h265 \
			--with-vb6 \
			--with-vb8 \
			--with-vb9 \
			--with-spark \
			--with-gstversion=1.0 \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(SILENT)for i in `cd $(TARGET_DIR)/usr/lib/gstreamer-1.0; echo *.la`; do \
		$(REWRITE_LIBTOOL_NQ)/gstreamer-1.0/$$i; done
	$(REMOVE)/gstreamer$(GST_PLUGINS_DVBMEDIASINK_VER)-plugin-dvbmediasink
	$(TOUCH)

#
# gst_plugins_multibox_dvbmediasink
#
GST_PLUGINS_MULTIBOX_DVBMEDIASINK_VER = 1.0
GST_PLUGINS_MULTIBOX_DVBMEDIASINK_PATCH = gst-plugins-multibox-dvbmediasink-$(GST_PLUGINS_MULTIBOX_DVBMEDIASINK_VER)-add-support-for-gamma-curve.patch

$(D)/gst_plugins_multibox_dvbmediasink: $(D)/bootstrap $(D)/gstreamer $(D)/gst_plugins_base $(D)/gst_plugin_subsink $(D)/libdca
	$(START_BUILD)
	$(REMOVE)/gstreamer$(GST_PLUGINS_MULTIBOX_DVBMEDIASINK_VER)-plugin-multibox-dvbmediasink
	$(SET) -e; if [ -d $(ARCHIVE)/gstreamer$(GST_PLUGINS_MULTIBOX_DVBMEDIASINK_VER)-plugin-multibox-dvbmediasink.git ]; \
		then cd $(ARCHIVE)/gstreamer$(GST_PLUGINS_MULTIBOX_DVBMEDIASINK_VER)-plugin-multibox-dvbmediasink.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) -b openatv-dev https://github.com/christophecvr/gstreamer$(GST_PLUGINS_MULTIBOX_DVBMEDIASINK_VER)-plugin-multibox-dvbmediasink.git gstreamer$(GST_PLUGINS_MULTIBOX_DVBMEDIASINK_VER)-plugin-multibox-dvbmediasink.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/gstreamer$(GST_PLUGINS_MULTIBOX_DVBMEDIASINK_VER)-plugin-multibox-dvbmediasink.git $(BUILD_TMP)/gstreamer$(GST_PLUGINS_DVBMEDIASINK_VER)-plugin-multibox-dvbmediasink
	$(CH_DIR)/gstreamer$(GST_PLUGINS_MULTIBOX_DVBMEDIASINK_VER)-plugin-multibox-dvbmediasink; \
		$(call apply_patches, $(GST_PLUGINS_MULTIBOX_DVBMEDIASINK_PATCH)); \
		aclocal --force -I m4; \
		libtoolize --copy --force; \
		autoconf --force; \
		autoheader --force; \
		automake --add-missing --copy --force-missing --foreign; \
		$(CONFIGURE) \
			--prefix=/usr \
			--with-wma \
			--with-wmv \
			--with-pcm \
			--with-eac3 \
			--with-dtsdownmix \
			--with-mpeg4v2 \
			--with-h265 \
			--with-gstversion=1.0 \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(SILENT)for i in `cd $(TARGET_DIR)/usr/lib/gstreamer-1.0; echo *.la`; do \
		$(REWRITE_LIBTOOL_NQ)/gstreamer-1.0/$$i; done
	$(REMOVE)/gstreamer$(GST_PLUGINS_MULTIBOX_DVBMEDIASINK_VER)-plugin-multibox-dvbmediasink
	$(TOUCH)

