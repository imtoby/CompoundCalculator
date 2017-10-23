import QtQuick 2.3
import QtQuick.Window 2.0
import "qml"

Window {
    visible: true
    width: 360
    height: 640
    title: qsTr("Compound Calculator")

    CompoundCalculator {
        anchors.fill: parent
    }
}
