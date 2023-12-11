import QtQuick
import QtQuick.Controls
import QtLocation
import QtPositioning

Page {
    id: root

    required property TrafficTicketData ticketData

    title: "Mapa"

    Plugin {
        id: osmPlugin
        name: "osm"
    }

    MapView {
        id: view
        anchors.fill: parent
        map.center: QtPositioning.coordinate(18.46, -69.93)
        map.plugin: osmPlugin
        map.zoomLevel: (maximumZoomLevel - minimumZoomLevel)/2

        MapItemView {
            model: ticketData.model
            parent: view.map
            delegate: MapQuickItem {
                required property real latitude
                required property real longitude
                coordinate: QtPositioning.coordinate(latitude, longitude)

                anchorPoint.x: image.width * 0.5
                anchorPoint.y: image.height

                sourceItem: Column {
                    Image { id: image; source: "assets/marker.svg" }

                }
            }
        }
    }
}
