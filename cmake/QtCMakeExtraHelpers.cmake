# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

string(COMPARE EQUAL "${_qt_install_prefix}" "" _is_empty)
if(_is_empty)
  message(FATAL_ERROR "Variable not set: _qt_install_prefix")
endif()

if(NOT EXISTS "${_qt_install_prefix}")
  message(
      FATAL_ERROR
      "Directory not exists: ${_qt_install_prefix}"
      " (variable _qt_install_prefix)"
  )
endif()

if(NOT IS_DIRECTORY "${_qt_install_prefix}")
  message(
      FATAL_ERROR
      "Is not directory: ${_qt_install_prefix}"
      " (variable _qt_install_prefix)"
  )
endif()

find_package(Qt5Core CONFIG REQUIRED)
get_target_property(_qt_type Qt5::Core TYPE)
string(COMPARE EQUAL "${_qt_type}" "STATIC_LIBRARY" _qt_is_static)

if(Qt5Core_VERSION VERSION_LESS 5.9)
  set(_qt_pcre_name "qtpcre")
  set(_qt_harfbuzz_name "qtharfbuzzng")
else()
  set(_qt_pcre_name "qtpcre2")
  set(_qt_harfbuzz_name "qtharfbuzz")
endif()

# Add library, framework or link flags
function(_qt_cmake_extra_helpers_add_interface target lib)
  if(NOT TARGET "${target}")
    message(FATAL_ERROR "Target not exists: ${target}")
  endif()

  get_target_property(linked_libs ${target} INTERFACE_LINK_LIBRARIES)
  if(NOT linked_libs)
    set(linked_libs "")
  endif()

  set_target_properties(
      ${target}
      PROPERTIES
      INTERFACE_LINK_LIBRARIES "${lib};${linked_libs}"
  )
endfunction()

function(_qt_cmake_extra_helpers_add_interface_release_debug target release debug)
  if(NOT TARGET "${target}")
    message(FATAL_ERROR "Target not exists: ${target}")
  endif()

  get_target_property(linked_libs ${target} INTERFACE_LINK_LIBRARIES)
  if(NOT linked_libs)
    set(linked_libs "")
  endif()

  if(EXISTS "${release}" AND EXISTS "${debug}")
    set(debug_gen_expr "$<$<CONFIG:Debug>:${debug}>")
    set(nondebug_gen_expr "$<$<NOT:$<CONFIG:Debug>>:${release}>")
    set(gen_expr "${debug_gen_expr};${nondebug_gen_expr}")

    set_target_properties(
        ${target}
        PROPERTIES
        INTERFACE_LINK_LIBRARIES "${gen_expr};${linked_libs}"
    )
  elseif(EXISTS "${release}")
    set_target_properties(
        ${target}
        PROPERTIES
        INTERFACE_LINK_LIBRARIES "${release};${linked_libs}"
    )
  elseif(EXISTS "${debug}")
    set_target_properties(
        ${target}
        PROPERTIES
        INTERFACE_LINK_LIBRARIES "${debug};${linked_libs}"
    )
  else()
    message(FATAL_ERROR "At least one file must exist: ${release} ${debug}")
  endif()
endfunction()

function(_qt_cmake_extra_helpers_add_source target source)
  if(NOT TARGET "${target}")
    # *Plugin target is not always installed,
    # for simplicity check existence 
    return()
  endif()

  string(COMPARE EQUAL "${source}" "" is_empty)
  if(is_empty)
    message(FATAL_ERROR "source is empty")
  endif()
  set(source_path "${_qt_install_prefix}/src/qt/plugins/${source}")
  if(NOT EXISTS "${source_path}")
    message(FATAL_ERROR "File not found: ${source_path}")
  endif()

  if(CMAKE_VERSION VERSION_LESS 3.1)
    message(
        WARNING
        "Can't use INTERFACE_SOURCES properties. "
        "Please update CMake to version 3.1+ or add source manually: "
        "\${QT_ROOT}/src/qt/plugins/${source}"
    )
  else()
    get_target_property(interface_sources ${target} INTERFACE_SOURCES)
    if(NOT interface_sources)
      set(interface_sources "")
    endif()
    list(APPEND interface_sources "${source_path}")

    set_target_properties(
        ${target}
        PROPERTIES
        INTERFACE_SOURCES "${interface_sources}"
    )
  endif()
endfunction()
