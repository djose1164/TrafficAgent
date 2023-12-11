import QtQuick
import QtWebView

Item {
    readonly property string title: "Horospoco"

    WebView {
        anchors.fill: parent
        url: "https://www.lecturas.com/horoscopo"
    }
}
