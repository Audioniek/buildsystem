#
# ncurses
#
NCURSES_VER = 6.1
NCURSES_SOURCE = ncurses-$(NCURSES_VER).tar.gz
NCURSES_PATCH = ncurses-$(NCURSES_VER)-gcc-5.x-MKlib_gen.patch

$(ARCHIVE)/$(NCURSES_SOURCE):
	$(WGET) https://ftp.gnu.org/pub/gnu/ncurses/$(NCURSES_SOURCE)

$(D)/ncurses: $(D)/bootstrap $(ARCHIVE)/$(NCURSES_SOURCE)
	$(START_BUILD)
	$(REMOVE)/ncurses-$(NCURSES_VER)
	$(UNTAR)/$(NCURSES_SOURCE)
	$(CH_DIR)/ncurses-$(NCURSES_VER); \
		$(call apply_patches, $(NCURSES_PATCH)); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix=/usr \
			--enable-pc-files \
			--with-pkg-config \
			--with-pkg-config-libdir=/usr/lib/pkgconfig \
			--with-shared \
			--with-fallbacks='linux vt100 xterm' \
			--without-ada \
			--without-cxx \
			--without-cxx-binding \
			--without-debug \
			--without-manpages \
			--without-profile \
			--without-progs \
			--without-tests \
			--disable-big-core \
			--disable-rpath \
			--disable-rpath-hack \
			--enable-echo \
			--enable-const \
			--enable-overwrite \
			--enable-widec \
		; \
		$(MAKE) libs \
			HOSTCC=gcc \
			HOSTCCFLAGS="$(CFLAGS) -DHAVE_CONFIG_H -I../ncurses -DNDEBUG -D_GNU_SOURCE -I../include" \
			HOSTLDFLAGS="$(LDFLAGS)"; \
		$(MAKE) install.libs DESTDIR=$(TARGET_DIR)
	$(SILENT)mv $(TARGET_DIR)/usr/bin/ncursesw6-config $(HOST_DIR)/bin
	$(SILENT)rm -f $(addprefix $(TARGET_LIB_DIR)/,libform* libmenu* libpanel*)
	$(SILENT)rm -f $(addprefix $(PKG_CONFIG_PATH)/,form.pc menu.pc panel.pc)
	$(REWRITE_PKGCONF) $(HOST_DIR)/bin/ncursesw6-config
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/ncursesw.pc
	$(REMOVE)/ncurses-$(NCURSES_VER)
	$(TOUCH)

#
# gmp
#
GMP_VER = 6.1.2
GMP_SOURCE = gmp-$(GMP_VER).tar.xz

$(ARCHIVE)/$(GMP_SOURCE):
	$(WGET) https://gmplib.org/download/gmp/$(GMP_SOURCE)

$(D)/gmp: $(D)/bootstrap $(ARCHIVE)/$(GMP_SOURCE)
	$(START_BUILD)
	$(REMOVE)/gmp-$(GMP_VER)
	$(UNTAR)/$(GMP_SOURCE)
	$(CH_DIR)/gmp-$(GMP_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--infodir=/.remove \
			--enable-silent-rules \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libgmp.la
	$(REMOVE)/gmp-$(GMP_VER)
	$(TOUCH)

#
# host_libffi
#
LIBFFI_VER = 3.2.1
LIBFFI_SOURCE = libffi-$(LIBFFI_VER).tar.gz
LIBFFI_PATCH = libffi-$(LIBFFI_VER).patch

$(ARCHIVE)/$(LIBFFI_SOURCE):
	$(WGET) ftp://sourceware.org/pub/libffi/$(LIBFFI_SOURCE)

$(D)/host_libffi: $(ARCHIVE)/$(LIBFFI_SOURCE)
	$(START_BUILD)
	$(SILENT)if [ ! -d $(BUILD_TMP) ]; then mkdir $(BUILD_TMP); fi;
	$(REMOVE)/libffi-$(LIBFFI_VER)
	$(UNTAR)/$(LIBFFI_SOURCE)
	$(CH_DIR)/libffi-$(LIBFFI_VER); \
		./configure $(SILENT_CONFIGURE) \
			--prefix=$(HOST_DIR) \
			--disable-static \
		; \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)/libffi-$(LIBFFI_VER)
	$(TOUCH)

#
# libffi
#
$(D)/libffi: $(D)/bootstrap $(ARCHIVE)/$(LIBFFI_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libffi-$(LIBFFI_VER)
	$(UNTAR)/$(LIBFFI_SOURCE)
	$(CH_DIR)/libffi-$(LIBFFI_VER); \
		$(call apply_patches, $(LIBFFI_PATCH)); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix=/usr \
			--mandir=/.remove \
			--infodir=/.remove \
			--disable-static \
			--enable-builddir=libffi \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libffi.pc
	$(REWRITE_LIBTOOL)/libffi.la
	$(REMOVE)/libffi-$(LIBFFI_VER)
	$(TOUCH)

#
# host_libglib2_genmarshal
#
LIBGLIB2_VER_MAJOR = 2
LIBGLIB2_VER_MINOR = 55
LIBGLIB2_VER_MICRO = 0
LIBGLIB2_VER = $(LIBGLIB2_VER_MAJOR).$(LIBGLIB2_VER_MINOR).$(LIBGLIB2_VER_MICRO)
LIBGLIB2_SOURCE = glib-$(LIBGLIB2_VER).tar.xz

$(ARCHIVE)/$(LIBGLIB2_SOURCE):
	$(WGET) https://ftp.gnome.org/pub/gnome/sources/glib/$(LIBGLIB2_VER_MAJOR).$(LIBGLIB2_VER_MINOR)/$(LIBGLIB2_SOURCE)

$(D)/host_libglib2_genmarshal: $(D)/bootstrap $(D)/host_libffi $(ARCHIVE)/$(LIBGLIB2_SOURCE)
	$(START_BUILD)
	$(REMOVE)/glib-$(LIBGLIB2_VER)
	$(UNTAR)/$(LIBGLIB2_SOURCE)
	$(CH_DIR)/glib-$(LIBGLIB2_VER); \
		export PKG_CONFIG=/usr/bin/pkg-config; \
		export PKG_CONFIG_PATH=$(HOST_DIR)/lib/pkgconfig; \
		./configure $(SILENT_CONFIGURE) \
			--prefix=`pwd`/out \
			--enable-static=yes \
			--enable-shared=no \
			--disable-fam \
			--disable-libmount \
			--with-pcre=internal \
			--disable-compile-warnings \
		; \
		$(MAKE) install; \
		cp -a out/bin/glib-* $(HOST_DIR)/bin
	$(REMOVE)/glib-$(LIBGLIB2_VER)
	$(TOUCH)

#
# libglib2
#
LIBGLIB2_PATCH  = libglib2-$(LIBGLIB2_VER)-disable-tests.patch
LIBGLIB2_PATCH += libglib2-$(LIBGLIB2_VER)-fix-gio-linking.patch

$(D)/libglib2: $(D)/bootstrap $(D)/host_libglib2_genmarshal $(D)/zlib $(D)/libffi $(ARCHIVE)/$(LIBGLIB2_SOURCE)
	$(START_BUILD)
	$(REMOVE)/glib-$(LIBGLIB2_VER)
	$(UNTAR)/$(LIBGLIB2_SOURCE)
	$(CH_DIR)/glib-$(LIBGLIB2_VER); \
		echo "glib_cv_va_copy=no" > config.cache; \
		echo "glib_cv___va_copy=yes" >> config.cache; \
		echo "glib_cv_va_val_copy=yes" >> config.cache; \
		echo "ac_cv_func_posix_getpwuid_r=yes" >> config.cache; \
		echo "ac_cv_func_posix_getgrgid_r=yes" >> config.cache; \
		echo "glib_cv_stack_grows=no" >> config.cache; \
		echo "glib_cv_uscore=no" >> config.cache; \
		echo "ac_cv_path_GLIB_GENMARSHAL=$(HOST_DIR)/bin/glib-genmarshal" >> config.cache; \
		$(call apply_patches, $(LIBGLIB2_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-static \
			--mandir=/.remove \
			--cache-file=config.cache \
			--disable-fam \
			--disable-libmount \
			--disable-gtk-doc \
			--disable-gtk-doc-html \
			--with-threads="posix" \
			--with-html-dir=/.remove \
			--with-pcre=internal \
			--enable-silent-rules \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/glib-2.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gmodule-2.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gio-2.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gio-unix-2.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gmodule-export-2.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gmodule-no-export-2.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gobject-2.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gthread-2.0.pc
	$(REWRITE_LIBTOOL)/libglib-2.0.la
	$(REWRITE_LIBTOOL)/libgmodule-2.0.la
	$(REWRITE_LIBTOOL)/libgio-2.0.la
	$(REWRITE_LIBTOOL)/libgobject-2.0.la
	$(REWRITE_LIBTOOL)/libgthread-2.0.la
	$(REWRITE_LIBTOOLDEP)/libglib-2.0.la
	$(REWRITE_LIBTOOLDEP)/libgmodule-2.0.la
	$(REWRITE_LIBTOOLDEP)/libgio-2.0.la
	$(REWRITE_LIBTOOLDEP)/libgobject-2.0.la
	$(REWRITE_LIBTOOLDEP)/libgthread-2.0.la
	rm -rf $(addprefix $(TARGET_DIR)/usr/share/,bash-completion gettext gdb glib-2.0)
	$(REMOVE)/glib-$(LIBGLIB2_VER)
	$(TOUCH)

#
# libpcre
#
LIBPCRE_VER = 8.39
LIBPCRE_SOURCE = pcre-$(LIBPCRE_VER).tar.bz2

$(ARCHIVE)/$(LIBPCRE_SOURCE):
	$(WGET) https://sourceforge.net/projects/pcre/files/pcre/$(LIBPCRE_VER)/$(LIBPCRE_SOURCE)

$(D)/libpcre: $(D)/bootstrap $(ARCHIVE)/$(LIBPCRE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/pcre-$(LIBPCRE_VER)
	$(UNTAR)/$(LIBPCRE_SOURCE)
	$(CH_DIR)/pcre-$(LIBPCRE_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--enable-utf8 \
			--enable-unicode-properties \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/pcre-config $(HOST_DIR)/bin/pcre-config
	$(REWRITE_PKGCONF) $(HOST_DIR)/bin/pcre-config
	$(REWRITE_LIBTOOL)/libpcre.la
	$(REWRITE_LIBTOOL)/libpcrecpp.la
	$(REWRITE_LIBTOOL)/libpcreposix.la
	$(REWRITE_LIBTOOLDEP)/libpcrecpp.la
	$(REWRITE_LIBTOOLDEP)/libpcreposix.la
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libpcre.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libpcrecpp.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libpcreposix.pc
	$(REMOVE)/pcre-$(LIBPCRE_VER)
	$(TOUCH)

#
# host_libarchive
#
LIBARCHIVE_VER = 3.4.0
LIBARCHIVE_SOURCE = libarchive-$(LIBARCHIVE_VER).tar.gz

$(ARCHIVE)/$(LIBARCHIVE_SOURCE):
	$(WGET) https://www.libarchive.org/downloads/$(LIBARCHIVE_SOURCE)

$(D)/host_libarchive: $(D)/bootstrap $(ARCHIVE)/$(LIBARCHIVE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libarchive-$(LIBARCHIVE_VER)
	$(UNTAR)/$(LIBARCHIVE_SOURCE)
	$(CH_DIR)/libarchive-$(LIBARCHIVE_VER); \
		./configure $(SILENT_CONFIGURE) \
			--build=$(BUILD) \
			--host=$(BUILD) \
			--prefix= \
			--without-xml2 \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(HOST_DIR)
	$(REMOVE)/libarchive-$(LIBARCHIVE_VER)
	$(TOUCH)

#
# libarchive
#
$(D)/libarchive: $(D)/bootstrap $(ARCHIVE)/$(LIBARCHIVE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libarchive-$(LIBARCHIVE_VER)
	$(UNTAR)/$(LIBARCHIVE_SOURCE)
	$(CH_DIR)/libarchive-$(LIBARCHIVE_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--enable-static=no \
			--disable-bsdtar \
			--disable-bsdcpio \
			--without-iconv \
			--without-libiconv-prefix \
			--without-lzo2 \
			--without-nettle \
			--without-xml2 \
			--without-expat \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libarchive.pc
	$(REWRITE_LIBTOOL)/libarchive.la
	$(REMOVE)/libarchive-$(LIBARCHIVE_VER)
	$(TOUCH)

#
# readline
#
READLINE_VER = 8.0
READLINE_SOURCE = readline-$(READLINE_VER).tar.gz

$(ARCHIVE)/$(READLINE_SOURCE):
	$(WGET) https://ftp.gnu.org/gnu/readline/$(READLINE_SOURCE)

$(D)/readline: $(D)/bootstrap $(ARCHIVE)/$(READLINE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/readline-$(READLINE_VER)
	$(UNTAR)/$(READLINE_SOURCE)
	$(CH_DIR)/readline-$(READLINE_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--infodir=/.remove \
			--datadir=/.remove \
			bash_cv_must_reinstall_sighandlers=no \
			bash_cv_func_sigsetjmp=present \
			bash_cv_func_strcoll_broken=no \
			bash_cv_have_mbstate_t=yes \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/readline-$(READLINE_VER)
	$(TOUCH)

#
# openssl
#
OPENSSL_MAJOR = 1.0.2
OPENSSL_MINOR = u
OPENSSL_VER = $(OPENSSL_MAJOR)$(OPENSSL_MINOR)
OPENSSL_SOURCE = openssl-$(OPENSSL_VER).tar.gz
OPENSSL_PATCH  = openssl-$(OPENSSL_VER)-optimize-for-size.patch
OPENSSL_PATCH += openssl-$(OPENSSL_VER)-makefile-dirs.patch
OPENSSL_PATCH += openssl-$(OPENSSL_VER)-disable_doc_tests.patch
OPENSSL_PATCH += openssl-$(OPENSSL_VER)-fix-parallel-building.patch
OPENSSL_PATCH += openssl-$(OPENSSL_VER)-compat_versioned_symbols-1.patch
OPENSSL_PATCH += openssl-$(OPENSSL_VER)-remove_timestamp_check.patch

ifeq ($(BOXARCH), sh4)
OPENSSL_SED_PATCH = sed -i 's|MAKEDEPPROG=makedepend|MAKEDEPPROG=$(CROSS_DIR)/bin/$$(CC) -M|' Makefile
else
OPENSSL_SED_PATCH = sed -i 's|MAKEDEPPROG=makedepend|MAKEDEPPROG=$(CROSS_BASE)/bin/$$(CC) -M|' Makefile
endif

$(ARCHIVE)/$(OPENSSL_SOURCE):
	$(DOWNLOAD) https://www.openssl.org/source/old/$(OPENSSL_MAJOR)/$(OPENSSL_SOURCE)

$(D)/openssl: $(D)/bootstrap $(ARCHIVE)/$(OPENSSL_SOURCE)
	$(START_BUILD)
	$(REMOVE)/openssl-$(OPENSSL_VER)
	$(UNTAR)/$(OPENSSL_SOURCE)
	$(CH_DIR)/openssl-$(OPENSSL_VER); \
		$(call apply_patches, $(OPENSSL_PATCH)); \
		$(BUILDENV) \
		./Configure $(SILENT_OPT) \
			-DL_ENDIAN \
			shared \
			no-hw \
			linux-generic32 \
			--prefix=/usr \
			--openssldir=/etc/ssl \
		; \
		$(OPENSSL_SED_PATCH); \
		$(MAKE) depend; \
		$(MAKE) all; \
		$(MAKE) install_sw INSTALL_PREFIX=$(TARGET_DIR)
	chmod 0755 $(TARGET_LIB_DIR)/lib{crypto,ssl}.so.*
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/openssl.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libcrypto.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libssl.pc
	cd $(TARGET_DIR) && rm -rf etc/ssl/man usr/bin/openssl usr/lib/engines
	ln -sf libcrypto.so.1.0.0 $(TARGET_LIB_DIR)/libcrypto.so.0.9.8
	ln -sf libssl.so.1.0.0 $(TARGET_LIB_DIR)/libssl.so.0.9.8
	$(REMOVE)/openssl-$(OPENSSL_VER)
	$(TOUCH)

#
# libbluray
#
LIBBLURAY_VER = 1.1.2
LIBBLURAY_SOURCE = libbluray-$(LIBBLURAY_VER).tar.bz2
#LIBBLURAY_PATCH = libbluray-$(LIBBLURAY_VER).patch

$(ARCHIVE)/$(LIBBLURAY_SOURCE):
#	$(WGET) ftp.videolan.org/pub/videolan/libbluray/$(LIBBLURAY_VER)/$(LIBBLURAY_SOURCE)
	$(WGET) https://download.videolan.org/pub/videolan/libbluray/$(LIBBLURAY_VER)/$(LIBBLURAY_SOURCE)

$(D)/libbluray: $(D)/bootstrap $(ARCHIVE)/$(LIBBLURAY_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libbluray-$(LIBBLURAY_VER)
	$(UNTAR)/$(LIBBLURAY_SOURCE)
	$(CH_DIR)/libbluray-$(LIBBLURAY_VER); \
		$(call apply_patches, $(LIBBLURAY_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared \
			--disable-static \
			--disable-bdjava-jar \
			--disable-extra-warnings \
			--disable-doxygen-doc \
			--disable-doxygen-dot \
			--disable-doxygen-html \
			--disable-doxygen-ps \
			--disable-doxygen-pdf \
			--disable-examples \
			--without-libxml2 \
			--without-freetype \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libbluray.pc
	$(REWRITE_LIBTOOL)/libbluray.la
	$(REMOVE)/libbluray-$(LIBBLURAY_VER)
	$(TOUCH)

#
# lua
#
LUA_VER = 5.2.4
LUA_VER_SHORT = 5.2
LUA_SOURCE = lua-$(LUA_VER).tar.gz

LUAPOSIX_VER = 31
LUAPOSIX_SOURCE = luaposix-git-$(LUAPOSIX_VER).tar.bz2
LUAPOSIX_URL = https://github.com/luaposix/luaposix.git
LUAPOSIX_PATCH = lua-$(LUA_VER)-luaposix-$(LUAPOSIX_VER).patch

$(ARCHIVE)/$(LUA_SOURCE):
	$(WGET) https://www.lua.org/ftp/$(LUA_SOURCE)

$(ARCHIVE)/$(LUAPOSIX_SOURCE):
	$(SCRIPTS_DIR)/get-git-archive.sh $(LUAPOSIX_URL) release-v$(LUAPOSIX_VER) $(notdir $@) $(ARCHIVE)

$(D)/lua: $(D)/bootstrap $(D)/ncurses $(ARCHIVE)/$(LUAPOSIX_SOURCE) $(ARCHIVE)/$(LUA_SOURCE)
	$(START_BUILD)
	$(REMOVE)/lua-$(LUA_VER)
	mkdir -p $(TARGET_DIR)/usr/share/lua/$(LUA_VER_SHORT)
	$(UNTAR)/$(LUA_SOURCE)
	$(CH_DIR)/lua-$(LUA_VER); \
		$(call apply_patches, $(LUAPOSIX_PATCH)); \
		tar xf $(ARCHIVE)/$(LUAPOSIX_SOURCE); \
		cd luaposix-git-$(LUAPOSIX_VER)/ext; cp posix/posix.c include/lua52compat.h ../../src/; cd ../..; \
		cd luaposix-git-$(LUAPOSIX_VER)/lib; cp *.lua $(TARGET_DIR)/usr/share/lua/$(LUA_VER_SHORT); cd ../..; \
		sed -i 's/<config.h>/"config.h"/' src/posix.c; \
		sed -i '/^#define/d' src/lua52compat.h; \
		sed -i 's|man/man1|/.remove|' Makefile; \
		$(MAKE) linux CC=$(TARGET)-gcc CPPFLAGS="$(TARGET_CPPFLAGS) -fPIC" LDFLAGS="-L$(TARGET_DIR)/usr/lib" BUILDMODE=dynamic PKG_VERSION=$(LUA_VER); \
		$(MAKE) install INSTALL_TOP=$(TARGET_DIR)/usr INSTALL_MAN=$(TARGET_DIR)/.remove
	cd $(TARGET_DIR)/usr && rm bin/lua bin/luac
	$(REMOVE)/lua-$(LUA_VER)
	$(TOUCH)

#
# luacurl
#
LUACURL_VER = 9ac72c7
LUACURL_SOURCE = luacurl-git-$(LUACURL_VER).tar.bz2
LUACURL_URL = https://github.com/Lua-cURL/Lua-cURLv3.git

$(ARCHIVE)/$(LUACURL_SOURCE):
	$(SCRIPTS_DIR)/get-git-archive.sh $(LUACURL_URL) $(LUACURL_VER) $(notdir $@) $(ARCHIVE)

$(D)/luacurl: $(D)/bootstrap $(D)/libcurl $(D)/lua $(ARCHIVE)/$(LUACURL_SOURCE)
	$(START_BUILD)
	$(REMOVE)/luacurl-git-$(LUACURL_VER)
	$(UNTAR)/$(LUACURL_SOURCE)
	$(CH_DIR)/luacurl-git-$(LUACURL_VER); \
		$(MAKE) CC=$(TARGET)-gcc LDFLAGS="-L$(TARGET_DIR)/usr/lib" \
			LIBDIR=$(TARGET_DIR)/usr/lib \
			LUA_INC=$(TARGET_DIR)/usr/include; \
		$(MAKE) install DESTDIR=$(TARGET_DIR) LUA_CMOD=/usr/lib/lua/$(LUA_VER_SHORT) LUA_LMOD=/usr/share/lua/$(LUA_VER_SHORT)
	$(REMOVE)/luacurl-git-$(LUACURL_VER)
	$(TOUCH)

#
# luaexpat
#
LUAEXPAT_VER = 1.3.0
LUAEXPAT_SOURCE = luaexpat-$(LUAEXPAT_VER).tar.gz
LUAEXPAT_PATCH = luaexpat-$(LUAEXPAT_VER).patch

$(ARCHIVE)/$(LUAEXPAT_SOURCE):
	$(WGET) https://matthewwild.co.uk/projects/luaexpat/$(LUAEXPAT_SOURCE)

$(D)/luaexpat: $(D)/bootstrap $(D)/lua $(D)/expat $(ARCHIVE)/$(LUAEXPAT_SOURCE)
	$(START_BUILD)
	$(REMOVE)/luaexpat-$(LUAEXPAT_VER)
	$(UNTAR)/$(LUAEXPAT_SOURCE)
	$(CH_DIR)/luaexpat-$(LUAEXPAT_VER); \
		$(call apply_patches, $(LUAEXPAT_PATCH)); \
		$(MAKE) CC=$(TARGET)-gcc LDFLAGS="-L$(TARGET_DIR)/usr/lib" PREFIX=$(TARGET_DIR)/usr; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)/usr
	$(REMOVE)/luaexpat-$(LUAEXPAT_VER)
	$(TOUCH)

#
# luasocket
#
LUASOCKET_VER = 5a17f79
LUASOCKET_SOURCE = luasocket-git-$(LUASOCKET_VER).tar.bz2
LUASOCKET_URL = https://github.com/diegonehab/luasocket.git

$(ARCHIVE)/$(LUASOCKET_SOURCE):
	$(SCRIPTS_DIR)/get-git-archive.sh $(LUASOCKET_URL) $(LUASOCKET_VER) $(notdir $@) $(ARCHIVE)

$(D)/luasocket: $(D)/bootstrap $(D)/lua $(ARCHIVE)/$(LUASOCKET_SOURCE)
	$(START_BUILD)
	$(REMOVE)/luasocket-git-$(LUASOCKET_VER)
	$(UNTAR)/$(LUASOCKET_SOURCE)
	$(CH_DIR)/luasocket-git-$(LUASOCKET_VER); \
		sed -i -e "s@LD_linux=gcc@LD_LINUX=$(TARGET)-gcc@" -e "s@CC_linux=gcc@CC_LINUX=$(TARGET)-gcc -L$(TARGET_DIR)/usr/lib@" -e "s@DESTDIR?=@DESTDIR?=$(TARGET_DIR)/usr@" src/makefile; \
		$(MAKE) CC=$(TARGET)-gcc LD=$(TARGET)-gcc LUAV=$(LUA_VER_SHORT) PLAT=linux COMPAT=COMPAT LUAINC_linux=$(TARGET_DIR)/usr/include LUAPREFIX_linux=; \
		$(MAKE) install LUAPREFIX_linux= LUAV=$(LUA_VER_SHORT)
	$(REMOVE)/luasocket-git-$(LUASOCKET_VER)
	$(TOUCH)

#
# luafeedparser
#
LUAFEEDPARSER_VER = 9b284bc
LUAFEEDPARSER_SOURCE = luafeedparser-git-$(LUAFEEDPARSER_VER).tar.bz2
LUAFEEDPARSER_URL = https://github.com/slact/lua-feedparser.git

$(ARCHIVE)/$(LUAFEEDPARSER_SOURCE):
	$(SCRIPTS_DIR)/get-git-archive.sh $(LUAFEEDPARSER_URL) $(LUAFEEDPARSER_VER) $(notdir $@) $(ARCHIVE)

$(D)/luafeedparser: $(D)/bootstrap $(D)/lua $(D)/luasocket $(D)/luaexpat $(ARCHIVE)/$(LUAFEEDPARSER_SOURCE)
	$(START_BUILD)
	$(REMOVE)/luafeedparser-git-$(LUAFEEDPARSER_VER)
	$(UNTAR)/$(LUAFEEDPARSER_SOURCE)
	$(CH_DIR)/luafeedparser-git-$(LUAFEEDPARSER_VER); \
		sed -i -e "s/^PREFIX.*//" -e "s/^LUA_DIR.*//" Makefile ; \
		$(BUILDENV) $(MAKE) install  LUA_DIR=$(TARGET_DIR)/usr/share/lua/$(LUA_VER_SHORT)
	$(REMOVE)/luafeedparser-git-$(LUAFEEDPARSER_VER)
	$(TOUCH)

#
# luasoap
#
LUASOAP_VER = 3.0
LUASOAP_SOURCE = luasoap-$(LUASOAP_VER).tar.gz
LUASOAP_PATCH = luasoap-$(LUASOAP_VER).patch

$(ARCHIVE)/$(LUASOAP_SOURCE):
	$(WGET) https://github.com/downloads/tomasguisasola/luasoap/$(LUASOAP_SOURCE)

$(D)/luasoap: $(D)/bootstrap $(D)/lua $(D)/luasocket $(D)/luaexpat $(ARCHIVE)/$(LUASOAP_SOURCE)
	$(START_BUILD)
	$(REMOVE)/luasoap-$(LUASOAP_VER)
	$(UNTAR)/$(LUASOAP_SOURCE)
	$(CH_DIR)/luasoap-$(LUASOAP_VER); \
		$(call apply_patches, $(LUASOAP_PATCH)); \
		$(MAKE) install LUA_DIR=$(TARGET_DIR)/share/lua/$(LUA_VER_SHORT)
	$(REMOVE)/luasoap-$(LUASOAP_VER)
	$(TOUCH)

#
# luajson
#
$(ARCHIVE)/json.lua:
	$(WGET) https://github.com/swiboe/swiboe/raw/master/term_gui/json.lua

$(D)/luajson: $(D)/bootstrap $(D)/lua $(ARCHIVE)/json.lua
	$(START_BUILD)
	$(SILENT)cp $(ARCHIVE)/json.lua $(TARGET_DIR)/usr/share/lua/$(LUA_VER_SHORT)/json.lua
	$(TOUCH)

#
# boost
#
BOOST_VER_MAJOR = 1
BOOST_VER_MINOR = 61
BOOST_VER_MICRO = 0
BOOST_VER_ARCHIVE = $(BOOST_VER_MAJOR).$(BOOST_VER_MINOR).$(BOOST_VER_MICRO)
BOOST_VER = $(BOOST_VER_MAJOR)_$(BOOST_VER_MINOR)_$(BOOST_VER_MICRO)
BOOST_SOURCE = boost_$(BOOST_VER).tar.bz2
BOOST_PATCH = boost-$(BOOST_VER).patch

$(ARCHIVE)/$(BOOST_SOURCE):
	$(WGET) https://sourceforge.net/projects/boost/files/boost/$(BOOST_VER_ARCHIVE)/$(BOOST_SOURCE)

$(D)/boost: $(D)/bootstrap $(ARCHIVE)/$(BOOST_SOURCE)
	$(START_BUILD)
	$(REMOVE)/boost_$(BOOST_VER)
	$(UNTAR)/$(BOOST_SOURCE)
	$(CH_DIR)/boost_$(BOOST_VER); \
		$(call apply_patches, $(BOOST_PATCH)); \
		rm -rf $(TARGET_DIR)/usr/include/boost; \
		mv $(BUILD_TMP)/boost_$(BOOST_VER)/boost $(TARGET_DIR)/usr/include/boost
	$(REMOVE)/boost_$(BOOST_VER)
	$(TOUCH)

#
# zlib
#
ZLIB_VER = 1.3.1
ZLIB_SOURCE = zlib-$(ZLIB_VER).tar.xz
ZLIB_Patch = zlib-$(ZLIB_VER).patch

$(ARCHIVE)/$(ZLIB_SOURCE):
	$(WGET) https://zlib.net/$(ZLIB_SOURCE)

$(D)/zlib: $(D)/bootstrap $(ARCHIVE)/$(ZLIB_SOURCE)
	$(START_BUILD)
	$(REMOVE)/zlib-$(ZLIB_VER)
	$(UNTAR)/$(ZLIB_SOURCE)
	$(CH_DIR)/zlib-$(ZLIB_VER); \
		$(call apply_patches, $(ZLIB_Patch)); \
		CC=$(TARGET)-gcc mandir=$(TARGET_DIR)/.remove CFLAGS="$(TARGET_CFLAGS)" \
		./configure $(SILENT_OPT) \
			--prefix=/usr \
			--shared \
			--uname=Linux \
		; \
		$(MAKE); \
		ln -sf /bin/true ldconfig; \
		$(MAKE) install prefix=$(TARGET_DIR)/usr
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/zlib.pc
	$(REMOVE)/zlib-$(ZLIB_VER)
	$(TOUCH)

#
# bzip2
#
BZIP2_VER = 1.0.8
BZIP2_SOURCE = bzip2-$(BZIP2_VER).tar.gz
BZIP2_Patch = bzip2-$(BZIP2_VER).patch

$(ARCHIVE)/$(BZIP2_SOURCE):
	$(WGET) ftp://sourceware.org/pub/bzip2/$(BZIP2_SOURCE)

$(D)/bzip2: $(D)/bootstrap $(ARCHIVE)/$(BZIP2_SOURCE)
	$(START_BUILD)
	$(REMOVE)/bzip2-$(BZIP2_VER)
	$(UNTAR)/$(BZIP2_SOURCE)
	$(CH_DIR)/bzip2-$(BZIP2_VER); \
		$(call apply_patches, $(BZIP2_Patch)); \
		mv Makefile-libbz2_so Makefile; \
		$(MAKE) all CC=$(TARGET)-gcc AR=$(TARGET)-ar RANLIB=$(TARGET)-ranlib; \
		$(MAKE) install PREFIX=$(TARGET_DIR)/usr
	cd $(TARGET_DIR) && rm -f usr/bin/bzip2
	$(REMOVE)/bzip2-$(BZIP2_VER)
	$(TOUCH)

#
# timezone
#
TZDATA_VER = 2022g
TZDATA_SOURCE = tzdata$(TZDATA_VER).tar.gz
TZDATA_ZONELIST = africa antarctica asia australasia europe northamerica southamerica etcetera
DEFAULT_TIMEZONE ?= "CET"

$(ARCHIVE)/$(TZDATA_SOURCE):
	$(WGET) ftp://ftp.iana.org/tz/releases/$(TZDATA_SOURCE)

$(D)/timezone: $(D)/bootstrap $(ARCHIVE)/$(TZDATA_SOURCE)
	$(START_BUILD)
	$(REMOVE)/timezone
	$(SILENT)mkdir $(BUILD_TMP)/timezone
	$(SILENT)tar -C $(BUILD_TMP)/timezone -xf $(ARCHIVE)/$(TZDATA_SOURCE)
	$(CH_DIR)/timezone; \
		unset ${!LC_*}; LANG=POSIX; LC_ALL=POSIX; export LANG LC_ALL; \
		for zone in $(TZDATA_ZONELIST); do \
			zic -d zoneinfo -L /dev/null -y yearistype.sh $$zone ; \
			: zic -d zoneinfo/posix -L /dev/null -y yearistype.sh $$zone ; \
			: zic -d zoneinfo/right -L leapseconds -y yearistype.sh $$zone ; \
		done; \
		install -d -m 0755 $(TARGET_DIR)/usr/share $(TARGET_DIR)/etc; \
		cp -a zoneinfo $(TARGET_DIR)/usr/share/; \
		cp -v zone.tab iso3166.tab $(TARGET_DIR)/usr/share/zoneinfo/
	# Install default timezone
	$(SILENT)if [ -e $(TARGET_DIR)/usr/share/zoneinfo/$(DEFAULT_TIMEZONE) ]; then \
		echo ${DEFAULT_TIMEZONE} > $(TARGET_DIR)/etc/timezone; \
	fi
	$(SILENT)install -m 0644 $(SKEL_ROOT)/etc/timezone.xml $(TARGET_DIR)/etc/
	$(REMOVE)/timezone
	$(TOUCH)

#
# freetype
#
FREETYPE_VER = 2.11.0
FREETYPE_SOURCE = freetype-$(FREETYPE_VER).tar.xz
FREETYPE_PATCH = freetype-$(FREETYPE_VER).patch

$(ARCHIVE)/$(FREETYPE_SOURCE):
	$(WGET) https://sourceforge.net/projects/freetype/files/freetype2/$(FREETYPE_VER)/$(FREETYPE_SOURCE)

$(D)/freetype: $(D)/bootstrap $(D)/zlib $(D)/libpng $(ARCHIVE)/$(FREETYPE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/freetype-$(FREETYPE_VER)
	$(UNTAR)/$(FREETYPE_SOURCE)
	$(CH_DIR)/freetype-$(FREETYPE_VER); \
		$(call apply_patches, $(FREETYPE_PATCH)); \
		sed -r "s:.*(#.*SUBPIXEL_(RENDERING|HINTING  2)) .*:\1:g" \
			-i include/freetype/config/ftoption.h; \
		sed -i '/^FONT_MODULES += \(type1\|cid\|pfr\|type42\|pcf\|bdf\|winfonts\|cff\)/d' modules.cfg; \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--disable-static \
			--enable-shared \
			--with-png \
			--with-zlib \
			--enable-freetype-config \
			--with-bzip2=no \
			--with-zlib=yes \
			--with-png=yes \
			--without-harfbuzz \
			--without-bzip2 \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
		if [ ! -e $(TARGET_DIR)/usr/include/freetype ] ; then \
			ln -sf freetype2 $(TARGET_DIR)/usr/include/freetype; \
		fi; \
		sed -e 's:^prefix=.*:prefix="$(TARGET_DIR)/usr":' \
		    -e 's:^exec_prefix=.*:exec_prefix="$${prefix}":' \
		    -e 's:^includedir=.*:includedir="$${prefix}/include":' \
		    -e 's:^libdir=.*:libdir="$${exec_prefix}/lib":' \
		    -i $(TARGET_DIR)/usr/bin/freetype-config; \
		mv $(TARGET_DIR)/usr/bin/freetype-config $(HOST_DIR)/bin/freetype-config
	$(REWRITE_LIBTOOL)/libfreetype.la
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/freetype2.pc
	$(REMOVE)/freetype-$(FREETYPE_VER)
	$(TOUCH)

#
# lirc
#
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), adb_box arivalink200 ipbox55 ipbox99 ipbox9900 cuberevo cuberevo_mini cuberevo_mini2 cuberevo_250hd cuberevo_2000hd cuberevo_3000hd hchs8100 hl101 pace7241 sagemcom88 spark spark7162 ufs910 vip1_v1 vip1_v2 vip2 vitamin_hd5000))

LIRC_VER = 0.9.0
LIRC_SOURCE = lirc-$(LIRC_VER).tar.bz2
LIRC_PATCH = lirc-$(LIRC_VER).patch
LIRC = $(D)/lirc

$(ARCHIVE)/$(LIRC_SOURCE):
	$(WGET) https://sourceforge.net/projects/lirc/files/LIRC/$(LIRC_VER)/$(LIRC_SOURCE)

ifeq ($(IMAGE), $(filter $(IMAGE), neutrino neutrino-wlandriver titan titan-wlandriver))
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), spark spark7162))
LIRC_OPTS = -D__KERNEL_STRICT_NAMES -DUINPUT_NEUTRINO_HACK -DSPARK -I$(DRIVER_DIR)/frontcontroller/aotom_spark
else
LIRC_OPTS = -D__KERNEL_STRICT_NAMES
endif
else
LIRC_OPTS = -D__KERNEL_STRICT_NAMES
endif

$(D)/lirc: $(D)/bootstrap $(ARCHIVE)/$(LIRC_SOURCE)
	$(START_BUILD)
	$(REMOVE)/lirc-$(LIRC_VER)
	$(UNTAR)/$(LIRC_SOURCE)
	$(CH_DIR)/lirc-$(LIRC_VER); \
		$(call apply_patches, $(LIRC_PATCH)); \
		$(CONFIGURE) \
		ac_cv_path_LIBUSB_CONFIG= \
		CFLAGS="$(TARGET_CFLAGS) $(LIRC_OPTS)" \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
			--sbindir=/usr/bin \
			--mandir=/.remove \
			--with-kerneldir=$(KERNEL_DIR) \
			--without-x \
			--with-devdir=/dev \
			--with-moduledir=/lib/modules \
			--with-major=61 \
			--with-driver=userspace \
			--enable-debug \
			--with-syslog=LOG_DAEMON \
			--enable-sandboxed \
		; \
		$(MAKE) -j1 all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/liblirc_client.la
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,lircmd ircat irpty irsend irw lircrcd mode2 pronto2lirc)
	$(REMOVE)/lirc-$(LIRC_VER)
	$(TOUCH)
endif

#
# jpeg
#
JPEG_VER = 8d
JPEG_SOURCE = jpegsrc.v$(JPEG_VER).tar.gz
JPEG_PATCH = jpeg-$(JPEG_VER).patch

$(ARCHIVE)/$(JPEG_SOURCE):
	$(WGET) http://www.ijg.org/files/$(JPEG_SOURCE)

$(D)/jpeg: $(D)/bootstrap $(ARCHIVE)/$(JPEG_SOURCE)
	$(START_BUILD)
	$(REMOVE)/jpeg-$(JPEG_VER)
	$(UNTAR)/$(JPEG_SOURCE)
	$(CH_DIR)/jpeg-$(JPEG_VER); \
		$(call apply_patches, $(JPEG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libjpeg.la
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom)
	$(REMOVE)/jpeg-$(JPEG_VER)
	$(TOUCH)

#
# libjpeg
#
ifeq ($(BOXTYPE), $(filter $(BOXTYPE), fs9000 hs9510 ufs910 ufs922 ipbox55 ipbox99 ipbox9900 cuberevo cuberevo_mini cuberevo_mini2 cuberevo_250hd cuberevo_2000hd cuberevo_3000hd))
$(D)/libjpeg: $(D)/jpeg
	@touch $@
else
$(D)/libjpeg: $(D)/libjpeg_turbo2
	@touch $@
endif

#
# libjpeg_turbo2
#
LIBJPEG_TURBO2_VER = 2.1.5.1
LIBJPEG_TURBO2_SOURCE = libjpeg-turbo-$(LIBJPEG_TURBO2_VER).tar.gz
LIBJPEG_TURBO2_PATCH = libjpeg-turbo-$(LIBJPEG_TURBO2_VER)-tiff-ojpeg.patch

$(ARCHIVE)/$(LIBJPEG_TURBO2_SOURCE):
	$(WGET) https://sourceforge.net/projects/libjpeg-turbo/files/$(LIBJPEG_TURBO2_VER)/$(LIBJPEG_TURBO2_SOURCE)

$(D)/libjpeg_turbo2: $(D)/bootstrap $(ARCHIVE)/$(LIBJPEG_TURBO2_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libjpeg-turbo-$(LIBJPEG_TURBO2_VER)
	$(UNTAR)/$(LIBJPEG_TURBO2_SOURCE)
	$(SET) -e; cd $(BUILD_TMP)/libjpeg-turbo-$(LIBJPEG_TURBO2_VER); \
		$(call apply_patches, $(LIBJPEG_TURBO2_PATCH)); \
		cmake   -DCMAKE_INSTALL_PREFIX=/usr \
			-DCMAKE_C_COMPILER=$(TARGET)-gcc \
			-DCMAKE_CXX_COMPILER=$(TARGET)-g++ \
			-DCMAKE_C_FLAGS="-pipe -Os" \
			-DCMAKE_CXX_FLAGS="-pipe -Os" \
			-DWITH_SIMD=False \
			-DCMAKE_INSTALL_DOCDIR=/.remove \
			-DCMAKE_INSTALL_MANDIR=/.remove \
			-DCMAKE_INSTALL_DEFAULT_LIBDIR=lib \
			-DENABLE_STATIC=OFF \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom tjbench)
	$(REMOVE)/libjpeg-turbo-$(LIBJPEG_TURBO2_VER)
	$(TOUCH)

#
# libjpeg_turbo
#
LIBJPEG_TURBO_VER = 1.5.3
LIBJPEG_TURBO_SOURCE = libjpeg-turbo-$(LIBJPEG_TURBO_VER).tar.gz

$(ARCHIVE)/$(LIBJPEG_TURBO_SOURCE):
	$(WGET) https://sourceforge.net/projects/libjpeg-turbo/files/$(LIBJPEG_TURBO_VER)/$(LIBJPEG_TURBO_SOURCE)

$(D)/libjpeg_turbo: $(D)/bootstrap $(ARCHIVE)/$(LIBJPEG_TURBO_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libjpeg-turbo-$(LIBJPEG_TURBO_VER)
	$(UNTAR)/$(LIBJPEG_TURBO_SOURCE)
	$(CH_DIR)/libjpeg-turbo-$(LIBJPEG_TURBO_VER); \
		export CC=$(TARGET)-gcc; \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared \
			--mandir=/.remove \
			--docdir=/.remove \
			--includedir=/.remove \
			--with-jpeg8 \
			--disable-static \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR); \
		make clean; \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared \
			--mandir=/.remove \
			--docdir=/.remove \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libjpeg.la
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libjpeg.pc
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom tjbench)
	rm -f $(TARGET_DIR)/usr/lib/libturbojpeg* $(TARGET_DIR)/usr/include/turbojpeg.h $(PKG_CONFIG_PATH)/libturbojpeg.pc
	$(REMOVE)/libjpeg-turbo-$(LIBJPEG_TURBO_VER)
	$(TOUCH)

#
# libpng
#
LIBPNG_VER = 1.6.47
LIBPNG_VER_X = 16
LIBPNG_SOURCE = libpng-$(LIBPNG_VER).tar.xz
#LIBPNG_PATCH = libpng-$(LIBPNG_VER)-disable-tools.patch

$(ARCHIVE)/$(LIBPNG_SOURCE):
	$(WGET) https://sourceforge.net/projects/libpng/files/libpng$(LIBPNG_VER_X)/$(LIBPNG_VER)/$(LIBPNG_SOURCE) || \
	$(WGET) https://sourceforge.net/projects/libpng/files/libpng$(LIBPNG_VER_X)/older-releases/$(LIBPNG_VER)/$(LIBPNG_SOURCE)

$(D)/libpng: $(D)/bootstrap $(D)/zlib $(ARCHIVE)/$(LIBPNG_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libpng-$(LIBPNG_VER)
	$(UNTAR)/$(LIBPNG_SOURCE)
	$(CH_DIR)/libpng-$(LIBPNG_VER); \
		$(call apply_patches, $(LIBPNG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-mips-msa \
			--disable-powerpc-vsx \
			--mandir=/.remove \
			--enable-silent-rules \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
		sed -e 's:^prefix=.*:prefix="$(TARGET_DIR)/usr":' -i $(TARGET_DIR)/usr/bin/libpng$(LIBPNG_VER_X)-config; \
		mv $(TARGET_DIR)/usr/bin/libpng*-config $(HOST_DIR)/bin/
	$(REWRITE_LIBTOOL)/libpng16.la
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libpng$(LIBPNG_VER_X).pc
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,pngfix png-fix-itxt)
	$(REMOVE)/libpng-$(LIBPNG_VER)
	$(TOUCH)

#
# png++
#
PNGPP_VER = 0.2.9
PNGPP_SOURCE = png++-$(PNGPP_VER).tar.gz

$(ARCHIVE)/$(PNGPP_SOURCE):
	$(WGET) https://download.savannah.gnu.org/releases/pngpp/$(PNGPP_SOURCE)

$(D)/pngpp: $(D)/bootstrap $(D)/libpng $(ARCHIVE)/$(PNGPP_SOURCE)
	$(START_BUILD)
	$(REMOVE)/png++-$(PNGPP_VER)
	$(UNTAR)/$(PNGPP_SOURCE)
	$(CH_DIR)/png++-$(PNGPP_VER); \
		$(MAKE) install-headers PREFIX=$(TARGET_DIR)/usr
	$(REMOVE)/png++-$(PNGPP_VER)
	$(TOUCH)

#
# giflib
#
GIFLIB_VER = 5.1.4
GIFLIB_SOURCE = giflib-$(GIFLIB_VER).tar.bz2

$(ARCHIVE)/$(GIFLIB_SOURCE):
	$(WGET) https://sourceforge.net/projects/giflib/files/$(GIFLIB_SOURCE)

$(D)/giflib: $(D)/bootstrap $(ARCHIVE)/$(GIFLIB_SOURCE)
	$(START_BUILD)
	$(REMOVE)/giflib-$(GIFLIB_VER)
	$(UNTAR)/$(GIFLIB_SOURCE)
	$(CH_DIR)/giflib-$(GIFLIB_VER); \
		export ac_cv_prog_have_xmlto=no; \
		$(CONFIGURE) \
			--prefix=/usr \
			--bindir=/.remove \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libgif.la
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,gif2rgb gifbuild gifclrmp gifecho giffix gifinto giftext giftool)
	$(REMOVE)/giflib-$(GIFLIB_VER)
	$(TOUCH)

#
# libconfig
#
LIBCONFIG_VER = 1.4.10
LIBCONFIG_SOURCE = libconfig-$(LIBCONFIG_VER).tar.gz

$(ARCHIVE)/$(LIBCONFIG_SOURCE):
	$(WGET) http://www.hyperrealm.com/packages/$(LIBCONFIG_SOURCE)

$(D)/libconfig: $(D)/bootstrap $(ARCHIVE)/$(LIBCONFIG_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libconfig-$(LIBCONFIG_VER)
	$(UNTAR)/$(LIBCONFIG_SOURCE)
	$(CH_DIR)/libconfig-$(LIBCONFIG_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-static \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libconfig.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libconfig++.pc
	$(REWRITE_LIBTOOL)/libconfig.la
	$(REWRITE_LIBTOOL)/libconfig++.la
	$(REMOVE)/libconfig-$(LIBCONFIG_VER)
	$(TOUCH)

#
# ca-bundle
#
$(ARCHIVE)/cacert.pem:
	$(WGET) https://curl.haxx.se/ca/cacert.pem

$(D)/ca-bundle: $(ARCHIVE)/cacert.pem
	$(START_BUILD)
	$(SILENT)install -D -m 644 $(ARCHIVE)/cacert.pem $(TARGET_DIR)/$(CA_BUNDLE_DIR)/$(CA_BUNDLE)
	$(TOUCH)

#
# libcurl
#
LIBCURL_VER = 8.12.1
LIBCURL_SOURCE = curl-$(LIBCURL_VER).tar.bz2
LIBCURL_PATCH = libcurl-$(LIBCURL_VER).patch

$(ARCHIVE)/$(LIBCURL_SOURCE):
	$(WGET) https://curl.haxx.se/download/$(LIBCURL_SOURCE)

$(D)/libcurl: $(D)/bootstrap $(D)/zlib $(D)/openssl $(D)/ca-bundle $(ARCHIVE)/$(LIBCURL_SOURCE)
	$(START_BUILD)
	$(REMOVE)/curl-$(LIBCURL_VER)
	$(UNTAR)/$(LIBCURL_SOURCE)
	$(CH_DIR)/curl-$(LIBCURL_VER); \
		$(call apply_patches, $(LIBCURL_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--enable-silent-rules \
			--disable-debug \
			--disable-curldebug \
			--disable-manual \
			--disable-file \
			--disable-rtsp \
			--disable-dict \
			--disable-imap \
			--disable-pop3 \
			--disable-smtp \
			--enable-shared \
			--enable-optimize \
			--disable-verbose \
			--disable-ldap \
			--without-libidn2 \
			--without-winidn \
			--without-libpsl \
			--without-libgsasl \
			--with-ca-bundle=$(CA_BUNDLE_DIR)/$(CA_BUNDLE) \
			--with-random=/dev/urandom \
			--with-ssl=$(TARGET_DIR)/usr \
		; \
		$(MAKE) all; \
		sed -e "s,^prefix=,prefix=$(TARGET_DIR)," < curl-config > $(HOST_DIR)/bin/curl-config; \
		chmod 755 $(HOST_DIR)/bin/curl-config; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
		rm -f $(TARGET_DIR)/usr/bin/curl-config
	$(REWRITE_LIBTOOL)/libcurl.la
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libcurl.pc
#ifeq ($(BOXTYPE), $(filter $(BOXTYPE), ufs910 ufs922))
#	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,curl)
#endif
	$(REMOVE)/curl-$(LIBCURL_VER)
	$(TOUCH)

#
# libfribidi
#
LIBFRIBIDI_VER = 1.0.16
LIBFRIBIDI_SOURCE = fribidi-$(LIBFRIBIDI_VER).tar.xz
LIBFRIBIDI_PATCH = libfribidi-$(LIBFRIBIDI_VER).patch

$(ARCHIVE)/$(LIBFRIBIDI_SOURCE):
	$(WGET) https://github.com/fribidi/fribidi/releases/download/v$(LIBFRIBIDI_VER)/$(LIBFRIBIDI_SOURCE)

$(D)/libfribidi: $(D)/bootstrap $(ARCHIVE)/$(LIBFRIBIDI_SOURCE)
	$(START_BUILD)
	$(REMOVE)/fribidi-$(LIBFRIBIDI_VER)
	$(UNTAR)/$(LIBFRIBIDI_SOURCE)
	$(CH_DIR)/fribidi-$(LIBFRIBIDI_VER); \
		$(call apply_patches, $(LIBFRIBIDI_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--enable-shared \
			--enable-static \
			--disable-debug \
			--disable-deprecated \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/fribidi.pc
	$(REWRITE_LIBTOOL)/libfribidi.la
	cd $(TARGET_DIR) && rm usr/bin/fribidi
	$(REMOVE)/fribidi-$(LIBFRIBIDI_VER)
	$(TOUCH)

#
# libsigc
#
LIBSIGC_VER_MAJOR = 2
LIBSIGC_VER_MINOR = 10
LIBSIGC_VER_MICRO = 6
LIBSIGC_VER = $(LIBSIGC_VER_MAJOR).$(LIBSIGC_VER_MINOR).$(LIBSIGC_VER_MICRO)
LIBSIGC_SOURCE = libsigc++-$(LIBSIGC_VER).tar.xz
LIBSIGC_PATCH = libsigc-$(LIBSIGC_VER_MAJOR).$(LIBSIGC_VER_MINOR).$(LIBSIGC_VER_MICRO).patch

$(ARCHIVE)/$(LIBSIGC_SOURCE):
	$(WGET) https://ftp.gnome.org/pub/GNOME/sources/libsigc++/$(LIBSIGC_VER_MAJOR).$(LIBSIGC_VER_MINOR)/$(LIBSIGC_SOURCE)

$(D)/libsigc: $(D)/bootstrap $(ARCHIVE)/$(LIBSIGC_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libsigc++-$(LIBSIGC_VER)
	$(UNTAR)/$(LIBSIGC_SOURCE)
	$(CH_DIR)/libsigc++-$(LIBSIGC_VER); \
		$(call apply_patches, $(LIBSIGC_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared \
			--disable-documentation \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR); \
		if [ -d $(TARGET_DIR)/usr/include/sigc++-2.0/sigc++ ] ; then \
			ln -sf ./sigc++-2.0/sigc++ $(TARGET_DIR)/usr/include/sigc++; \
		fi;
		mv $(TARGET_DIR)/usr/lib/sigc++-2.0/include/sigc++config.h $(TARGET_DIR)/usr/include; \
		rm -fr $(TARGET_DIR)/usr/lib/sigc++-2.0
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/sigc++-2.0.pc
	$(REWRITE_LIBTOOL)/libsigc-2.0.la
	$(REMOVE)/libsigc++-$(LIBSIGC_VER)
	$(TOUCH)

#
# libsigc241
#
LIBSIGC241_VER_MAJOR = 2
LIBSIGC241_VER_MINOR = 4
LIBSIGC241_VER_MICRO = 1
LIBSIGC241_VER = $(LIBSIGC241_VER_MAJOR).$(LIBSIGC241_VER_MINOR).$(LIBSIGC241_VER_MICRO)
LIBSIGC241_SOURCE = libsigc++-$(LIBSIGC241_VER).tar.xz

$(ARCHIVE)/$(LIBSIGC241_SOURCE):
	$(WGET) https://ftp.gnome.org/pub/GNOME/sources/libsigc++/$(LIBSIGC241_VER_MAJOR).$(LIBSIGC241_VER_MINOR)/$(LIBSIGC241_SOURCE)

$(D)/libsigc241: $(D)/bootstrap $(ARCHIVE)/$(LIBSIGC241_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libsigc++-$(LIBSIGC241_VER)
	$(UNTAR)/$(LIBSIGC241_SOURCE)
	$(CH_DIR)/libsigc++-$(LIBSIGC241_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared \
			--disable-documentation \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR); \
		if [ -d $(TARGET_DIR)/usr/include/sigc++-2.0/sigc++ ] ; then \
			ln -sf ./sigc++-2.0/sigc++ $(TARGET_DIR)/usr/include/sigc++; \
		fi;
		mv $(TARGET_DIR)/usr/lib/sigc++-2.0/include/sigc++config.h $(TARGET_DIR)/usr/include; \
		rm -fr $(TARGET_DIR)/usr/lib/sigc++-2.0
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/sigc++-2.0.pc
	$(REWRITE_LIBTOOL)/libsigc-2.0.la
	$(REMOVE)/libsigc++-$(LIBSIGC241_VER)
	$(TOUCH)

#
# libmad
#
LIBMAD_VER = 0.15.1b
LIBMAD_SOURCE = libmad-$(LIBMAD_VER).tar.gz
LIBMAD_PATCH = libmad-$(LIBMAD_VER).patch

$(ARCHIVE)/$(LIBMAD_SOURCE):
	$(WGET) https://sourceforge.net/projects/mad/files/libmad/$(LIBMAD_VER)/$(LIBMAD_SOURCE)

$(D)/libmad: $(D)/bootstrap $(ARCHIVE)/$(LIBMAD_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libmad-$(LIBMAD_VER)
	$(UNTAR)/$(LIBMAD_SOURCE)
	$(CH_DIR)/libmad-$(LIBMAD_VER); \
		$(call apply_patches, $(LIBMAD_PATCH)); \
		touch NEWS AUTHORS ChangeLog; \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-debugging \
			--enable-shared=yes \
			--enable-speed \
			--enable-sso \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/mad.pc
	$(REWRITE_LIBTOOL)/libmad.la
	$(REMOVE)/libmad-$(LIBMAD_VER)
	$(TOUCH)

#
# libid3tag
#
LIBID3TAG_VER = 0.15.1b
LIBID3TAG_SOURCE = libid3tag-$(LIBID3TAG_VER).tar.gz
LIBID3TAG_PATCH = libid3tag-$(LIBID3TAG_VER).patch

$(ARCHIVE)/$(LIBID3TAG_SOURCE):
	$(WGET) https://sourceforge.net/projects/mad/files/libid3tag/$(LIBID3TAG_VER)/$(LIBID3TAG_SOURCE)

$(D)/libid3tag: $(D)/bootstrap $(D)/zlib $(ARCHIVE)/$(LIBID3TAG_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libid3tag-$(LIBID3TAG_VER)
	$(UNTAR)/$(LIBID3TAG_SOURCE)
	$(CH_DIR)/libid3tag-$(LIBID3TAG_VER); \
		$(call apply_patches, $(LIBID3TAG_PATCH)); \
		touch NEWS AUTHORS ChangeLog; \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared=yes \
			--enable-silent-rules \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/id3tag.pc
	$(REWRITE_LIBTOOL)/libid3tag.la
	$(REMOVE)/libid3tag-$(LIBID3TAG_VER)
	$(TOUCH)

#
# libvorbis
#
LIBVORBIS_VER = 1.3.6
LIBVORBIS_SOURCE = libvorbis-$(LIBVORBIS_VER).tar.xz

$(ARCHIVE)/$(LIBVORBIS_SOURCE):
	$(WGET) https://ftp.osuosl.org/pub/xiph/releases/vorbis/$(LIBVORBIS_SOURCE)

$(D)/libvorbis: $(D)/bootstrap $(D)/libogg $(ARCHIVE)/$(LIBVORBIS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libvorbis-$(LIBVORBIS_VER)
	$(UNTAR)/$(LIBVORBIS_SOURCE)
	$(CH_DIR)/libvorbis-$(LIBVORBIS_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--docdir=/.remove \
			--mandir=/.remove \
			--disable-docs \
			--disable-examples \
			--enable-silent-rules \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) docdir=/.remove
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/vorbis.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/vorbisenc.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/vorbisfile.pc
	$(REWRITE_LIBTOOL)/libvorbis.la
	$(REWRITE_LIBTOOL)/libvorbisenc.la
	$(REWRITE_LIBTOOL)/libvorbisfile.la
	$(REWRITE_LIBTOOLDEP)/libvorbis.la
	$(REWRITE_LIBTOOLDEP)/libvorbisenc.la
	$(REWRITE_LIBTOOLDEP)/libvorbisfile.la
	$(REMOVE)/libvorbis-$(LIBVORBIS_VER)
	$(TOUCH)

#
# libvorbisidec
#
LIBVORBISIDEC_VER = 1.2.1+git20180316
LIBVORBISIDEC_VER_APPEND = .orig
LIBVORBISIDEC_SOURCE = libvorbisidec_$(LIBVORBISIDEC_VER)$(LIBVORBISIDEC_VER_APPEND).tar.gz

$(ARCHIVE)/$(LIBVORBISIDEC_SOURCE):
	$(WGET) https://ftp.de.debian.org/debian/pool/main/libv/libvorbisidec/$(LIBVORBISIDEC_SOURCE)

$(D)/libvorbisidec: $(D)/bootstrap $(D)/libogg $(ARCHIVE)/$(LIBVORBISIDEC_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libvorbisidec-$(LIBVORBISIDEC_VER)
	$(UNTAR)/$(LIBVORBISIDEC_SOURCE)
	$(CH_DIR)/libvorbisidec-$(LIBVORBISIDEC_VER); \
		$(call apply_patches, $(LIBVORBISIDEC_PATCH)); \
		ACLOCAL_FLAGS="-I . -I $(TARGET_DIR)/usr/share/aclocal" \
		$(BUILDENV) \
		./autogen.sh $(SILENT_OPT) \
			--host=$(TARGET) \
			--build=$(BUILD) \
			--prefix=/usr \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/vorbisidec.pc
	$(REWRITE_LIBTOOL)/libvorbisidec.la
	$(REMOVE)/libvorbisidec-$(LIBVORBISIDEC_VER)
	$(TOUCH)

#
# libiconv
#
LIBICONV_VER = 1.18
LIBICONV_SOURCE = libiconv-$(LIBICONV_VER).tar.gz

$(ARCHIVE)/$(LIBICONV_SOURCE):
	$(WGET) https://ftp.gnu.org/gnu/libiconv/$(LIBICONV_SOURCE)

$(D)/libiconv: $(D)/bootstrap $(ARCHIVE)/$(LIBICONV_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libiconv-$(LIBICONV_VER)
	$(UNTAR)/$(LIBICONV_SOURCE)
	$(CH_DIR)/libiconv-$(LIBICONV_VER); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix=/usr \
			--bindir=/.remove \
			--datarootdir=/.remove \
			--disable-static \
			--enable-shared \
		; \
		$(MAKE); \
		cp ./srcm4/* $(HOST_DIR)/share/aclocal/ ; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libcharset.la
	$(REWRITE_LIBTOOL)/libiconv.la
	rm -f $(addprefix $(TARGET_DIR)/usr/lib/,preloadable_libiconv.so)
	$(REMOVE)/libiconv-$(LIBICONV_VER)
	$(TOUCH)

#
# expat
#
EXPAT_VER = 2.7.1
EXPAT_SOURCE = expat-$(EXPAT_VER).tar.bz2
EXPAT_PATCH  = expat-$(EXPAT_VER)-libtool-tag.patch

$(ARCHIVE)/$(EXPAT_SOURCE):
	$(WGET) https://sourceforge.net/projects/expat/files/expat/$(EXPAT_VER)/$(EXPAT_SOURCE)

$(D)/expat: $(D)/bootstrap $(ARCHIVE)/$(EXPAT_SOURCE)
	$(START_BUILD)
	$(REMOVE)/expat-$(EXPAT_VER)
	$(UNTAR)/$(EXPAT_SOURCE)
	$(CH_DIR)/expat-$(EXPAT_VER); \
		$(call apply_patches, $(EXPAT_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--bindir=/.remove \
			--without-xmlwf \
			--without-docbook \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/expat.pc
	$(REWRITE_LIBTOOL)/libexpat.la
	$(REMOVE)/expat-$(EXPAT_VER)
	$(TOUCH)

#
# fontconfig
#
FONTCONFIG_VER = 2.11.93
FONTCONFIG_SOURCE = fontconfig-$(FONTCONFIG_VER).tar.bz2

$(ARCHIVE)/$(FONTCONFIG_SOURCE):
	$(WGET) https://www.freedesktop.org/software/fontconfig/release/$(FONTCONFIG_SOURCE)

$(D)/fontconfig: $(D)/bootstrap $(D)/freetype $(D)/expat $(ARCHIVE)/$(FONTCONFIG_SOURCE)
	$(START_BUILD)
	$(REMOVE)/fontconfig-$(FONTCONFIG_VER)
	$(UNTAR)/$(FONTCONFIG_SOURCE)
	$(CH_DIR)/fontconfig-$(FONTCONFIG_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--with-freetype-config=$(HOST_DIR)/bin/freetype-config \
			--with-expat-includes=$(TARGET_DIR)/usr/include \
			--with-expat-lib=$(TARGET_DIR)/usr/lib \
			--sysconfdir=/etc \
			--disable-docs \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libfontconfig.la
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/fontconfig.pc
	$(REMOVE)/fontconfig-$(FONTCONFIG_VER)
	$(TOUCH)

#
# libdvdcss
#
LIBDVDCSS_VER = 1.2.13
LIBDVDCSS_SOURCE = libdvdcss-$(LIBDVDCSS_VER).tar.bz2

$(ARCHIVE)/$(LIBDVDCSS_SOURCE):
	$(WGET) https://download.videolan.org/pub/libdvdcss/$(LIBDVDCSS_VER)/$(LIBDVDCSS_SOURCE)

$(D)/libdvdcss: $(D)/bootstrap $(ARCHIVE)/$(LIBDVDCSS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libdvdcss-$(LIBDVDCSS_VER)
	$(UNTAR)/$(LIBDVDCSS_SOURCE)
	$(CH_DIR)/libdvdcss-$(LIBDVDCSS_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-doc \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libdvdcss.pc
	$(REWRITE_LIBTOOL)/libdvdcss.la
	$(SILENT)$(REMOVE)/libdvdcss-$(LIBDVDCSS_VER)
	$(TOUCH)

#
# libdvdnav
#
LIBDVDNAV_VER = 4.2.1
LIBDVDNAV_SOURCE = libdvdnav-$(LIBDVDNAV_VER).tar.xz
LIBDVDNAV_PATCH = libdvdnav-$(LIBDVDNAV_VER).patch

$(ARCHIVE)/$(LIBDVDNAV_SOURCE):
	$(WGET) http://dvdnav.mplayerhq.hu/releases/$(LIBDVDNAV_SOURCE)

$(D)/libdvdnav: $(D)/bootstrap $(D)/libdvdread $(ARCHIVE)/$(LIBDVDNAV_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libdvdnav-$(LIBDVDNAV_VER)
	$(UNTAR)/$(LIBDVDNAV_SOURCE)
	$(CH_DIR)/libdvdnav-$(LIBDVDNAV_VER); \
		$(call apply_patches, $(LIBDVDNAV_PATCH)); \
		$(BUILDENV) \
		libtoolize --copy --force --quiet --ltdl; \
		./autogen.sh \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
			--enable-static \
			--enable-shared \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/dvdnav.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/dvdnavmini.pc
	$(REWRITE_LIBTOOL)/libdvdnav.la
	$(REWRITE_LIBTOOL)/libdvdnavmini.la
	$(REMOVE)/libdvdnav-$(LIBDVDNAV_VER)
	$(TOUCH)

#
# libdvdread
#
LIBDVDREAD_VER = 4.9.9
LIBDVDREAD_SOURCE = libdvdread-$(LIBDVDREAD_VER).tar.xz
LIBDVDREAD_PATCH = libdvdread-$(LIBDVDREAD_VER).patch

$(ARCHIVE)/$(LIBDVDREAD_SOURCE):
	$(WGET) http://dvdnav.mplayerhq.hu/releases/$(LIBDVDREAD_SOURCE)

$(D)/libdvdread: $(D)/bootstrap $(ARCHIVE)/$(LIBDVDREAD_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libdvdread-$(LIBDVDREAD_VER)
	$(UNTAR)/$(LIBDVDREAD_SOURCE)
	$(CH_DIR)/libdvdread-$(LIBDVDREAD_VER); \
		$(call apply_patches, $(LIBDVDREAD_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-static \
			--enable-shared \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/dvdread.pc
	$(REWRITE_LIBTOOL)/libdvdread.la
	$(REMOVE)/libdvdread-$(LIBDVDREAD_VER)
	$(TOUCH)

#
# libdreamdvd
#
LIBDREAMDVD_PATCH  = libdreamdvd-1.0-sh4-support.patch
ifeq ($(IMAGE), $(filter $(IMAGE), titan titan-wlandriver))
LIBDREAMDVD_PATCH += libdreamdvd-1.0-titan-support.patch
endif

$(D)/libdreamdvd: $(D)/bootstrap $(D)/libdvdnav
	$(START_BUILD)
	$(REMOVE)/libdreamdvd
	$(SET) -e; if [ -d $(ARCHIVE)/libdreamdvd.git ]; \
		then cd $(ARCHIVE)/libdreamdvd.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) https://github.com/mirakels/libdreamdvd.git libdreamdvd.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/libdreamdvd.git $(BUILD_TMP)/libdreamdvd
	$(CH_DIR)/libdreamdvd; \
		$(call apply_patches, $(LIBDREAMDVD_PATCH)); \
		$(BUILDENV) \
		libtoolize --copy --ltdl --force --quiet; \
		autoreconf --verbose --force --install $(SILENT_OPT); \
		./configure $(SILENT_CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libdreamdvd.pc
	$(REWRITE_LIBTOOL)/libdreamdvd.la
	$(REMOVE)/libdreamdvd
	$(TOUCH)

#
# libass
#
LIBASS_VER = 0.14.0
LIBASS_SOURCE = libass-$(LIBASS_VER).tar.xz
LIBASS_PATCH = libass-$(LIBASS_VER).patch

$(ARCHIVE)/$(LIBASS_SOURCE):
	$(WGET) https://github.com/libass/libass/releases/download/$(LIBASS_VER)/$(LIBASS_SOURCE)

$(D)/libass: $(D)/bootstrap $(D)/freetype $(D)/libfribidi $(ARCHIVE)/$(LIBASS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libass-$(LIBASS_VER)
	$(UNTAR)/$(LIBASS_SOURCE)
	$(CH_DIR)/libass-$(LIBASS_VER); \
		$(call apply_patches, $(LIBASS_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-static \
			--disable-test \
			--disable-fontconfig \
			--disable-harfbuzz \
			--disable-require-system-font-provider \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libass.pc
	$(REWRITE_LIBTOOL)/libass.la
	$(REMOVE)/libass-$(LIBASS_VER)
	$(TOUCH)

#
# sqlite
#
SQLITE_VER = 3160100
SQLITE_SOURCE = sqlite-autoconf-$(SQLITE_VER).tar.gz

$(ARCHIVE)/$(SQLITE_SOURCE):
	$(WGET) http://www.sqlite.org/2017/$(SQLITE_SOURCE)

$(D)/sqlite: $(D)/bootstrap $(ARCHIVE)/$(SQLITE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/sqlite-autoconf-$(SQLITE_VER)
	$(UNTAR)/$(SQLITE_SOURCE)
	$(CH_DIR)/sqlite-autoconf-$(SQLITE_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/sqlite3.pc
	$(REWRITE_LIBTOOL)/libsqlite3.la
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,sqlite3)
	$(REMOVE)/sqlite-autoconf-$(SQLITE_VER)
	$(TOUCH)

#
# libsoup
#
LIBSOUP_VER_MAJOR = 2.64
LIBSOUP_VER_MINOR = 0
LIBSOUP_VER = $(LIBSOUP_VER_MAJOR).$(LIBSOUP_VER_MINOR)
LIBSOUP_SOURCE = libsoup-$(LIBSOUP_VER).tar.xz

$(ARCHIVE)/$(LIBSOUP_SOURCE):
	$(WGET) https://download.gnome.org/sources/libsoup/$(LIBSOUP_VER_MAJOR)/$(LIBSOUP_SOURCE)

$(D)/libsoup: $(D)/bootstrap $(D)/sqlite $(D)/libxml2 $(D)/libglib2 $(D)/libpsl $(ARCHIVE)/$(LIBSOUP_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libsoup-$(LIBSOUP_VER)
	$(UNTAR)/$(LIBSOUP_SOURCE)
	$(CH_DIR)/libsoup-$(LIBSOUP_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--datarootdir=/.remove \
			--disable-more-warnings \
			--without-gnome \
			--without-gssapi \
			--disable-gtk-doc \
			--disable-gtk-doc-html \
			--disable-gtk-doc-pdf \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) itlocaledir=$(TARGET_DIR)/.remove
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libsoup-2.4.pc
	$(REWRITE_LIBTOOL)/libsoup-2.4.la
	$(REMOVE)/libsoup-$(LIBSOUP_VER)
	$(TOUCH)

#
# libpsl
#
LIBPSL_VER_MAJOR = 0.21
LIBPSL_VER_MINOR = 2
LIBPSL_VER = $(LIBPSL_VER_MAJOR).$(LIBPSL_VER_MINOR)
LIBPSL_SOURCE = libpsl-$(LIBPSL_VER).tar.gz
LIBPSL_PATCH =

$(ARCHIVE)/$(LIBPSL_SOURCE):
	$(WGET) https://github.com/rockdaboot/libpsl/releases/download/$(LIBPSL_VER)/$(LIBPSL_SOURCE)

$(D)/libpsl: $(D)/bootstrap $(D)/host_python $(ARCHIVE)/$(LIBPSL_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libpsl-$(LIBPSL_VER)
	$(UNTAR)/$(LIBPSL_SOURCE)
	$(CH_DIR)/libpsl-$(LIBPSL_VER); \
		$(call apply_patches, $(LIBPSL_PATCH)); \
		$(BUILDENV) \
		$(CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
			--enable-man=no \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libpsl.pc
	$(REWRITE_LIBTOOL)/libpsl.la
	$(REMOVE)/libpsl-$(LIBPSL_VER)
	$(TOUCH)

#
# libogg
#
LIBOGG_VER = 1.3.3
LIBOGG_SOURCE = libogg-$(LIBOGG_VER).tar.gz

$(ARCHIVE)/$(LIBOGG_SOURCE):
	$(WGET) https://ftp.osuosl.org/pub/xiph/releases/ogg/$(LIBOGG_SOURCE)

$(D)/libogg: $(D)/bootstrap $(ARCHIVE)/$(LIBOGG_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libogg-$(LIBOGG_VER)
	$(UNTAR)/$(LIBOGG_SOURCE)
	$(CH_DIR)/libogg-$(LIBOGG_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--docdir=/.remove \
			--enable-shared \
			--disable-static \
			--enable-silent-rules \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(SILENT)$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/ogg.pc
	$(SILENT)$(REWRITE_LIBTOOL)/libogg.la
	$(REMOVE)/libogg-$(LIBOGG_VER)
	$(TOUCH)

#
# flac
#
FLAC_VER = 1.3.2
FLAC_SOURCE = flac-$(FLAC_VER).tar.xz
FLAC_PATCH = flac-$(FLAC_VER).patch

$(ARCHIVE)/$(FLAC_SOURCE):
	$(WGET) https://ftp.osuosl.org/pub/xiph/releases/flac/$(FLAC_SOURCE)

$(D)/flac: $(D)/bootstrap $(ARCHIVE)/$(FLAC_SOURCE)
	$(START_BUILD)
	$(REMOVE)/flac-$(FLAC_VER)
	$(UNTAR)/$(FLAC_SOURCE)
	$(CH_DIR)/flac-$(FLAC_VER); \
		$(call apply_patches, $(FLAC_PATCH)); \
		touch NEWS AUTHORS ChangeLog; \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--disable-cpplibs \
			--disable-debug \
			--disable-asm-optimizations \
			--disable-sse \
			--disable-altivec \
			--disable-doxygen-docs \
			--disable-thorough-tests \
			--disable-exhaustive-tests \
			--disable-valgrind-testing \
			--disable-ogg \
			--disable-oggtest \
			--disable-local-xmms-plugin \
			--disable-xmms-plugin \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) docdir=/.remove
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/flac.pc
	$(REWRITE_LIBTOOL)/libFLAC.la
	$(REMOVE)/flac-$(FLAC_VER)
	$(TOUCH)

#
# libxml2
#
LIBXML2_MAJOR = 2.12
LIBXML2_MINOR = 10
LIBXML2_VER = $(LIBXML2_MAJOR).$(LIBXML2_MINOR)
LIBXML2_SOURCE = libxml2-$(LIBXML2_VER).tar.xz
LIBXML2_PATCH = libxml2-$(LIBXML2_VER).patch

$(ARCHIVE)/$(LIBXML2_SOURCE):
	$(WGET) https://download.gnome.org/sources/libxml2/$(LIBXML2_MAJOR)/$(LIBXML2_SOURCE)

ifeq ($(IMAGE), $(filter $(IMAGE), enigma2 enigma2-wlandriver))
#LIBXML2_CONF_OPTS  = --with-python=$(HOST_DIR)
LIBXML2_CONF_OPTS  = --without-python
#LIBXML2_CONF_OPTS += --with-python-install-dir=/$(PYTHON_DIR)/site-packages
#LIBXML2_DEPS  = $(D)/python
endif

ifeq ($(IMAGE), $(filter $(IMAGE), neutrino neutrino-wlandriver titan titan-wlandriver))
LIBXML2_CONF_OPTS  = --without-python
ifeq ($(MEDIAFW), gstreamer)
LIBXML2_CONF_OPTS += --with-tree
LIBXML2_CONF_OPTS += --with-output
LIBXML2_CONF_OPTS += --with-sax1
endif
LIBXML2_CONF_OPTS += --without-iconv
LIBXML2_CONF_OPTS += --with-minimum
LIBXML2_CONF_OPTS += --with-schematron=yes
endif

$(D)/libxml2: $(D)/bootstrap $(D)/zlib $(LIBXML2_DEPS) $(ARCHIVE)/$(LIBXML2_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libxml2-$(LIBXML2_VER).tar.gz
	$(UNTAR)/$(LIBXML2_SOURCE)
	$(CH_DIR)/libxml2-$(LIBXML2_VER); \
		$(call apply_patches, $(LIBXML2_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix=/usr \
			--datarootdir=/.remove \
			--enable-shared \
			--disable-static \
			--without-catalog \
			--without-debug \
			--without-legacy \
			--without-mem-debug \
			--without-lzma \
			--with-zlib \
			$(LIBXML2_CONF_OPTS) \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR); \
		if [ -d $(TARGET_DIR)/usr/include/libxml2/libxml ] ; then \
			ln -sf ./libxml2/libxml $(TARGET_DIR)/usr/include/libxml; \
		fi
	$(SILENT)mv $(TARGET_DIR)/usr/bin/xml2-config $(HOST_DIR)/bin
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libxml-2.0.pc
	$(REWRITE_PKGCONF) $(HOST_DIR)/bin/xml2-config
	$(REWRITE_LIBTOOL)/libxml2.la
	$(SILENT)rm -f $(addprefix $(TARGET_DIR)/usr/bin/,xmlcatalog xmllint)
	$(SILENT)rm -rf $(TARGET_LIB_DIR)/xml2Conf.sh
	$(SILENT)rm -rf $(TARGET_LIB_DIR)/cmake
	$(REMOVE)/libxml2-$(LIBXML2_VER)
	$(TOUCH)

#
# libxslt
#
LIBXSLT_VER = 1.1.32
LIBXSLT_SOURCE = libxslt-$(LIBXSLT_VER).tar.gz

$(ARCHIVE)/$(LIBXSLT_SOURCE):
	$(WGET) ftp://xmlsoft.org/libxml2/$(LIBXSLT_SOURCE)

$(D)/libxslt: $(D)/bootstrap $(D)/libxml2 $(ARCHIVE)/$(LIBXSLT_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libxslt-$(LIBXSLT_VER)
	$(UNTAR)/$(LIBXSLT_SOURCE)
	$(CH_DIR)/libxslt-$(LIBXSLT_VER); \
		$(CONFIGURE) \
			CPPFLAGS="$(CPPFLAGS) -I$(TARGET_DIR)/usr/include/libxml2" \
			--prefix=/usr \
			--datarootdir=/.remove \
			--enable-shared \
			--disable-static \
			--without-python \
			--without-crypto \
			--without-debug \
			--without-mem-debug \
			--without-debugger \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/xslt-config $(HOST_DIR)/bin
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libexslt.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libxslt.pc
	$(REWRITE_PKGCONF) $(HOST_DIR)/bin/xslt-config
	$(REWRITE_LIBTOOL)/libexslt.la
	$(REWRITE_LIBTOOL)/libxslt.la
	$(REWRITE_LIBTOOLDEP)/libexslt.la
	$(SILENT)rm -f $(addprefix $(TARGET_DIR)/usr/bin/,xsltproc xslt-config)
	$(SILENT)rm -rf $(TARGETLIB)/xsltConf.sh
	$(SILENT)rm -rf $(TARGETLIB)/libxslt-plugins/
	$(REMOVE)/libxslt-$(LIBXSLT_VER)
	$(TOUCH)


#
# libpopt
#
LIBPOPT_VER = 1.16
LIBPOPT_SOURCE = popt-$(LIBPOPT_VER).tar.gz

$(ARCHIVE)/$(LIBPOPT_SOURCE):
	$(WGET) ftp://anduin.linuxfromscratch.org/BLFS/popt/$(LIBPOPT_SOURCE)

$(D)/libpopt: $(D)/bootstrap $(ARCHIVE)/$(LIBPOPT_SOURCE)
	$(START_BUILD)
	$(REMOVE)/popt-$(LIBPOPT_VER)
	$(UNTAR)/$(LIBPOPT_SOURCE)
	$(CH_DIR)/popt-$(LIBPOPT_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-static \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/popt.pc
	$(REWRITE_LIBTOOL)/libpopt.la
	$(REMOVE)/popt-$(LIBPOPT_VER)
	$(TOUCH)

#
# libroxml
#
LIBROXML_VER = 3.0.2
LIBROXML_SOURCE = libroxml-$(LIBROXML_VER).tar.gz

$(ARCHIVE)/$(LIBROXML_SOURCE):
	$(WGET) http://download.libroxml.net/pool/v3.x/$(LIBROXML_SOURCE)

$(D)/libroxml: $(D)/bootstrap $(ARCHIVE)/$(LIBROXML_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libroxml-$(LIBROXML_VER)
	$(UNTAR)/$(LIBROXML_SOURCE)
	$(CH_DIR)/libroxml-$(LIBROXML_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared \
			--disable-static \
			--disable-roxml \
			--disable-rocat \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libroxml.pc
	$(REWRITE_LIBTOOL)/libroxml.la
	$(REMOVE)/libroxml-$(LIBROXML_VER)
	$(TOUCH)

#
# pugixml
#
PUGIXML_VER = caade5a
PUGIXML_URL = https://github.com/zeux/pugixml.git
PUGIXML_PATCH = pugixml-$(PUGIXML_VER)-config.patch

$(D)/pugixml: $(D)/bootstrap
	$(START_BUILD)
	$(REMOVE)/pugixml-$(PUGIXML_VER)
	$(SET) -e; if [ -d $(ARCHIVE)/pugixml.git ]; \
		then cd $(ARCHIVE)/pugixml.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) $(PUGIXML_URL) pugixml.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/pugixml.git $(BUILD_TMP)/pugixml-$(PUGIXML_VER)
	$(SILENT)(cd $(BUILD_TMP)/pugixml-$(PUGIXML_VER); git checkout $(MINUS_Q) $(PUGIXML_VER))
	$(CH_DIR)/pugixml-$(PUGIXML_VER); \
		$(call apply_patches, $(PUGIXML_PATCH)); \
		cmake  --no-warn-unused-cli \
			-DCMAKE_INSTALL_PREFIX=/usr \
			-DBUILD_SHARED_LIBS=ON \
			-DCMAKE_BUILD_TYPE=Linux \
			-DCMAKE_C_COMPILER=$(TARGET)-gcc \
			-DCMAKE_CXX_COMPILER=$(TARGET)-g++ \
			-DCMAKE_C_FLAGS="-pipe -Os" \
			-DCMAKE_CXX_FLAGS="-pipe -Os" \
			| tail -n +90 \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/pugixml-$(PUGIXML_VER)
	cd $(TARGET_DIR) && rm -rf usr/lib/cmake
	$(TOUCH)

#
# graphlcd
#
GRAPHLCD_VER = 55d4bd8
GRAPHLCD_SOURCE = graphlcd-git-$(GRAPHLCD_VER).tar.bz2
GRAPHLCD_URL = https://github.com/Duckbox-Developers/graphlcd.git
GRAPHLCD_PATCH = graphlcd-git-$(GRAPHLCD_VER).patch

$(ARCHIVE)/$(GRAPHLCD_SOURCE):
	$(SCRIPTS_DIR)/get-git-archive.sh $(GRAPHLCD_URL) $(GRAPHLCD_VER) $(notdir $@) $(ARCHIVE)

$(D)/graphlcd: $(D)/bootstrap $(D)/freetype $(D)/libusb $(ARCHIVE)/$(GRAPHLCD_SOURCE)
	$(START_BUILD)
	$(REMOVE)/graphlcd-git-$(GRAPHLCD_VER)
	$(UNTAR)/$(GRAPHLCD_SOURCE)
	$(CH_DIR)/graphlcd-git-$(GRAPHLCD_VER); \
		$(call apply_patches, $(GRAPHLCD_PATCH)); \
		$(MAKE) -C glcdgraphics all TARGET=$(TARGET)- DESTDIR=$(TARGET_DIR); \
		$(MAKE) -C glcddrivers all TARGET=$(TARGET)- DESTDIR=$(TARGET_DIR); \
		$(MAKE) -C glcdgraphics install DESTDIR=$(TARGET_DIR); \
		$(MAKE) -C glcddrivers install DESTDIR=$(TARGET_DIR); \
		cp -a graphlcd.conf $(TARGET_DIR)/etc
	$(REMOVE)/graphlcd-git-$(GRAPHLCD_VER)
	$(TOUCH)

#
# libdpf
#
LIBDPF_VER = 62c8fd0
LIBDPF_SOURCE = dpf-ax-git-$(LIBDPF_VER).tar.bz2
LIBDPF_URL = https://github.com/Duckbox-Developers/dpf-ax.git
LIBDPF_PATCH = libdpf-crossbuild.patch

$(ARCHIVE)/$(LIBDPF_SOURCE):
	$(SCRIPTS_DIR)/get-git-archive.sh $(LIBDPF_URL) $(LIBDPF_VER) $(notdir $@) $(ARCHIVE)

$(D)/libdpf: $(D)/bootstrap $(D)/libusb_compat $(ARCHIVE)/$(LIBDPF_SOURCE)
	$(START_BUILD)
	$(REMOVE)/dpf-ax-git-$(LIBDPF_VER)
	$(UNTAR)/$(LIBDPF_SOURCE)
	$(CH_DIR)/dpf-ax-git-$(LIBDPF_VER)/dpflib; \
		$(call apply_patches, $(LIBDPF_PATCH)); \
		make libdpf.a CC=$(TARGET)-gcc PREFIX=$(TARGET_DIR)/usr; \
		mkdir -p $(TARGET_INCLUDE_DIR)/libdpf; \
		cp dpf.h $(TARGET_INCLUDE_DIR)/libdpf/libdpf.h; \
		cp ../include/spiflash.h $(TARGET_INCLUDE_DIR)/libdpf/; \
		cp ../include/usbuser.h $(TARGET_INCLUDE_DIR)/libdpf/; \
		cp libdpf.a $(TARGET_LIB_DIR)/
	$(REMOVE)/dpf-ax-git-$(LIBDPF_VER)
	$(TOUCH)

#
# lcd4linux
#
LCD4LINUX_VER = e2cfdc5
LCD4LINUX_SOURCE = lcd4linux-git-$(LCD4LINUX_VER).tar.bz2
LCD4LINUX_URL = https://github.com/TangoCash/lcd4linux.git
#LCD4LINUX_PATCH = lcd4linux-widget.patch

$(ARCHIVE)/$(LCD4LINUX_SOURCE):
	$(SCRIPTS_DIR)/get-git-archive.sh $(LCD4LINUX_URL) $(LCD4LINUX_VER) $(notdir $@) $(ARCHIVE)

$(D)/lcd4linux: $(D)/bootstrap $(D)/libusb_compat $(D)/gd $(D)/libusb $(D)/libdpf $(ARCHIVE)/$(LCD4LINUX_SOURCE)
	$(START_BUILD)
	$(REMOVE)/lcd4linux-git-$(LCD4LINUX_VER)
	$(UNTAR)/$(LCD4LINUX_SOURCE)
	$(CH_DIR)/lcd4linux-git-$(LCD4LINUX_VER); \
		if [ ! -d m4 ]; then mkdir m4; fi; \
		$(call apply_patches, $(LCD4LINUX_PATCH)); \
		$(BUILDENV) ./bootstrap $(SILENT_OPT); \
		$(BUILDENV) ./configure $(CONFIGURE_OPTS) \
			--prefix=/usr \
			--with-drivers='DPF,SamsungSPF$(LCD4LINUX_DRV),PNG' \
			--with-plugins='all,!apm,!asterisk,!dbus,!dvb,!gps,!hddtemp,!huawei,!imon,!isdn,!kvv,!mpd,!mpris_dbus,!mysql,!pop3,!ppp,!python,!qnaplog,!raspi,!sample,!seti,!w1retap,!wireless,!xmms' \
			--without-ncurses \
		; \
		$(MAKE) vcs_version all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	install -m 755 $(SKEL_ROOT)/etc/init.d/lcd4linux $(TARGET_DIR)/etc/init.d/
	install -D -m 0600 $(SKEL_ROOT)/etc/lcd4linux_ni.conf $(TARGET_DIR)/etc/lcd4linux.conf
	$(REMOVE)/lcd4linux-git-$(LCD4LINUX_VER)
	$(TOUCH)

#
# gd
#
GD_VER = 2.3.2
GD_SOURCE = libgd-$(GD_VER).tar.xz

$(ARCHIVE)/$(GD_SOURCE):
	$(WGET) https://github.com/libgd/libgd/releases/download/gd-$(GD_VER)/$(GD_SOURCE)

$(D)/gd: $(D)/bootstrap $(D)/libpng $(D)/libjpeg $(D)/freetype $(ARCHIVE)/$(GD_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libgd-$(GD_VER)
	$(UNTAR)/$(GD_SOURCE)
	$(CH_DIR)/libgd-$(GD_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--bindir=/.remove \
			--without-fontconfig \
			--without-xpm \
			--without-x \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libgd.la
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gdlib.pc
	$(REMOVE)/libgd-$(GD_VER)
	$(TOUCH)

#
# libusb
#
LIBUSB_VER = 1.0.22
LIBUSB_VER_MAJOR = 1.0
LIBUSB_SOURCE = libusb-$(LIBUSB_VER).tar.bz2
LIBUSB_PATCH  = libusb-$(LIBUSB_VER).patch
LIBUSB_PATCH += libusb-$(LIBUSB_VER)-automake-version.patch
LIBUSB_PATCH += libusb-$(LIBUSB_VER)-sh4-clock_gettime.patch

$(ARCHIVE)/$(LIBUSB_SOURCE):
	$(WGET) https://sourceforge.net/projects/libusb/files/libusb-$(LIBUSB_VER_MAJOR)/libusb-$(LIBUSB_VER)/$(LIBUSB_SOURCE)

$(D)/libusb: $(D)/bootstrap $(ARCHIVE)/$(LIBUSB_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libusb-$(LIBUSB_VER)
	$(UNTAR)/$(LIBUSB_SOURCE)
	$(CH_DIR)/libusb-$(LIBUSB_VER); \
		rm aclocal.m4; \
		rm compile; \
		rm config.*; \
		rm configure; \
		rm depcomp; \
		rm install-sh; \
		$(call apply_patches, $(LIBUSB_PATCH)); \
		chmod +x autogen.sh; \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-static \
			--disable-log \
			--disable-debug-log \
			--disable-udev \
			--disable-examples-build \
		; \
		$(MAKE) ; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libusb-1.0.la
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libusb-1.0.pc
	$(REMOVE)/libusb-$(LIBUSB_VER)
	$(TOUCH)

#
# libusb_compat
#
LIBUSB_COMPAT_VER = 0.1.5
LIBUSB_COMPAT_SOURCE = libusb-compat-$(LIBUSB_COMPAT_VER).tar.bz2

$(ARCHIVE)/$(LIBUSB_COMPAT_SOURCE):
	$(WGET) https://sourceforge.net/projects/libusb/files/libusb-compat-0.1/libusb-compat-$(LIBUSB_COMPAT_VER)/$(LIBUSB_COMPAT_SOURCE)

$(D)/libusb_compat: $(D)/bootstrap $(D)/libusb $(ARCHIVE)/$(LIBUSB_COMPAT_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libusb-compat-$(LIBUSB_COMPAT_VER)
	$(UNTAR)/$(LIBUSB_COMPAT_SOURCE)
	$(CH_DIR)/libusb-compat-$(LIBUSB_COMPAT_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-log \
			--disable-debug-log \
			--disable-examples-build \
		; \
		$(MAKE) ; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(TARGET_DIR)/usr/bin/libusb-config
	$(REWRITE_LIBTOOL)/libusb.la
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libusb.pc
	$(REMOVE)/libusb-compat-$(LIBUSB_COMPAT_VER)
	$(TOUCH)

#
# alsa-lib
#
ALSA_LIB_VER = 1.2.13
ALSA_LIB_SOURCE = alsa-lib-$(ALSA_LIB_VER).tar.bz2
ALSA_LIB_PATCH  = alsa-lib-$(ALSA_LIB_VER).patch
ALSA_LIB_PATCH += alsa-lib-$(ALSA_LIB_VER)-link_fix.patch
ALSA_LIB_PATCH += alsa-lib-$(ALSA_LIB_VER)-header.patch
ALSA_LIB_PATCH += alsa-lib-$(ALSA_LIB_VER)-sh4_kernel_long_t-fix.patch


$(ARCHIVE)/$(ALSA_LIB_SOURCE):
	$(WGET) https://www.alsa-project.org/files/pub/lib/$(ALSA_LIB_SOURCE)

$(D)/alsa_lib: $(D)/bootstrap $(ARCHIVE)/$(ALSA_LIB_SOURCE)
	$(START_BUILD)
	$(REMOVE)/alsa-lib-$(ALSA_LIB_VER)
	$(UNTAR)/$(ALSA_LIB_SOURCE)
	$(CH_DIR)/alsa-lib-$(ALSA_LIB_VER); \
		$(call apply_patches, $(ALSA_LIB_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--with-alsa-devdir=/dev/snd/ \
			--with-plugindir=/usr/lib/alsa \
			--without-debug \
			--with-debug=no \
			--with-versioned=no \
			--enable-symbolic-functions \
			--enable-silent-rules \
			--disable-aload \
			--disable-rawmidi \
			--disable-resmgr \
			--disable-old-symbols \
			--disable-alisp \
			--disable-ucm \
			--disable-hwdep \
			--disable-python \
			--disable-topology \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/alsa.pc
	$(REWRITE_LIBTOOL)/libasound.la
	$(REMOVE)/alsa-lib-$(ALSA_LIB_VER)
	$(TOUCH)

#
# alsa-utils
#
ALSA_UTILS_VER = 1.2.13
ALSA_UTILS_SOURCE = alsa-utils-$(ALSA_UTILS_VER).tar.bz2
ALSA_UTILS_PATCH  = alsa-utils-$(ALSA_UTILS_VER).patch

$(ARCHIVE)/$(ALSA_UTILS_SOURCE):
	$(WGET) https://www.alsa-project.org/files/pub/utils/$(ALSA_UTILS_SOURCE)

$(D)/alsa_utils: $(D)/bootstrap $(D)/alsa_lib $(ARCHIVE)/$(ALSA_UTILS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/alsa-utils-$(ALSA_UTILS_VER)
	$(UNTAR)/$(ALSA_UTILS_SOURCE)
	$(CH_DIR)/alsa-utils-$(ALSA_UTILS_VER); \
		$(call apply_patches, $(ALSA_UTILS_PATCH)); \
		sed -ir -r "s/(alsamixer|amidi|aplay|iecset|speaker-test|seq|alsactl|alsaucm|topology)//g" Makefile.am ;\
		autoreconf -fi -I $(TARGET_DIR)/usr/share/aclocal $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--with-curses=ncurses \
			--enable-silent-rules \
			--disable-bat \
			--disable-nls \
			--disable-alsatest \
			--disable-alsaconf \
			--disable-alsaloop \
			--disable-alsamixer \
			--disable-xmlto \
			--disable-rst2man \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/alsa-utils-$(ALSA_UTILS_VER)
	install -m 755 $(SKEL_ROOT)/etc/init.d/amixer $(TARGET_DIR)/etc/init.d/amixer
	install -m 644 $(SKEL_ROOT)/etc/amixer.conf $(TARGET_DIR)/etc/amixer.conf
	install -m 644 $(SKEL_ROOT)/etc/asound.conf $(TARGET_DIR)/etc/asound.conf
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,aserver)
	rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,alsa-info.sh)
	$(TOUCH)

#
# libopenthreads
#
LIBOPENTHREADS_VER = 3.2
LIBOPENTHREADS_SOURCE = OpenThreads-$(LIBOPENTHREADS_VER).tar.gz
LIBOPENTHREADS_PATCH = libopenthreads-$(LIBOPENTHREADS_VER).patch

$(ARCHIVE)/$(LIBOPENTHREADS_SOURCE):
	$(WGET) https://sourceforge.net/projects/mxedeps/files/$(LIBOPENTHREADS_SOURCE)

$(D)/libopenthreads: $(D)/bootstrap $(ARCHIVE)/$(LIBOPENTHREADS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/OpenThreads-$(LIBOPENTHREADS_VER)
	$(UNTAR)/$(LIBOPENTHREADS_SOURCE)
	$(CH_DIR)/OpenThreads-$(LIBOPENTHREADS_VER); \
		$(call apply_patches, $(LIBOPENTHREADS_PATCH)); \
		echo "# dummy file to prevent warning message" > examples/CMakeLists.txt; \
		cmake . -DCMAKE_BUILD_TYPE=Release \
			-DCMAKE_SYSTEM_NAME="Linux" \
			-DCMAKE_INSTALL_PREFIX=/usr \
			-DCMAKE_C_COMPILER="$(TARGET)-gcc" \
			-DCMAKE_CXX_COMPILER="$(TARGET)-g++" \
			-D_OPENTHREADS_ATOMIC_USE_GCC_BUILTINS_EXITCODE=1 \
			-D_OPENTHREADS_ATOMIC_USE_GCC_BUILTINS_EXITCODE__TRYRUN_OUTPUT=1 \
		; \
		find . -name cmake_install.cmake -print0 | xargs -0 \
		sed -i 's@SET(CMAKE_INSTALL_PREFIX "/usr/local")@SET(CMAKE_INSTALL_PREFIX "")@'; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/openthreads.pc
	$(REMOVE)/OpenThreads-$(LIBOPENTHREADS_VER)
	$(TOUCH)

#
# librtmp
#
LIBRTMP_VER = ad70c64
LIBRTMP_SOURCE = rtmpdump-git-$(LIBRTMP_VER).tar.bz2
LIBRTMP_URL = https://github.com/oe-alliance/rtmpdump.git
LIBRTMP_PATCH = rtmpdump-git-$(LIBRTMP_VER).patch

$(ARCHIVE)/$(LIBRTMP_SOURCE):
	$(SCRIPTS_DIR)/get-git-archive.sh $(LIBRTMP_URL) $(LIBRTMP_VER) $(notdir $@) $(ARCHIVE)

$(D)/librtmp: $(D)/bootstrap $(D)/zlib $(D)/openssl $(ARCHIVE)/$(LIBRTMP_SOURCE)
	$(START_BUILD)
	$(REMOVE)/rtmpdump-git-$(LIBRTMP_VER)
	$(UNTAR)/$(LIBRTMP_SOURCE)
	$(CH_DIR)/rtmpdump-git-$(LIBRTMP_VER); \
		$(call apply_patches, $(LIBRTMP_PATCH)); \
		$(BUILDENV) \
		$(MAKE) CROSS_COMPILE=$(TARGET)- XCFLAGS="-I$(TARGET_INCLUDE_DIR) -L$(TARGET_LIB_DIR)" LDFLAGS="-L$(TARGET_LIB_DIR)"; \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR) MANDIR=$(TARGET_DIR)/.remove
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/librtmp.pc
	$(SILENT)rm -f $(addprefix $(TARGET_DIR)/usr/sbin/,rtmpgw rtmpsrv rtmpsuck)
	$(SILENT)rm -f $(addprefix $(TARGET_DIR)/usr/bin/,rtmpdump)
	$(REMOVE)/rtmpdump-git-$(LIBRTMP_VER)
	$(TOUCH)

#
# libdvbsi++
#
LIBDVBSI_VER = f3c40ea
LIBDVBSI_SOURCE = libdvbsi-git-$(LIBDVBSI_VER).tar.bz2
LIBDVBSI_URL = https://github.com/OpenVisionE2/libdvbsi.git
#LIBDVBSI_PATCH = libdvbsi-git-$(LIBDVBSI_VER).patch

$(ARCHIVE)/$(LIBDVBSI_SOURCE):
	$(SCRIPTS_DIR)/get-git-archive.sh $(LIBDVBSI_URL) $(LIBDVBSI_VER) $(notdir $@) $(ARCHIVE)

$(D)/libdvbsi: $(D)/bootstrap $(ARCHIVE)/$(LIBDVBSI_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libdvbsi-git-$(LIBDVBSI_VER)
	$(UNTAR)/$(LIBDVBSI_SOURCE)
	$(CH_DIR)/libdvbsi-git-$(LIBDVBSI_VER); \
		$(call apply_patches, $(LIBDVBSI_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libdvbsi++.pc
	$(REWRITE_LIBTOOL)/libdvbsi++.la
	$(REMOVE)/libdvbsi-git-$(LIBDVBSI_VER)
	$(TOUCH)

#
# libdvbcsa
#
$(D)/libdvbcsa: $(D)/bootstrap $(ARCHIVE)/$(LIBDVBCSA_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libdvbcsa
	$(SET) -e; if [ -d $(ARCHIVE)/libdvbcsa.git ]; \
		then cd $(ARCHIVE)/libdvbcsa.git; git pull; \
		else cd $(ARCHIVE); git clone https://code.videolan.org/videolan/libdvbcsa.git libdvbcsa.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/libdvbcsa.git $(BUILD_TMP)/libdvbcsa
	$(CH_DIR)/libdvbcsa; \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libdvbcsa.la
	$(REMOVE)/libdvbcsa
	$(TOUCH)

#
# libmodplug
#
LIBMODPLUG_VER = 0.8.8.4
LIBMODPLUG_SOURCE = libmodplug-$(LIBMODPLUG_VER).tar.gz

$(ARCHIVE)/$(LIBMODPLUG_SOURCE):
	$(WGET) https://sourceforge.net/projects/modplug-xmms/files/libmodplug/$(LIBMODPLUG_VER)/$(LIBMODPLUG_SOURCE)

$(D)/libmodplug: $(D)/bootstrap $(ARCHIVE)/$(LIBMODPLUG_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libmodplug-$(LIBMODPLUG_VER)
	$(UNTAR)/$(LIBMODPLUG_SOURCE)
	$(CH_DIR)/libmodplug-$(LIBMODPLUG_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libmodplug.pc
	$(REWRITE_LIBTOOL)/libmodplug.la
	$(REMOVE)/libmodplug-$(LIBMODPLUG_VER)
	$(TOUCH)

#
# lzo
#
LZO_VER = 2.10
LZO_SOURCE = lzo-$(LZO_VER).tar.gz

$(ARCHIVE)/$(LZO_SOURCE):
	$(WGET) https://www.oberhumer.com/opensource/lzo/download/$(LZO_SOURCE)

$(D)/lzo: $(D)/bootstrap $(ARCHIVE)/$(LZO_SOURCE)
	$(START_BUILD)
	$(REMOVE)/lzo-$(LZO_VER)
	$(UNTAR)/$(LZO_SOURCE)
	$(CH_DIR)/lzo-$(LZO_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--docdir=/.remove \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/lzo2.pc
	$(REWRITE_LIBTOOL)/liblzo2.la
	$(REMOVE)/lzo-$(LZO_VER)
	$(TOUCH)

#
# minidlna
#
MINIDLNA_VER = 1.3.2
MINIDLNA_SOURCE = minidlna-$(MINIDLNA_VER).tar.gz
MINIDLNA_PATCH = minidlna-$(MINIDLNA_VER).patch

$(ARCHIVE)/$(MINIDLNA_SOURCE):
	$(WGET) https://sourceforge.net/projects/minidlna/files/minidlna/$(MINIDLNA_VER)/$(MINIDLNA_SOURCE)

$(D)/minidlna: $(D)/bootstrap $(D)/zlib $(D)/sqlite $(D)/libexif $(D)/libjpeg $(D)/libid3tag $(D)/libogg $(D)/libvorbis $(D)/flac $(D)/ffmpeg $(ARCHIVE)/$(MINIDLNA_SOURCE)
	$(START_BUILD)
	$(REMOVE)/minidlna-$(MINIDLNA_VER)
	$(UNTAR)/$(MINIDLNA_SOURCE)
	$(CH_DIR)/minidlna-$(MINIDLNA_VER); \
		$(call apply_patches, $(MINIDLNA_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR)
	$(REMOVE)/minidlna-$(MINIDLNA_VER)
	$(TOUCH)

#
# libexif
#
LIBEXIF_VER = 0.6.21
LIBEXIF_SOURCE = libexif-$(LIBEXIF_VER).tar.gz

$(ARCHIVE)/$(LIBEXIF_SOURCE):
	$(WGET) https://sourceforge.net/projects/libexif/files/libexif/$(LIBEXIF_VER)/$(LIBEXIF_SOURCE)

$(D)/libexif: $(D)/bootstrap $(ARCHIVE)/$(LIBEXIF_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libexif-$(LIBEXIF_VER)
	$(UNTAR)/$(LIBEXIF_SOURCE)
	$(CH_DIR)/libexif-$(LIBEXIF_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-silent-rules \
		; \
		$(MAKE); \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libexif.pc
	$(REWRITE_LIBTOOL)/libexif.la
	$(REMOVE)/libexif-$(LIBEXIF_VER)
	$(TOUCH)

#
# djmount
#
DJMOUNT_VER = 0.71
DJMOUNT_SOURCE = djmount-$(DJMOUNT_VER).tar.gz
DJMOUNT_PATCH  = djmount-$(DJMOUNT_VER)-fix-hang-with-asset-upnp.patch
DJMOUNT_PATCH += djmount-$(DJMOUNT_VER)-fix-incorrect-range-when-retrieving-content-via-HTTP.patch
DJMOUNT_PATCH += djmount-$(DJMOUNT_VER)-fix-new-autotools.patch
DJMOUNT_PATCH += djmount-$(DJMOUNT_VER)-fixed-crash-when-using-UTF-8-charset.patch
DJMOUNT_PATCH += djmount-$(DJMOUNT_VER)-fixed-crash.patch
DJMOUNT_PATCH += djmount-$(DJMOUNT_VER)-support-fstab-mounting.patch
DJMOUNT_PATCH += djmount-$(DJMOUNT_VER)-support-seeking-in-large-2gb-files.patch

$(ARCHIVE)/$(DJMOUNT_SOURCE):
	$(WGET) https://sourceforge.net/projects/djmount/files/djmount/$(DJMOUNT_VER)/$(DJMOUNT_SOURCE)

$(D)/djmount: $(D)/bootstrap $(D)/fuse $(ARCHIVE)/$(DJMOUNT_SOURCE)
	$(START_BUILD)
	$(REMOVE)/djmount-$(DJMOUNT_VER)
	$(UNTAR)/$(DJMOUNT_SOURCE)
	$(CH_DIR)/djmount-$(DJMOUNT_VER); \
		touch libupnp/config.aux/config.rpath; \
		$(call apply_patches, $(DJMOUNT_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) -C \
			--prefix=/usr \
			--disable-debug \
		; \
		make; \
		make install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/djmount-$(DJMOUNT_VER)
	$(TOUCH)

#
# libupnp
#
LIBUPNP_VER = 1.6.25
LIBUPNP_SOURCE = libupnp-$(LIBUPNP_VER).tar.bz2

$(ARCHIVE)/$(LIBUPNP_SOURCE):
	$(WGET) https://sourceforge.net/projects/pupnp/files/pupnp/libUPnP\ $(LIBUPNP_VER)/$(LIBUPNP_SOURCE)

$(D)/libupnp: $(D)/bootstrap $(ARCHIVE)/$(LIBUPNP_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libupnp-$(LIBUPNP_VER)
	$(UNTAR)/$(LIBUPNP_SOURCE)
	$(CH_DIR)/libupnp-$(LIBUPNP_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libupnp.pc
	$(REWRITE_LIBTOOL)/libixml.la
	$(REWRITE_LIBTOOL)/libthreadutil.la
	$(REWRITE_LIBTOOL)/libupnp.la
	$(REMOVE)/libupnp-$(LIBUPNP_VER)
	$(TOUCH)

#
# rarfs
#
RARFS_VER = 0.1.1
RARFS_SOURCE = rarfs-$(RARFS_VER).tar.gz

$(ARCHIVE)/$(RARFS_SOURCE):
	$(WGET) https://sourceforge.net/projects/rarfs/files/rarfs/$(RARFS_VER)/$(RARFS_SOURCE)

$(D)/rarfs: $(D)/bootstrap $(D)/fuse $(ARCHIVE)/$(RARFS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/rarfs-$(RARFS_VER)
	$(UNTAR)/$(RARFS_SOURCE)
	$(CH_DIR)/rarfs-$(RARFS_VER); \
		export PKG_CONFIG_PATH=$(PKG_CONFIG_PATH); \
		$(CONFIGURE) \
			CFLAGS="$(TARGET_CFLAGS) -D_FILE_OFFSET_BITS=64" \
			--prefix=/usr \
			--disable-option-checking \
			--includedir=/usr/include/fuse \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/rarfs-$(RARFS_VER)
	$(TOUCH)

#
# sshfs
#
SSHFS_VER = 2.9
SSHFS_SOURCE = sshfs-$(SSHFS_VER).tar.gz

$(ARCHIVE)/$(SSHFS_SOURCE):
	$(WGET) https://github.com/libfuse/sshfs/releases/download/sshfs-$(SSHFS_VER)/$(SSHFS_SOURCE)

$(D)/sshfs: $(D)/bootstrap $(D)/libglib2 $(D)/fuse $(ARCHIVE)/$(SSHFS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/sshfs-$(SSHFS_VER)
	$(UNTAR)/$(SSHFS_SOURCE)
	$(CH_DIR)/sshfs-$(SSHFS_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/sshfs-$(SSHFS_VER)
	$(TOUCH)

#
# howl
#
HOWL_VER = 1.0.0
HOWL_SOURCE = howl-$(HOWL_VER).tar.gz

$(ARCHIVE)/$(HOWL_SOURCE):
	$(WGET) https://sourceforge.net/projects/howl/files/howl/$(HOWL_VER)/$(HOWL_SOURCE)

$(D)/howl: $(D)/bootstrap $(ARCHIVE)/$(HOWL_SOURCE)
	$(START_BUILD)
	$(REMOVE)/howl-$(HOWL_VER)
	$(UNTAR)/$(HOWL_SOURCE)
	$(CH_DIR)/howl-$(HOWL_VER); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix=/usr \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/howl.pc
	$(REWRITE_LIBTOOL)/libhowl.la
	$(REMOVE)/howl-$(HOWL_VER)
	$(TOUCH)

#
# libdaemon
#
LIBDAEMON_VER = 0.14
LIBDAEMON_SOURCE = libdaemon-$(LIBDAEMON_VER).tar.gz

$(ARCHIVE)/$(LIBDAEMON_SOURCE):
	$(WGET) http://0pointer.de/lennart/projects/libdaemon/$(LIBDAEMON_SOURCE)

$(D)/libdaemon: $(D)/bootstrap $(ARCHIVE)/$(LIBDAEMON_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libdaemon-$(LIBDAEMON_VER)
	$(UNTAR)/$(LIBDAEMON_SOURCE)
	$(CH_DIR)/libdaemon-$(LIBDAEMON_VER); \
		$(CONFIGURE) \
			ac_cv_func_setpgrp_void=yes \
			--prefix=/usr \
			--disable-static \
			--disable-lynx \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libdaemon.pc
	$(REWRITE_LIBTOOL)/libdaemon.la
	$(REMOVE)/libdaemon-$(LIBDAEMON_VER)
	$(TOUCH)

#
# libplist
#
LIBPLIST_VER = 1.10
LIBPLIST_SOURCE = libplist-$(LIBPLIST_VER).tar.gz

$(ARCHIVE)/$(LIBPLIST_SOURCE):
	$(WGET) https://cgit.sukimashita.com/libplist.git/snapshot/$(LIBPLIST_SOURCE)

$(D)/libplist: $(D)/bootstrap $(D)/libxml2 $(ARCHIVE)/$(LIBPLIST_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libplist-$(LIBPLIST_VER)
	$(UNTAR)/$(LIBPLIST_SOURCE)
	export PKG_CONFIG_PATH=$(PKG_CONFIG_PATH)
	$(CH_DIR)/libplist-$(LIBPLIST_VER); \
		rm CMakeFiles/* -rf CMakeCache.txt cmake_install.cmake; \
		cmake . -DCMAKE_BUILD_TYPE=Release \
			-DCMAKE_SYSTEM_NAME="Linux" \
			-DCMAKE_INSTALL_PREFIX="/usr" \
			-DCMAKE_C_COMPILER="$(TARGET)-gcc" \
			-DCMAKE_CXX_COMPILER="$(TARGET)-g++" \
			-DCMAKE_INCLUDE_PATH="$(TARGET_DIR)/usr/include" \
		; \
		find . -name cmake_install.cmake -print0 | xargs -0 \
		sed -i 's@SET(CMAKE_INSTALL_PREFIX "/usr/local")@SET(CMAKE_INSTALL_PREFIX "")@'; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libplist.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libplist++.pc
	$(REMOVE)/libplist-$(LIBPLIST_VER)
	$(TOUCH)

#
# libao
#
LIBAO_VER = 1.1.0
LIBAO_SOURCE = libao-$(LIBAO_VER).tar.gz

$(ARCHIVE)/$(LIBAO_SOURCE):
	$(WGET) https://ftp.osuosl.org/pub/xiph/releases/ao/$(LIBAO_SOURCE)

$(D)/libao: $(D)/bootstrap $(D)/alsa_lib $(ARCHIVE)/$(LIBAO_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libao-$(LIBAO_VER)
	$(UNTAR)/$(LIBAO_SOURCE)
	$(CH_DIR)/libao-$(LIBAO_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared \
			--disable-static \
			--enable-alsa \
			--enable-alsa-mmap \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/ao.pc
	$(REWRITE_LIBTOOL)/libao.la
	$(REMOVE)/libao-$(LIBAO_VER)
	$(TOUCH)

#
# nettle
#
NETTLE_VER = 3.3
NETTLE_SOURCE = nettle-$(NETTLE_VER).tar.gz
NETTLE_PATCH = nettle-$(NETTLE_VER).patch

$(ARCHIVE)/$(NETTLE_SOURCE):
	$(WGET) https://ftp.gnu.org/gnu/nettle/$(NETTLE_SOURCE)

$(D)/nettle: $(D)/bootstrap $(D)/gmp $(ARCHIVE)/$(NETTLE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/nettle-$(NETTLE_VER)
	$(UNTAR)/$(NETTLE_SOURCE)
	$(CH_DIR)/nettle-$(NETTLE_VER); \
		$(call apply_patches, $(NETTLE_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-documentation \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/hogweed.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/nettle.pc
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,sexp-conv nettle-hash nettle-pbkdf2 nettle-lfib-stream pkcs1-conv)
	$(REMOVE)/nettle-$(NETTLE_VER)
	$(TOUCH)

#
# gnutls
#
GNUTLS_VER_MAJOR = 3.6
GNUTLS_VER_MINOR = 1
GNUTLS_VER = $(GNUTLS_VER_MAJOR).$(GNUTLS_VER_MINOR)
GNUTLS_SOURCE = gnutls-$(GNUTLS_VER).tar.xz

$(ARCHIVE)/$(GNUTLS_SOURCE):
	$(WGET) ftp://ftp.gnutls.org/gcrypt/gnutls/v$(GNUTLS_VER_MAJOR)/$(GNUTLS_SOURCE)

$(D)/gnutls: $(D)/bootstrap $(D)/nettle $(D)/ca-bundle $(ARCHIVE)/$(GNUTLS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/gnutls-$(GNUTLS_VER)
	$(UNTAR)/$(GNUTLS_SOURCE)
	$(CH_DIR)/gnutls-$(GNUTLS_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--infodir=/.remove \
			--datarootdir=/.remove \
			--with-included-libtasn1 \
			--enable-local-libopts \
			--with-libpthread-prefix=$(TARGET_DIR)/usr \
			--with-included-unistring \
			--with-default-trust-store-dir=$(CA_BUNDLE_DIR)/ \
			--disable-guile \
			--without-p11-kit \
			--without-idn \
			--disable-libdane \
			--without-tpm \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/gnutls.pc
	$(REWRITE_LIBTOOL)/libgnutls.la
	$(REWRITE_LIBTOOL)/libgnutlsxx.la
	$(REWRITE_LIBTOOLDEP)/libgnutlsxx.la
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,psktool gnutls-cli-debug certtool srptool ocsptool gnutls-serv gnutls-cli)
	$(REMOVE)/gnutls-$(GNUTLS_VER)
	$(TOUCH)

#
# glib-networking
#
GLIB_NETWORKING_VER_MAJOR = 2.50
GLIB_NETWORKING_VER_MINOR = 0
GLIB_NETWORKING_VER = $(GLIB_NETWORKING_VER_MAJOR).$(GLIB_NETWORKING_VER_MINOR)
GLIB_NETWORKING_SOURCE = glib-networking-$(GLIB_NETWORKING_VER).tar.xz

$(ARCHIVE)/$(GLIB_NETWORKING_SOURCE):
	$(WGET) https://ftp.acc.umu.se/pub/GNOME/sources/glib-networking/$(GLIB_NETWORKING_VER_MAJOR)/$(GLIB_NETWORKING_SOURCE)

$(D)/glib_networking: $(D)/bootstrap $(D)/gnutls $(D)/libglib2 $(ARCHIVE)/$(GLIB_NETWORKING_SOURCE)
	$(START_BUILD)
	$(REMOVE)/glib-networking-$(GLIB_NETWORKING_VER)
	$(UNTAR)/$(GLIB_NETWORKING_SOURCE)
	$(CH_DIR)/glib-networking-$(GLIB_NETWORKING_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--datadir=/.remove \
			--datarootdir=/.remove \
			--localedir=/.remove \
		; \
		$(MAKE); \
		$(MAKE) install prefix=$(TARGET_DIR) giomoduledir=$(TARGET_DIR)/usr/lib/gio/modules itlocaledir=$(TARGET_DIR)/.remove
	$(REMOVE)/glib-networking-$(GLIB_NETWORKING_VER)
	$(TOUCH)

#
# libudfread
#
LIBUDFREAD_VER_MAJOR = 1
LIBUDFREAD_VER_MINOR = 0
LIBUDFREAD_VER_MICRO = 0
LIBUDFREAD_VER = $(LIBUDFREAD_VER_MAJOR).$(LIBUDFREAD_VER_MINOR).$(LIBUDFREAD_VER_MICRO)
LIBUDFREAD_URL = https://code.videolan.org/videolan/libudfread.git
LIBUDFREAD_PATCH =

$(D)/libudfread: $(D)/bootstrap
	$(START_BUILD)
	$(REMOVE)/libudfread-$(LIBUDFREAD_VER)
	$(SET) -e; if [ -d $(ARCHIVE)/libudfread.git ]; \
		then cd $(ARCHIVE)/libudfread.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) $(LIBUDFREAD_URL) libudfread.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/libudfread.git $(BUILD_TMP)/libudfread-$(LIBUDFREAD_VER)
	$(CH_DIR)/libudfread-$(LIBUDFREAD_VER); \
		$(call apply_patches, $(LIBUDFREAD_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--infodir=/.remove \
			--datarootdir=/.remove \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libudfread.la
	$(REWRITE_LIBTOOLDEP)/libudfread.la
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,psktool gnutls-cli-debug certtool srptool ocsptool gnutls-serv gnutls-cli)
	$(REMOVE)/libudfread-$(LIBUDFREAD_VER)
	$(TOUCH)

#
# uchardet
#
UCHARDET_VER = 0.0.6
UCHARDET_SOURCE = uchardet-$(UCHARDET_VER).tar.xz
UCHARDET_PATCH =

$(ARCHIVE)/$(UCHARDET_SOURCE):
	$(WGET) https://www.freedesktop.org/software/uchardet/releases/$(UCHARDET_SOURCE)

$(D)/uchardet: $(D)/bootstrap $(ARCHIVE)/$(UCHARDET_SOURCE)
	$(START_BUILD)
	$(REMOVE)/uchardet-$(UCHARDET_VER)
	$(UNTAR)/$(UCHARDET_SOURCE)
	$(CH_DIR)/uchardet-$(UCHARDET_VER); \
		$(call apply_patches, $(UCHARDET_PATCH)); \
		rm CMakeFiles/* -rf CMakeCache.txt cmake_install.cmake; \
		cmake . -DCMAKE_BUILD_TYPE=Release \
			-DCMAKE_SYSTEM_NAME="Linux" \
			-DCMAKE_INSTALL_PREFIX="/usr" \
			-DCMAKE_C_COMPILER="$(TARGET)-gcc" \
			-DCMAKE_CXX_COMPILER="$(TARGET)-g++" \
			-DCMAKE_INCLUDE_PATH="$(TARGET_DIR)/usr/include" \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/uchardet.pc
	$(REMOVE)/uchardet-$(UCHARDET_VER)
	$(TOUCH)

#
# libcap
#
LIBCAP_VER = 2.25
LIBCAP_SOURCE = libcap-$(LIBCAP_VER).tar.gz
LIBCAP_PATCH  = libcap-$(LIBCAP_VER)-cross_compile.patch
LIBCAP_PATCH += libcap-$(LIBCAP_VER)-old_kernel.patch

$(ARCHIVE)/$(LIBCAP_SOURCE):
	$(WGET) https://git.kernel.org/pub/scm/libs/libcap/libcap.git/snapshot/$(LIBCAP_SOURCE)

$(D)/libcap: $(D)/bootstrap $(D)/libglib2 $(ARCHIVE)/$(LIBCAP_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libcap-$(LIBCAP_VER)
	$(UNTAR)/$(LIBCAP_SOURCE)
	$(CH_DIR)/libcap-$(LIBCAP_VER); \
		$(call apply_patches, $(LIBCAP_PATCH)); \
		sed -e 's,:=,?=,g' -i Make.Rules; \
		sed -e 's,^BUILD_CFLAGS ?= $(.*CFLAGS),BUILD_CFLAGS := $(BUILD_CFLAGS),' -i Make.Rules; \
		sed -e '/shell gperf/cifeq (,yes)' -i libcap/Makefile; \
		$(MAKE) CC=$(TARGET)-gcc INDENT= lib=/usr/lib RAISE_SETFCAP=no DYNAMIC=yes; \
		$(MAKE) RAISE_SETFCAP=no prefix=/usr lib=lib DESTDIR=$(TARGET_DIR) SBINDIR=/usr/sbin install
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libcap.pc
	$(REMOVE)/libcap-$(LIBCAP_VER)
	$(TOUCH)

#
# libevent
#
LIBEVENT_VER   = 2.2
LIBEVENT_URL   = https://github.com/libevent/libevent.git
LIBEVENT_PATCH = libevent-$(LIBEVENT_VER).patch

$(D)/libevent: $(D)/bootstrap $(D)/openssl
	$(START_BUILD)
	$(REMOVE)/libevent-$(LIBEVENT_VER)
	$(SET) -e; if [ -d $(ARCHIVE)/libevent.git ]; \
		then cd $(ARCHIVE)/libevent.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) $(LIBEVENT_URL) libevent.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/libevent.git $(BUILD_TMP)/libevent-$(LIBEVENT_VER)
	$(CH_DIR)/libevent-$(LIBEVENT_VER); \
		$(call apply_patches, $(LIBEVENT_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-silent-rules \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libevent.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libevent_openssl.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libevent_pthreads.pc
	$(REWRITE_LIBTOOL)/libevent_core.la
	$(REWRITE_LIBTOOL)/libevent_extra.la
	$(REWRITE_LIBTOOL)/libevent.la
	$(REWRITE_LIBTOOL)/libevent_openssl.la
	$(REWRITE_LIBTOOL)/libevent_pthreads.la
	$(REMOVE)/libevent-$(LIBEVENT_VER)
	$(TOUCH)

#
# libnl
#
LIBNL_VER = 3.2.25
LIBNL_SOURCE = libnl-$(LIBNL_VER).tar.gz

$(ARCHIVE)/$(LIBNL_SOURCE):
	$(WGET) https://www.infradead.org/~tgr/libnl/files/$(LIBNL_SOURCE)

$(D)/libnl: $(D)/bootstrap $(D)/openssl $(ARCHIVE)/$(LIBNL_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libnl-$(LIBNL_VER)
	$(UNTAR)/$(LIBNL_SOURCE)
	$(CH_DIR)/libnl-$(LIBNL_VER); \
		$(CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--prefix=/usr \
			--bindir=/.remove \
			--mandir=/.remove \
			--infodir=/.remove \
		make $(SILENT_OPT); \
		make install $(SILENT_OPT) DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libnl-3.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libnl-cli-3.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libnl-genl-3.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libnl-nf-3.0.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libnl-route-3.0.pc
	$(REWRITE_LIBTOOL)/libnl-3.la
	$(REWRITE_LIBTOOL)/libnl-cli-3.la
	$(REWRITE_LIBTOOL)/libnl-genl-3.la
	$(REWRITE_LIBTOOL)/libnl-idiag-3.la
	$(REWRITE_LIBTOOL)/libnl-nf-3.la
	$(REWRITE_LIBTOOL)/libnl-route-3.la
	$(REMOVE)/libnl-$(LIBNL_VER)
	$(TOUCH)

#
# mpg123
#
MPG123_VER = 1.28.2
MPG123_SOURCE = mpg123-$(MPG123_VER).tar.bz2

$(ARCHIVE)/$(MPG123_SOURCE):
	$(WGET) https://sourceforge.net/projects/mpg123/files/mpg123/$(MPG123_VER)/$(MPG123_SOURCE)

$(D)/mpg123: $(D)/bootstrap $(ARCHIVE)/$(MPG123_SOURCE)
	$(START_BUILD)
	$(REMOVE)/mpg123-$(MPG123_VER)
	$(UNTAR)/$(MPG123_SOURCE)
	$(CH_DIR)/mpg123-$(MPG123_VER); \
		$(CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--target=$(TARGET) \
			--prefix=/usr \
			--bindir=/.remove \
			--mandir=/.remove \
			--docdir=/.remove \
			--infodir=/.remove \
			--with-audio=alsa \
			--with-audio=oss \
			--with-default-audio=alsa \
			--with-default-audio=oss \
		make $(SILENT_OPT); \
		make install $(SILENT_OPT) DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libmpg123.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libout123.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/libsyn123.pc
	$(REWRITE_LIBTOOL)/libmpg123.la
	$(REWRITE_LIBTOOL)/libout123.la
	$(REWRITE_LIBTOOL)/libsyn123.la
	$(REMOVE)/mpg123-$(MPG123_VER)
	$(TOUCH)

#
# a52dec
#
A52DEC_VER = 0.7.4
A52DEC_SOURCE = a52dec-$(A52DEC_VER).tar.gz

$(ARCHIVE)/$(A52DEC_SOURCE):
	$(WGET) https://ftp.osuosl.org/pub/blfs/conglomeration/a52dec/$(A52DEC_SOURCE)

$(D)/a52dec: $(D)/bootstrap $(ARCHIVE)/$(A52DEC_SOURCE)
	$(START_BUILD)
	$(REMOVE)/a52dec-$(A52DEC_VER)
	$(UNTAR)/$(A52DEC_SOURCE)
	$(CH_DIR)/a52dec-$(A52DEC_VER); \
		$(CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--target=$(TARGET) \
			--disable-al-audio \
			--disable-solaris-audio \
			--disable-win \
			--prefix=/usr \
			--bindir=/.remove \
			--mandir=/.remove \
			--infodir=/.remove \
		make $(SILENT_OPT); \
		make install $(SILENT_OPT) DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/liba52.la
	$(REMOVE)/a52dec-$(A52DEC_VER)
	$(TOUCH)

#
# amrnb
#
AMRNB_VER = 11.0.0.0
AMRNB_SOURCE = amrnb-$(AMRNB_VER).tar.bz2

$(ARCHIVE)/$(AMRNB_SOURCE):
	$(WGET) http://www.penguin.cz/~utx/ftp/amr/$(AMRNB_SOURCE)

$(D)/amrnb: $(D)/bootstrap $(ARCHIVE)/$(AMRNB_SOURCE)
	$(START_BUILD)
	$(REMOVE)/amrnb-$(AMRNB_VER)
	$(UNTAR)/$(AMRNB_SOURCE)
	$(CH_DIR)/amrnb-$(AMRNB_VER); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--target=$(TARGET) \
			--prefix=/usr \
			--bindir=/.remove \
			--mandir=/.remove \
			--docdir=/.remove \
			--infodir=/.remove \
		make $(SILENT_OPT); \
		make install $(SILENT_OPT) DESTDIR=$(TARGET_DIR)
	$(REMOVE)/amrnb-$(AMRNB_VER)
	$(TOUCH)

#
# libwrap
#
LIBWRAP_VER = 7.6
LIBWRAP_SOURCE = tcp_wrappers_$(LIBWRAP_VER).tar.bz2

$(ARCHIVE)/$(LIBWRAP_SOURCE):
	$(WGET) https://ftp.osuosl.org/pub/blfs/conglomeration/tcp_wrappers/$(LIBWRAP_SOURCE)

$(D)/libwrap: $(D)/bootstrap $(ARCHIVE)/$(LIBWRAP_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libwrap-$(LIBWRAP_VER)
	$(UNTAR)/$(LIBWRAP_SOURCE)
	$(CH_DIR)/tcp_wrappers_$(LIBWRAP_VER); \
		make all; \
		make install $(SILENT_OPT) DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libwrap.la
	$(REMOVE)/libwrap-$(LIBWRAP_VER)
	$(TOUCH)

#
# libxmlccwrap
#
LIBXMLCCWRAP_VER = 0.0.12
LIBXMLCCWRAP_SOURCE = libxmlccwrap-$(LIBXMLCCWRAP_VER).tar.gz

$(ARCHIVE)/$(LIBXMLCCWRAP_SOURCE):
	$(WGET) http://www.ant.uni-bremen.de/whomes/rinas/libxmlccwrap/download/$(LIBXMLCCWRAP_SOURCE)

$(D)/libxmlccwrap: $(D)/bootstrap $(D)/libxml2 $(D)/libxslt $(ARCHIVE)/$(LIBXMLCCWRAP_SOURCE)
	$(START_BUILD)
	$(REMOVE)/libxmlccwrap-$(LIBXMLCCWRAP_VER)
	$(UNTAR)/$(LIBXMLCCWRAP_SOURCE)
	$(CH_DIR)/libxmlccwrap-$(LIBXMLCCWRAP_VER); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix=/usr \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libxmlccwrap.la
	$(REMOVE)/libxmlccwrap-$(LIBXMLCCWRAP_VER)
	$(TOUCH)

#

# libsigc++_e2
#
LIBSIGCPP_E2_MAJOR = 1
LIBSIGCPP_E2_MINOR = 2
LIBSIGCPP_E2_MICRO = 7
LIBSIGCPP_E2_VER=$(LIBSIGCPP_E2_MAJOR).$(LIBSIGCPP_E2_MINOR).$(LIBSIGCPP_E2_MICRO)

$(ARCHIVE)/libsigc++-$(LIBSIGCPP_E2_VER).tar.gz:
	$(WGET) https://ftp.gnome.org/pub/GNOME/sources/libsigc++/$(LIBSIGCPP_E2_MAJOR).$(LIBSIGCPP_E2_MINOR)/libsigc++-$(LIBSIGCPP_E2_VER).tar.gz

$(D)/libsigc_e2: $(D)/bootstrap $(ARCHIVE)/libsigc++-$(LIBSIGCPP_E2_VER).tar.gz
	$(START_BUILD)
	$(UNTAR)/libsigc++-$(LIBSIGCPP_E2_VER).tar.gz
	$(CH_DIR)/libsigc++-$(LIBSIGCPP_E2_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-checks \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/sigc++-1.2.pc
	$(REWRITE_LIBTOOL)/libsigc-1.2.la
	$(REMOVE)/libsigc++-$(LIBSIGCPP_E2_VER)
	$(TOUCH)
	
#
# harfbuzz
#
HARFBUZZ_VER = 1.8.8
HARFBUZZ_SOURCE = harfbuzz-$(HARFBUZZ_VER).tar.bz2

$(ARCHIVE)/$(HARFBUZZ_SOURCE):
	$(DOWNLOAD) https://www.freedesktop.org/software/harfbuzz/release/$(HARFBUZZ_SOURCE)

$(D)/harfbuzz: $(D)/bootstrap $(D)/freetype $(D)/libglib2 $(ARCHIVE)/$(HARFBUZZ_SOURCE)
	$(START_BUILD)
	$(REMOVE)/harfbuzz-$(HARFBUZZ_VER)
	$(UNTAR)/$(HARFBUZZ_SOURCE)
	$(CH_DIR)/harfbuzz-$(HARFBUZZ_VER); \
		$(CONFIGURE) \
			--prefix=/usr \
			--infodir=/.remove \
			--localedir=/.remove \
			--mandir=/.remove \
			--docdir=/.remove \
			--htmldir=/.remove \
			--dvidir=/.remove \
			--pdfdir=/.remove \
			--psdir=/.remove \
			--with-freetype \
			--with-glib \
			--without-cairo \
			--without-fontconfig \
			--without-graphite2 \
			--without-icu \
		; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
		if [ -d $(TARGET_INCLUDE_DIR)/harfbuzz ]; then \
			cp $(TARGET_INCLUDE_DIR)/harfbuzz/* $(TARGET_INCLUDE_DIR)/glib-2.0; \
		fi;
	$(REWRITE_LIBTOOL)/libharfbuzz.la
	$(REWRITE_LIBTOOL)/libharfbuzz-subset.la
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/harfbuzz.pc
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/harfbuzz-subset.pc
	$(REMOVE)/harfbuzz-$(HARFBUZZ_VER)
	$(TOUCH)


#
# dvb-apps
#
DVB_APPS_PATCH = dvb-apps.patch

$(D)/dvb-apps: $(D)/bootstrap $(ARCHIVE)/$(DVB_APPS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/dvb-apps
	set -e; if [ -d $(ARCHIVE)/dvb-apps.git ]; \
		then cd $(ARCHIVE)/dvb-apps.git; git pull; \
		else cd $(ARCHIVE); git clone https://github.com/openpli-arm/dvb-apps.git dvb-apps.git; \
		fi
	cp -ra $(ARCHIVE)/dvb-apps.git $(BUILD_TMP)/dvb-apps
	$(CH_DIR)/dvb-apps; \
		$(call apply_patches,$(DVB_APPS_PATCH)); \
		$(BUILDENV) \
		$(BUILDENV) $(MAKE) DESTDIR=$(TARGET_DIR); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/dvb-apps
	$(TOUCH)


#
# libgpg-error
#
LIBGPG_ERROR_VER    = 1.45
LIBGPG_ERROR_DIR    = libgpg-error-$(LIBGPG_ERROR_VER)
LIBGPG_ERROR_SOURCE = libgpg-error-$(LIBGPG_ERROR_VER).tar.bz2
LIBGPG_ERROR_URL    = https://www.gnupg.org/ftp/gcrypt/libgpg-error

$(ARCHIVE)/$(LIBGPG_ERROR_SOURCE):
	$(WGET) $(LIBGPG_ERROR_URL)/$(LIBGPG_ERROR_SOURCE)

$(D)/libgpg-error: $(D)/bootstrap $(ARCHIVE)/$(LIBGPG_ERROR_SOURCE)
	$(START_BUILD)
	$(REMOVE)/$(LIBGPG_ERROR_DIR)
	$(UNTAR)/$(LIBGPG_ERROR_SOURCE)
	$(CH_DIR)/$(LIBGPG_ERROR_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--infodir=/.remove \
			--datarootdir=/.remove \
			--disable-tests \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)/libgpg-error.la
	$(REMOVE)/$(LIBGPG_ERROR_DIR)
	$(TOUCH)

#
# libgcrypt
#
LIBGCRYPT_VER    = 1.8.10
LIBGCRYPT_DIR    = libgcrypt-$(LIBGCRYPT_VER)
LIBGCRYPT_SOURCE = libgcrypt-$(LIBGCRYPT_VER).tar.bz2
LIBGCRYPT_URL    = https://gnupg.org/ftp/gcrypt/libgcrypt

$(ARCHIVE)/$(LIBGCRYPT_SOURCE):
	$(WGET) $(LIBGCRYPT_URL)/$(LIBGCRYPT_SOURCE)

$(D)/libgcrypt: $(D)/bootstrap $(D)/libgpg-error $(ARCHIVE)/$(LIBGCRYPT_SOURCE)
	$(START_BUILD)
	$(REMOVE)/$(LIBGCRYPT_DIR)
	$(UNTAR)/$(LIBGCRYPT_SOURCE)
	$(CH_DIR)/$(LIBGCRYPT_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-tests \
			--with-gpg-error-prefix=$(TARGET_DIR)/usr \
			--mandir=/.remove \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/libgcrypt-config $(HOST_DIR)/bin
	$(REWRITE_LIBTOOL)/libgcrypt.la
	$(REMOVE)/$(LIBGCRYPT_DIR)
	$(TOUCH)




