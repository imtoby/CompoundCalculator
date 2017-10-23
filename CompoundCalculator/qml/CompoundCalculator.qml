import QtQuick 2.0

MouseArea {

    property double principal: 0.0 // 本金
    property double rate: 0.0 // 利率
    property double times: 1.0 // 年复利次数
    property double years: 1.0 // 年数

    CalculationFactor {
        id: principalObj
        anchors.top: parent.top
        anchors.topMargin: 20
        label: qsTr("本金")
        placeHoldText: "元"
        onValueChanged: {
            principal = value * 1.0
        }
        KeyNavigation.tab: rateObj
        KeyNavigation.backtab: yearsObj
        KeyNavigation.up: yearsObj
        KeyNavigation.down: rateObj
    }

    CalculationFactor {
        id: rateObj
        anchors.top: principalObj.bottom
        label: qsTr("利率")
        placeHoldText: "%"
        onValueChanged: {
            rate = value / 100.0
        }
        tip: inputFocus ? qsTr("仅需输入百分数的分子部分") : ""
        KeyNavigation.tab: timesObj
        KeyNavigation.backtab: principalObj
        KeyNavigation.up: principalObj
        KeyNavigation.down: timesObj
    }

    CalculationFactor {
        id: timesObj
        anchors.top: rateObj.bottom
        label: qsTr("年数")
        placeHoldText: "年"
        onValueChanged: {
            years = value * 1.0
        }
        tip: inputFocus ? qsTr("年数小于一年的按照如下值输入：<br>"
                  +"1月: 0.0833,2月: 0.1667,3月: 0.25,4月: 0.3333,<br>"
                  +"5月: 0.4167,6月: 0.5,7月: 0.5833,8月: 0.6667,<br>"
                  +"9月: 0.75,10月: 0.8333,11月: 0.9167") : ""
        KeyNavigation.tab: yearsObj
        KeyNavigation.backtab: rateObj
        KeyNavigation.up: rateObj
        KeyNavigation.down: yearsObj
    }

    CalculationFactor {
        id: yearsObj
        anchors.top: timesObj.bottom
        label: qsTr("复利")
        placeHoldText: "次"
        onValueChanged: {
            times = value * 1.0
        }
        tip: inputFocus ? qsTr("年复利次数") : ""
        KeyNavigation.tab: principalObj
        KeyNavigation.backtab: timesObj
        KeyNavigation.up: timesObj
        KeyNavigation.down: principalObj
    }

    Text {
        id: labelObj
        width: Math.max(labelObj.paintedWidth, 40)
        height: 50
        anchors.top: yearsObj.bottom
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 14
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        antialiasing: true
        text: qsTr("结果")
    }

    Text {
        id: resultObj
        width: Math.max(resultObj.paintedWidth, 40)
        height: 20
        anchors.top: labelObj.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        antialiasing: true
        text: {
            var result = principal*Math.pow(1 + rate/times, times*years)
            return result === 0 ? "" : result
        }
    }

    onClicked: {
        principalObj.inputFocus = false
        rateObj.inputFocus = false
        timesObj.inputFocus = false
        yearsObj.inputFocus = false
    }

}
