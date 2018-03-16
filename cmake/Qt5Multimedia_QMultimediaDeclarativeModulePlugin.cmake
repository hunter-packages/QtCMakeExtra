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

if(TARGET Qt5::QMultimediaDeclarativeModule)
  return()
endif()

string(COMPARE EQUAL "${CMAKE_SYSTEM_NAME}" "Linux" _is_linux)

if(IOS OR APPLE OR _is_linux)
  add_library(Qt5::QMultimediaDeclarativeModule MODULE IMPORTED)

  set(_release_lib "${_qt_install_prefix}/qml/QtMultimedia/libdeclarative_multimedia.a")
  set(_debug_lib "${_qt_install_prefix}/qml/QtMultimedia/libdeclarative_multimedia_debug.a")

  if(EXISTS "${_release_lib}")
    set_property(
        TARGET
        Qt5::QMultimediaDeclarativeModule
        APPEND
        PROPERTY
        IMPORTED_CONFIGURATIONS RELEASE
    )
    set_target_properties(
        Qt5::QMultimediaDeclarativeModule
        PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
        IMPORTED_LOCATION_RELEASE "${_release_lib}"
    )
  endif()

  if(EXISTS "${_debug_lib}")
    set_property(
        TARGET
        Qt5::QMultimediaDeclarativeModule
        APPEND
        PROPERTY
        IMPORTED_CONFIGURATIONS DEBUG
    )
    set_target_properties(
        Qt5::QMultimediaDeclarativeModule
        PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
        IMPORTED_LOCATION_DEBUG "${_debug_lib}"
    )
  endif()

  if(Qt5Core_VERSION VERSION_LESS 5.10)
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QMultimediaDeclarativeModule
        "${_qt_install_prefix}/lib/libQt5MultimediaQuick_p.a"
        "${_qt_install_prefix}/lib/libQt5MultimediaQuick_p_debug.a"
    )
  else()
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QMultimediaDeclarativeModule
        "${_qt_install_prefix}/lib/libQt5MultimediaQuick.a"
        "${_qt_install_prefix}/lib/libQt5MultimediaQuick_debug.a"
    )
  endif()
elseif(MSVC)
  add_library(Qt5::QMultimediaDeclarativeModule MODULE IMPORTED)

  set(_release_lib "${_qt_install_prefix}/qml/QtMultimedia/declarative_multimedia.lib")
  set(_debug_lib "${_qt_install_prefix}/qml/QtMultimedia/declarative_multimediad.lib")

  if(EXISTS "${_release_lib}")
    set_property(
        TARGET
        Qt5::QMultimediaDeclarativeModule
        APPEND
        PROPERTY
        IMPORTED_CONFIGURATIONS RELEASE
    )
    set_target_properties(
        Qt5::QMultimediaDeclarativeModule
        PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
        IMPORTED_LOCATION_RELEASE "${_release_lib}"
    )
  endif()

  if(EXISTS "${_debug_lib}")
    set_property(
        TARGET
        Qt5::QMultimediaDeclarativeModule
        APPEND
        PROPERTY
        IMPORTED_CONFIGURATIONS DEBUG
    )
    set_target_properties(
        Qt5::QMultimediaDeclarativeModule
        PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
        IMPORTED_LOCATION_DEBUG "${_debug_lib}"
    )
  endif()

  if(Qt5Core_VERSION VERSION_LESS 5.10)
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QMultimediaDeclarativeModule
        "${_qt_install_prefix}/lib/Qt5MultimediaQuick_p.lib"
        "${_qt_install_prefix}/lib/Qt5MultimediaQuick_pd.lib"
    )
  else()
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::QMultimediaDeclarativeModule
        "${_qt_install_prefix}/lib/Qt5MultimediaQuick.lib"
        "${_qt_install_prefix}/lib/Qt5MultimediaQuickd.lib"
    )
  endif()
endif()

_qt_cmake_extra_helpers_add_source(
    Qt5::QMultimediaDeclarativeModule
    "static_qt_QMultimediaDeclarativeModule.cpp"
)
