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

if(NOT TARGET Qt5::Qml)
  message(FATAL_ERROR "Expected target Qt5::Qml")
endif()

if(TARGET Qt5::QTcpServerConnection)
  # No Qt5::QTcpServerConnection target in Qt 5.6

  if(IOS OR APPLE OR UNIX OR MINGW)
    _qt_cmake_extra_helpers_add_interface(Qt5::Qml Qt5::QTcpServerConnection)
  endif()
endif()

if(Qt5Core_VERSION VERSION_LESS 5.9)
  include(
      "${CMAKE_CURRENT_LIST_DIR}/Qt5Qml_QLocalClientConnectionFactory.cmake"
      OPTIONAL
  )
  include(
      "${CMAKE_CURRENT_LIST_DIR}/Qt5Qml_QQmlDebugServerFactory.cmake"
      OPTIONAL
  )
  include(
      "${CMAKE_CURRENT_LIST_DIR}/Qt5Qml_QQmlDebuggerServiceFactory.cmake"
      OPTIONAL
  )
  include(
      "${CMAKE_CURRENT_LIST_DIR}/Qt5Qml_QQmlInspectorServiceFactory.cmake"
      OPTIONAL
  )
  include(
      "${CMAKE_CURRENT_LIST_DIR}/Qt5Qml_QQmlProfilerServiceFactory.cmake"
      OPTIONAL
  )
  include(
      "${CMAKE_CURRENT_LIST_DIR}/Qt5Qml_QTcpServerConnectionFactory.cmake"
      OPTIONAL
  )
endif()
