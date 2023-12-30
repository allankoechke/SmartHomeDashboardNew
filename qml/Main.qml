import QtQuick

Window {
    width: 1024
    height: 768
    visible: true
    title: qsTr("Smart Dashboard")

    property string bgGradientStart: '#0d8bfd'
    property string bgGradientStop: '#866aaf'

    Rectangle {
        id: bg
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: bgGradientStart }
            GradientStop { position: 1.0; color: bgGradientStop }
        }

        Item {
            anchors.fill: parent
            anchors.margins: 76.4

            Rectangle {
                anchors.fill: parent

            }
        }
    }
}
