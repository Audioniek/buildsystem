#
# python helpers
#
PYTHON_DIR         = usr/lib/python$(PYTHON_VER_MAJOR)
PYTHON_INCLUDE_DIR = usr/include/python$(PYTHON_VER_MAJOR)

PYTHON_BUILD = \
	CC="$(TARGET)-gcc" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	LDSHARED="$(TARGET)-gcc -shared" \
	PYTHONPATH=$(TARGET_DIR)/$(PYTHON_DIR)/site-packages \
	CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
	$(HOST_DIR)/bin/python ./setup.py $(MINUS_Q) build --executable=/usr/bin/python

PYTHON_INSTALL = \
	CC="$(TARGET)-gcc" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	LDSHARED="$(TARGET)-gcc -shared" \
	PYTHONPATH=$(TARGET_DIR)/$(PYTHON_DIR)/site-packages \
	CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
	$(HOST_DIR)/bin/python ./setup.py $(MINUS_Q) install --root=$(TARGET_DIR) --prefix=/usr

#
# host_python
#
PYTHON_VER_MAJOR = 2.7
PYTHON_VER_MINOR = 18
PYTHON_VER = $(PYTHON_VER_MAJOR).$(PYTHON_VER_MINOR)
PYTHON_SOURCE = Python-$(PYTHON_VER).tar.xz
HOST_PYTHON_PATCH  = python-$(PYTHON_VER).patch
HOST_PYTHON_PATCH += python-$(PYTHON_VER)-support_64bit.patch

$(ARCHIVE)/$(PYTHON_SOURCE):
	$(WGET) https://www.python.org/ftp/python/$(PYTHON_VER)/$(PYTHON_SOURCE)

$(D)/host_python: $(ARCHIVE)/$(PYTHON_SOURCE)
	$(START_BUILD)
	$(SILENT)if [ ! -d $(BUILD_TMP) ]; then mkdir $(BUILD_TMP); fi;
	$(REMOVE)/Python-$(PYTHON_VER)
	$(UNTAR)/$(PYTHON_SOURCE)
	$(CH_DIR)/Python-$(PYTHON_VER); \
		$(call apply_patches, $(HOST_PYTHON_PATCH)); \
		autoconf; \
		CONFIG_SITE= \
		OPT="$(HOST_CFLAGS)" \
		./configure $(SILENT_CONFIGURE) \
			--without-cxx-main \
			--with-threads \
		; \
		$(MAKE) python Parser/pgen; \
		mv python ./hostpython; \
		mv Parser/pgen ./hostpgen; \
		\
		$(MAKE) distclean; \
		./configure $(SILENT_CONFIGURE) \
			--prefix=$(HOST_DIR) \
			--sysconfdir=$(HOST_DIR)/etc \
			--without-cxx-main \
			--with-threads \
		; \
		$(MAKE) all install; \
		cp ./hostpgen $(HOST_DIR)/bin/pgen
	$(REMOVE)/Python-$(PYTHON_VER)
	$(TOUCH)

#
# python
#
PYTHON_PATCH  = python-$(PYTHON_VER).patch
PYTHON_PATCH += python-$(PYTHON_VER)-xcompile.patch
PYTHON_PATCH += python-$(PYTHON_VER)-revert_use_of_sysconfigdata.patch
PYTHON_PATCH += python-$(PYTHON_VER)-pgettext.patch

$(D)/python: $(D)/bootstrap $(D)/host_python $(D)/ncurses $(D)/zlib $(D)/openssl $(D)/libffi $(D)/bzip2 $(D)/readline $(D)/sqlite $(ARCHIVE)/$(PYTHON_SOURCE)
	$(START_BUILD)
	$(REMOVE)/Python-$(PYTHON_VER)
	$(UNTAR)/$(PYTHON_SOURCE)
	$(CH_DIR)/Python-$(PYTHON_VER); \
		$(call apply_patches, $(PYTHON_PATCH)); \
		CONFIG_SITE= \
		$(BUILDENV) \
		autoreconf -vif Modules/_ctypes/libffi $(SILENT_OPT); \
		autoconf $(SILENT_OPT); \
		./configure $(SILENT_CONFIGURE) \
			--build=$(BUILD) \
			--host=$(TARGET) \
			--target=$(TARGET) \
			--prefix=/usr \
			--mandir=/.remove \
			--sysconfdir=/etc \
			--enable-shared \
			--with-lto \
			--enable-ipv6 \
			--with-threads \
			--with-pymalloc \
			--with-signal-module \
			--with-wctype-functions \
			ac_sys_system=Linux \
			ac_sys_release=2 \
			ac_cv_file__dev_ptmx=no \
			ac_cv_file__dev_ptc=no \
			ac_cv_have_long_long_format=yes \
			ac_cv_no_strict_aliasing_ok=yes \
			ac_cv_pthread=yes \
			ac_cv_cxx_thread=yes \
			ac_cv_sizeof_off_t=8 \
			ac_cv_have_chflags=no \
			ac_cv_have_lchflags=no \
			ac_cv_py_format_size_t=yes \
			ac_cv_broken_sem_getvalue=no \
			HOSTPYTHON=$(HOST_DIR)/bin/python$(PYTHON_VER_MAJOR) \
		; \
		$(MAKE) $(MAKE_OPTS) \
			PYTHON_MODULES_INCLUDE="$(TARGET_DIR)/usr/include" \
			PYTHON_MODULES_LIB="$(TARGET_DIR)/usr/lib" \
			PYTHON_XCOMPILE_DEPENDENCIES_PREFIX="$(TARGET_DIR)" \
			CROSS_COMPILE_TARGET=yes \
			CROSS_COMPILE=$(TARGET) \
			MACHDEP=linux2 \
			HOSTARCH=$(TARGET) \
			CFLAGS="$(TARGET_CFLAGS)" \
			LDFLAGS="$(TARGET_LDFLAGS)" \
			LD="$(TARGET)-gcc" \
			HOSTPYTHON=$(HOST_DIR)/bin/python$(PYTHON_VER_MAJOR) \
			HOSTPGEN=$(HOST_DIR)/bin/pgen \
			all DESTDIR=$(TARGET_DIR) \
		; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	ln -sf ../../libpython$(PYTHON_VER_MAJOR).so.1.0 $(TARGET_DIR)/$(PYTHON_DIR)/config/libpython$(PYTHON_VER_MAJOR).so; \
	ln -sf $(TARGET_DIR)/$(PYTHON_INCLUDE_DIR) $(TARGET_DIR)/usr/include/python
	$(REWRITE_PKGCONF) $(PKG_CONFIG_PATH)/python-$(PYTHON_VER_MAJOR).pc
	$(REMOVE)/Python-$(PYTHON_VER)
	$(TOUCH)

#
# python_setuptools
#
PYTHON_SETUPTOOLS_VER = 18.5
PYTHON_SETUPTOOLS_SOURCE = setuptools-$(PYTHON_SETUPTOOLS_VER).tar.gz

$(ARCHIVE)/$(PYTHON_SETUPTOOLS_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/s/setuptools/$(PYTHON_SETUPTOOLS_SOURCE)

$(D)/python_setuptools: $(D)/bootstrap $(D)/python $(ARCHIVE)/$(PYTHON_SETUPTOOLS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/setuptools-$(PYTHON_SETUPTOOLS_VER)
	$(UNTAR)/$(PYTHON_SETUPTOOLS_SOURCE)
	$(CH_DIR)/setuptools-$(PYTHON_SETUPTOOLS_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/setuptools-$(PYTHON_SETUPTOOLS_VER)
	$(TOUCH)

#
# python_lxml
#
PYTHON_LXML_MAJOR = 2.2
PYTHON_LXML_MINOR = 8
PYTHON_LXML_VER = $(PYTHON_LXML_MAJOR).$(PYTHON_LXML_MINOR)
PYTHON_LXML_SOURCE = lxml-$(PYTHON_LXML_VER).tar.gz

$(ARCHIVE)/$(PYTHON_LXML_SOURCE):
#	$(WGET) http://launchpad.net/lxml/$(PYTHON_LXML_MAJOR)/$(PYTHON_LXML_VER)/+download/$(PYTHON_LXML_SOURCE)
	$(WGET) https://files.pythonhosted.org/packages/48/71/397947beaadda1b2ad589a685160b8848888364af387b6c6707bb2769a23/$(PYTHON_LXML_SOURCE)

$(D)/python_lxml: $(D)/bootstrap $(D)/python $(D)/libxml2 $(D)/libxslt $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_LXML_SOURCE)
	$(START_BUILD)
	$(REMOVE)/lxml-$(PYTHON_LXML_VER)
	$(UNTAR)/$(PYTHON_LXML_SOURCE)
	$(CH_DIR)/lxml-$(PYTHON_LXML_VER); \
		$(PYTHON_BUILD) \
			--with-xml2-config=$(HOST_DIR)/bin/xml2-config \
			--with-xslt-config=$(HOST_DIR)/bin/xslt-config; \
		$(PYTHON_INSTALL)
	$(REMOVE)/lxml-$(PYTHON_LXML_VER)
	$(TOUCH)

#
# python_twisted
#
PYTHON_TWISTED_VER = 16.4.1
PYTHON_TWISTED_SOURCE = Twisted-$(PYTHON_TWISTED_VER).tar.bz2

$(ARCHIVE)/$(PYTHON_TWISTED_SOURCE):
#	$(WGET) https://pypi.python.org/packages/source/T/Twisted/$(PYTHON_TWISTED_SOURCE)
#	$(WGET) https://twistedmatrix.com/Releases/Twisted/16.4/$(PYTHON_TWISTED_SOURCE)
	$(WGET) https://files.pythonhosted.org/packages/6b/23/8dbe86fc83215015e221fbd861a545c6ec5c9e9cd7514af114d1f64084ab/$(PYTHON_TWISTED_SOURCE)

$(D)/python_twisted: $(D)/bootstrap $(D)/python $(D)/python_zope_interface $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_TWISTED_SOURCE)
	$(START_BUILD)
	$(REMOVE)/Twisted-$(PYTHON_TWISTED_VER)
	$(UNTAR)/$(PYTHON_TWISTED_SOURCE)
	$(CH_DIR)/Twisted-$(PYTHON_TWISTED_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/Twisted-$(PYTHON_TWISTED_VER)
	$(TOUCH)

#
# python_imaging
#
PYTHON_IMAGING_VER = 1.1.7
PYTHON_IMAGING_SOURCE = Imaging-$(PYTHON_IMAGING_VER).tar.gz
PYTHON_IMAGING_PATCH = python-imaging-$(PYTHON_IMAGING_VER).patch

$(ARCHIVE)/$(PYTHON_IMAGING_SOURCE):
	$(WGET) https://src.fedoraproject.org/repo/pkgs/python-imaging/$(PYTHON_IMAGING_SOURCE)/fc14a54e1ce02a0225be8854bfba478e/$(PYTHON_IMAGING_SOURCE)

$(D)/python_imaging: $(D)/bootstrap $(D)/libjpeg $(D)/freetype $(D)/zlib $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_IMAGING_SOURCE)
	$(START_BUILD)
	$(REMOVE)/Imaging-$(PYTHON_IMAGING_VER)
	$(UNTAR)/$(PYTHON_IMAGING_SOURCE)
	$(CH_DIR)/Imaging-$(PYTHON_IMAGING_VER); \
		$(call apply_patches, $(PYTHON_IMAGING_PATCH)); \
		sed -ie "s|"darwin"|"darwinNot"|g" "setup.py"; \
		sed -ie "s|ZLIB_ROOT = None|ZLIB_ROOT = libinclude(\"${TARGET_DIR}/usr\")|" "setup.py"; \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/Imaging-$(PYTHON_IMAGING_VER)
	$(TOUCH)

#
# python_pycrypto
#
PYTHON_PYCRYPTO_VER = 2.6.1
PYTHON_PYCRYPTO_SOURCE = pycrypto-$(PYTHON_PYCRYPTO_VER).tar.gz
PYTHON_PYCRYPTO_PATCH = python-pycrypto-$(PYTHON_PYCRYPTO_VER).patch

$(ARCHIVE)/$(PYTHON_PYCRYPTO_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/p/pycrypto/$(PYTHON_PYCRYPTO_SOURCE)

$(D)/python_pycrypto: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(D)/gmp $(ARCHIVE)/$(PYTHON_PYCRYPTO_SOURCE)
	$(START_BUILD)
	$(REMOVE)/pycrypto-$(PYTHON_PYCRYPTO_VER)
	$(UNTAR)/$(PYTHON_PYCRYPTO_SOURCE)
	$(CH_DIR)/pycrypto-$(PYTHON_PYCRYPTO_VER); \
		$(call apply_patches, $(PYTHON_PYCRYPTO_PATCH)); \
		export ac_cv_func_malloc_0_nonnull=yes; \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/pycrypto-$(PYTHON_PYCRYPTO_VER)
	$(TOUCH)

#
# python_pyusb
#
PYTHON_PYUSB_VER = 1.0.0a3
PYTHON_PYUSB_SOURCE = pyusb-$(PYTHON_PYUSB_VER).tar.gz

$(ARCHIVE)/$(PYTHON_PYUSB_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/p/pyusb/$(PYTHON_PYUSB_SOURCE)

$(D)/python_pyusb: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_PYUSB_SOURCE)
	$(START_BUILD)
	$(REMOVE)/pyusb-$(PYTHON_PYUSB_VER)
	$(UNTAR)/$(PYTHON_PYUSB_SOURCE)
	$(CH_DIR)/pyusb-$(PYTHON_PYUSB_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/pyusb-$(PYTHON_PYUSB_VER)
	$(TOUCH)

#
# python_ipaddress
#
PYTHON_IPADDRESS_VER = 1.0.18
PYTHON_IPADDRESS_SOURCE = ipaddress-$(PYTHON_IPADDRESS_VER).tar.gz

$(ARCHIVE)/$(PYTHON_IPADDRESS_SOURCE):
#	$(WGET) https://distfiles.macports.org/py-ipaddress/$(PYTHON_IPADDRESS_SOURCE)
	$(WGET) https://files.pythonhosted.org/packages/source/i/ipaddress/$(PYTHON_IPADDRESS_SOURCE)

$(D)/python_ipaddress: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_IPADDRESS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/ipaddress-$(PYTHON_IPADDRESS_VER)
	$(UNTAR)/$(PYTHON_IPADDRESS_SOURCE)
	$(CH_DIR)/ipaddress-$(PYTHON_IPADDRESS_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/ipaddress-$(PYTHON_IPADDRESS_VER)
	$(TOUCH)

#
# python_six
#
PYTHON_SIX_VER = 1.15.0
PYTHON_SIX_SOURCE = six-$(PYTHON_SIX_VER).tar.gz

$(ARCHIVE)/$(PYTHON_SIX_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/s/six/$(PYTHON_SIX_SOURCE)

$(D)/python_six: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_SIX_SOURCE)
	$(START_BUILD)
	$(REMOVE)/six-$(PYTHON_SIX_VER)
	$(UNTAR)/$(PYTHON_SIX_SOURCE)
	$(CH_DIR)/six-$(PYTHON_SIX_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/six-$(PYTHON_SIX_VER)
	$(TOUCH)

#
# python_cffi
#
PYTHON_CFFI_VER = 1.14.6
PYTHON_CFFI_SOURCE = cffi-$(PYTHON_CFFI_VER).tar.gz

$(ARCHIVE)/$(PYTHON_CFFI_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/c/cffi/$(PYTHON_CFFI_SOURCE)

$(D)/python_cffi: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(D)/libffi $(D)/python_pycparser $(ARCHIVE)/$(PYTHON_CFFI_SOURCE)
	$(START_BUILD)
	$(REMOVE)/cffi-$(PYTHON_CFFI_VER)
	$(UNTAR)/$(PYTHON_CFFI_SOURCE)
	$(CH_DIR)/cffi-$(PYTHON_CFFI_VER); \
		PYTHONPATH=$(TARGET_DIR)/$(PYTHON_DIR)/site-packages \
		CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
		$(HOST_DIR)/bin/python ./setup.py $(MINUS_Q) build_ext -f -i; \
		$(PYTHON_INSTALL)
		$(SILENT)cd $(BUILD_TMP)/cffi-$(PYTHON_CFFI_VER); \
		CC="$(TARGET)-gcc" \
		CFLAGS="$(TARGET_CFLAGS)" \
		LDFLAGS="$(TARGET_LDFLAGS)" \
		LDSHARED="$(TARGET)-gcc -shared" \
		PYTHONPATH=$(TARGET_DIR)/$(PYTHON_DIR)/site-packages \
		CPPFLAGS="$(TARGET_CPPFLAGS) -I$(TARGET_DIR)/$(PYTHON_INCLUDE_DIR)" \
		$(HOST_DIR)/bin/python ./setup.py $(MINUS_Q) build_ext -f -i; \
		cp ./_cffi_backend.so $(TARGET_DIR)/$(PYTHON_DIR)/site-packages/_cffi_backend.so.sh4
	$(REMOVE)/cffi-$(PYTHON_CFFI_VER)
	$(TOUCH)

#
# python_sqlite3
#
PYTHON_SQLITE3_VER = 1.0.5
PYTHON_SQLITE3_SOURCE = sqlite3-$(PYTHON_SQLITE3_VER).tar.gz

$(ARCHIVE)/$(PYTHON_SQLITE3_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/c/sqlite3/$(PYTHON_SQLITE3_SOURCE)

$(D)/python_sqlite3: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_SQLITE3_SOURCE)
	$(START_BUILD)
	$(REMOVE)/sqlite3-$(PYTHON_SQLITE3_VER)
	$(UNTAR)/$(PYTHON_SQLITE3_SOURCE)
	$(CH_DIR)/sqlite3-$(PYTHON_SQLITE3_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/sqlite3-$(PYTHON_SQLITE3_VER)
	$(TOUCH)

#
# python_enum34
#
PYTHON_ENUM34_VER = 1.0.4
PYTHON_ENUM34_SOURCE = enum34-$(PYTHON_ENUM34_VER).tar.gz

$(ARCHIVE)/$(PYTHON_ENUM34_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/e/enum34/$(PYTHON_ENUM34_SOURCE)

$(D)/python_enum34: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_ENUM34_SOURCE)
	$(START_BUILD)
	$(REMOVE)/enum34-$(PYTHON_ENUM34_VER)
	$(UNTAR)/$(PYTHON_ENUM34_SOURCE)
	$(CH_DIR)/enum34-$(PYTHON_ENUM34_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/enum34-$(PYTHON_ENUM34_VER)
	$(TOUCH)

#
# python_pyasn1_modules
#
PYTHON_PYASN1_MODULES_VER = 0.0.7
PYTHON_PYASN1_MODULES_SOURCE = pyasn1-modules-$(PYTHON_PYASN1_MODULES_VER).tar.gz

$(ARCHIVE)/$(PYTHON_PYASN1_MODULES_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/p/pyasn1-modules/$(PYTHON_PYASN1_MODULES_SOURCE)

$(D)/python_pyasn1_modules: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_PYASN1_MODULES_SOURCE)
	$(START_BUILD)
	$(REMOVE)/pyasn1-modules-$(PYTHON_PYASN1_MODULES_VER)
	$(UNTAR)/$(PYTHON_PYASN1_MODULES_SOURCE)
	$(CH_DIR)/pyasn1-modules-$(PYTHON_PYASN1_MODULES_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/pyasn1-modules-$(PYTHON_PYASN1_MODULES_VER)
	$(TOUCH)

#
# python_pyasn1
#
PYTHON_PYASN1_VER = 0.1.8
PYTHON_PYASN1_SOURCE = pyasn1-$(PYTHON_PYASN1_VER).tar.gz

$(ARCHIVE)/$(PYTHON_PYASN1_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/p/pyasn1/$(PYTHON_PYASN1_SOURCE)

$(D)/python_pyasn1: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(D)/python_pyasn1_modules $(ARCHIVE)/$(PYTHON_PYASN1_SOURCE)
	$(START_BUILD)
	$(REMOVE)/pyasn1-$(PYTHON_PYASN1_VER)
	$(UNTAR)/$(PYTHON_PYASN1_SOURCE)
	$(CH_DIR)/pyasn1-$(PYTHON_PYASN1_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/pyasn1-$(PYTHON_PYASN1_VER)
	$(TOUCH)

#
# python_pycparser
#
PYTHON_PYCPARSER_VER = 2.14
PYTHON_PYCPARSER_SOURCE = pycparser-$(PYTHON_PYCPARSER_VER).tar.gz

$(ARCHIVE)/$(PYTHON_PYCPARSER_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/p/pycparser/$(PYTHON_PYCPARSER_SOURCE)

$(D)/python_pycparser: $(D)/bootstrap $(D)/python $(ARCHIVE)/$(PYTHON_PYCPARSER_SOURCE)
	$(START_BUILD)
	$(REMOVE)/pycparser-$(PYTHON_PYCPARSER_VER)
	$(UNTAR)/$(PYTHON_PYCPARSER_SOURCE)
	$(CH_DIR)/pycparser-$(PYTHON_PYCPARSER_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/pycparser-$(PYTHON_PYCPARSER_VER)
	$(TOUCH)

#
# python_cryptography
#
PYTHON_CRYPTOGRAPHY_VER = 2.9.1
PYTHON_CRYPTOGRAPHY_SOURCE = cryptography-$(PYTHON_CRYPTOGRAPHY_VER).tar.gz

$(ARCHIVE)/$(PYTHON_CRYPTOGRAPHY_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/c/cryptography/$(PYTHON_CRYPTOGRAPHY_SOURCE)

$(D)/python_cryptography: $(D)/bootstrap $(D)/python_cffi $(D)/python_pyasn1 $(D)/python_enum34 $(D)/python $(D)/python_setuptools $(D)/python_six $(ARCHIVE)/$(PYTHON_CRYPTOGRAPHY_SOURCE)
	$(START_BUILD)
	$(REMOVE)/cryptography-$(PYTHON_CRYPTOGRAPHY_VER)
	$(UNTAR)/$(PYTHON_CRYPTOGRAPHY_SOURCE)
	$(CH_DIR)/cryptography-$(PYTHON_CRYPTOGRAPHY_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/cryptography-$(PYTHON_CRYPTOGRAPHY_VER)
	$(TOUCH)

#
# python_pyopenssl
#
PYTHON_PYOPENSSL_VER = 20.0.1
PYTHON_PYOPENSSL_SOURCE = pyOpenSSL-$(PYTHON_PYOPENSSL_VER).tar.gz
PYTHON_PYOPENSSL_PATCH =

$(ARCHIVE)/$(PYTHON_PYOPENSSL_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/p/pyOpenSSL/$(PYTHON_PYOPENSSL_SOURCE)

$(D)/python_pyopenssl: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(D)/openssl $(D)/python_cryptography $(ARCHIVE)/$(PYTHON_PYOPENSSL_SOURCE)
	$(START_BUILD)
	$(REMOVE)/pyOpenSSL-$(PYTHON_PYOPENSSL_VER)
	$(UNTAR)/$(PYTHON_PYOPENSSL_SOURCE)
	$(CH_DIR)/pyOpenSSL-$(PYTHON_PYOPENSSL_VER); \
		$(call apply_patches, $(PYTHON_PYOPENSSL_PATCH)); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/pyOpenSSL-$(PYTHON_PYOPENSSL_VER)
	$(TOUCH)

#
# python_service_identity
#
PYTHON_SERVICE_IDENTITY_VER = 16.0.0
PYTHON_SERVICE_IDENTITY_SOURCE = service_identity-$(PYTHON_SERVICE_IDENTITY_VER).tar.gz
PYTHON_SERVICE_IDENTITY_PATCH =

$(ARCHIVE)/$(PYTHON_SERVICE_IDENTITY_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/s/service_identity/$(PYTHON_SERVICE_IDENTITY_SOURCE)

$(D)/python_service_identity: $(D)/bootstrap $(D)/python_pyasn1 $(D)/python_attr $(D)/python_attrs $(D)/python_ipaddress $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_SERVICE_IDENTITY_SOURCE)
	$(START_BUILD)
	$(REMOVE)/service_identity-$(PYTHON_SERVICE_IDENTITY_VER)
	$(UNTAR)/$(PYTHON_SERVICE_IDENTITY_SOURCE)
	$(CH_DIR)/service_identity-$(PYTHON_SERVICE_IDENTITY_VER); \
		$(call apply_patches, $(PYTHON_SERVICE_IDENTITY_PATCH)); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/service_identity-$(PYTHON_SERVICE_IDENTITY_VER)
	$(TOUCH)

#
# python_attr
#
PYTHON_ATTR_VER = 0.3.1
PYTHON_ATTR_SOURCE = attr-$(PYTHON_ATTR_VER).tar.gz
PYTHON_ATTR_PATCH =

$(ARCHIVE)/$(PYTHON_ATTR_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/a/attr/$(PYTHON_ATTR_SOURCE)

$(D)/python_attr: $(D)/bootstrap $(D)/python $(ARCHIVE)/$(PYTHON_ATTR_SOURCE)
	$(START_BUILD)
	$(REMOVE)/attr-$(PYTHON_ATTR_VER)
	$(UNTAR)/$(PYTHON_ATTR_SOURCE)
	$(CH_DIR)/attr-$(PYTHON_ATTR_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/attr-$(PYTHON_ATTR_VER)
	$(TOUCH)

#
# python_attrs
#
PYTHON_ATTRS_VER = 19.1.0
PYTHON_ATTRS_SOURCE = attrs-$(PYTHON_ATTRS_VER).tar.gz
PYTHON_ATTRS_PATCH =

$(ARCHIVE)/$(PYTHON_ATTRS_SOURCE):
	$(WGET) https://pypi.io/packages/source/a/attrs/$(PYTHON_ATTRS_SOURCE)

$(D)/python_attrs: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_ATTRS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/attrs-$(PYTHON_ATTRS_VER)
	$(UNTAR)/$(PYTHON_ATTRS_SOURCE)
	$(CH_DIR)/attrs-$(PYTHON_ATTRS_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/attrs-$(PYTHON_ATTRS_VER)
	$(TOUCH)

#
# python_elementtree
#
PYTHON_ELEMENTTREE_VER = 1.2.6-20050316
PYTHON_ELEMENTTREE_SOURCE = elementtree-$(PYTHON_ELEMENTTREE_VER).tar.gz

$(ARCHIVE)/$(PYTHON_ELEMENTTREE_SOURCE):
#	$(WGET) http://effbot.org/media/downloads/$(PYTHON_ELEMENTTREE_SOURCE)
	$(WGET) https://sourceforge.net/projects/rlsuite/files/rlsuite/support-files/$(PYTHON_ELEMENTTREE_SOURCE)

$(D)/python_elementtree: $(D)/bootstrap $(D)/python $(ARCHIVE)/$(PYTHON_ELEMENTTREE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/elementtree-$(PYTHON_ELEMENTTREE_VER)
	$(UNTAR)/$(PYTHON_ELEMENTTREE_SOURCE)
	$(CH_DIR)/elementtree-$(PYTHON_ELEMENTTREE_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/elementtree-$(PYTHON_ELEMENTTREE_VER)
	$(TOUCH)

#
# python_wifi
#
PYTHON_WIFI_VER = 0.5.0
PYTHON_WIFI_SOURCE = pythonwifi-$(PYTHON_WIFI_VER).tar.bz2

$(ARCHIVE)/$(PYTHON_WIFI_SOURCE):
	$(WGET) https://git.tuxfamily.org/pythonwifi/pythonwifi.git/snapshot/$(PYTHON_WIFI_SOURCE)

$(D)/python_wifi: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_WIFI_SOURCE)
	$(START_BUILD)
	$(REMOVE)/pythonwifi-$(PYTHON_WIFI_VER)
	$(UNTAR)/$(PYTHON_WIFI_SOURCE)
	$(CH_DIR)/pythonwifi-$(PYTHON_WIFI_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL) --install-data=/.remove
	$(REMOVE)/pythonwifi-$(PYTHON_WIFI_VER)
	$(TOUCH)

#
# python_cheetah
#
PYTHON_CHEETAH_VER = 2.4.4
PYTHON_CHEETAH_SOURCE = Cheetah-$(PYTHON_CHEETAH_VER).tar.gz

$(ARCHIVE)/$(PYTHON_CHEETAH_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/C/Cheetah/$(PYTHON_CHEETAH_SOURCE)

$(D)/python_cheetah: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_CHEETAH_SOURCE)
	$(START_BUILD)
	$(REMOVE)/Cheetah-$(PYTHON_CHEETAH_VER)
	$(UNTAR)/$(PYTHON_CHEETAH_SOURCE)
	$(CH_DIR)/Cheetah-$(PYTHON_CHEETAH_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/Cheetah-$(PYTHON_CHEETAH_VER)
	$(TOUCH)

#
# python_mechanize
#
PYTHON_MECHANIZE_VER = 0.4.2
PYTHON_MECHANIZE_SOURCE = mechanize-$(PYTHON_MECHANIZE_VER).tar.gz

$(ARCHIVE)/$(PYTHON_MECHANIZE_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/m/mechanize/$(PYTHON_MECHANIZE_SOURCE)

$(D)/python_mechanize: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_MECHANIZE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/mechanize-$(PYTHON_MECHANIZE_VER)
	$(UNTAR)/$(PYTHON_MECHANIZE_SOURCE)
	$(CH_DIR)/mechanize-$(PYTHON_MECHANIZE_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/mechanize-$(PYTHON_MECHANIZE_VER)
	$(TOUCH)

#
# python_chardet
#
PYTHON_CHARDET_VER = 4.0.0
PYTHON_CHARDET_SOURCE = chardet-$(PYTHON_CHARDET_VER).tar.gz

$(ARCHIVE)/$(PYTHON_CHARDET_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/c/chardet/$(PYTHON_CHARDET_SOURCE)

$(D)/python_chardet: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_CHARDET_SOURCE)
	$(START_BUILD)
	$(REMOVE)/chardet-$(PYTHON_CHARDET_VER)
	$(UNTAR)/$(PYTHON_CHARDET_SOURCE)
	$(CH_DIR)/chardet-$(PYTHON_CHARDET_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/chardet-$(PYTHON_CHARDET_VER)
	$(TOUCH)

#
# python_urllib3
#
PYTHON_URLLIB3_VER = 1.24.3
PYTHON_URLLIB3_SOURCE = urllib3-$(PYTHON_URLLIB3_VER).tar.gz

$(ARCHIVE)/$(PYTHON_URLLIB3_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/u/urllib3/$(PYTHON_URLLIB3_SOURCE)

$(D)/python_urllib3: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_URLLIB3_SOURCE)
	$(START_BUILD)
	$(REMOVE)/urllib3-$(PYTHON_URLLIB3_VER)
	$(UNTAR)/$(PYTHON_URLLIB3_SOURCE)
	$(CH_DIR)/urllib3-$(PYTHON_URLLIB3_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/urllib3-$(PYTHON_URLLIB3_VER)
	$(TOUCH)

#
# python_certifi
#
PYTHON_CERTIFI_VER =2021.5.30
PYTHON_CERTIFI_SOURCE = certifi-$(PYTHON_CERTIFI_VER).tar.gz

$(ARCHIVE)/$(PYTHON_CERTIFI_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/c/certifi/$(PYTHON_CERTIFI_SOURCE)

$(D)/python_certifi: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_CERTIFI_SOURCE)
	$(START_BUILD)
	$(REMOVE)/certifi-$(PYTHON_CERTIFI_VER)
	$(UNTAR)/$(PYTHON_CERTIFI_SOURCE)
	$(CH_DIR)/certifi-$(PYTHON_CERTIFI_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/certifi-$(PYTHON_CERTIFI_VER)
	$(TOUCH)




#
# python_execnet
#
PYTHON_EXECNET_VER =1.2.0
PYTHON_EXECNET_SOURCE = execnet-$(PYTHON_EXECNET_VER).tar.gz

$(ARCHIVE)/$(PYTHON_EXECNET_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/e/execnet/$(PYTHON_EXECNET_SOURCE)

$(D)/python_execnet: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_EXECNET_SOURCE)
	$(START_BUILD)
	$(REMOVE)/execnet-$(PYTHON_EXECNET_VER)
	$(UNTAR)/$(PYTHON_EXECNET_SOURCE)
	$(CH_DIR)/execnet-$(PYTHON_EXECNET_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/execnet-$(PYTHON_EXECNET_VER)
	$(TOUCH)

#
# python-idna
#
PYTHON_IDNA_VER =2.10
PYTHON_IDNA_SOURCE = idna-$(PYTHON_IDNA_VER).tar.gz

$(ARCHIVE)/$(PYTHON_IDNA_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/i/idna/$(PYTHON_IDNA_SOURCE)

$(D)/python_idna: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_IDNA_SOURCE)
	$(START_BUILD)
	$(REMOVE)/idna-$(PYTHON_IDNA_VER)
	$(UNTAR)/$(PYTHON_IDNA_SOURCE)
	$(CH_DIR)/idna-$(PYTHON_IDNA_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/idna-$(PYTHON_IDNA_VER)
	$(TOUCH)



#
# python_gdata
#
PYTHON_GDATA_VER = 2.0.18
PYTHON_GDATA_SOURCE = gdata-$(PYTHON_GDATA_VER).tar.gz

$(ARCHIVE)/$(PYTHON_GDATA_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/g/gdata/$(PYTHON_GDATA_SOURCE)

$(D)/python_gdata: $(D)/bootstrap $(D)/python $(ARCHIVE)/$(PYTHON_GDATA_SOURCE)
	$(START_BUILD)
	$(REMOVE)/gdata-$(PYTHON_GDATA_VER)
	$(UNTAR)/$(PYTHON_GDATA_SOURCE)
	$(CH_DIR)/gdata-$(PYTHON_GDATA_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/gdata-$(PYTHON_GDATA_VER)
	$(TOUCH)

#
# python_zope_interface
#
PYTHON_ZOPE_INTERFACE_VER = 4.6.0
PYTHON_ZOPE_INTERFACE_SOURCE = zope.interface-$(PYTHON_ZOPE_INTERFACE_VER).tar.gz

$(ARCHIVE)/$(PYTHON_ZOPE_INTERFACE_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/z/zope.interface/$(PYTHON_ZOPE_INTERFACE_SOURCE)

$(D)/python_zope_interface: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_ZOPE_INTERFACE_SOURCE)
	$(START_BUILD)
	$(REMOVE)/zope.interface-$(PYTHON_ZOPE_INTERFACE_VER)
	$(UNTAR)/$(PYTHON_ZOPE_INTERFACE_SOURCE)
	$(CH_DIR)/zope.interface-$(PYTHON_ZOPE_INTERFACE_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/zope.interface-$(PYTHON_ZOPE_INTERFACE_VER)
	$(TOUCH)

#
# python_requests
#
PYTHON_REQUESTS_VER = 2.22.0
PYTHON_REQUESTS_SOURCE = requests-$(PYTHON_REQUESTS_VER).tar.gz

$(ARCHIVE)/$(PYTHON_REQUESTS_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/r/requests/$(PYTHON_REQUESTS_SOURCE)

$(D)/python_requests: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_REQUESTS_SOURCE)
	$(START_BUILD)
	$(REMOVE)/requests-$(PYTHON_REQUESTS_VER)
	$(UNTAR)/$(PYTHON_REQUESTS_SOURCE)
	$(CH_DIR)/requests-$(PYTHON_REQUESTS_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/requests-$(PYTHON_REQUESTS_VER)
	$(TOUCH)

#
# python_futures
#
PYTHON_FUTURES_VER = 3.2.0
PYTHON_FUTURES_SOURCE = futures-$(PYTHON_FUTURES_VER).tar.gz

$(ARCHIVE)/$(PYTHON_FUTURES_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/f/futures/$(PYTHON_FUTURES_SOURCE)

$(D)/python_futures: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_FUTURES_SOURCE)
	$(START_BUILD)
	$(REMOVE)/futures-$(PYTHON_FUTURES_VER)
	$(UNTAR)/$(PYTHON_FUTURES_SOURCE)
	$(CH_DIR)/futures-$(PYTHON_FUTURES_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/futures-$(PYTHON_FUTURES_VER)
	$(TOUCH)

#
# python_singledispatch
#
PYTHON_SINGLEDISPATCH_VER = 3.4.0.3
PYTHON_SINGLEDISPATCH_SOURCE = singledispatch-$(PYTHON_SINGLEDISPATCH_VER).tar.gz

$(ARCHIVE)/$(PYTHON_SINGLEDISPATCH_SOURCE):
	$(WGET) https://pypi.python.org/packages/source/s/singledispatch/$(PYTHON_SINGLEDISPATCH_SOURCE)

$(D)/python_singledispatch: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_SINGLEDISPATCH_SOURCE)
	$(START_BUILD)
	$(REMOVE)/singledispatch-$(PYTHON_SINGLEDISPATCH_VER)
	$(UNTAR)/$(PYTHON_SINGLEDISPATCH_SOURCE)
	$(CH_DIR)/singledispatch-$(PYTHON_SINGLEDISPATCH_VER); \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/singledispatch-$(PYTHON_SINGLEDISPATCH_VER)
	$(TOUCH)

#
# python_livestreamer
#
$(D)/python_livestreamer: $(D)/bootstrap $(D)/python $(D)/python_setuptools
	$(START_BUILD)
	$(REMOVE)/livestreamer
	$(SET) -e; if [ -d $(ARCHIVE)/livestreamer.git ]; \
		then cd $(ARCHIVE)/livestreamer.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) https://github.com/chrippa/livestreamer.git livestreamer.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/livestreamer.git $(BUILD_TMP)/livestreamer
	$(CH_DIR)/livestreamer; \
		touch AUTHORS; \
		$(PYTHON_BUILD); \
		$(PYTHON_INSTALL)
	$(REMOVE)/livestreamer
	$(TOUCH)

#
# python_livestreamersrv
#
$(D)/python_livestreamersrv: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(D)/python_livestreamer
	$(START_BUILD)
	$(REMOVE)/livestreamersrv
	$(SET) -e; if [ -d $(ARCHIVE)/livestreamersrv.git ]; \
		then cd $(ARCHIVE)/livestreamersrv.git; git pull $(MINUS_Q); \
		else cd $(ARCHIVE); git clone $(MINUS_Q) https://github.com/athoik/livestreamersrv.git livestreamersrv.git; \
		fi
	$(SILENT)cp -ra $(ARCHIVE)/livestreamersrv.git $(BUILD_TMP)/livestreamersrv
	$(CH_DIR)/livestreamersrv; \
		cp -rd livestreamersrv $(TARGET_DIR)/usr/sbin; \
		cp -rd offline.mp4 $(TARGET_DIR)/usr/share
	$(REMOVE)/livestreamersrv
	$(TOUCH)

#
# python_netifaces
#
PYTHON_NETIFACES_VER = w38-0.10.9
PYTHON_NETIFACES_SOURCE = netifaces-$(PYTHON_NETIFACES_VER).tar.gz

$(ARCHIVE)/$(PYTHON_NETIFACES_SOURCE):
#	$(WGET) http://qpypi.qpython.org/repository/15020/$(PYTHON_NETIFACES_SOURCE)
	$(WGET) https://files.pythonhosted.org/packages/04/06/2b337652548387021f33c936dc5bd3008e7527affee2bed7b36bbc6d2211/$(PYTHON_NETIFACES_SOURCE)

$(D)/python_netifaces: $(D)/bootstrap $(D)/python $(D)/python_setuptools $(ARCHIVE)/$(PYTHON_NETIFACES_SOURCE)
	$(START_BUILD)
	$(REMOVE)/netifaces-$(PYTHON_NETIFACES_VER)
	$(UNTAR)/$(PYTHON_NETIFACES_SOURCE)
	$(CH_DIR)/netifaces-$(PYTHON_NETIFACES_VER); \
		$(PYTHON_INSTALL)
	$(REMOVE)/netifaces-$(PYTHON_NETIFACES_VER)
	$(TOUCH)

# -----------------------------------------------------------------------------

PYTHON_DEPS  = $(D)/host_python
PYTHON_DEPS += $(D)/python
PYTHON_DEPS += $(D)/python_setuptools
PYTHON_DEPS += $(D)/libxmlccwrap
PYTHON_DEPS += $(D)/python_elementtree
PYTHON_DEPS += $(D)/python_lxml
PYTHON_DEPS += $(D)/python_zope_interface
PYTHON_DEPS += $(D)/python_netifaces
PYTHON_DEPS += $(D)/python_pyopenssl
PYTHON_DEPS += $(D)/python_twisted
PYTHON_DEPS += $(D)/python_wifi
PYTHON_DEPS += $(D)/python_imaging
PYTHON_DEPS += $(D)/python_pyusb
PYTHON_DEPS += $(D)/python_pycrypto
PYTHON_DEPS += $(D)/python_pyasn1
PYTHON_DEPS += $(D)/python_mechanize
PYTHON_DEPS += $(D)/python_six
PYTHON_DEPS += $(D)/python_cffi
#PYTHON_DEPS += $(D)/python_sqlite3
PYTHON_DEPS += $(D)/python_enum34
PYTHON_DEPS += $(D)/python_pyasn1_modules
PYTHON_DEPS += $(D)/python_pycparser
#PYTHON_DEPS += $(D)/python_cryptography
PYTHON_DEPS += $(D)/python_service_identity
PYTHON_DEPS += $(D)/python_attrs
PYTHON_DEPS += $(D)/python_cheetah
PYTHON_DEPS += $(D)/python_gdata
PYTHON_DEPS += $(D)/python_requests
PYTHON_DEPS += $(D)/python_futures
PYTHON_DEPS += $(D)/python_singledispatch
PYTHON_DEPS += $(D)/python_ipaddress
PYTHON_DEPS += $(D)/python_livestreamer
PYTHON_DEPS += $(D)/python_livestreamersrv
PYTHON_DEPS += $(D)/python_urllib3
PYTHON_DEPS += $(D)/python_chardet
PYTHON_DEPS += $(D)/python_certifi
#PYTHON_DEPS += $(D)/python_cffi
PYTHON_DEPS += $(D)/python_execnet
PYTHON_DEPS += $(D)/python_idna

python-all: $(PYTHON_DEPS)

PHONY += python-all
