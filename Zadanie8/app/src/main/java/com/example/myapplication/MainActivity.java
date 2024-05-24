package com.example.myapplication;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends Activity {
    private Cart cart;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        cart = new Cart();

        List<Category> categories = new ArrayList<>();
        categories.add(new Category(1, "Kategoria 1", new ArrayList<Product>() {{
            add(new Product(1, "Produkt 1", 10.0));
            add(new Product(2, "Produkt 2", 20.0));
        }}));
        categories.add(new Category(2, "Kategoria 2", new ArrayList<Product>() {{
            add(new Product(3, "Produkt 3", 30.0));
            add(new Product(4, "Produkt 4", 40.0));
        }}));

        TextView categoriesText = findViewById(R.id.categories_text);
        for (Category category : categories) {
            categoriesText.append("Kategoria: " + category.getName() + "\n");
            for (Product product : category.getProducts()) {
                categoriesText.append("  Produkt: " + product.getName() + ", Cena: " + product.getPrice() + "\n");
            }
        }

        LinearLayout productList = findViewById(R.id.product_list);
        for (Category category : categories) {
            for (Product product : category.getProducts()) {
                Button addButton = new Button(this);
                addButton.setText("Dodaj " + product.getName() + " do koszyka");
                addButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        addToCart(product, 1);
                    }
                });
                productList.addView(addButton);
            }
        }
    }

    public void addToCart(Product product, int quantity) {
        CartItem existingItem = null;
        for (CartItem item : cart.getItems()) {
            if (item.getProduct().equals(product)) {
                existingItem = item;
                break;
            }
        }
        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
        } else {
            cart.addItem(new CartItem(product, quantity));
        }
        displayCart();
    }

    public void removeFromCart(Product product) {
        for (CartItem item : cart.getItems()) {
            if (item.getProduct().equals(product)) {
                cart.removeItem(item);
                break;
            }
        }
        displayCart();
    }

    private void displayCart() {
        LinearLayout cartLayout = (LinearLayout) findViewById(R.id.cart_layout);
        cartLayout.removeAllViews();
        for (CartItem item : cart.getItems()) {
            TextView productInfo = new TextView(this);
            productInfo.setText("Produkt: " + item.getProduct().getName() + ", Ilość: " + item.getQuantity() + ", Cena: " + item.getProduct().getPrice());
            cartLayout.addView(productInfo);

            Button removeButton = new Button(this);
            removeButton.setText("Usuń " + item.getProduct().getName() + " z koszyka");
            removeButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    removeFromCart(item.getProduct());
                    displayCart();
                }
            });
            cartLayout.addView(removeButton);
        }
        TextView total = new TextView(this);
        total.setText("Całkowita kwota koszyka: " + cart.getTotal());
        cartLayout.addView(total);
    }
}