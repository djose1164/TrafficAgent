import QtQuick
import QtQuick.Controls
import "service.js" as Service

Page {
    id: root
    title: "Vehiculos"

    SearchBar {
        id: searchBar
        width: root.width
        height: 100
        title: "Placa del vehiculo"
        onSearchClicked: text => Service.vehicleByLicensePlate(text, data => listModel.set(0, data))
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
            required property string owner
            required property string motor_type
            required property string color
            required property int year

            spacing: 20
            padding: 15

            Label {
                text: "Detalles del vehiculo: "+id
                font.bold: true
            }

            Label {
                text: `Nombre del vehiculo: ${name}`
            }

            Label {
                text: `Propietario del vehiculo: ${owner}`
            }
            Label {
                text: `Motor del vehiculo: ${motor_type}`
            }

            Label {
                text: `Color del vehiculo: ${color}`
            }

            Label {
                text: `Año del vehiculo: ${year}`
            }
        }
    }
}
