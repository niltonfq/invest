package br.com.abs.invest.models;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Type;
import org.springframework.hateoas.RepresentationModel;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;




@JsonInclude(JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "meta", 
	   uniqueConstraints = { @UniqueConstraint(columnNames = {"usuarioId", "nome" }) }

)
public class MetaModel extends RepresentationModel<MetaModel> implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Type(type = "uuid-char")
	@Column(nullable = false, columnDefinition="char(36)")
	private UUID id;
	
	@ManyToOne
	@JoinColumn(name="usuarioId", nullable=false)
	UsuarioModel usuario;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime dataCriacao;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime dataAtualizacao;
	
	@Column(nullable = false, unique = true, length = 255)
	private String nome;
	
	@Column(length = 10)
	private String numero;

	public MetaModel() {
		super();
	}

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public UsuarioModel getUsuario() {
		return usuario;
	}

	public void setUsuario(UsuarioModel usuario) {
		this.usuario = usuario;
	}

	public LocalDateTime getDataCriacao() {
		return dataCriacao;
	}

	public void setDataCriacao(LocalDateTime dataCriacao) {
		this.dataCriacao = dataCriacao;
	}

	public LocalDateTime getDataAtualizacao() {
		return dataAtualizacao;
	}

	public void setDataAtualizacao(LocalDateTime dataAtualizacao) {
		this.dataAtualizacao = dataAtualizacao;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}

	
		
}
