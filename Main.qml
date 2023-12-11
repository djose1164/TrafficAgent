import QtQuick
import QtQuick.Controls.Material

ApplicationWindow {
    id: app
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    header: ToolBar {
        ToolButton {
            readonly property bool shouldGoBack: appStack.depth > 1
            visible: appStack.title !== "Login"
            icon.source: shouldGoBack ? "assets/arrow-left-solid.svg" : "assets/bars-solid.svg"
            onClicked: shouldGoBack ? appStack.pop() : drawer.open()
        }

        Label {
            anchors.centerIn: parent
            text: appStack.title
            font.pointSize: 14
            font.bold: true
        }
    }

    StackView {
        id: appStack
        readonly property string title: currentItem.title
        anchors.fill: parent
        initialItem: "LoginPage.qml"
    }

    SideMenu {
        id: drawer
        width: app.width * .44
        height: app.height
        stackView: appStack
    }
}
