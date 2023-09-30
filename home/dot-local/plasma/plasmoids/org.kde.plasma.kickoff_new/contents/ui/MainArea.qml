/*
 *    Copyright 2014  Sebastian Kügler <sebas@kde.org>
 *    SPDX-FileCopyrightText: (C) 2020 Carl Schwan <carl@carlschwan.eu>
 *    Copyright (C) 2021 by Mikel Johnson <mikel5764@gmail.com>
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 2 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License along
 *    with this program; if not, write to the Free Software Foundation, Inc.,
 *    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

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

Rectangle {
    Rectangle {
        id: rightArea
        anchors {
            left:verticalSeparator.right
            right: parent.right
            top:parent.top
            bottom: parent.bottom
        }
        color: "#d3e5fa"
    }

    DefaultAppsView {
        anchors {
            left: parent.left
            right: verticalSeparator.left
            top: parent.top
            margins: Math.round(6 * PlasmaCore.Units.devicePixelRatio)
        }
    }

    FavoritesView {
        anchors {
            left: parent.left
            right: verticalSeparator.left
            top: parent.top
            bottom: parent.bottom
            margins: Math.round(6 * PlasmaCore.Units.devicePixelRatio)
        }
    }

    Rectangle {
        id: verticalSeparator
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: PlasmaCore.Units.devicePixelRatio
        anchors.left: parent.left
        anchors.leftMargin: Math.round(parent.width/2)
        color: "#95bdee"
    }

    Rectangle {
        id: topLine
        anchors {
            left:parent.left
            right: parent.right
            top:parent.top
        }
        height: 2 * PlasmaCore.Units.devicePixelRatio
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: "#ff8f25" }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }
}