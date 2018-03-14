install(
    FILES
    Qt5Widgets_HunterPlugin_5_5.cmake
    Qt5Widgets_HunterPlugin_5_6.cmake
    Qt5Widgets_HunterPlugin_5_9.cmake
    Qt5Widgets_HunterPlugin_5_10.cmake
    Qt5Widgets_HunterPlugin.cmake
    DESTINATION
    "lib/cmake/Qt5Widgets"
)

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
    Qt5MultimediaWidgets_ZZZ_HunterPlugin.cmake
    DESTINATION
    "lib/cmake/Qt5MultimediaWidgets"
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
