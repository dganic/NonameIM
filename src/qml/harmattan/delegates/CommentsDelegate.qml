// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import "../utils.js" as Utils
import "../components"

ItemDelegate {
    id: itemDelegate

    onVisibleChanged: {
        if (visible)
            from.update()
    }

    clickable: true
    imageSource: Utils.getContactPhotoSource(from)
    item: data

    Column {
        id: data

        Label {
            id: titleLabel
            text: from.name
            anchors {
                left: parent.left
                right: parent.right
            }
            color: "#2b497a"

            font.pixelSize: appWindow.normalFontSize
        }

        Label {
            id: activityLabel

            onLinkActivated: Qt.openUrlExternally(link)

            text: Utils.format(body)
            anchors {
                left: parent.left
                right: parent.right
            }
            font.pixelSize: appWindow.smallFontSize
        }
        PostInfo {
            date: model.date
            likes: model.likes ? model.likes.count : 0
        }
    }

    onClicked: appWindow.showProfile(from)
}
