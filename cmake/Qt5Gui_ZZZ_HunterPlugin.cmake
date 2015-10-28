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
  #
elseif(APPLE)
  #
elseif(UNIX)
  # Linux

  # defined: `glBindTexture'
  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "GL")

  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "png")

  _qt_cmake_extra_helpers_add_interface(Qt5::Gui "jpeg")
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
