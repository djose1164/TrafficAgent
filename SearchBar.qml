import QtQuick
import QtQuick.Controls
import "service.js" as Service

Rectangle {
    id: root

    required property string title
    signal searchClicked(text: string)

    z: 100

    Row {
        id: row
        padding: 20
        spacing: 20

        TextField {
            id: searchField
            width: root.width * .65
            placeholderText: title
        }

        Button {
            text: "Buscar"
            width: root.width * .25
            onClicked: searchClicked(searchField.text)
        }
    }
}
