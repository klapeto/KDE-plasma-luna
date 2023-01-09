/*
    SPDX-FileCopyrightText: 2012 Martin Gräßlin <mgraesslin@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/
import QtQuick 2.0
import org.kde.kwin.decoration 0.1
import org.kde.plasma.core 2.0 as PlasmaCore

Decoration {
    id: root
    property bool animate: false
    Component.onCompleted: {
        borders.left   = Qt.binding(function() { return Math.max(0, auroraeTheme.borderLeft);});
        borders.right  = Qt.binding(function() { return Math.max(0, auroraeTheme.borderRight);});
        borders.top    = Qt.binding(function() { return Math.max(0, auroraeTheme.borderTop);});
        borders.bottom = Qt.binding(function() { return Math.max(0, auroraeTheme.borderBottom);});
        maximizedBorders.left   = Qt.binding(function() { return Math.max(0, auroraeTheme.borderLeftMaximized);});
        maximizedBorders.right  = Qt.binding(function() { return Math.max(0, auroraeTheme.borderRightMaximized);});
        maximizedBorders.bottom = Qt.binding(function() { return Math.max(0, auroraeTheme.borderBottomMaximized);});
        maximizedBorders.top    = Qt.binding(function() { return Math.max(0, auroraeTheme.borderTopMaximized);});
        padding.left   = auroraeTheme.paddingLeft;
        padding.right  = auroraeTheme.paddingRight;
        padding.bottom = auroraeTheme.paddingBottom;
        padding.top    = auroraeTheme.paddingTop;
        root.animate = true;
    }
    DecorationOptions {
        id: options
        deco: decoration
    }
    Item {
        id: titleRect
        x: decoration.client.maximized ? maximizedBorders.left : borders.left
        y: decoration.client.maximized ? 0 : root.borders.bottom
        width: decoration.client.width//parent.width - x - (decoration.client.maximized ? maximizedBorders.right : borders.right)
        height: decoration.client.maximized ? maximizedBorders.top : borders.top
        Component.onCompleted: {
            decoration.installTitleItem(titleRect);
        }
    }
    PlasmaCore.FrameSvg {
        property bool supportsInactive: true //hasElementPrefix("decoration-inactive")
        property bool supportsMaximized: true //hasElementPrefix("decoration-maximized")
        property bool supportsMaximizedInactive: true //hasElementPrefix("decoration-maximized-inactive")
        property bool supportsInnerBorder: hasElementPrefix("innerborder")
        property bool supportsInnerBorderInactive: hasElementPrefix("innerborder-inactive")
        id: backgroundSvg
        imagePath: auroraeTheme.decorationPath
    }
    
    
    
    //==============================
    // Active
    //==============================
    
    Item {
        id: decorationActiveContainer
        property bool shown: (!decoration.client.maximized || !backgroundSvg.supportsMaximized) && (decoration.client.active || !backgroundSvg.supportsInactive)
        anchors.fill: parent
        opacity: shown ? 1 : 0
        
        PlasmaCore.FrameSvgItem {
            id: decorationActiveBarLeft
    
            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
        
            width: Math.round(29 * PlasmaCore.Units.devicePixelRatio)
            height: borders.top
        
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBarLeft"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationActiveBarRight
        
            anchors {
                right: parent.right
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
        
            width: Math.round(29 * PlasmaCore.Units.devicePixelRatio)
            height: borders.top
            
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBarRight"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationActiveBarTop
        
            anchors {
                left: decorationActiveBarLeft.right
                right: decorationActiveBarRight.left
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            height: borders.top
            
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBarCenter"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationActiveBorderLeft
        
            
            anchors {
                left: parent.left
                top: decorationActiveBarLeft.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.left
            height: parent.height - borders.top - borders.bottom
            
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBorderLeft"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationActiveBorderRight
            
            anchors {
                right: parent.right
                top: decorationActiveBarLeft.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.right
            height: parent.height - borders.top - borders.bottom
            
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBorderRight"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationActiveBorderBottomRight
            
            anchors {
                right: parent.right
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.right
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBorderBottomRight"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationActiveBorderBottomLeft
            
            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.left
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBorderBottomLeft"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationActiveBorderBottom
            
            anchors {
                left: decorationActiveBorderBottomLeft.right
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: parent.width - borders.right - borders.left
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveBorderBottom"

        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationActiveCenter
        
            anchors {
                left: decorationActiveBorderLeft.right
                right: decorationActiveBorderRight.left
                top: decorationActiveBarTop.bottom
                bottom: decorationActiveBorderBottom.Top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
        
            imagePath: backgroundSvg.imagePath
            prefix: "ActiveWindow"
        }
    
        
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
        
    }

    
    
    //==============================
    // Inactive
    //==============================
    
    Item {
        id: decorationInactiveContainer
        anchors.fill: parent
        opacity: (!decoration.client.active && backgroundSvg.supportsInactive) ? 1 : 0
        
        PlasmaCore.FrameSvgItem {
            id: decorationInactiveBarLeft
            
            anchors {
                left: parent.left
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: Math.round(29 * PlasmaCore.Units.devicePixelRatio)
            height: borders.top
            
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBarLeft"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationInactiveBarRight
            anchors {
                right: parent.right
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: Math.round(29 * PlasmaCore.Units.devicePixelRatio)
            height: borders.top
            
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBarRight"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationInactiveBarTop
            
            anchors {
                left: decorationInactiveBarLeft.right
                right: decorationInactiveBarRight.left
                top: parent.top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            height: borders.top
            
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBarCenter"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationInactiveBorderLeft
            
            anchors {
                left: parent.left
                top: decorationInactiveBarLeft.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.left
            height: parent.height - borders.top - borders.bottom
            
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBorderLeft"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationInactiveBorderRight
        
            anchors {
                right: parent.right
                top: decorationInactiveBarLeft.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.right
            height: parent.height - borders.top - borders.bottom
            
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBorderRight"
        }
        
        
        PlasmaCore.FrameSvgItem {
            id: decorationInactiveBorderBottomRight
            
            anchors {
                right: parent.right
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.right
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBorderBottomRight"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationInactiveBorderBottomLeft
            
            anchors {
                left: parent.left
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: borders.left
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBorderBottomLeft"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationInactiveBorderBottom
            
            anchors {
                left: decorationInactiveBorderBottomLeft.right
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
            
            width: parent.width - borders.right - borders.left
            height: borders.bottom
        
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveBorderBottom"
        }
        
        PlasmaCore.FrameSvgItem {
            id: decorationInactiveCenter
            
            anchors {
                left: decorationInactiveBorderLeft.right
                right: decorationInactiveBorderRight.left
                top: decorationInactiveBarTop.bottom
                bottom: decorationInactiveBorderBottom.Top
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
            }
        
            imagePath: backgroundSvg.imagePath
            prefix: "InactiveWindow"
        }
        
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    

    
    //==============================
    // Maximized Active
    //==============================
    
    PlasmaCore.FrameSvgItem {
        id: decorationActiveMaximizedBarLeft
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: Math.round(29 * PlasmaCore.Units.devicePixelRatio)
        
        imagePath: backgroundSvg.imagePath
        prefix: "ActiveMaximizedBarLeft"
        height: parent.maximizedBorders.top
        opacity: shown ? 1 : 0
        enabledBorders: PlasmaCore.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    
    PlasmaCore.FrameSvgItem {
        id: decorationActiveMaximizedBarRight
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            right: parent.right
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: Math.round(29 * PlasmaCore.Units.devicePixelRatio)
        
        imagePath: backgroundSvg.imagePath
        prefix: "ActiveMaximizedBarRight"
        height: parent.maximizedBorders.top
        opacity: shown ? 1 : 0
        enabledBorders: PlasmaCore.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }

    
    PlasmaCore.FrameSvgItem {
        id: decorationActiveMaximizedBarTop
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            left: decorationActiveMaximizedBarLeft.right
            right: decorationActiveMaximizedBarRight.left
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: Math.round(29 * PlasmaCore.Units.devicePixelRatio)
        
        imagePath: backgroundSvg.imagePath
        prefix: "ActiveMaximizedBarCenter"
        height: parent.maximizedBorders.top
        opacity: shown ? 1 : 0
        enabledBorders: PlasmaCore.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    
    
    //==============================
    // Maximized Inactive
    //==============================

    
    PlasmaCore.FrameSvgItem {
        id: decorationInactiveMaximizedBarLeft
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: Math.round(29 * PlasmaCore.Units.devicePixelRatio)
        
        imagePath: backgroundSvg.imagePath
        prefix: "InactiveMaximizedBarLeft"
        height: parent.maximizedBorders.top
        opacity: (!decoration.client.active && decoration.client.maximized && backgroundSvg.supportsMaximizedInactive) ? 1 : 0
        enabledBorders: PlasmaCore.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    
    PlasmaCore.FrameSvgItem {
        id: decorationInactiveMaximizedBarRight
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            right: parent.right
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: Math.round(29 * PlasmaCore.Units.devicePixelRatio)
        
        imagePath: backgroundSvg.imagePath
        prefix: "InactiveMaximizedBarRight"
        height: parent.maximizedBorders.top
        opacity: (!decoration.client.active && decoration.client.maximized && backgroundSvg.supportsMaximizedInactive) ? 1 : 0
        enabledBorders: PlasmaCore.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }

    
    PlasmaCore.FrameSvgItem {
        id: decorationInactiveMaximizedBarTop
        property bool shown: decoration.client.maximized && backgroundSvg.supportsMaximized && (decoration.client.active || !backgroundSvg.supportsMaximizedInactive)
        
        anchors {
            left: decorationInactiveMaximizedBarLeft.right
            right: decorationInactiveMaximizedBarRight.left
            top: parent.top
            leftMargin: 0
            rightMargin: 0
            topMargin: 0
        }
        
        width: Math.round(29 * PlasmaCore.Units.devicePixelRatio)
        
        imagePath: backgroundSvg.imagePath
        prefix: "InactiveMaximizedBarCenter"
        height: parent.maximizedBorders.top
        opacity: (!decoration.client.active && decoration.client.maximized && backgroundSvg.supportsMaximizedInactive) ? 1 : 0
        enabledBorders: PlasmaCore.FrameSvg.NoBorder
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    
    
    
    
    AuroraeButtonGroup {
        id: leftButtonGroup
        buttons: options.titleButtonsLeft
        width: childrenRect.width
        animate: root.animate
        anchors {
            left: root.left
            leftMargin: decoration.client.maximized ? auroraeTheme.titleEdgeLeftMaximized : (auroraeTheme.titleEdgeLeft + root.padding.left)
        }
    }
    AuroraeButtonGroup {
        id: rightButtonGroup
        buttons: options.titleButtonsRight
        width: childrenRect.width
        animate: root.animate
        anchors {
            right: root.right
            rightMargin: decoration.client.maximized ? auroraeTheme.titleEdgeRightMaximized : (auroraeTheme.titleEdgeRight + root.padding.right)
        }
    }
    Text {
        id: caption
        text: "<strong>" + getCleanText(decoration.client.caption) + "</strong>"
        textFormat: Text.StyledText
        horizontalAlignment: auroraeTheme.horizontalAlignment
        verticalAlignment: auroraeTheme.verticalAlignment
        elide: Text.ElideRight
        height: Math.max(auroraeTheme.titleHeight, auroraeTheme.buttonHeight * auroraeTheme.buttonSizeFactor)
        color: decoration.client.active ? auroraeTheme.activeTextColor : auroraeTheme.inactiveTextColor
        font.family: "Trebuchet MS"
        font.pointSize: 11
        style: decoration.client.active ? Text.Raised : Text.Normal // crashes if text contains emoji
        styleColor: "black"
        renderType: Text.NativeRendering
        anchors {
            left: leftButtonGroup.right
            right: rightButtonGroup.left
            top: root.top
            topMargin: decoration.client.maximized ? auroraeTheme.titleEdgeTopMaximized : (auroraeTheme.titleEdgeTop + root.padding.top)
            leftMargin: auroraeTheme.titleBorderLeft
            rightMargin: auroraeTheme.titleBorderRight
        }
        Behavior on color {
            enabled: root.animate
            ColorAnimation {
                duration: auroraeTheme.animationTime
            }
        }
        
        function getCleanText(text){
         return text.replace(/([\u2700-\u27BF]|[\uE000-\uF8FF]|\uD83C[\uDC00-\uDFFF]|\uD83D[\uDC00-\uDFFF]|[\u2011-\u26FF]|\uD83E[\uDD10-\uDDFF])/g, '');  // Remove emojis to avoid crash
        }
    }
    PlasmaCore.FrameSvgItem {
        id: innerBorder
        anchors {
            fill: parent
            leftMargin: parent.padding.left + parent.borders.left - margins.left
            rightMargin: parent.padding.right + parent.borders.right - margins.right
            topMargin: parent.padding.top + parent.borders.top - margins.top
            bottomMargin: parent.padding.bottom + parent.borders.bottom - margins.bottom
        }
        visible: parent.borders.left > fixedMargins.left
            && parent.borders.right > fixedMargins.right
            && parent.borders.top > fixedMargins.top
            && parent.borders.bottom > fixedMargins.bottom

        imagePath: backgroundSvg.imagePath
        prefix: "innerborder"
        opacity: (decoration.client.active && !decoration.client.maximized && backgroundSvg.supportsInnerBorder) ? 1 : 0
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
    PlasmaCore.FrameSvgItem {
        id: innerBorderInactive
        anchors {
            fill: parent
            leftMargin: parent.padding.left + parent.borders.left - margins.left
            rightMargin: parent.padding.right + parent.borders.right - margins.right
            topMargin: parent.padding.top + parent.borders.top - margins.top
            bottomMargin: parent.padding.bottom + parent.borders.bottom - margins.bottom
        }

        visible: parent.borders.left > fixedMargins.left
            && parent.borders.right > fixedMargins.right
            && parent.borders.top > fixedMargins.top
            && parent.borders.bottom > fixedMargins.bottom

        imagePath: backgroundSvg.imagePath
        prefix: "innerborder-inactive"
        opacity: (!decoration.client.active && !decoration.client.maximized && backgroundSvg.supportsInnerBorderInactive) ? 1 : 0
        Behavior on opacity {
            enabled: root.animate
            NumberAnimation {
                duration: auroraeTheme.animationTime
            }
        }
    }
}
