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

if(TARGET Qt5::AVFServicePlugin)
  # AVFServicePlugin is not always installed,
  # for simplicity check existence of target

  # Fix linking errors
  if(IOS)
    # _CVPixelBufferGetBaseAddress
    _qt_cmake_extra_helpers_add_interface(Qt5::AVFServicePlugin "-framework CoreVideo")

    # _AVCaptureExposureDurationCurrent
    _qt_cmake_extra_helpers_add_interface(Qt5::AVFServicePlugin "-framework AVFoundation")

    # _CMFormatDescriptionGetMediaSubType
    _qt_cmake_extra_helpers_add_interface(Qt5::AVFServicePlugin "-framework CoreMedia")
  elseif(APPLE)
    _qt_cmake_extra_helpers_add_interface(Qt5::AVFServicePlugin "-framework AVFoundation")
    _qt_cmake_extra_helpers_add_interface(Qt5::AVFServicePlugin "-framework CoreMedia")
  endif()
endif()

if(TARGET Qt5::CoreAudioPlugin)
  # CoreAudioPlugin is not always installed (???)
  # for simplicity check existence of target

  if(IOS)
    # TODO
  elseif(APPLE)
    _qt_cmake_extra_helpers_add_interface(Qt5::CoreAudioPlugin "-framework AudioUnit")
    _qt_cmake_extra_helpers_add_interface(Qt5::CoreAudioPlugin "-framework AudioToolbox")
    _qt_cmake_extra_helpers_add_interface(Qt5::CoreAudioPlugin "-framework CoreAudio")
  endif()
endif()

if(TARGET Qt5::AVFMediaPlayerServicePlugin)
  # AVFMediaPlayerServicePlugin is not always installed,
  # for simplicity check existence of target

  if(IOS)
    # We can't add find_package(Qt5MultimediaWidgets) here because of cyclic
    # dependency. User should do it himself :(
    _qt_cmake_extra_helpers_add_interface(
        Qt5::AVFMediaPlayerServicePlugin Qt5::MultimediaWidgets
    )
  elseif(APPLE)
    _qt_cmake_extra_helpers_add_interface(
        Qt5::AVFMediaPlayerServicePlugin
        "-framework QuartzCore"
    )
  endif()
endif()

if(TARGET Qt5::CoreAudioPlugin)
  if(IOS)
    # _AudioSessionGetProperty
    _qt_cmake_extra_helpers_add_interface(
        Qt5::CoreAudioPlugin "-framework AudioToolbox"
    )
  endif()
endif()

if(TARGET Qt5::DSServicePlugin)
  if(WIN32)
    # _MFCreateMediaType
    _qt_cmake_extra_helpers_add_interface(Qt5::DSServicePlugin Mfplat)

    # _IID_IMFGetService
    _qt_cmake_extra_helpers_add_interface(Qt5::DSServicePlugin Mfuuid)

    # _MFGetService
    _qt_cmake_extra_helpers_add_interface(Qt5::DSServicePlugin Mf)

    # _MFCreateVideoSampleFromSurface
    _qt_cmake_extra_helpers_add_interface(Qt5::DSServicePlugin Evr)

    # _DXVA2CreateDirect3DDeviceManager9
    _qt_cmake_extra_helpers_add_interface(Qt5::DSServicePlugin Dxva2)
  endif()
endif()

_qt_cmake_extra_helpers_add_source(
    Qt5::AVFServicePlugin
    "static_qt_AVFServicePlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::DSServicePlugin
    "static_qt_DSServicePlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::AudioCaptureServicePlugin
    "static_qt_AudioCaptureServicePlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::AVFMediaPlayerServicePlugin
    "static_qt_AVFMediaPlayerServicePlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::CoreAudioPlugin
    "static_qt_CoreAudioPlugin.cpp"
)

_qt_cmake_extra_helpers_add_source(
    Qt5::QM3uPlaylistPlugin
    "static_qt_QM3uPlaylistPlugin.cpp"
)
