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

    RejectPasswordAnimation {
        id: rejectPasswordAnimation
        target: mainStack
    }

    MouseArea {
        id: loginScreenRoot
        anchors.fill: parent

        property bool uiVisible: true
        property bool blockUI: mainStack.depth > 1 || userListComponent.mainPasswordBox.text.length > 0 || inputPanel.keyboardActive || config.type !== "image"

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
                        target: mainStack
                        y: Math.min(0, root.height - inputPanel.height - userListComponent.visibleBoundary)
                    }
                    PropertyChanges {
                        target: inputPanel
                        y: root.height - inputPanel.height
                        opacity: 1
                    }
                },
                State {
                    name: "hidden"
                    PropertyChanges {
                        target: mainStack
                        y: 0
                    }
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
                                target: mainStack
                                property: "y"
                                duration: PlasmaCore.Units.longDuration
                                easing.type: Easing.InOutQuad
                            }
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
                                target: mainStack
                                property: "y"
                                duration: PlasmaCore.Units.longDuration
                                easing.type: Easing.InOutQuad
                            }
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
/*
        Component {
            id: userPromptComponent
            Login {
                showUsernamePrompt: true
                notificationMessage: root.notificationMessage
                loginScreenUiVisible: loginScreenRoot.uiVisible
                fontSize: parseInt(config.fontSize) + 2

                // using a model rather than a QObject list to avoid QTBUG-75900
                userListModel: ListModel {
                    ListElement {
                        name: ""
                        iconSource: ""
                    }
                    Component.onCompleted: {
                        // as we can't bind inside ListElement
                        setProperty(0, "name", i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Type in Username and Password"));
                    }
                }

                onLoginRequest: {
                    root.notificationMessage = ""
                    sddm.login(username, password, sessionButton.currentIndex)
                }

                actionItemsVisible: !inputPanel.keyboardActive
                actionItems: [
                    ActionButton {
                        iconSource: "system-suspend"
                        text: i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "Suspend to RAM", "Sleep")
                        fontSize: parseInt(config.fontSize) + 1
                        onClicked: sddm.suspend()
                        enabled: sddm.canSuspend
                    },
                    ActionButton {
                        iconSource: "system-reboot"
                        text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Restart")
                        fontSize: parseInt(config.fontSize) + 1
                        onClicked: sddm.reboot()
                        enabled: sddm.canReboot
                    },
                    ActionButton {
                        iconSource: "system-shutdown"
                        text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Shut Down")
                        fontSize: parseInt(config.fontSize) + 1
                        onClicked: sddm.powerOff()
                        enabled: sddm.canPowerOff
                    },
                    ActionButton {
                        iconSource: "system-user-list"
                        text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "List Users")
                        fontSize: parseInt(config.fontSize) + 1
                        onClicked: mainStack.pop()
                    }
                ]
            }
        }
*/
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
                    rightMargin: Math.round(20 * Screen.devicePixelRatio)
                    verticalCenter: parent.verticalCenter
                }

                source: config.logo
                asynchronous: true
                sourceSize.height: height
                fillMode: Image.PreserveAspectFit
                height: Math.round(48 * Screen.devicePixelRatio)
            }

            Text {
                anchors {
                    right: separator.left
                    rightMargin: Math.round(20 * Screen.devicePixelRatio)
                    topMargin: Math.round(28 * Screen.devicePixelRatio)
                    top: logo.bottom
                }
                color: "#eff7ff"
                font.family: "Tahoma"
                font.pixelSize: 14
                text: "To begin, click your username"
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
                    // top: parent.top
                    // bottom: parent.bottom
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

            height: 96

            RowLayout {
            id: footer
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                top: parent.top
                leftMargin: 40
                rightMargin: 60
                bottomMargin: 20
            }

            spacing: 10

            Behavior on opacity {
                OpacityAnimator {
                    duration: PlasmaCore.Units.longDuration
                }
            }

            ActionButton {
                iconSource: "system-shutdown"
                text: i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Shut Down")
                fontSize: parseInt(config.fontSize) + 1
                onClicked: sddm.powerOff()
                enabled: sddm.canPowerOff
           }

            PlasmaComponents3.ToolButton {
                text: i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "Button to show/hide virtual keyboard", "Virtual Keyboard")
                font.pointSize: config.fontSize
                icon.name: inputPanel.keyboardActive ? "input-keyboard-virtual-on" : "input-keyboard-virtual-off"
                onClicked: inputPanel.showHide()
                visible: inputPanel.status === Loader.Ready
            }

            SessionButton {
                id: sessionButton
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
                color: "#eff7ff"
                font.family: "Tahoma"
                font.pixelSize: 14
                text: "After you logon, you can add or change accounts.\nJust go to Control Panel and click User Accounts."
            }

        }
    }


        }

    Connections {
        target: sddm
        function onLoginFailed() {
            notificationMessage = i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Login Failed")
            footer.enabled = true
            mainStack.enabled = true
            userListComponent.userList.opacity = 1
            rejectPasswordAnimation.start()
        }
        function onLoginSucceeded() {
            //note SDDM will kill the greeter at some random point after this
            //there is no certainty any transition will finish, it depends on the time it
            //takes to complete the init
            mainStack.opacity = 0
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
