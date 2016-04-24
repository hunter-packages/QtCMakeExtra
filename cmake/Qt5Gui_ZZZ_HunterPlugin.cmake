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
      "${_qt_install_prefix}/lib/libqtpcre.a"
      "${_qt_install_prefix}/lib/libqtpcre_debug.a"
  )

  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Gui
      "${_qt_install_prefix}/lib/libqtharfbuzzng.a"
      "${_qt_install_prefix}/lib/libqtharfbuzzng_debug.a"
  )
elseif(APPLE)
  # _adler32
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "z")

  # _glBindTexture
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "-framework OpenGL")

  # _hb_blob_create
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Gui
      "${_qt_install_prefix}/lib/libqtharfbuzzng.a"
      "${_qt_install_prefix}/lib/libqtharfbuzzng_debug.a"
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
      "${_qt_install_prefix}/lib/libQt5PlatformSupport.a"
      "${_qt_install_prefix}/lib/libQt5PlatformSupport_debug.a"
  )
elseif(UNIX)
  # Linux

  # defined: `glBindTexture'
  # Disable for build with xcb from Hunter
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "GL")

  # Disable for build with xcb from Hunter
  # _qt_cmake_extra_helpers_add_interface(Qt5::Gui "png")

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
