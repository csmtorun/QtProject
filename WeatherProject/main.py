# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
from PySide6.QtCore import QObject, Signal, Slot
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
import requests

class WeatherGenerator(QObject):
    def __init__(self):
        QObject. __init__(self)



    nextWeather=Signal(float)
    nextDurum=Signal(str)




    @Slot(str)
    def updateWeather(self,city):
        API = "8f90ce759981c8d2aed55ab4db7dfb68"
        Base_Url = "http://api.openweathermap.org/data/2.5/weather?"
        url = Base_Url + "appid=" + API + "&q=" + city
        response = requests.get(url)
        data = response.json()
        temp = data.get("main", {}).get("temp")
        desc = data.get("weather", [])[0].get("description")
        #print(f"Temperature: {temp} K")
        temp_celsius = round(temp - 273.15, 2)


        self.nextWeather.emit(temp_celsius)
        self.nextDurum.emit(desc)





if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "main.qml"

    weather_generator=WeatherGenerator()
    engine.rootContext().setContextProperty("weatherGen",weather_generator)


    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
