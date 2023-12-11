import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {
    id: root

    required property string name
    required property ListModel weather
    required property var main

    ColumnLayout {
        width: root.width * .8
        height: root.height/2
        anchors.centerIn: parent
        spacing: 20

        Label {
            id: label
            text: name
            Layout.rowSpan: 2
            font.bold: true
            font.pointSize: 12
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        }

        Label {
            text: main.temp + " °C"
            font.pointSize: 14
            font.bold: true
            Layout.alignment: Qt.AlignCenter
        }

        RowLayout {
            id: rowLayout
            Layout.fillWidth: true
            Layout.topMargin: 30

            Repeater {
                id: repeater
                model: weather

                Item {
                    id: imageWithDescription
                    required property string description
                    required property string icon

                    implicitWidth: 100
                    implicitHeight: 80

                    Image {
                        id: image
                        width: imageWithDescription.width
                        height: 50
                        source: `https://openweathermap.org/img/wn/${icon}@2x.png`
                        sourceSize: "70x70"
                        fillMode: Image.PreserveAspectFit

                        BusyIndicator {
                            anchors.centerIn: parent
                            visible: image.status !== Image.Ready
                        }
                    }

                    Label {
                        anchors.top: image.bottom
                        anchors.topMargin: 5
                        text: description
                        font.pointSize: 11
                    }
                }
            }
        }
    }
}
