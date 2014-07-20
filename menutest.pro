# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = menutest

CONFIG += sailfishapp

SOURCES += src/menutest.cpp

OTHER_FILES += qml/menutest.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/menutest.changes.in \
    rpm/menutest.spec \
    rpm/menutest.yaml \
    translations/*.ts \
    menutest.desktop \
    qml/pages/ContactNameGroupView.qml \
    qml/pages/ContactNameGroup.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/menutest-de.ts

