package main

import (
	"fmt"
	"github.com/labstack/echo/v4"
	"io"
	"net/http"
	"strings"
)

func GetWeather(c echo.Context) error {
	resp, err := http.Get("http://wttr.in/Krakow?format=%C")
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	weatherCondition := strings.TrimSpace(string(body))

	resp, err = http.Get("http://wttr.in/Krakow?format=%t+%w+%m+%p")
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}
	defer resp.Body.Close()

	body, err = io.ReadAll(resp.Body)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, err.Error())
	}

	weatherInfo := strings.TrimSpace(string(body))
	weatherParts := strings.Split(weatherInfo, " ")

	if len(weatherParts) != 4 {
		return c.JSON(http.StatusInternalServerError, "Unexpected weather information format")
	}

	formattedWeatherInfo := fmt.Sprintf("Currently in Krakow: %s with temperature %s, wind %s, moon %s, precipitation %s",
		weatherCondition, weatherParts[0], weatherParts[1], weatherParts[2], weatherParts[3])

	return c.String(http.StatusOK, formattedWeatherInfo)
}
