package com.example.zadanie3

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RestController
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity

@RestController
class MyController {

    @GetMapping("/my-endpoint")
    fun getStrings(): List<String> {
        return listOf("Element 1", "Element 2", "Element 3")
    }
}