import QtQuick
import QtQuick.Controls
import "service.js" as Service

Page {
    id: root
    title: "Conductores"

    SearchBar {
        id: searchBar
        width: root.width
        height: 100
        title: "ID del conductor"
        onSearchClicked: text => Service.driverById(text, data => listModel.set(0, data))
    }

    ListView {
        id: listView
        anchors {
            top: searchBar.bottom
            topMargin: 20
            bottom: parent.bottom
        }
        width: root.width
        model: listModel
        delegate: vehicleDelegate
    }

    ListModel { id: listModel }

    Component {
        id: vehicleDelegate
        Column {
            required property string id
            required property string name
            required property date birth_date
            required property string address
            required property string phone_number
            required property url picture

            spacing: 20
            padding: 15

            Image {
                source: picture
                sourceSize: "100x100"
            }

            Label {
                text: `Nombre: ${name}`
                font.pointSize: 14
            }

            Label {
                text: `Fecha de nacimiento: ${birth_date.toLocaleDateString()}`
                font.pointSize: 14
            }
            Label {
                text: `Direccion: ${address}`
                font.pointSize: 14
            }

            Label {
                text: `Numero telefonico: ${phone_number}`
                font.pointSize: 14
            }
        }
    }
}
