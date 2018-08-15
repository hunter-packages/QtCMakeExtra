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
    _qt_cmake_extra_helpers_add_interface(Qt5::Core "-Wl,-e,_qt_main_wrapper")

    find_package(mobilecoreservices REQUIRED)
    _qt_cmake_extra_helpers_add_interface(Qt5::Core mobilecoreservices::mobilecoreservices)
  endif()
elseif(APPLE)
  # _FSCopyAliasInfo
  _qt_cmake_extra_helpers_add_interface(Qt5::Core "-framework CoreServices")

  # _OBJC_CLASS_$_NSAutoreleasePool
  _qt_cmake_extra_helpers_add_interface(Qt5::Core "-framework Foundation")

  # _OBJC_CLASS_$_NSApplication
  find_package(appkit REQUIRED)
  _qt_cmake_extra_helpers_add_interface(Qt5::Core "appkit::appkit")

  # _pcre16_assign_jit_stack
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Core
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}_debug.a"
  )

  _qt_cmake_extra_helpers_add_interface(Qt5::Core "z") # TODO: link Hunter version
elseif(UNIX)
  # Linux

  # defined: `ucal_close_52`
  # Disable for build with xcb from Hunter
  # _qt_cmake_extra_helpers_add_interface(Qt5::Core "icui18n")

  # Disable for build with xcb from Hunter
  # _qt_cmake_extra_helpers_add_interface(Qt5::Core "icuuc")

  if(NOT Qt5Core_VERSION VERSION_LESS 5.9)
    find_package(Threads REQUIRED)
    _qt_cmake_extra_helpers_add_interface(Qt5::Core "Threads::Threads")
  endif()

  _qt_cmake_extra_helpers_add_interface(Qt5::Core "dl")

  # _pcre16_assign_jit_stack
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Core
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}_debug.a"
  )
elseif(MSVC)
  # defined: '_pcre16_compile2'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Core
      "${_qt_install_prefix}/lib/${_qt_pcre_name}.lib"
      "${_qt_install_prefix}/lib/${_qt_pcre_name}d.lib"
  )

  # defined: '_WSAAsyncSelect'
  _qt_cmake_extra_helpers_add_interface(Qt5::Core ws2_32)

  # defined: '_GetFileVersionInfoSizeW'
  _qt_cmake_extra_helpers_add_interface(Qt5::Core Version)

  # defined: 'NetShareEnum'
  _qt_cmake_extra_helpers_add_interface(Qt5::Core Netapi32)

  # defined: '__imp__GetUserProfileDirectoryW'
  _qt_cmake_extra_helpers_add_interface(Qt5::Core Userenv)

  # defined: '__imp__timeSetEvent'
  _qt_cmake_extra_helpers_add_interface(Qt5::Core Winmm)
elseif(MINGW)
  # defined: '_pcre16_compile2'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Core
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}d.a"
  )

  # defined: '_WSAAsyncSelect'
  _qt_cmake_extra_helpers_add_interface(Qt5::Core ws2_32)
endif()
