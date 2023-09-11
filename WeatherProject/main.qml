import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "WeatherApp"

    Rectangle {
        width: parent.width
        height: parent.height
        color: "lightpink"

        Image {
            source: "sky.jpg" // Replace with the actual path to your image
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
        }

        ColumnLayout {
            spacing: 10
            anchors.centerIn: parent

            // Title
            Text {
                text: "Weather Report"
                font.pointSize: 36
                color: "white"
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    width: parent.width
                    height: 2
                    color: "#3498db"
                    anchors {
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            TextField {
                id: cityInput
                width: parent.width
                placeholderText: "Enter a city name"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
                background: Rectangle {
                    color: "#FFFFFF"
                    radius: 5
                    border.color: "lightpink"
                    border.width: 2
                }
            }

            Button {
                id: searchButton
                text: "Search"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
                background: Rectangle {
                    color: "lightpink"
                    radius: 5
                }
                onClicked: {

                    weatherGen.updateWeather(cityInput.text)
                }
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    color: "white"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    padding: 5
                }

                transitions: Transition {
                    NumberAnimation {
                        properties: "opacity"
                        from: 1
                        to: 0
                        duration: 100
                    }
                    NumberAnimation {
                        properties: "opacity"
                        from: 0
                        to: 1
                        duration: 100
                    }
                }
            }

            Text {
                id: name
                font.pixelSize: 24
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                id: durum
                font.pixelSize: 18
                Layout.alignment: Qt.AlignHCenter
            }

            Connections {
                target: weatherGen
                function onNextWeather(value) {
                    name.text = "Temperature: " + value.toFixed(2) + " °C"
                }
                function onNextDurum(value) {
                    durum.text = "Weather: " + value
                }
            }
        }
    }
}
