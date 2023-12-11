import QtQuick
import QtQuick.Controls

Item {
    id: root

    required property var user
    readonly property string title: "Inicio"

    Label {
        width: root.width * .8
        anchors.horizontalCenter: parent.horizontalCenter
        text: `
            <h4>Bienvenido Agente, aqui podras realizar diferentes actividades como:</h4>
            <ul>
                <li>Manejar tus multas</li>
                <li>Ver el clima</li>
                <li>Ver el horospoco</li>
                <li>Consulta de vehiculo por placa</li>
            </ul>
        `
        wrapMode: Label.Wrap
        font.pointSize: 14
    }
}
