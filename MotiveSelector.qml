import QtQuick
import QtQuick.Controls
import "service.js" as Service

ComboBox {
    id: root


    Component.onCompleted: Service.allMotives(data => listModel.append(data))

    //anchors.fill: parent
    textRole: "name"
    valueRole: "id"
    displayText: currentIndex === -1 ? "Selecionar motivo" : currentText
    model: listModel
    ListModel { id: listModel }
}


