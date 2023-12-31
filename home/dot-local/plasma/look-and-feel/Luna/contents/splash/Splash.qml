import QtQuick 2.5


Image {
    id: root
    source: "images/background.png"

    property int stage

    
        Row {
            spacing: PlasmaCore.Units.smallSpacing*2
            anchors {
                bottom: parent.verticalCenter
                right: parent.horizontalCenter
                margins: PlasmaCore.Units.gridUnit
            }
            Text {
                color: "white"
                font.pointSize: 40
                font.family: "Tahoma"
                font.weight: Font.Bold
                font.italic: true
                //renderType: Text.QtRendering
                anchors.verticalCenter: parent.verticalCenter
                text: i18ndc("winxp_welcome_message", "welcome message", "welcome")
            }
        }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

    }
}
