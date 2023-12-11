import QtQuick 2.15
import "service.js" as Service

WeatherForm {
    listView.model: listModel
    Component.onCompleted: {
        Service.weatherIn("Santo Domingo", data => listModel.append(data))
    }

    ListModel { id: listModel }
}
