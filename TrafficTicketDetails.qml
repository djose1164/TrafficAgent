import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Page {
    id: root

    required property var model
    required property var motive

    title: "Consulta de Multa"

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth
    ColumnLayout {
        id: columnLayout
        width: root.width * .8
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            source: model.picture ?? "assets/image-placeholder.svg"
            sourceSize.width: root.width * .8
            sourceSize.height: root.height/3
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
        }

        Label {
            text: "Cedula: "+ model.cedula
            color: "white"
            horizontalAlignment: Label.AlignHCenter
            background: Rectangle {
                color: "red"
            }
            font.pointSize: 14
            font.bold: true
            Layout.fillWidth: true
        }

        Label {
            text: "Placa: "+model.licensePlate
            wrapMode: Label.Wrap
            font.pointSize: 12
            Layout.fillWidth: true
        }

        Label {
            text: `
                <h1>${motive.name}</h1>
                <p>${motive.description}</p>
            `
            wrapMode: Label.Wrap
            Layout.fillWidth: true
        }

        Label {
            text: `
                <h1>Comentario</h1>
                <p>${model.commentary}</p>
            `
            wrapMode: Label.Wrap
            Layout.fillWidth: true
        }

        Label {
            text: `Coordenadas: ${model.latitude}, ${model.longitude}`
        }

        Label {
            readonly property date dateTime: model.dateTime
            text: dateTime.toLocaleDateString()
        }

        MediaPlayer {
            id: playMusic
            source: model.voiceNote
            audioOutput: AudioOutput {
                volume: slider.value
            }
        }

        Button {
            text: playBtnStatus()
            enabled: playMusic.hasAudio
            onClicked: playBtnClicked()
        }

        Slider {
            id: slider
            from: 0.
            to: 1.
            value: 1.
        }
    }
    }
    function playBtnStatus(): string {
        print("playbackState: ", playMusic.playbackState);
        if (playMusic.playing)
            return "Detener";
        else if (playMusic.hasAudio && !playMusic.playing)
            return "Reproducir audio";
        else
            return "Esta vivencia no contiene audio";
    }

    function playBtnClicked(): void {
        if (playMusic.playing)
            playMusic.stop();
        else if (playMusic.hasAudio)
            playMusic.play();
    }
}

