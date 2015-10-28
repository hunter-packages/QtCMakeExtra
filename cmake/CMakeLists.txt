hunter_add_package(Qt)
find_package(Qt5Core REQUIRED)

if(Qt5Core_VERSION MATCHES "^5\\.5\\.")
  install(
      FILES Qt5Widgets_HunterPlugin_5_5.cmake
      DESTINATION "lib/cmake/Qt5Widgets"
  )
elseif(Qt5Core_VERSION MATCHES "^5\\.6\\.")
  install(
      FILES Qt5Widgets_HunterPlugin_5_6.cmake
      DESTINATION "lib/cmake/Qt5Widgets"
  )
else()
  message(FATAL_ERROR "Unexpected Qt version")
endif()

install(
    FILES
    Qt5Qml_QmlQtQuick2Plugin.cmake
    Qt5Qml_ZZZ_HunterPlugin.cmake
    DESTINATION
    "lib/cmake/Qt5Qml"
)

install(
    FILES
    Qt5Multimedia_QMultimediaDeclarativeModulePlugin.cmake
    Qt5Multimedia_ZZZ_HunterPlugin.cmake
    DESTINATION
    "lib/cmake/Qt5Multimedia"
)

install(
    FILES
    Qt5Core_HunterPlugin.cmake
    DESTINATION
    "lib/cmake/Qt5Core"
)

install(
    FILES
    Qt5Gui_ZZZ_HunterPlugin.cmake
    DESTINATION
    "lib/cmake/Qt5Gui"
)

install(
    FILES
    Qt5Network_ZZZ_HunterPlugin.cmake
    DESTINATION
    "lib/cmake/Qt5Network"
)

install(FILES QtCMakeExtraHelpers.cmake DESTINATION cmake)
