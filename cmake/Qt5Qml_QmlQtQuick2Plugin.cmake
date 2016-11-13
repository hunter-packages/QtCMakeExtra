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

if(TARGET Qt5::QmlQtQuick2Plugin)
  return()
endif()

string(COMPARE EQUAL "${CMAKE_SYSTEM_NAME}" "Linux" _is_linux)

if(APPLE OR IOS OR _is_linux)
  add_library(Qt5::QmlQtQuick2Plugin MODULE IMPORTED)

  set(_release_lib "${_qt_install_prefix}/qml/QtQuick.2/libqtquick2plugin.a")
  set(_debug_lib "${_qt_install_prefix}/qml/QtQuick.2/libqtquick2plugin_debug.a")

  if(EXISTS "${_release_lib}")
    set_property(
        TARGET
        Qt5::QmlQtQuick2Plugin
        APPEND
        PROPERTY
        IMPORTED_CONFIGURATIONS RELEASE
    )
    set_target_properties(
        Qt5::QmlQtQuick2Plugin
        PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
        IMPORTED_LOCATION_RELEASE "${_release_lib}"
    )
  endif()

  if(EXISTS "${_debug_lib}")
    set_property(
        TARGET
        Qt5::QmlQtQuick2Plugin
        APPEND
        PROPERTY
        IMPORTED_CONFIGURATIONS DEBUG
    )
    set_target_properties(
        Qt5::QmlQtQuick2Plugin
        PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
        IMPORTED_LOCATION_DEBUG "${_debug_lib}"
    )
  endif()
endif()

_qt_cmake_extra_helpers_add_source(
    Qt5::QmlQtQuick2Plugin
    "static_qt_QtQuick2Plugin.cpp"
)
