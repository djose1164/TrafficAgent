import QtQuick
import QtQuick.Controls

Drawer {
    id: root

    required property StackView stackView

    Column {
        component ItemMenu: ItemDelegate {
            required property string source
            width: root.width
            onClicked: {
                stackView.push(source);
                close();
            }
        }

        ItemMenu {
            text: "Tarifario de Multa"
            source: "FineTariff.qml"
        }

        ItemMenu {
            text: "Consulta de Vehiculo"
            source: "Vehicle.qml"
        }

        ItemMenu {
            text: "Consulta de conductor"
            source: "DriverPage.qml"
        }

        ItemMenu {
            text: "Multas"
            source: "TrafficTicketPage.qml"
        }

        ItemMenu {
            text: "Noticias"
            source: "News.qml"
        }

        ItemMenu {
            text: "Clima"
            source: "Weather.qml"
        }

        ItemMenu {
            text: "Horospoco"
            source: "Horoscope.qml"
        }
    }
}
