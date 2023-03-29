package br.com.abs.invest.models;


import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
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
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "ativoFechamento",
	uniqueConstraints = { @UniqueConstraint(columnNames = {"usuarioId", "ativoId", "data" }) }
)
public class AtivoFechamentoModel extends RepresentationModel<AtivoFechamentoModel> implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Type(type = "uuid-char")
	@Column(nullable = false, columnDefinition="char(36)")
	private UUID id;
	
	@ManyToOne
	@JoinColumn(name="usuarioId", nullable=false)
	UsuarioModel usuario;
	
	@ManyToOne
	@JoinColumn(nullable = false ,name = "ativoId")
	private AtivoModel ativo;
	
	@Column(precision = 15, scale = 10)
	private BigDecimal quantidade;
	
	private BigDecimal total;
	
	@Column(precision = 15, scale = 10)
	private BigDecimal precoMedio;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDate data;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime dataCriacao;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime dataAtualizacao;
	


	public AtivoFechamentoModel() {
		super();
	}

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
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

	public UsuarioModel getUsuario() {
		return usuario;
	}

	public void setUsuario(UsuarioModel usuario) {
		this.usuario = usuario;
	}

	public AtivoModel getAtivo() {
		return ativo;
	}

	public void setAtivo(AtivoModel ativo) {
		this.ativo = ativo;
	}

	public BigDecimal getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(BigDecimal quantidade) {
		this.quantidade = quantidade;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public BigDecimal getPrecoMedio() {
		return precoMedio;
	}

	public void setPrecoMedio(BigDecimal precoMedio) {
		this.precoMedio = precoMedio;
	}

	public LocalDate getData() {
		return data;
	}

	public void setData(LocalDate data) {
		this.data = data;
	}

	
}
	
