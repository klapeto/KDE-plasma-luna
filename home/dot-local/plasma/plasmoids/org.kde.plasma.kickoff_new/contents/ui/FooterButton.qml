import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kcoreaddons 1.0 as KCoreAddons
// While using Kirigami in applets is normally a no, we
// use Avatar, which doesn't need to read the colour scheme
// at all to function, so there won't be any oddities with colours.
import org.kde.kirigami 2.13 as Kirigami
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons

 MouseArea {
    id: rootArea
    property alias iconSource: icon.source
    property alias text: text.text

    hoverEnabled: true

    // signal clicked()
    // clicked: rootArea.clicked()
    width: icon.width + Math.round(20 * PlasmaCore.Units.devicePixelRatio) + text.width
    


    Rectangle { 
        id: hoverBg
        anchors {
            fill: parent
        }
        visible: rootArea. containsMouse
        color: "#316ac5"
    }

    Kirigami.Icon {
        id: icon
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            topMargin: Math.round(3 * PlasmaCore.Units.devicePixelRatio)
            bottomMargin: Math.round(3 * PlasmaCore.Units.devicePixelRatio)
            leftMargin: Math.round(3 * PlasmaCore.Units.devicePixelRatio)
        }
        width: height
    }
    Text {
        id: text
        anchors {
            left: icon.right
            leftMargin: Math.round(4 * PlasmaCore.Units.devicePixelRatio)
            verticalCenter: icon.verticalCenter
        }
        font.family: "Tahoma"
        font.pointSize: 8
        color: "white"
    }
}
