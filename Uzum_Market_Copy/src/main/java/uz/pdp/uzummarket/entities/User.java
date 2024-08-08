package uz.pdp.uzummarket.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.pdp.uzummarket.enums.Role;
import uz.pdp.uzummarket.enums.Status;

import java.time.LocalDateTime;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	private String firstName;
	private String lastName;

	@Column(unique = true, nullable = false)
	private String username;

	private Integer age;

	@Column(unique = true, nullable = false)
	private String email;

	@Column(nullable = false)
	private String password;

	private String phone;

	private String gender;

	private LocalDateTime dateTime = LocalDateTime.now();

	private String address;

	private String city;

	private String state;

	@Enumerated(EnumType.STRING)
	private Role role = Role.CUSTOMER;

	@Enumerated(EnumType.STRING)
	private Status status = Status.ACTIVE;

	private boolean isDeleted = Boolean.FALSE;

	private String code;

	private Boolean hasConfirmed = Boolean.FALSE;

	@OneToMany(mappedBy = "owner", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private Set<Shop> shops;
}
