
import org.kde.ksvg 1.0 as KSvg

KSvg.FrameSvgItem {
    id: baseFrame

        property double targetScale: 1.0;
        property double topMargin: 0.0
        property double bottomMargin: 0.0

        property double borderSizeTop: 3.0
        property double borderSizeBottom: 3.0

        property string image

        anchors {
            fill: parent

            topMargin: topMargin * targetScale
            bottomMargin: bottomMargin * targetScale
            leftMargin: 0
            rightMargin: 0
        }

        KSvg.FrameSvgItem {
            id: frmTop
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            height: borderSizeTop
            imagePath: image
            prefix: baseFrame.basePrefix + "Top"
        }

        KSvg.FrameSvgItem {
            id: frmBottom
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                //top: parent.top
            }
            height: borderSizeBottom
            imagePath: image
            prefix: baseFrame.basePrefix + "Bottom"
        }

        KSvg.FrameSvgItem {
            id: frmCenter
            anchors {
                top: frmTop.bottom
                left: frmTop.left
                right: frmBottom.right
                bottom: frmBottom.top
            }

            imagePath: image
            prefix: baseFrame.basePrefix + "Center"
        }

        property bool isHovered: false
        property string basePrefix: "Normal"
}
