/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: root


    ListModel {
        id: trackList
        property string filterProperty: 'title'

        ListElement {
            artist: "Megadeth"
            title: "Countdown to Extinction"
            album: ""
            length: "03:32"
        }

        ListElement {
            artist: "Amon Amarth"
            title: "Shape Shifter"
            album: "Deceiver of the Gods"
            length: "04:02"
        }
    }

    SilicaFlickable {
        anchors.fill: parent
        id: contentColumn

        ContactNameGroupView {
            id: nameGroupView
            width: parent.width
            opacity: enabled ? 1 : 0
            dataModel: trackList
            Behavior on opacity { FadeAnimation {} }

            delegate: ListView {
                width: parent.width
                Label {text: name}
            }

            onActivated: {
                // If height is reduced, allow the exterior flickable to reposition itself
                if (newViewHeight > nameGroupView.height) {
                    // Where should the list be positioned to show as much of the list as possible
                    // (but also show one row beyond the list if possible)
                    var maxVisiblePosition = nameGroupView.y + viewSectionY + newListHeight + rowHeight - root.height

                    // Ensure up to two rows of group elements to show at the top
                    var maxAllowedPosition = nameGroupView.y + Math.max(viewSectionY - (2 * rowHeight), 0)

                    // Don't position beyond the end of the flickable
                    var totalContentHeight = contentColumn.height + (newViewHeight - nameGroupView.height)
                    var maxContentY = root.originY + totalContentHeight - root.height

                    var newContentY = Math.max(Math.min(Math.min(maxVisiblePosition, maxAllowedPosition), maxContentY), 0)
                    if (newContentY > root.contentY) {
                        if (root._contentYBeforeGroupOpen < 0) {
                            root._contentYBeforeGroupOpen = root.contentY
                        }
                        root._animateContentY(newContentY, heightAnimationDuration, heightAnimationEasing)
                    }
                }
            }
            onDeactivated: {
                if (root._contentYBeforeGroupOpen >= 0) {
                    root._animateContentY(root._contentYBeforeGroupOpen, heightAnimationDuration, heightAnimationEasing)
                    root._contentYBeforeGroupOpen = -1
                }
            }
        }
    }
}


