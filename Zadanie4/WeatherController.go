package main

import (
	"github.com/labstack/echo/v4"
	"net/http"
)

func GetWeather(c echo.Context) error {
	db := InitDB()
	defer db.Close()

	var weather []Weather
	db.Find(&weather)

	return c.JSON(http.StatusOK, weather)
}
