package com.example.myapplication;

import java.util.List;

public class Category {
    private int id;
    private String name;
    private List<Product> products;

    public Category(int id, String name, List<Product> products) {
        this.id = id;
        this.name = name;
        this.products = products;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public List<Product> getProducts() {
        return products;
    }
}