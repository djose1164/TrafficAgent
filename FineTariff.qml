import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import "service.js"  as Service

Page {
    id: root

    readonly property StackView stackView: StackView.view

    title: "Tarifario de multas"
    Component.onCompleted: Service.trafficTickets(tickets => listModel.append(tickets))

    ListView {
        anchors.fill: parent
        model: listModel
        delegate: fineTarrifDelegate
    }

    ListModel {
        id: listModel
    }

    Component {
        id: fineTarrifDelegate
        ItemDelegate {
            required property string name
            required property string description

            text: name
            font.pointSize: 12
            onClicked: {
                message.text = name;
                message.informativeText = description;
                message.open();
            }
        }
    }

    MessageDialog {
        id: message
        onButtonClicked: close()
    }
}
