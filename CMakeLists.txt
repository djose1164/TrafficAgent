cmake_minimum_required(VERSION 3.16)

project(TrafficAgent VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Multimedia WebView)

qt_standard_project_setup()

qt_add_executable(appTrafficAgent
    main.cpp
)

qt_add_qml_module(appTrafficAgent
    URI TrafficAgent
    VERSION 1.0
    QML_FILES
        Main.qml
        LoginPage.qml
        QML_FILES Home.qml
        SideMenu.qml
        FineTariff.qml
        Vehicle.qml
        DriverPage.qml
        SearchBar.qml
        NewTicket.qml
        TrafficTicketData.qml
        TrafficTicketPage.qml
        MotiveSelector.qml
        Maps.qml
        TrafficTicketDetails.qml
        Weather.qml
        WeatherDelegate.ui.qml
        WeatherForm.ui.qml
        News.qml
        Horoscope.qml
    RESOURCES
        assets/arrow-left-solid.svg
        assets/marker.svg
        assets/bars-solid.svg
        assets/plus-solid.svg
        assets/maps.svg
        assets/image-placeholder.svg
        assets/xmark-solid.svg
        service.js
        database.js

)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appTrafficAgent PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTrafficAgent
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTrafficAgent
    PRIVATE Qt6::Quick Qt6::Multimedia Qt6::WebView
)

include(GNUInstallDirs)
install(TARGETS appTrafficAgent
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

if (ANDROID)
    set(OpenSSLPath "C:/Users/Daniel Victoriano/AppData/Local/Android/Sdk/android_openssl")
    include(${OpenSSLPath}/android_openssl.cmake)
    add_android_openssl_libraries(appTrafficAgent)
endif()
