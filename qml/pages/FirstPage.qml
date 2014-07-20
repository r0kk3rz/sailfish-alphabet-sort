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
        ListElement {
            artist: "Anthrax"
            title: "Armed and Dangerous"
            album: "Spreading the Disease"
            length: "05:43"
        }
        ListElement {
            artist: "ACDC"
            title: "Are you ready"
            album: ""
            length: "05:00"
        }
        ListElement {
            artist: "Amon Amarth"
            title: "As Loke Falls"
            album: "Deceiver of the Gods"
            length: "04:38"
        }
        ListElement {
            artist: "Anthrax"
            title: "Among the Living"
            album: "Spreading the Disease"
            length: "05:43"
        }
        ListElement {
            artist: "Black Label Society"
            title: "Ain't Life Grand"
            album: "Spreading the Disease"
            length: "04:39"
        }
        ListElement {
            artist: "The Sword"
            title: "Apocryphon"
            album: "Apocryphon"
            length: "04:57"
        }
        ListElement {
            artist: "3 Inches of Blood"
            title: "Deadly Sinners"
            album: "Brutal Legend Soundtrack"
            length: "04:31"
        }
        ListElement {
            artist: "3 Inches of Blood"
            title: "Destroy the Orcs"
            album: "Brutal Legend Soundtrack"
            length: "02:21"
        }
        ListElement {
            artist: "Amon Amarth"
            title: "Deceiver of the Gods"
            album: "Deceiver of the Gods"
            length: "04:19"
        }
        ListElement {
            artist: "Amon Amarth"
            title: "Father of the Wolf"
            album: "Deceiver of the Gods"
            length: "04:19"
        }
        ListElement {
            artist: "Amon Amarth"
            title: "Under Siege"
            album: "Deceiver of the Gods"
            length: "04:19"
        }
        ListElement {
            artist: "Amon Amarth"
            title: "Blood Eagle"
            album: "Deceiver of the Gods"
            length: "03:15"
        }
        ListElement {
            artist: "Amon Amarth"
            title: "We Shall Destroy"
            album: "Deceiver of the Gods"
            length: "04:19"
        }
        ListElement {
            artist: "Amon Amarth"
            title: "Hel"
            album: "Deceiver of the Gods"
            length: "04:10"
        }

    }

    SilicaFlickable {

        anchors.fill: parent
        id: contentColumn
        contentHeight: Math.max(1, nameGroupView.height)

        VerticalScrollDecorator {}

        ContactNameGroupView {
            id: nameGroupView
            width: parent.width
            opacity: enabled ? 1 : 0
            dataModel: trackList
            Behavior on opacity { FadeAnimation {} }

            delegate: ListItem {
                width: parent.width

                Rectangle
                {
                    Row{
                        spacing: 20
                        Label {
                            text: length
                            height: Theme.itemSizeHuge
                            font.pixelSize: Theme.fontSizeHuge
                            color: Theme.secondaryColor
                        }

                        Column{
                            Label {
                                text: title
                                font.pixelSize: Theme.fontSizeMedium
                                color: Theme.primaryColor
                            }
                            Label {
                                text: artist
                                font.pixelSize: Theme.fontSizeSmall
                                color: Theme.secondaryColor
                            }
                        }
                    }
                }


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

        PullDownMenu {
            MenuItem {
                text: "Shuffle All"
            }
            MenuItem {
                text: "Search"
            }
            MenuItem {
                text: "Sort by: Artists"
            }
        }

        PushUpMenu {

        }
    }
}


