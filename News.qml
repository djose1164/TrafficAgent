import QtQuick
import QtQuick.Controls
import "service.js" as Service

Page {
    id: root

    title: "Noticias"
    Component.onCompleted: Service.news(data => listModel.append(data))

    ListView {
        id: listView
        anchors.fill: parent
        spacing: 20
        model: listModel
        delegate: newsDelegate

        BusyIndicator {
            anchors.centerIn: parent
            visible: listView.count === 0
        }
    }

    ListModel { id: listModel }

    Component {
        id: newsDelegate
        Label {
            required property var title
            required property var content

            width: listView.width * .95
            anchors.horizontalCenter: parent.horizontalCenter
            text: `
                <h1>${title.rendered}</h1>
                ${content.rendered}
            `
            wrapMode: Label.Wrap
        }
    }
}
