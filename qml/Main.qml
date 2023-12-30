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

            Item {
                id: leftItem
                width: 370
                height: parent.height
                anchors.left: parent.left

                Item {
                    id: dateitem
                    height: 150
                    width: parent.width
                    anchors.top: parent.top
                }

                Rectangle {
                    id: todaysweatheritem
                    width: parent.width
                    color: '#1e1f2a'
                    anchors.top: dateitem.bottom
                    anchors.bottom: locationitem.top
                    anchors.topMargin: 17
                    anchors.bottomMargin: 17
                }

                Rectangle {
                    id: locationitem
                    height: 126
                    width: parent.width
                    anchors.bottom: parent.bottom
                }
            }

            Rectangle {
                id: middleItem
                width: 152
                height: parent.height
                anchors.left: leftItem.right
                anchors.leftMargin: 22
            }

            Rectangle {
                id: rightItem
                height: parent.height
                anchors.left: middleItem.right
                anchors.right: parent.right
                anchors.leftMargin: 35
            }
        }
    }
}
