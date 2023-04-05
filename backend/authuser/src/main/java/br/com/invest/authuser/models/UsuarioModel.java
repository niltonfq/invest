package br.com.invest.authuser.models;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;
import org.springframework.hateoas.RepresentationModel;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;

import br.com.invest.authuser.enums.UsuarioStatus;
import br.com.invest.authuser.enums.UsuarioType;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@JsonInclude(JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "usuario")
public class UsuarioModel extends RepresentationModel<UsuarioModel> implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Type(type = "uuid-char")
	private UUID id;
	
	@Column(nullable = false, unique = true, length = 50)
	private String username;
	
	@Column(nullable = false, unique = true, length = 50)
	private String email;
	
	@JsonIgnore
	@Column(nullable = false, length = 255)
	private String password;
	
	@Column(nullable = false, length = 150)
	private String fullName;

	@Column(nullable = false)
	@Enumerated(EnumType.STRING)
	private UsuarioStatus usuarioStatus;
	
	@Column(nullable = false)
	@Enumerated(EnumType.STRING)
	private UsuarioType usuarioType;
	
	@Column(length = 20)
	private String phoneNumber;
	
	@Column(length = 20)
	private String cpf;
	
	@Column
	private String imagemUrl;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime creationDate;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime lastUpdateDate;
	
}
