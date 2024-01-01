import QtQuick

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

        Text {
            text: Qt.formatDate(currentTime, 'yyyy-MM-dd')
            font.pixelSize: 16
            color: textColor
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.topMargin: 24
        }

        Text {
            text: Qt.formatDate(currentTime, 'ddd')
            font.pixelSize: 16
            color: textColor
            anchors.top: parent.top
            anchors.right: ampmtxt.right
            anchors.topMargin: 24
        }

        Text {
            id: timetxt
            text: Qt.formatTime(currentTime, 'hh:mm')
            font.pixelSize: 64
            color: textColor
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.bottomMargin: 24
        }

        Text {
            id: sectxt
            width: 50
            text: ':' + Qt.formatTime(currentTime, 'ss')
            font.pixelSize: 24
            color: textColor
            anchors.baseline: timetxt.baseline
            anchors.left: timetxt.right
        }

        Text {
            id: ampmtxt
            text: Qt.formatTime(currentTime, 'AP')
            font.pixelSize: 16
            color: textColor
            anchors.baseline: timetxt.baseline
            anchors.left: sectxt.right
            anchors.leftMargin: 8
        }
    }

    Rectangle {
        id: todaysweatheritem
        radius: 16
        width: parent.width
        color: glassyBgColor
        anchors.top: dateitem.bottom
        anchors.bottom: locationitem.top
        anchors.topMargin: 17
        anchors.bottomMargin: 17

        Text {
            text: qsTr('Today')
            font.pixelSize: 14
            color: textColor
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 24
        }

        Column {
            anchors.centerIn: parent
            spacing: 24

            Row {
                spacing: 24
                height: tmptxt.height
                anchors.horizontalCenter: parent.horizontalCenter

                IconLabel {
                    id: cloudicon
                    icon: '\uf746'
                    size: 24
                    color: textColor
                    anchors.baseline: tmptxt.baseline
                }

                Text {
                    id: tmptxt
                    text: ambientTemperature
                    font.pixelSize: 82
                    color: textColor

                    Text {
                        text: qsTr('°C')
                        font.pixelSize: 12
                        color: textColor
                        anchors.top: parent.top
                        anchors.left: parent.right
                    }
                }

                Text {
                    id: minmaxtxt
                    text: qsTr('24/16')
                    font.pixelSize: 14
                    color: textColor
                    anchors.baseline: tmptxt.baseline
                }
            }

            Text {
                id: weathercommentxt
                text: qsTr('Partially Clouded')
                font.pixelSize: 16
                color: textColor
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    Rectangle {
        id: locationitem
        radius: 16
        height: 126
        color: glassyBgColor
        width: parent.width
        anchors.bottom: parent.bottom

        Row {
            id: locationitempadded
            anchors.fill: parent
            anchors.margins: 24

            Repeater {
                id: locationrepeater
                model: roomsModel

                delegate: Item {
                    id: roomdelegateitem
                    height: locationitempadded.height
                    width: locationitempadded.width / locationrepeater.model.count

                    property string label
                    property bool isActive: label===activeRoomLabel
                    property alias icon: iconlabel.icon
                    property alias size: iconlabel.size

                    signal clicked()

                    label: model.label
                    icon: model.icon
                    size: model.size
                    onClicked: activeRoomLabel=label

                    Column {
                        anchors.fill: parent
                        spacing: 8

                        IconLabel {
                            id: iconlabel
                            width: parent.height * 0.5
                            height: width
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: IconLabel.AlignHCenter
                            verticalAlignment: IconLabel.AlignVCenter
                        }

                        Text {
                            text: roomdelegateitem.label
                            font.pixelSize: 12
                            color: textColor
                            anchors.horizontalCenter: parent.horizontalCenter

                            Rectangle {
                                width: parent.parent.width * 0.8
                                height: 4
                                radius: 2
                                color: textColor
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: -8
                                opacity: roomdelegateitem.isActive ? 1 : 0.5

                                Behavior on opacity { NumberAnimation { duration: 300 }}
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: roomdelegateitem.clicked()
                    }
                }
            }
        }
    }
}
