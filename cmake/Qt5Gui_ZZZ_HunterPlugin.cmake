# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

get_filename_component(
    _qt_install_prefix "${CMAKE_CURRENT_LIST_DIR}/../../.." ABSOLUTE
)

# Define:
# * _qt_is_static (variable)
# * _qt_cmake_extra_helpers_add_interface (function)
# * _qt_cmake_extra_helpers_add_interface_release_debug (function)
# * _qt_cmake_extra_helpers_add_source (function)
include("${_qt_install_prefix}/cmake/QtCMakeExtraHelpers.cmake")

if(NOT _qt_is_static)
  return()
endif()

if(IOS)
  if(NOT Qt5Core_VERSION VERSION_LESS 5.9)
    # ??? -framework CoreText
    # ??? -lQt5Core
    # ??? -lm
    # ??? -lqtfreetype
    # ??? -lqtharfbuzz

    # _OBJC_METACLASS_$_UIAccessibilityElement
    find_package(uikit REQUIRED)
    _qt_cmake_extra_helpers_add_interface(Qt5::QIOSIntegrationPlugin uikit::uikit)

    find_package(foundation REQUIRED)
    _qt_cmake_extra_helpers_add_interface(Qt5::QIOSIntegrationPlugin foundation::foundation)

    find_package(quartzcore REQUIRED)
    _qt_cmake_extra_helpers_add_interface(Qt5::QIOSIntegrationPlugin quartzcore::quartzcore)

    find_package(assetslibrary REQUIRED)
    _qt_cmake_extra_helpers_add_interface(Qt5::QIOSIntegrationPlugin assetslibrary::assetslibrary)

    find_package(corefoundation REQUIRED)
    _qt_cmake_extra_helpers_add_interface(Qt5::QIOSIntegrationPlugin corefoundation::corefoundation)

    find_package(opengles REQUIRED)
    _qt_cmake_extra_helpers_add_interface(Qt5::QIOSIntegrationPlugin opengles::opengles)

    find_package(coregraphics REQUIRED)
    _qt_cmake_extra_helpers_add_interface(Qt5::QIOSIntegrationPlugin coregraphics::coregraphics)

    find_package(audiotoolbox REQUIRED)
    _qt_cmake_extra_helpers_add_interface(Qt5::QIOSIntegrationPlugin audiotoolbox::audiotoolbox)

    # QAccessibleActionInterface::scrollRightAction
    _qt_cmake_extra_helpers_add_interface(Qt5::QIOSIntegrationPlugin Qt5::Gui)

    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QIOSIntegrationPlugin
        "${_qt_install_prefix}/lib/libQt5FontDatabaseSupport.a"
        "${_qt_install_prefix}/lib/libQt5FontDatabaseSupport_debug.a"
    )

    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QIOSIntegrationPlugin
        "${_qt_install_prefix}/lib/libQt5GraphicsSupport.a"
        "${_qt_install_prefix}/lib/libQt5GraphicsSupport_debug.a"
    )

    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QIOSIntegrationPlugin
        "${_qt_install_prefix}/lib/libQt5ClipboardSupport.a"
        "${_qt_install_prefix}/lib/libQt5ClipboardSupport_debug.a"
    )

    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QIOSIntegrationPlugin
        "${_qt_install_prefix}/lib/libqtlibpng.a"
        "${_qt_install_prefix}/lib/libqtlibpng_debug.a"
    )

    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QIOSIntegrationPlugin
        "${_qt_install_prefix}/lib/lib${_qt_pcre_name}.a"
        "${_qt_install_prefix}/lib/lib${_qt_pcre_name}_debug.a"
    )
  endif()

  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework Foundation")
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework UIKit")
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework CoreFoundation")
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework CoreText")
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework CoreGraphics")
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework OpenGLES")

  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "m")
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "z")

  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Gui
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}_debug.a"
  )

  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Gui
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}_debug.a"
  )

  if(NOT Qt5Core_VERSION VERSION_LESS 5.9)
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::Gui
        "${_qt_install_prefix}/lib/libqtlibpng.a"
        "${_qt_install_prefix}/lib/libqtlibpng_debug.a"
    )
  endif()
elseif(APPLE)
  # _adler32
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "z")

  # _glBindTexture
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework OpenGL")

  # _hb_blob_create
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Gui
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}_debug.a"
  )

  # _CGFontCopyTableForTag
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework CoreGraphics")

  # _CTFontCopyGraphicsFont
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework CoreText")

  _qt_cmake_extra_helpers_add_source(
      Qt5::Gui
      "static_qt_plugins.cpp"
  )

  _qt_cmake_extra_helpers_add_interface(Qt5::Gui Qt5::QCocoaIntegrationPlugin)

  # _CGImageDestinationAddImage
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework ImageIO")

  # _DisableSecureEventInput
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework Carbon")

  # _IODisplayCreateInfoDictionary
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework IOKit")

  # _NSAccessibilityApplicationRole
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework AppKit")

  # qcgl_getProcAddress
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Gui
      "${_qt_install_prefix}/lib/lib${_qt_platform_support_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_platform_support_name}_debug.a"
  )

  if(NOT Qt5Core_VERSION VERSION_LESS 5.9)
    # _png_create_info_struct
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::Gui
        "${_qt_install_prefix}/lib/libqtlibpng.a"
        "${_qt_install_prefix}/lib/libqtlibpng_debug.a"
    )

    # qt_mac_addToGlobalMimeList(QMacInternalPasteboardMime*)
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QCocoaIntegrationPlugin
        "${_qt_install_prefix}/lib/libQt5ClipboardSupport.a"
        "${_qt_install_prefix}/lib/libQt5ClipboardSupport_debug.a"
    )

    # qcgl_createNSOpenGLPixelFormat
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QCocoaIntegrationPlugin
        "${_qt_install_prefix}/lib/libQt5CglSupport.a"
        "${_qt_install_prefix}/lib/libQt5CglSupport_debug.a"
    )

    # QCoreTextFontEngine::antialiasingThreshold
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QCocoaIntegrationPlugin
        "${_qt_install_prefix}/lib/libQt5FontDatabaseSupport.a"
        "${_qt_install_prefix}/lib/libQt5FontDatabaseSupport_debug.a"
    )

    # QRasterBackingStore::beginPaint
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QCocoaIntegrationPlugin
        "${_qt_install_prefix}/lib/libQt5GraphicsSupport.a"
        "${_qt_install_prefix}/lib/libQt5GraphicsSupport_debug.a"
    )

    # QAccessibleBridgeUtils::effectiveActionNames
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QCocoaIntegrationPlugin
        "${_qt_install_prefix}/lib/libQt5AccessibilitySupport.a"
        "${_qt_install_prefix}/lib/libQt5AccessibilitySupport_debug.a"
    )

    # QAbstractFileIconEngine::actualSize
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QCocoaIntegrationPlugin
        "${_qt_install_prefix}/lib/libQt5ThemeSupport.a"
        "${_qt_install_prefix}/lib/libQt5ThemeSupport_debug.a"
    )
  endif()
elseif(UNIX)
  # Linux

  # defined: `glBindTexture'
  # Disable for build with xcb from Hunter
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "GL")

  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Gui
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}_debug.a"
  )

  if(NOT Qt5Core_VERSION VERSION_LESS 5.9)
    # defined: `png_set_option'
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::Gui
        "${_qt_install_prefix}/lib/libqtlibpng.a"
        "${_qt_install_prefix}/lib/libqtlibpng_debug.a"
    )
  endif()

  # Disable for build with xcb from Hunter
  # _qt_cmake_extra_helpers_add_interface(Qt5::Gui "jpeg")
elseif(MSVC)
  #
elseif(MINGW)
  #
endif()

if(TARGET Qt5::QXcbEglIntegrationPlugin)
  # QXcbEglIntegrationPlugin is not always installed (?),
  # for simplicity check existence of target

  _qt_cmake_extra_helpers_add_interface(Qt5::QXcbEglIntegrationPlugin "EGL")
endif()

_qt_cmake_extra_helpers_add_source(
    Qt5::QXcbEglIntegrationPlugin
    "static_qt_QXcbEglIntegrationPlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::QDDSPlugin
    "static_qt_QDDSPlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::QICNSPlugin
    "static_qt_QICNSPlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::QICOPlugin
    "static_qt_QICOPlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::QJp2Plugin
    "static_qt_QJp2Plugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::QMngPlugin
    "static_qt_QMngPlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::QTgaPlugin
    "static_qt_QTgaPlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::QTiffPlugin
    "static_qt_QTiffPlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::QWbmpPlugin
    "static_qt_QWbmpPlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::QWebpPlugin
    "static_qt_QWebpPlugin.cpp"
)
