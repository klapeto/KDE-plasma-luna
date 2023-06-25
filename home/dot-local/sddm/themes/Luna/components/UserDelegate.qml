/*
    SPDX-FileCopyrightText: 2014 David Edmundson <davidedmundson@kde.org>
    SPDX-FileCopyrightText: 2014 Aleix Pol Gonzalez <aleixpol@blue-systems.com>

    SPDX-License-Identifier: LGPL-2.0-or-later
*/

import QtQuick 2.15
import QtQuick.Window 2.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item {
    id: wrapper

    //color: isCurrent ? "red" : "white"
    // If we're using software rendering, draw outlines instead of shadows
    // See https://bugs.kde.org/show_bug.cgi?id=398317
    readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software

    property bool isCurrent: true

    property string name
    property string userName
    property string avatarPath
    property string iconSource
    property bool needsPassword
    property var vtNumber
    property bool constrainText: true
    property alias nameFontSize: usernameDelegate.font.pointSize
    property int fontSize: PlasmaCore.Theme.defaultFont.pointSize + 2
    signal clicked()

    signal loginRequest(string username, string password)

    opacity: isCurrent ? 1.0 : 0.5 

    property real faceSize: 256

    Behavior on opacity {
        OpacityAnimator {
            duration: PlasmaCore.Units.longDuration
        }
    }

    Image {
        anchors {
            fill: parent
        }
        visible: isCurrent
        source: "../selected-user.svg"
        sourceSize: Qt.size(width, height)
        fillMode: Image.PreserveAspectFit
        horizontalAlignment: Image.AlignLeft
        verticalAlignment: Image.AlignTop
    }

    // Draw a translucent background circle under the user picture
    Rectangle {
        id: imageWrapper
        anchors.centerIn: imageSource
        width: imageSource.width + 4
        height: imageSource.height + 4
        radius: 4

        color: isCurrent ? "#ffb600" : "#cad2ea"
    }

    Item {
        id: imageSource
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            leftMargin: 12
            topMargin: 11
            bottomMargin: 11
        }

        Behavior on width {
            PropertyAnimation {
                from: faceSize
                duration: PlasmaCore.Units.longDuration;
            }
        }
        width: height

        //Image takes priority, taking a full path to a file, if that doesn't exist we show an icon
        Image {
            id: face
            source: wrapper.avatarPath
            sourceSize: Qt.size(faceSize, faceSize)
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
        }

        PlasmaCore.IconItem {
            id: faceIcon
            source: iconSource
            visible: (face.status == Image.Error || face.status == Image.Null)
            anchors.fill: parent
            colorGroup: PlasmaCore.ColorScope.colorGroup
        }
    }

    PlasmaComponents3.Label {
        id: usernameDelegate

        anchors {
            left: imageWrapper.right
            top: parent.top
            leftMargin: 12
            topMargin: 5
        }

        // Make it bigger than other fonts to match the scale of the avatar better
        font.pointSize: 12
        font.family: "Tahoma"
        font.letterSpacing: 0
        color: "#eff7ff"

        text: wrapper.name
        wrapMode: Text.WordWrap
        maximumLineCount: wrapper.constrainText ? 3 : 1
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignLeft
        //make an indication that this has active focus, this only happens when reached with keyboard navigation
        font.underline: wrapper.activeFocus
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: wrapper.clicked()
    }

    Text {
        id: typePasswordText
        anchors {
            left: imageWrapper.right
            top: parent.top
            topMargin: 33
            leftMargin: 12
        }

        visible: isCurrent
        font.pointSize: 8
        font.family: "Tahoma"
        color: "#eff7ff"
        text: "Πληκτρολογήστε τον κωδικό σας"
    }

    Rectangle {
        anchors {
            left: passwordContainer.left
            top: passwordContainer.top
            topMargin: 2
            leftMargin: 2
        }

        antialiasing: true

        visible: isCurrent

        height: passwordContainer.height
        width: passwordContainer.width

        radius: 3

        gradient: Gradient {
            GradientStop { position: 0.9; color: "#1e4cae" }
             GradientStop { position: 1.0; color: "#2d59b8" }
        }
    }

    Rectangle {
        height: 27
        id: passwordContainer
        anchors {
            left: imageWrapper.right
            right: typePasswordText.right
            top: typePasswordText.bottom
            topMargin: 3
            leftMargin: 9
        }

        radius: 3
        color: control.enabled ? "transparent" : "#353637"
        border.color: "transparent"

        visible: isCurrent

        PlasmaExtras.PasswordField {
            id: passwordBox

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 9
            }

            color: "black"

            placeholderText: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Password")
            focus: isCurrent

            // Disable reveal password action because SDDM does not have the breeze icon set loaded
            rightActions: []

            onAccepted: {
                if (root.loginScreenUiVisible) {
                    startLogin();
                }
            }

            background: Rectangle {
                color: "transparent"
                border.color: "transparent"
            }

            Keys.onEscapePressed: {
                mainStack.currentItem.forceActiveFocus();
            }

            //if empty and left or right is pressed change selection in user switch
            //this cannot be in keys.onLeftPressed as then it doesn't reach the password box
            Keys.onPressed: {
                if (event.key === Qt.Key_Left && !text) {
                    userList.decrementCurrentIndex();
                    event.accepted = true
                }
                if (event.key === Qt.Key_Right && !text) {
                    userList.incrementCurrentIndex();
                    event.accepted = true
                }
            }

            Connections {
                target: sddm
                function onLoginFailed() {
                    passwordBox.selectAll()
                    passwordBox.forceActiveFocus()
                }
            }
        }
    }

     KeyboardButton {
        id: keyboardButton
        anchors {
            verticalCenter: passwordContainer.verticalCenter
            left: passwordContainer.right
            leftMargin: 7
        }

        visible: isCurrent

        onKeyboardLayoutChanged: {
            // Otherwise the password field loses focus and virtual keyboard
            // keystrokes get eaten
            passwordBox.forceActiveFocus();
        }
    }

    Rectangle {
        anchors {
            left: loginButton.left
            top: loginButton.top
            topMargin: 2
            leftMargin: 2
        }

        visible: isCurrent

        height: loginButton.height
        width: loginButton.width

        radius: 3
            
        gradient: Gradient {
            GradientStop { position: 0.9; color: "#1e4cae" }
            GradientStop { position: 1.0; color: "#2d59b8" }
        }
    }

    PlasmaComponents3.Button {
        id: loginButton

        anchors {
            top: passwordContainer.top
            bottom: passwordContainer.bottom
            left: keyboardButton.right
            leftMargin: 5
        }

        width: height
        visible: isCurrent

        Accessible.name: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Log In")

        Image {
            source: "../enter.svg"
            anchors.fill: parent
        }
        //icon.name: text.length === 0 ? (root.LayoutMirroring.enabled ? "go-previous" : "go-next") : ""

        onClicked: startLogin()
        Keys.onEnterPressed: clicked()
        Keys.onReturnPressed: clicked()
    }

    function startLogin() {
        const username = userName
        const password = passwordBox.text

        // This is partly because it looks nicer, but more importantly it
        // works round a Qt bug that can trigger if the app is closed with a
        // TextField focused.
        //
        // See https://bugreports.qt.io/browse/QTBUG-55460
        //loginButton.forceActiveFocus();
        loginRequest(username, password);
    }

    Keys.onSpacePressed: wrapper.clicked()

    Accessible.name: name
    Accessible.role: Accessible.Button
    function accessiblePressAction() { wrapper.clicked() }
}
