import QtQuick 2.0

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaCore.FrameSvgItem {
        id: baseFrame
        
        property double targetScale: PlasmaCore.Units.devicePixelRatio;
        
        property double topMargin: 0.0
        property double bottomMargin: 0.0
        property double leftMargin: 0.0
        property double rightMargin: 0.0
        property double borderSize: 3.0
        property string image

        anchors {
            fill: parent

            topMargin: topMargin * targetScale
            bottomMargin: bottomMargin * targetScale
            leftMargin: 0
            rightMargin: 0
        }
            
        PlasmaCore.FrameSvgItem {
            id: frmTopLeft
            anchors {
                top: parent.top
                left: parent.left
            }
            
            width: Math.round(borderSize * baseFrame.targetScale)
            height: Math.round(borderSize * baseFrame.targetScale)
            
            imagePath: image
            prefix: baseFrame.basePrefix + "TopLeft"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmTopRight
            anchors {
                top: parent.top
                right: parent.right
            }
            
            width: Math.round(borderSize * baseFrame.targetScale)
            height: Math.round(borderSize * baseFrame.targetScale)
            
            imagePath: image
            prefix: baseFrame.basePrefix + "TopRight"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmTop
            anchors {
                top: parent.top
                left: frmTopLeft.right
            }
            
            width: parent.width - frmTopLeft.width  - frmTopRight.width
            height: Math.round(borderSize * baseFrame.targetScale)
            
            imagePath: image
            prefix: baseFrame.basePrefix + "Top"
        }
        
        
        PlasmaCore.FrameSvgItem {
            id: frmBottomLeft
            anchors {
                bottom: parent.bottom
                left: parent.left
            }
            
            width: Math.round(borderSize * baseFrame.targetScale)
            height: Math.round(borderSize * baseFrame.targetScale)
            
            imagePath: image
            prefix: baseFrame.basePrefix + "BottomLeft"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmLeft
            anchors {
                top: frmTop.bottom
                left: parent.left
            }
            
            width: Math.round(borderSize * baseFrame.targetScale)
            height: parent.height - frmTop.height - frmBottomLeft.height
            
            imagePath: image
            prefix: baseFrame.basePrefix + "Left"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmBottomRight
            anchors {
                bottom: parent.bottom
                right: parent.right
            }
            
            width: Math.round(borderSize * baseFrame.targetScale)
            height: Math.round(borderSize * baseFrame.targetScale)
            
            imagePath: image
            prefix: baseFrame.basePrefix + "BottomRight"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmRight
            anchors {
                top: frmTop.bottom
                right: parent.right
            }
            
            width: Math.round(borderSize * baseFrame.targetScale)
            height: parent.height - frmTop.height - frmBottomRight.height
            
            imagePath: image
            prefix: baseFrame.basePrefix + "Right"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmBottom
            anchors {
                bottom: parent.bottom
                left: frmBottomLeft.right
            }
            
            width: parent.width - frmBottomLeft.width - frmBottomRight.width
            height: Math.round(borderSize * baseFrame.targetScale)
            
            imagePath: image
            prefix: baseFrame.basePrefix + "Bottom"
        }
        
        PlasmaCore.FrameSvgItem {
            id: frmCenter
            anchors {
                top: frmTop.bottom
                left: frmTopLeft.right
            }
            
            width: parent.width - frmBottomLeft.width - frmBottomRight.width
            height: parent.height - frmTop.height - frmBottomRight.height
            
            imagePath: image
            prefix: baseFrame.basePrefix + "Center"
        }
        
        property bool isHovered: false
        property string basePrefix: "Normal"
        
}
