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
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id; // productId

    @Column(nullable = false)
    private String name; // productName

    @Column(nullable = false)
    private String description; // productDescription

    @Column(nullable = false)
    private float price; // productPrice

    private int discount; // productDiscount

    @Column(nullable = false)
    private int quantity; // productQuantity

    @Column(nullable = false)
    private String images; // productImages

    private float priceAfterDiscount; // productPriceAfterDiscount

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @ManyToOne
    @JoinColumn(name = "shop_id", nullable = false)
    private Shop shop;
}
