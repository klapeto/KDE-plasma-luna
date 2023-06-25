/*
    SPDX-FileCopyrightText: 2016 David Edmundson <davidedmundson@kde.org>

    SPDX-License-Identifier: LGPL-2.0-or-later
*/

import QtQuick 2.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3

Item {
    id: root
    property alias text: label.text
    property alias iconSource: icon.source
    property alias containsMouse: mouseArea.containsMouse
    property alias font: label.font
    property alias labelRendering: label.renderType
    property int fontSize: PlasmaCore.Theme.defaultFont.pointSize + 1
    readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software
    signal clicked

    activeFocusOnTab: true

    property int iconSize: 24

    implicitWidth: (iconSize + PlasmaCore.Units.largeSpacing) + label.contentWidth
    implicitHeight: iconSize + PlasmaCore.Units.smallSpacing + label.implicitHeight

    opacity: activeFocus || containsMouse ? 1 : 0.85
    Behavior on opacity {
        PropertyAnimation { // OpacityAnimator makes it turn black at random intervals
            duration: PlasmaCore.Units.longDuration
            easing.type: Easing.InOutQuad
        }
    }

    Rectangle {
        anchors {
            top: icon.top
            left: icon.left
            topMargin: 1
            leftMargin: 1
        }
        width: icon.width
        height: icon.height
        color: "#162088"
        radius: 3
    }

    PlasmaCore.IconItem {
        id: icon
        anchors {
            top: parent.top
            verticalCenter: parent.verticalCenter
            left: parent.left
        }
        width: iconSize
        height: iconSize

        colorGroup: PlasmaCore.ColorScope.colorGroup
        active: mouseArea.containsMouse || root.activeFocus
    }

    PlasmaComponents3.Label {
        id: label
        font.pointSize: 14
        anchors {
            verticalCenter: icon.verticalCenter
            left: icon.right
            leftMargin: 8
        }
        font.family: "Tahoma"
        //font.weight: Font.DemiBold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        wrapMode: Text.WordWrap
        font.underline: root.activeFocus
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        onClicked: root.clicked()
        anchors.fill: parent
    }

    Keys.onEnterPressed: clicked()
    Keys.onReturnPressed: clicked()
    Keys.onSpacePressed: clicked()

    Accessible.onPressAction: clicked()
    Accessible.role: Accessible.Button
    Accessible.name: label.text
}
