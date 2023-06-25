/*
    SPDX-FileCopyrightText: 2016 David Edmundson <davidedmundson@kde.org>
    SPDX-FileCopyrightText: 2022 Aleix Pol Gonzalez <aleixpol@kde.org>

    SPDX-License-Identifier: LGPL-2.0-or-later
*/

import QtQuick 2.15
import QtQuick.Window 2.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

Rectangle {
    id: root

    property int currentIndex: keyboard.currentLayout
    onCurrentIndexChanged: keyboard.currentLayout = currentIndex

    visible: menu.count > 1

    height: 12 * Screen.devicePixelRatio
    width: 12 * Screen.devicePixelRatio

    color: "#316ac5"
    //color: "#fff"

    Text {
            color: "#fff"
            font.pointSize: 12
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            } 
            text: keyboard.layouts[currentIndex].shortName
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            menu.popup(root, 0, 0)
        }
    }

    signal keyboardLayoutChanged()

    PlasmaComponents.Menu {
        id: menu
        PlasmaCore.ColorScope.colorGroup: PlasmaCore.Theme.NormalColorGroup
        PlasmaCore.ColorScope.inherit: false

        Instantiator {
            id: instantiator
            model: {
                let layouts = keyboard.layouts;
                layouts.sort((a, b) => a.longName.localeCompare(b.longName));
                return layouts;
            }
            onObjectAdded: menu.insertItem(index, object)
            onObjectRemoved: menu.removeItem(object)
            delegate: PlasmaComponents.MenuItem {
                text: modelData.longName
                onTriggered: {
                    keyboard.currentLayout = keyboard.layouts.indexOf(modelData)
                    root.keyboardLayoutChanged()
                }
            }
        }
    }
}
