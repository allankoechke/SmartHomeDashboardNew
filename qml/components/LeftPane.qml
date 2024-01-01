import QtQuick

Item {
    id: leftItem
    width: 370
    height: parent.height
    anchors.left: parent.left

    property ListModel roomsModel: ListModel {
        ListElement {
            label: 'Living'
            icon: '\uf4b8'
        }

        ListElement {
            label: 'Kitchen'
            icon: '\ue01b'
        }

        ListElement {
            label: 'Bedroom'
            icon: '\uf236'
        }

        ListElement {
            label: 'Laundry'
            icon: '\uf898'
        }
    }

    Item {
        id: dateitem
        height: 150
        width: parent.width
        anchors.top: parent.top

        Text {
            text: qsTr('2023-12-30')
            font.pixelSize: 16
            color: textColor
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.topMargin: 24
        }

        Text {
            text: qsTr('SAT')
            font.pixelSize: 16
            color: textColor
            anchors.top: parent.top
            anchors.right: ampmtxt.right // parent.right
            // anchors.rightMargin: 24
            anchors.topMargin: 24
        }

        Text {
            id: timetxt
            text: qsTr('10:30')
            font.pixelSize: 64
            color: textColor
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.bottomMargin: 24
        }

        Text {
            id: ampmtxt
            text: qsTr('AM')
            font.pixelSize: 16
            color: textColor
            anchors.baseline: timetxt.baseline
            anchors.left: timetxt.right
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

                Text {
                    id: cloudicon
                    text: qsTr('CLOUD')
                    font.pixelSize: 14
                    color: textColor
                    anchors.baseline: tmptxt.baseline
                }

                Text {
                    id: tmptxt
                    text: qsTr('22')
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

                    signal clicked()

                    label: locationrepeater.model.label
                    icon: locationrepeater.model.icon
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
