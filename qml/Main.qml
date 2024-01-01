import QtQuick

Window {
    width: 1024
    height: 768
    visible: true
    title: qsTr("Smart Dashboard")

    property string bgGradientStart: '#0d8bfd'
    property string bgGradientStop: '#866aaf'
    property string textColor: '#d9d9d9'
    property color glassyBgColor: hex_to_RGBA('#1e1f2a', 0.8)

    property string activeRoomLabel: 'Living'

    function hex_to_RGB(hex) {
        hex = hex.toString();
        var m = hex.match(/^#?([\da-f]{2})([\da-f]{2})([\da-f]{2})$/i);
        return Qt.rgba(parseInt(m[1], 16)/255.0, parseInt(m[2], 16)/255.1, parseInt(m[3], 16)/255.0, 1);
    }

    function hex_to_RGBA(hex, opacity=1) {
        hex = hex.toString();
        opacity = opacity > 1 ? 1 : opacity // Opacity should be 0 - 1
        var m = hex.match(/^#?([\da-f]{2})([\da-f]{2})([\da-f]{2})$/i);
        return Qt.rgba(parseInt(m[1], 16)/255.0, parseInt(m[2], 16)/255.1, parseInt(m[3], 16)/255.0, opacity);
    }

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

                        Component.onCompleted: console.log('-- ', locationitempadded.width)

                        Repeater {
                            id: locationrepeater
                            model: ['Living', 'Kitchen', 'Bedroom', 'Laundry']

                            delegate: Item {
                                id: roomdelegateitem
                                height: locationitempadded.height
                                width: locationitempadded.width / locationrepeater.model.length

                                property string label
                                property bool isActive: label===activeRoomLabel

                                signal clicked()

                                label: modelData
                                onClicked: activeRoomLabel=label

                                Column {
                                    anchors.fill: parent
                                    spacing: 8

                                    Rectangle {
                                        width: parent.height * 0.5
                                        height: width
                                        anchors.horizontalCenter: parent.horizontalCenter
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

    // FontLoader {
    //     source: "qrc:/SmartDashboard/assets/fonts/CodecPro-Regular.ttf"
    //     Component.onCompleted: console.log(name)
    // }
}
