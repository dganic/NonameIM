import QtQuick 1.1
import com.nokia.meego 1.0
import com.vk.api 0.1

Page {
    id: friendsPage

    function __update() {
        if (client.online)
            client.roster.sync()
    }

    onStatusChanged: {
        if (status === PageStatus.Active)
            __update()
    }

    tools: commonTools
    orientationLock: PageOrientation.LockPortrait

    PageHeader {
        id: header
        text: qsTr("Friends")
    }

    ContactsModel {
        id: contactsModel
        roster: client.roster
    }

    ListView {
        id: rosterView;
        width: parent.width;
        anchors.top: header.bottom;
        anchors.bottom: parent.bottom;
        model: contactsModel
        highlight: HighlightDelegate {}
        delegate: ContactDelegate {
           id: contactDelegate
           onClicked: {
               profilePage.contact = contact;
               pageStack.push(profilePage);
           }
        }
        currentIndex: -1;
        header: SearchBar {
            id: searchBar

            onSearch: contactsModel.filterByName = searchBar.searchingText
            onCancel: contactsModel.filterByName = ""
        }
    }

    ScrollDecorator {
        flickableItem: rosterView
    }

    UpdateIcon {
        flickableItem: rosterView
        onTriggered: __update()
    }

    Connections {
        target: client
    }
}
