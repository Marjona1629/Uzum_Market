package uz.pdp.uzummarket.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "ordered_products") // Specify the table name if different from class name
public class OrderedProduct {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;
    private int quantity;
    private float price;
    private String image;

    @Column(name = "order_id") // Map this field to the "order_id" column in the database
    private int orderId;

    // Constructor without `id` for easier object creation
    public OrderedProduct(String name, int quantity, float price, String image, int orderId) {
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.image = image;
        this.orderId = orderId;
    }
}
