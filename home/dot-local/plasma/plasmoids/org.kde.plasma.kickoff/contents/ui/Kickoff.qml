/*
    Copyright (C) 2011  Martin Gräßlin <mgraesslin@kde.org>
    Copyright (C) 2012  Gregor Taetzner <gregor@freenet.de>
    Copyright (C) 2012  Marco Martin <mart@kde.org>
    Copyright (C) 2013  David Edmundson <davidedmundson@kde.org>
    Copyright (C) 2015  Eike Hein <hein@kde.org>
    Copyright (C) 2021 by Mikel Johnson <mikel5764@gmail.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/
import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.15

import org.kde.plasma.plasmoid 2.0 as PlasmaPlasmoid
import org.kde.plasma.core 2.0 as PlasmaCore

import org.kde.plasma.private.kicker 0.1 as Kicker

Item {
    id: kickoff

    readonly property bool inPanel: (plasmoid.location === PlasmaCore.Types.TopEdge
        || plasmoid.location === PlasmaCore.Types.RightEdge
        || plasmoid.location === PlasmaCore.Types.BottomEdge
        || plasmoid.location === PlasmaCore.Types.LeftEdge)
    readonly property bool vertical: (plasmoid.formFactor === PlasmaCore.Types.Vertical)

    PlasmaPlasmoid.Plasmoid.switchWidth: PlasmaCore.Units.gridUnit * 28
    PlasmaPlasmoid.Plasmoid.switchHeight: PlasmaCore.Units.gridUnit * 20

    PlasmaPlasmoid.Plasmoid.fullRepresentation: FullRepresentation {}
    
    PlasmaPlasmoid.Plasmoid.constraintHints: PlasmaCore.Types.CanFillArea
    
    PlasmaPlasmoid.Plasmoid.icon: plasmoid.configuration.icon

    PlasmaPlasmoid.Plasmoid.compactRepresentation: MouseArea {
        id: compactRoot

        hoverEnabled: true
        onClicked: plasmoid.expanded = !plasmoid.expanded

        property double buttonAspectRatio: 4
        
        property double itemsBaseMargin: 4.0
        
        property double targetScale: PlasmaCore.Units.devicePixelRatio;
        
        property bool pressed: false

        property string buttonText: "έναρξη"
        
        Layout.minimumWidth: Math.round(parent.height * buttonAspectRatio)
        
        DropArea {
            id: compactDragArea
            anchors.fill: parent
        }
        
        
        onPressed: {
            if (mouse.button == Qt.LeftButton) {
                pressed = true;
                bgFrame.basePrefix = "Pressed"
            }
        }
        
        onContainsMouseChanged:  {
            if (containsMouse) {
               bgFrame.basePrefix = "Hover"
            } else {
                pressed = false;
                bgFrame.basePrefix = "Normal"
            }
        }
        
         onReleased: {
             if (pressed) {
                bgFrame.basePrefix = "Normal"
             }
             pressed = false;
        }

        Timer {
            id: expandOnDragTimer
            // this is an interaction and not an animation, so we want it as a constant
            interval: 250
            running: compactDragArea.containsDrag
            onTriggered: plasmoid.expanded = true
        }
        
        FrameSvgAdv {
            id: bgFrame
            borderSize: 6.0
            image: "icons/start-bg"
            basePrefix: "Normal"
        }
        
        Item {

            id: container

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                bottom: parent.bottom
                topMargin: Math.round(2 * targetScale)
                bottomMargin: Math.round(3 * targetScale)
            }

            width: icon.width + label.contentWidth + Math.round(20 * targetScale)

            Image {
                id: icon

                readonly property double aspectRatio: (vertical ? implicitHeight / implicitWidth
                        : implicitWidth / implicitHeight)

                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                    topMargin: Math.round(3 * targetScale)
                    bottomMargin: Math.round(3 * targetScale)
                }
                sourceSize.width: height
                sourceSize.height: height
                width: height
                source: "./assets/windows-logo.svg"
                smooth: true
            }

            Text {
                id: label
                anchors {
                    left: icon.right
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                    topMargin: Math.round(1 * targetScale)
                    bottomMargin: Math.round(1 * targetScale)
                    leftMargin: Math.round(6 * targetScale)
                }
                text: buttonText
                font.italic: true
                font.family: "Franklin Gothic Medium"
                font.pointSize: 72
                font.letterSpacing: -0.5
                fontSizeMode: Text.VerticalFit;
                //font.hintingPreference: Text.PreferFullHinting
                minimumPixelSize: 10
                verticalAlignment: Text.AlignVCenter

                color: "white"
            }

            DropShadow {
                anchors.fill: icon
                horizontalOffset: 1
                verticalOffset: 2
                radius: Math.ceil(2 + targetScale)
                samples: 9
                color: "#80000000"
                source: icon
            }

            DropShadow {
                anchors.fill: label
                horizontalOffset: 1
                verticalOffset: 1
                radius: Math.ceil(3 + targetScale)
                samples: 9
                color: "#ff000000"
                source: label
            }
        }
        
    }

    property Item dragSource: null

    Kicker.ProcessRunner {
        id: processRunner;
    }

    function action_menuedit() {
        processRunner.runMenuEditor();
    }

    Component.onCompleted: {
        if (plasmoid.hasOwnProperty("activationTogglesExpanded")) {
            plasmoid.activationTogglesExpanded = true
        }
        if (plasmoid.immutability !== PlasmaCore.Types.SystemImmutable) {
            plasmoid.setAction("menuedit", i18n("Edit Applications..."), "kmenuedit");
        }
    }
} // root
