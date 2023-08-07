/*
    SPDX-FileCopyrightText: 2016 David Edmundson <davidedmundson@kde.org>

    SPDX-License-Identifier: LGPL-2.0-or-later
*/

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import QtGraphicalEffects 1.15
import QtQuick.Window 2.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras

import "components"
import "components/animation"

// TODO: Once SDDM 0.19 is released and we are setting the font size using the
// SDDM KCM's syncing feature, remove the `config.fontSize` overrides here and
// the fontSize properties in various components, because the theme's default
// font size will be correctly propagated to the login screen

Image {
    id: root

    // If we're using software rendering, draw outlines instead of shadows
    // See https://bugs.kde.org/show_bug.cgi?id=398317
    readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software

    source: "center.svg"

    width: 1600
    height: 900

    property string notificationMessage

    LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    PlasmaCore.DataSource {
        id: keystateSource
        engine: "keystate"
        connectedSources: "Caps Lock"
    }

    MouseArea {
        id: loginScreenRoot
        anchors.fill: parent

        property bool uiVisible: true
        property bool blockUI: inputPanel.keyboardActive || config.type !== "image"

        hoverEnabled: true
        drag.filterChildren: true
        onPressed: uiVisible = true;
        onPositionChanged: uiVisible = true;
        onUiVisibleChanged: {
            if (blockUI) {
                fadeoutTimer.running = false;
            } else if (uiVisible) {
                fadeoutTimer.restart();
            }
        }
        onBlockUIChanged: {
            if (blockUI) {
                fadeoutTimer.running = false;
                uiVisible = true;
            } else {
                fadeoutTimer.restart();
            }
        }

        Keys.onPressed: {
            uiVisible = true;
            event.accepted = false;
        }

        //takes one full minute for the ui to disappear
        Timer {
            id: fadeoutTimer
            running: true
            interval: 60000
            onTriggered: {
                if (!loginScreenRoot.blockUI) {
                    loginScreenRoot.uiVisible = false;
                }
            }
        }

        Loader {
            id: inputPanel
            state: "hidden"
            property bool keyboardActive: item ? item.active : false
            onKeyboardActiveChanged: {
                if (keyboardActive) {
                    state = "visible"
                    // Otherwise the password field loses focus and virtual keyboard
                    // keystrokes get eaten
                    userListComponent.mainPasswordBox.forceActiveFocus();
                } else {
                    state = "hidden";
                }
            }

            source: Qt.platform.pluginName.includes("wayland") ? "components/VirtualKeyboard_wayland.qml" : "components/VirtualKeyboard.qml"
            anchors {
                left: parent.left
                right: parent.right
            }

            function showHide() {
                state = state === "hidden" ? "visible" : "hidden";
            }

            states: [
                State {
                    name: "visible"
                    PropertyChanges {
                        target: inputPanel
                        y: root.height - inputPanel.height
                        opacity: 1
                    }
                },
                State {
                    name: "hidden"
                    PropertyChanges {
                        target: inputPanel
                        y: root.height - root.height/4
                        opacity: 0
                    }
                }
            ]
            transitions: [
                Transition {
                    from: "hidden"
                    to: "visible"
                    SequentialAnimation {
                        ScriptAction {
                            script: {
                                inputPanel.item.activated = true;
                                Qt.inputMethod.show();
                            }
                        }
                        ParallelAnimation {
                            NumberAnimation {
                                target: inputPanel
                                property: "y"
                                duration: PlasmaCore.Units.longDuration
                                easing.type: Easing.OutQuad
                            }
                            OpacityAnimator {
                                target: inputPanel
                                duration: PlasmaCore.Units.longDuration
                                easing.type: Easing.OutQuad
                            }
                        }
                    }
                },
                Transition {
                    from: "visible"
                    to: "hidden"
                    SequentialAnimation {
                        ParallelAnimation {
                            NumberAnimation {
                                target: inputPanel
                                property: "y"
                                duration: PlasmaCore.Units.longDuration
                                easing.type: Easing.InQuad
                            }
                            OpacityAnimator {
                                target: inputPanel
                                duration: PlasmaCore.Units.longDuration
                                easing.type: Easing.InQuad
                            }
                        }
                        ScriptAction {
                            script: {
                                inputPanel.item.activated = false;
                                Qt.inputMethod.hide();
                            }
                        }
                    }
                }
            ]
        }

        Image {
            id: header
            source: "top.svg"

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            height: 80
        }

        Item {
            anchors {
                top: header.bottom
                bottom: footerImage.top
                left: parent.left
                right: parent.right
            }

            Image {
                id: logo
                anchors {
                    right: separator.left
                    rightMargin: 20
                    verticalCenter: parent.verticalCenter
                }

                source: config.logo
                asynchronous: true
                sourceSize.height: height
                fillMode: Image.PreserveAspectFit
                height: 81
            }

            Text {
                anchors {
                    right: separator.left
                    rightMargin: 43
                    topMargin: 23
                    top: logo.bottom
                }
                width: 327
                color: "#eff7ff"
                font.family: "Tahoma"
                font.pixelSize: 15
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignRight
                text: "Για να ξεκινήσετε, κάντε κλικ στο δικό σας όνομα χρήστη"
            }

            Image {
                id: separator

                anchors {
                    horizontalCenter: parent.horizontalCenter
                }

                source: "separator.svg"
                asynchronous: true

                //fillMode: Image.PreserveAspectFit
                height: parent.height
                width: 1 * Screen.devicePixelRatio
            }

            Login {
                anchors {
                    left: separator.right
                    right: parent.right
                    leftMargin: Math.round(20 * Screen.devicePixelRatio)
                    verticalCenter: parent.verticalCenter
                }
                height: (Math.round(48 * Screen.devicePixelRatio) + 20) * userModel.count //hack

                id: userListComponent
                userListModel: userModel
                loginScreenUiVisible: loginScreenRoot.uiVisible
                userListCurrentIndex: -1
                //lastUserName: userModel.lastUser
                showUserList: {
                    if (!userListModel.hasOwnProperty("count")
                        || !userListModel.hasOwnProperty("disableAvatarsThreshold")) {
                        return false
                    }

                    if (userListModel.count === 0 ) {
                        return false
                    }

                    if (userListModel.hasOwnProperty("containsAllUsers") && !userListModel.containsAllUsers) {
                        return false
                    }

                    return userListModel.count <= userListModel.disableAvatarsThreshold
                }

                notificationMessage: {
                    const parts = [];
                    if (keystateSource.data["Caps Lock"]["Locked"]) {
                        parts.push(i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Caps Lock is on"));
                    }
                    if (root.notificationMessage) {
                        parts.push(root.notificationMessage);
                    }
                    return parts.join(" • ");
                }

                onLoginRequest: {
                    root.notificationMessage = ""
                    sddm.login(username, password, sessionButton.currentIndex)
                }
            }

            Rectangle {
                height: parent.height
                Layout.fillWidth: true
            }
        }

        //Footer
        Image {
            id: footerImage
            source: "bottom.svg"

            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            height: 98

            RowLayout {
                id: footer
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    leftMargin: 40
                    rightMargin: 60
                }

                spacing: 10

                Behavior on opacity {
                    OpacityAnimator {
                        duration: PlasmaCore.Units.longDuration
                    }
                }

                ActionButton {
                    Layout.preferredHeight: 24
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 22
                    iconSource: "system-shutdown"
                    text: "Σβήσιμο του υπολογιστή"
                    fontSize: 20
                    onClicked: sddm.powerOff()
                    enabled: sddm.canPowerOff
                }

                PlasmaComponents3.ToolButton {
                                        Layout.preferredHeight: 24
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 22
                    text: i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "Button to show/hide virtual keyboard", "Virtual Keyboard")
                    font.pointSize: config.fontSize
                    icon.name: inputPanel.keyboardActive ? "input-keyboard-virtual-on" : "input-keyboard-virtual-off"
                    onClicked: inputPanel.showHide()
                    visible: inputPanel.status === Loader.Ready
                }

                SessionButton {
                    id: sessionButton
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 22

                    font.pointSize: config.fontSize

                    onSessionChanged: {
                        // Otherwise the password field loses focus and virtual keyboard
                        // keystrokes get eaten
                        userListComponent.mainPasswordBox.forceActiveFocus();
                    }
                }

                Battery {
                    fontSize: config.fontSize
                }

                Item {
                    Layout.fillWidth: true
                }

                Text {
                    Layout.preferredWidth: 276
                    color: "#eff7ff"
                    font.family: "Tahoma"
                    font.pointSize: 9
                    wrapMode: Text.WordWrap
                    text: "Αφού συνδεθείτε, μπορείτε να προσθέσετε ή να αλλάξετε λογαριασμούς.\nΠηγαίνετε στον Πίνακα Ελέγχου και κάντε κλίκ στην επιλογή \"Λογαριασμοί χρηστών\"."
                    //text: "After you logon, you can add or change accounts.\nJust go to Control Panel and click User Accounts."
                }
            }
        }
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            notificationMessage = i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Login Failed")
            footer.enabled = true
            rejectPasswordAnimation.start()
        }
        function onLoginSucceeded() {
            //note SDDM will kill the greeter at some random point after this
            //there is no certainty any transition will finish, it depends on the time it
            //takes to complete the init
            footer.opacity = 0
        }
    }

    onNotificationMessageChanged: {
        if (notificationMessage) {
            notificationResetTimer.start();
        }
    }

    Timer {
        id: notificationResetTimer
        interval: 3000
        onTriggered: notificationMessage = ""
    }
}
