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
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework Foundation")
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework UIKit")
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework CoreFoundation")
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework Security")
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework SystemConfiguration")
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework CoreFoundation")
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "m")
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "z")

  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Network
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}_debug.a"
  )
elseif(APPLE)
  # _SCDynamicStoreCopyProxies
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework SystemConfiguration")

  # _SecKeychainFindInternetPassword
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework Security")

  # _CFArrayAppendValue
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework CoreFoundation")

  # _CFNetworkCopyProxiesForAutoConfigurationScript
  _qt_cmake_extra_helpers_add_interface(Qt5::Network "-framework CFNetwork")
endif()
