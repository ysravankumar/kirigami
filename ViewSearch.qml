/*
    Copyright 2011 Marco Martin <mart@kde.org>

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public License
    along with this library; see the file COPYING.LIB.  If not, write to
    the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
    Boston, MA 02110-1301, USA.
*/

import QtQuick 1.0
import org.kde.plasma.core 0.1 as PlasmaCore
import org.kde.plasma.components 0.1 as PlasmaComponents
import org.kde.qtextracomponents 0.1
import org.kde.plasma.mobilecomponents 0.1 as MobileComponents


Item {
    id: searchFieldContainer

    property string searchQuery
    property int delay : 100
    property bool busy: false

    // hide busy indicator after busyTimeout miliseconds.
    property alias busyTimeout: busyTimer.interval

    onSearchQueryChanged: {
        searchField.text = searchQuery
        busy = true

        if (busyTimeout > 0) {
            busyTimer.restart()
        }
    }

    width: searchField.width

    height: searchField.height
    PlasmaComponents.TextField {
        id : searchField

        placeholderText: i18n("Search...")
        clearButtonShown: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        onTextChanged: searchTimer.restart()
    }

    PlasmaComponents.BusyIndicator {
        anchors.verticalCenter: searchField.verticalCenter
        anchors.right: searchField.right
        anchors.rightMargin: searchFieldContainer.height
        height: searchField.height
        width: searchField.height
        visible: searchFieldContainer.busy
        running: visible
    }

    function setIdle() {
        searchFieldContainer.busy = false
    }

    Timer {
        id: busyTimer
        repeat: false
        interval: 0
        running: false
        onTriggered: { searchFieldContainer.busy = false }
    }

    Timer {
        id: searchTimer
        interval: delay
        running: false
        repeat: false
        onTriggered: searchQuery = searchField.text
    }
}

