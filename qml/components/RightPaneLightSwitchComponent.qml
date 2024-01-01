import QtQuick
import QtQuick.Layouts

RowLayout {
    width: parent.width
    height: 20

    property string label
    property alias checked: _switch.checked

    Text {
        text: label
        font.pixelSize: 14
        color: textColor
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
    }

    Switch {
        id: _switch
        checked: true
        Layout.alignment: Qt.AlignVCenter
    }
}
