# Copyright (c) 2015-2018, Ruslan Baratov
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

if(NOT TARGET Qt5::Widgets)
  message(FATAL_ERROR "Expected target Qt5::Widgets")
endif()

if(IOS)
  # Frameworks
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework UIKit")
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework AssetsLibrary")
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework OpenGLES")
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework Foundation")
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework QuartzCore")
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework CoreFoundation")
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework CoreText")
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework CoreGraphics")

  # 3rdParty
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "z") # TODO: link Hunter version

  # Qt non-imported
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}_debug.a"
  )

  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}_debug.a"
  )

  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/lib${_qt_platform_support_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_platform_support_name}_debug.a"
  )

  set(
      _libqios_release
      "${_qt_install_prefix}/plugins/platforms/libqios.a"
  )
  set(
      _libqios_debug
      "${_qt_install_prefix}/plugins/platforms/libqios_debug.a"
  )

  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::QIOSIntegrationPlugin)

  # Linker flags
  if(EXISTS "${_libqios_release}" AND EXISTS "${_libqios_debug}")
    _qt_cmake_extra_helpers_add_interface(
        Qt5::Widgets
        "-force_load ${_qt_install_prefix}/plugins/platforms/libqios$<$<CONFIG:Debug>:_debug>.a"
    )
  elseif(EXISTS "${_libqios_release}")
    _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-force_load ${_libqios_release}")
  elseif(EXISTS "${_libqios_debug}")
    _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-force_load ${_libqios_debug}")
  else()
    message(FATAL_ERROR "At least one file must exist: ${_libqios_release} ${_libqios_debug}")
  endif()
elseif(APPLE)
  _qt_cmake_extra_helpers_add_source(
      Qt5::Widgets
      "static_qt_plugins.cpp"
  )

  # Lead to configuration errors (cyclic dependencies)
  # find_package(Qt5PrintSupport REQUIRED)
  # _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::PrintSupport)

  # Frameworks
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework Carbon")
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework Cocoa")
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework IOKit")
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "-framework OpenGL")

  # Qt
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::QCocoaIntegrationPlugin)

  # Qt non-imported
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}_debug.a"
  )

  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}_debug.a"
  )

  # defined: '_FT_Done_Face'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/libqtfreetype.a"
      "${_qt_install_prefix}/lib/libqtfreetype_debug.a"
  )

  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/lib${_qt_platform_support_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_platform_support_name}_debug.a"
  )

  # 3rdParty
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "z") # TODO: link Hunter version
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "cups") # TODO: Hunterize and link
elseif(ANDROID)
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "GLESv2")
elseif(UNIX)
  # Linux

  _qt_cmake_extra_helpers_add_source(
      Qt5::Widgets
      "static_qt_plugins.cpp"
  )

  find_package(Qt5DBus REQUIRED)

  # Order is important. Clean-up first.
  set_target_properties(Qt5::Widgets PROPERTIES INTERFACE_LINK_LIBRARIES "")

  # 3rd party

  # defined: 'IceProcessMessages'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "ICE")

  # defined: `SmcCloseConnection'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "SM")

  find_package(x11 CONFIG REQUIRED)
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "PkgConfig::x11")

  find_package(x11-xcb CONFIG REQUIRED)
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "PkgConfig::x11-xcb")

  # defined: pthread_once
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "pthread")

  find_package(xcb CONFIG REQUIRED)
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "PkgConfig::xcb")

  # defined: `crc32'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets "z")

  # defined `hb_ot_tags_from_script'
  # should be set before Qt5::Gui
  _qt_cmake_extra_helpers_add_interface(
      Qt5::Widgets "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}.a"
  )

  # should be set before Qt5::Gui
  _qt_cmake_extra_helpers_add_interface(
      Qt5::Widgets "${_qt_install_prefix}/lib/lib${_qt_pcre_name}.a"
  )

  # libs should be set before lib${_qt_platform_support_name}
  # defined: QPlatformMenuItem::activated()
  # (depends on z, lib${_qt_harfbuzz_name}, GL)
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::Gui)

  # before lib${_qt_platform_support_name}.a
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::DBus)

  _qt_cmake_extra_helpers_add_interface(
      Qt5::Widgets "${_qt_install_prefix}/lib/libxcb-static.a"
  )
  _qt_cmake_extra_helpers_add_interface(
      Qt5::Widgets "${_qt_install_prefix}/lib/libqtfreetype.a"
  )

  # undefined: QPlatformMenuItem::activated() (depends on Qt5::Gui)
  _qt_cmake_extra_helpers_add_interface(
      Qt5::Widgets "${_qt_install_prefix}/lib/lib${_qt_platform_support_name}.a"
  )

  # undefined reference to `createUnixEventDispatcher()'
  # (before libQt5XcbQpa.a)
  _qt_cmake_extra_helpers_add_interface(
      Qt5::Widgets "${_qt_install_prefix}/lib/libQt5EventDispatcherSupport.a"
  )

  # undefined reference to `QGenericUnixTheme::themeNames()'
  # (before libQt5XcbQpa.a)
  _qt_cmake_extra_helpers_add_interface(
      Qt5::Widgets "${_qt_install_prefix}/lib/libQt5ThemeSupport.a"
  )

  # undefined reference to `vtable for QGenericUnixServices'
  # (before libQt5XcbQpa.a)
  _qt_cmake_extra_helpers_add_interface(
      Qt5::Widgets "${_qt_install_prefix}/lib/libQt5ServiceSupport.a"
  )

  # undefined reference to `vtable for QFreeTypeFontDatabase'
  # (before libQt5XcbQpa.a)
  _qt_cmake_extra_helpers_add_interface(
      Qt5::Widgets "${_qt_install_prefix}/lib/libQt5FontDatabaseSupport.a"
  )

  # undefined reference to `SmcCloseConnection' (depends on SM, ICE)
  _qt_cmake_extra_helpers_add_interface(
      Qt5::Widgets "${_qt_install_prefix}/lib/libQt5XcbQpa.a"
  )

  # should be set after libQt5XcbQpa
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::QXcbIntegrationPlugin)
elseif(MSVC)
  _qt_cmake_extra_helpers_add_source(
      Qt5::Widgets
      "static_qt_plugins.cpp"
  )

  if(TARGET Qt5::Gui_GLESv2 AND TARGET Qt5::Gui_EGL)
    # Qt with ANGLE (default)

    # defined: '_glBindBuffer'
    _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::Gui_GLESv2)

    # defined: 'CreateTLSIndex'
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::Widgets
        "${_qt_install_prefix}/lib/translator.lib"
        "${_qt_install_prefix}/lib/translatord.lib"
    )

    # defined: '_eglChooseConfig'
    _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::Gui_EGL)

    # defined: 'pp::Preprocessor::Preprocessor'
    _qt_cmake_extra_helpers_add_interface_release_debug(
        Qt5::Widgets
        "${_qt_install_prefix}/lib/preprocessor.lib"
        "${_qt_install_prefix}/lib/preprocessord.lib"
    )
  endif()

  # defined: '_hb_buffer_create'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/${_qt_harfbuzz_name}.lib"
      "${_qt_install_prefix}/lib/${_qt_harfbuzz_name}d.lib"
  )

  # defined: '_pcre16_compile2'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/${_qt_pcre_name}.lib"
      "${_qt_install_prefix}/lib/${_qt_pcre_name}d.lib"
  )

  # defined: '_WSAAsyncSelect'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets ws2_32)

  # for static plugin
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::QWindowsIntegrationPlugin)

  # defined: 'QBasicFontDatabase::populateFontDatabase'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/${_qt_platform_support_name}.lib"
      "${_qt_install_prefix}/lib/${_qt_platform_support_name}d.lib"
  )

  # defined: '_ImmGetDefaultIMEWnd'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets imm32)

  # defined: '__imp__PlaySoundW'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets winmm)

  # defined: '_Direct3DCreate9'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets d3d9)

  # defined: '_IID_IDirect3D9'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets dxguid)

  # defined: '_FT_New_Face'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/qtfreetype.lib"
      "${_qt_install_prefix}/lib/qtfreetyped.lib"
  )

  # defined: ' __imp__OpenThemeData'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets UxTheme)

  # defined: 'QWindowsFontDatabase::QWindowsFontDatabase(void)'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/Qt5FontDatabaseSupport.lib"
      "${_qt_install_prefix}/lib/Qt5FontDatabaseSupportd.lib"
  )

  # defined: QWindowsGuiEventDispatcher::QWindowsGuiEventDispatcher(class QObject *)
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/Qt5EventDispatcherSupport.lib"
      "${_qt_install_prefix}/lib/Qt5EventDispatcherSupportd.lib"
  )

  # defined: __imp__DwmEnableBlurBehindWindow
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Dwmapi)

  # defined: QAbstractFileIconEngine::pixmap
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/Qt5ThemeSupport.lib"
      "${_qt_install_prefix}/lib/Qt5ThemeSupportd.lib"
  )

  # defined: QAccessibleBridgeUtils::effectiveActionNames
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/Qt5AccessibilitySupport.lib"
      "${_qt_install_prefix}/lib/Qt5AccessibilitySupportd.lib"
  )

  # defined: _png_set_sig_bytes
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/qtlibpng.lib"
      "${_qt_install_prefix}/lib/qtlibpngd.lib"
  )

  # defined: QWindowsUiaWrapper::instance
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/Qt5WindowsUIAutomationSupport.lib"
      "${_qt_install_prefix}/lib/Qt5WindowsUIAutomationSupportd.lib"
  )
elseif(MINGW)
  _qt_cmake_extra_helpers_add_source(
      Qt5::Widgets
      "static_qt_plugins.cpp"
  )

  # Order is important. Clean-up first.
  set_target_properties(Qt5::Widgets PROPERTIES INTERFACE_LINK_LIBRARIES "")

  # defined: 'FT_New_Memory_Face'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/libqtfreetype.a"
      "${_qt_install_prefix}/lib/libqtfreetyped.a"
  )

  # defined: 'ImmGetVirtualKey'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets imm32)

  # defined: '_imp__PlaySoundW'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets winmm)

  # defined: vtable for QPlatformNativeInterface
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/lib${_qt_platform_support_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_platform_support_name}d.a"
  )

  # defined: '_imp__WSAAsyncSelect'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets ws2_32)

  # defined: 'pcre16_exec'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_pcre_name}d.a"
  )

  # defined: 'uncompress'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets z) # TODO: link Hunter version

  # defined: '_imp__glDepthRange'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets opengl32)

  # defined: 'QObject::objectName'

  # defined: '_hb_buffer_create'
  _qt_cmake_extra_helpers_add_interface_release_debug(
      Qt5::Widgets
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}.a"
      "${_qt_install_prefix}/lib/lib${_qt_harfbuzz_name}d.a"
  )

  # defined: 'QPalette::~QPalette'
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::Gui)

  # for static plugin
  _qt_cmake_extra_helpers_add_interface(Qt5::Widgets Qt5::QWindowsIntegrationPlugin)
endif()
