package com.example.myapplication;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        List<Category> categories = new ArrayList<>();
        categories.add(new Category(1, "Kategoria 1", new ArrayList<Product>() {{
            add(new Product(1, "Produkt 1"));
            add(new Product(2, "Produkt 2"));
        }}));
        categories.add(new Category(2, "Kategoria 2", new ArrayList<Product>() {{
            add(new Product(3, "Produkt 3"));
            add(new Product(4, "Produkt 4"));
        }}));

        TextView textView = (TextView) findViewById(R.id.greeting_text);
        StringBuilder displayText = new StringBuilder();
        for (Category category : categories) {
            displayText.append("Kategoria: ").append(category.getName()).append("\n");
            for (Product product : category.getProducts()) {
                displayText.append("  Produkt: ").append(product.getName()).append("\n");
            }
        }
        textView.setText(displayText.toString());
    }

    private void displayCategoriesAndProducts(List<Category> categories) {
        for (Category category : categories) {
            System.out.println("Kategoria: " + category.getName());
            for (Product product : category.getProducts()) {
                System.out.println("  Produkt: " + product.getName());
            }
        }
    }

    public void Greeting(String name) {
        TextView textView = (TextView) findViewById(R.id.greeting_text);
        textView.setText("Hello " + name + "!");
    }
}