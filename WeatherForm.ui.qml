

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Page {
    id: root

    readonly property alias listView: listView

    title: "Clima"

    ListView {
        id: listView
        anchors.fill: parent
        interactive: false
        delegate: WeatherDelegate {
            id: gridLayout
            width: listView.width
            height: listView.height/2
        }

        BusyIndicator {
            anchors.centerIn: parent
            visible: listView.count === 0
        }
    }
}
