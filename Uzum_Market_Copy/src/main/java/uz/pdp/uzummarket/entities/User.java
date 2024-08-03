package uz.pdp.uzummarket.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.pdp.uzummarket.enums.Role;
import uz.pdp.uzummarket.enums.Status;

import java.sql.Timestamp;
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
	private Integer userId;
	@Column(nullable = false)
	private String first_name;
	@Column(nullable = false)
	private String last_name;
	@Column(unique = true, nullable = false)
	private String userName;
	private Integer age;
	@Column(unique = true, nullable = false)
	private String userEmail;
	@Column(nullable = false)
	private String userPassword;
	@Column(nullable = false)
	private String userPhone;
	private String userGender;
	private LocalDateTime dateTime = LocalDateTime.now();
	private String userAddress;
	private String userCity;
	private String userState;
	@Enumerated(EnumType.STRING)
	private Role role = Role.CUSTOMER;
	@Enumerated(EnumType.STRING)
	private Status status = Status.ACTIVE;
	private boolean isDeleted = Boolean.FALSE;
	private String code;
	private Boolean hasConfirmed = Boolean.FALSE;

	@OneToMany(mappedBy = "owner", cascade = CascadeType.ALL, orphanRemoval = true)
	private Set<Shop> shops;
}
