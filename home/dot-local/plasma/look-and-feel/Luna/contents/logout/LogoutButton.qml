/*
    SPDX-FileCopyrightText: 2016 Marco Martin <mart@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick 2.2
import QtQuick.Layouts 1.2

import org.kde.plasma.core 2.0 as PlasmaCore

import "../components"
import "timer.js" as AutoTriggerTimer

ActionButton {
    property var action

    Layout.alignment: Qt.AlignTop

    iconSize: 32

    labelRendering: Text.QtRendering // Remove once we've solved Qt bug: https://bugreports.qt.io/browse/QTBUG-70138 (KDE bug: https://bugs.kde.org/show_bug.cgi?id=401644)
    font.underline: false
    font.pointSize: 8
    font.weight: Font.DemiBold
    font.family: "Tahoma"

    circleVisiblity: activeFocus || containsMouse
    circleOpacity: 0.15 // Selected option's circle is instantly visible
    opacity: 1.0
    Behavior on opacity {
        PropertyAnimation { // OpacityAnimator makes it turn black at random intervals
            duration: PlasmaCore.Units.longDuration
            easing.type: Easing.InOutQuad
        }
    }

    Keys.onPressed: {
        AutoTriggerTimer.cancelAutoTrigger();
    }

    onClicked: {
        action()
    }
}
