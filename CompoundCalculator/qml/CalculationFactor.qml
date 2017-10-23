import QtQuick 2.3

MouseArea {
    id: factor
    implicitHeight: factorHeight + tipObj.height
    implicitWidth: 360

    property alias color: labelObj.color
    property alias divColor: divObj.color
    property alias divVisible: divObj.visible
    property alias inputFocus: inputObj.focus
    property alias label: labelObj.text
    property alias placeHoldText: placeHoldObj.text
    property alias readOnly: inputObj.readOnly
    property string tip: ""
    property alias value: inputObj.text
    readonly property int factorHeight: 50

    Item {
        width: labelObj.width + spaceObj.width + inputObj.width
        height: factorHeight
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: labelObj
            width: Math.max(labelObj.paintedWidth, 40)
            height: factorHeight
            font.pointSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            antialiasing: true
        }

        Item {
            id: spaceObj
            implicitWidth: 10
            implicitHeight: factorHeight
            anchors.left: labelObj.right
        }

        TextInput {
            id: inputObj
            width: focus || length ?
                       Math.min(Math.max(inputObj.contentWidth,
                                         labelObj.paintedWidth), 280) : 0
            height: factorHeight
            anchors.left: spaceObj.right
            font.pointSize: 14
            verticalAlignment: Text.AlignVCenter
            antialiasing: true
            clip: true
            validator: DoubleValidator {}
            activeFocusOnTab: true

            Behavior on width {
                NumberAnimation {
                    duration: 100
                }
            }

            Text {
                id: placeHoldObj
                font: inputObj.font
                anchors.fill: parent
                anchors.leftMargin: 6
                verticalAlignment: Text.AlignVCenter
                color: "#B6B6B6"
                opacity: inputObj.length ? 0 : 1

                Behavior on width {
                    NumberAnimation {
                        duration: 200
                    }
                }
            }
        }
    }

    onClicked: {
        if (!inputFocus) {
            inputFocus = true
        }
    }

    Text {
        id: tipObj
        font.pointSize: 10
        anchors.bottom: divObj.top
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        antialiasing: true
        color: "#B6B6B6"
        text: tip.length ? tip : ""
        height: text.length ? paintedHeight : 0
        width: Math.min(paintedWidth, 280)
        wrapMode: Text.Wrap

        Behavior on height {
            NumberAnimation {
                duration: 200
            }
        }
    }

    Rectangle {
        id: divObj
        implicitHeight: 1
        anchors.left: parent.left
        anchors.leftMargin: 9
        anchors.right: parent.right
        anchors.rightMargin: 9
        anchors.bottom: parent.bottom
        color: "#EEEEEE"
    }
}
