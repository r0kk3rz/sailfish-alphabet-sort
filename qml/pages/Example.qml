import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

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
        width: parent ? parent.width : Screen.width
        height: parent ? parent.height : Screen.height
        VerticalScrollDecorator {}
        contentHeight: Math.max(1, alphaMenu.height)

    AlphaMenu {
        id: alphaMenu
        dataSource: trackList
        listDelegate:  BackgroundItem {
            width: parent.width
            id: songList
            onClicked: console.log(length + ' ' + title+' ' + artist)

                Row{
                    spacing: 20

                    Label {
                        text: length
                        height: Theme.itemSizeHuge
                        font.pixelSize: Theme.fontSizeExtraLarge
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
                            font.pixelSize: Theme.fontSizeExtraSmall
                            color: Theme.secondaryColor
                        }
                    }
                }
            }
        }
    }
}
