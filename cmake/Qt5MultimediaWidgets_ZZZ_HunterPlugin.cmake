# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

# *_ZZZ_* added so this file will be loaded the last

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

if(TARGET Qt5::AVFMediaPlayerServicePlugin)
  # cyclic dependencies, see Qt5Multimedia_ZZZ_HunterPlugin.cmake
  _qt_cmake_extra_helpers_add_interface(
      Qt5::AVFMediaPlayerServicePlugin Qt5::MultimediaWidgets
  )
endif()
