import QtQuick

Rectangle {
    id: root
    implicitHeight: 20
    implicitWidth: 40
    radius: height/2
    color: checked ? '#48709F' : '#3C608B'

    Behavior on color { ColorAnimation { duration: 200 } }

    property bool checked: false
    signal toggled(checked: bool)

    Rectangle {
        id: indicator
        color: checked ? '#fff' : textColor
        width: root.height - 4
        height: width
        radius: height/2
        x: checked ? (root.width - width - 2) : 2
        anchors.verticalCenter: parent.verticalCenter

        Behavior on x { NumberAnimation { duration: 200 } }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            checked = !checked
            root.toggled(checked)
        }
    }
}
