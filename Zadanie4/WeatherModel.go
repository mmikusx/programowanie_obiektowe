package main

import (
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
)

type Weather struct {
	gorm.Model
	City             string
	WeatherCondition string
	Temperature      string
	Wind             string
	Moon             string
	Precipitation    string
}

func InitDB() *gorm.DB {
	db, err := gorm.Open("sqlite3", "test.db")
	if err != nil {
		panic("failed to connect database")
	}

	db.AutoMigrate(&Weather{})

	return db
}

func LoadData(db *gorm.DB) {
	weatherData := []Weather{
		{City: "Krakow", WeatherCondition: "Sunny", Temperature: "20C", Wind: "5km/h", Moon: "Full", Precipitation: "0.0mm"},
		{City: "Warsaw", WeatherCondition: "Foggy", Temperature: "15C", Wind: "7km/h", Moon: "Half", Precipitation: "0.6mm"},
		{City: "Wroclaw", WeatherCondition: "Windy", Temperature: "11C", Wind: "15km/h", Moon: "None", Precipitation: "0.0mm"},
	}

	for _, weather := range weatherData {
		var existingWeather Weather
		if db.Where("city = ?", weather.City).First(&existingWeather).RecordNotFound() {
			db.Create(&weather)
		}
	}
}
