import QtQuick
import QtQuick.Controls
import "service.js" as Service

Page {
    id: root

    readonly property StackView stackView: StackView.view

    title: "Multas de trafico"

    ListView {
        id: listView
        anchors.fill: parent
        spacing: 20
        model: data.model
        delegate: trafficTicketDelegate

        Label {
            anchors.centerIn: parent
            visible: listView.count === 0
            text: "No hay ninguna multada de trafico registrada."
        }
    }

    TrafficTicketData {
        id: data
    }

    Component {
        id: trafficTicketDelegate
        ItemDelegate {
            id: itemDelegate

            required property var model
            required property string cedula
            required property string licensePlate
            required property string motiveId
            required property string picture
            property var motive

            width: listView.width
            height: 100
            onClicked: stackView.push("TrafficTicketDetails.qml", {motive, model})
            Component.onCompleted: Service.motiveById(motiveId, resp => motive = resp)

            Image {
                id: img
                source: picture
                sourceSize: "100x100"
            }

            Label {
                id: label
                anchors.left: img.right
                anchors.leftMargin: 15
                height: itemDelegate.height
                text: `
                    <strong>Cedula:</strong> ${cedula}<br>
                    <strong>Placa:</strong> ${licensePlate}<br>
                    <strong>Motivo: </strong> ${motive?.name}
                `
                verticalAlignment: Label.AlignVCenter
                font.pointSize: 14
            }
        }
    }

    Column {
        anchors {
            bottom: parent.bottom
            bottomMargin: 14
            right: parent.right
            rightMargin: 14
        }

        RoundButton {
            icon.source: "assets/maps.svg"
            onClicked: stackView.push("Maps.qml", {ticketData: data})
        }

        RoundButton {
            icon.source: "assets/plus-solid.svg"
            onClicked: stackView.push("NewTicket.qml", {model: data})
        }
    }
}
