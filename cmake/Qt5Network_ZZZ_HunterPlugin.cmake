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

if(NOT TARGET Qt5::Network)
  message(FATAL_ERROR "No target Qt5::Network")
endif()

# Fix linking errors
if(IOS)
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework Security")
elseif(APPLE)
  # _SCDynamicStoreCopyProxies
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework SystemConfiguration")

  # _SecKeychainFindInternetPassword
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework Security")
endif()
