set(
    sources
    static_qt_AudioCaptureServicePlugin.cpp
    static_qt_AVFMediaPlayerServicePlugin.cpp
    static_qt_AVFServicePlugin.cpp
    static_qt_CoreAudioPlugin.cpp
    static_qt_DSServicePlugin.cpp
    static_qt_plugins.cpp
    static_qt_QDDSPlugin.cpp
    static_qt_QICNSPlugin.cpp
    static_qt_QICOPlugin.cpp
    static_qt_QJp2Plugin.cpp
    static_qt_QM3uPlaylistPlugin.cpp
    static_qt_QMngPlugin.cpp
    static_qt_QMultimediaDeclarativeModule.cpp
    static_qt_QTgaPlugin.cpp
    static_qt_QTiffPlugin.cpp
    static_qt_QtQuick2Plugin.cpp
    static_qt_QWbmpPlugin.cpp
    static_qt_QWebpPlugin.cpp
    static_qt_QXcbEglIntegrationPlugin.cpp
)

install(FILES ${sources} DESTINATION "src/qt/plugins")
