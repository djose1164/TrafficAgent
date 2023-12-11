import QtCore
import QtQuick
import QtMultimedia
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import Qt.labs.folderlistmodel

Page {
    id: root

    required property TrafficTicketData model

    title: "Registrar nueva multa de trafico"

    ScrollView {
        anchors.fill: parent
        contentWidth: availableWidth

        ColumnLayout {
            width: root.width * .8
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            TextField {
                id: cedulaField
                placeholderText: "Cedula"
                Layout.fillWidth: true
            }

            TextArea {
                id: licensePlateField
                placeholderText: "Placa del vehiculo"
                Layout.fillWidth: true
            }

            MotiveSelector {
                id: motiveSelector
                Layout.fillWidth: true
            }

            TextField {
                id: latitudeField
                placeholderText: "Latitud"
                Layout.fillWidth: true
            }

            TextField {
                id: longitudeField
                placeholderText: "Longitude"
                Layout.fillWidth: true
            }

            Image {
                id: image
                source: "assets/image-placeholder.svg"
                sourceSize.width: page.width/2
                sourceSize.height: page.height/4
            }

            Button {
                text: "Seleccionar imagen"
                onClicked: fileDialog.open()
            }

            FileDialog {
                id: fileDialog
                nameFilters: ["PNG (*.png)", "JPG (*jpg)", "JPEG (*.jpeg)"]
                currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
                onAccepted: image.source = selectedFile
            }

            Label {
                visible: recordBtn.isRecording
                text: "Grabando audio..."
            }

            RowLayout {
                spacing: 10

                Button {
                    id: recordBtn
                    readonly property bool isRecording: mediaRecorder.recorderState === MediaRecorder.RecordingState
                    text:  !isRecording ? "Record" : "Stop"
                    onClicked:  {
                        if (!isRecording)
                            mediaRecorder.record()
                        else {
                            mediaRecorder.stop();
                            deleteBtn.visible = true;
                        }
                    }
                }

                Button {
                    id: deleteBtn
                    visible: false
                    text: "Eliminar audio"
                    onClicked: {
                        if (fileUtils.remove(getAudioPath()))
                            visible = false;
                    }
                }
            }

            MicrophonePermission {
                Component.onCompleted: request()
            }

            CaptureSession {
                id: session
                audioInput: AudioInput {
                    Component.onCompleted: print("audio device: "+device)
                }
                recorder: mediaRecorder
            }

            MediaRecorder {
                id: mediaRecorder
                mediaFormat {
                    fileFormat: MediaFormat.MP3
                    audioCodec: MediaFormat.AC3
                }
                outputLocation: StandardPaths.writableLocation(StandardPaths.MusicLocation)
                onRecorderStateChanged: print(`recorderState: ${mediaRecorder.recorderState}`)
                onErrorChanged: print(`error: ${mediaRecorder.errorString}`)
            }

            FolderListModel {
                id: folderModel
                folder: StandardPaths.writableLocation(StandardPaths.MusicLocation)
            }

            Button {
                text: "Agregar"
                onClicked: newTicket()
                Layout.fillWidth: true
            }
        }
    }

    MessageDialog {
        id: message

        function openWith(text: string, infoText: string): void {
            message.text = text;
            message.informativeText = infoText;
            message.open();
        }
    }

    function newTicket(): void {
        try {
            const audioPath = folderModel.get(folderModel.count-1, "fileUrl") ?? "";
            const exp = {
                cedula: cedulaField.text,
                licensePlate: licensePlateField.text,
                picture: image.source,
                voiceNote: audioPath,
                latitude: latitudeField.text,
                longitude: longitudeField.text,
                motiveId: motiveSelector.currentValue
            }
            print(JSON.stringify(exp,null,2));
            model.addTrafficTicket(exp);
            message.openWith("Exito al registrar multa!");
        } catch (e) {
            print("NewTicker: "+e);
            message.openWith("No se ha podido registrar la multa", "Error: "+e);
        }
    }

    function getAudioPath(): url {
        return folderModel.get(folderModel.count-1, "fileUrl");
    }
}
