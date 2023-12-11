import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "service.js" as Service

Page {
    id: root

    readonly property StackView stackView: StackView.view

    title: "Login"
    states: [
        State {
            name: "invalidCredentials"
            PropertyChanges {
                target: message
                text: "La contrasena o correo electronico son incorrectas."
            }
            StateChangeScript {
                script: message.open()
            }
        }
    ]

    ColumnLayout {
        id: columnLayout
        width: root.width * .8
        height: root.height/2
        anchors.centerIn: parent

        TextField {
            id: emailField
            placeholderText: "Correo electronico"
            Layout.fillWidth: true
        }

        TextField {
            id: passwordField
            placeholderText: "Contrasena"
            echoMode: TextField.Password
            Layout.fillWidth: true
        }

        Button {
            text: "Iniciar sesion"
            Layout.fillWidth: true
            onClicked: {
                const credentials = {email: emailField.text, password: passwordField.text};
                authenticate(credentials, saveUser)
            }
        }
    }

    MessageDialog {
        id: message
        onButtonClicked: close()
    }

    function authenticate(credentials, callback): void {
        Service.request("POST", "/users/login", callback, credentials);
    }

    function saveUser(user): void {
        print(JSON.stringify(user, null, 2));
        stackView.replace("Home.qml", {user: user});
    }
}
