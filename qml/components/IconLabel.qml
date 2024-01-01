import QtQuick
import QtQuick.Controls

Label {
    id: lbl

    property real size: 16
    property string icon

    text: icon
    color: textColor
    font.pixelSize: size
    font.family: fontawesomefontloader.name
}
