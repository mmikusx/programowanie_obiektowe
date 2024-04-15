package main

import (
	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()

	db := InitDB()
	defer db.Close()

	LoadData(db)

	e.GET("/weather", GetWeather)

	e.Start(":8080")
}
