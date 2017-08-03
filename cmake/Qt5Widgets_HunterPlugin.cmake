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

find_package(Qt5Core REQUIRED)

if(Qt5Core_VERSION MATCHES "^5\\.5\\.")
  include("${CMAKE_CURRENT_LIST_DIR}/Qt5Widgets_HunterPlugin_5_5.cmake")
elseif(Qt5Core_VERSION MATCHES "^5\\.6\\.")
  include("${CMAKE_CURRENT_LIST_DIR}/Qt5Widgets_HunterPlugin_5_6.cmake")
elseif(Qt5Core_VERSION MATCHES "^5\\.9\\.")
  include("${CMAKE_CURRENT_LIST_DIR}/Qt5Widgets_HunterPlugin_5_9.cmake")
else()
  message(FATAL_ERROR "Unexpected Qt version")
endif()
