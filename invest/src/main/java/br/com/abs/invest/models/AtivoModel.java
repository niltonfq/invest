package br.com.abs.invest.models;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
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

import br.com.abs.invest.enums.Moeda;
import br.com.abs.invest.enums.TipoAtivo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
@JsonInclude(JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "ativo",
	uniqueConstraints = { @UniqueConstraint(columnNames = {"usuarioId", "codigo" }) }
)
public class AtivoModel extends RepresentationModel<AtivoModel> implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Type(type = "uuid-char")
	private UUID id;
	
	@ManyToOne
	@JoinColumn(name="usuarioId", nullable=false)
	UsuarioModel usuario;
	
	@ManyToOne
	@JoinColumn(name = "segmentoId")
	private SegmentoModel segmento;
	
	@ManyToOne
	@JoinColumn(name = "bancoId")
	private BancoModel banco;
	
	@Column(nullable = false, length = 50)
	private String codigo;
	
	@Column(nullable = false)
	@Enumerated(EnumType.STRING)
	private TipoAtivo tipoAtivo;	
	
	@Column(nullable = false, length = 10)
	@Enumerated(EnumType.STRING)
	private Moeda moeda;	
	
	private String observacao;
	
	@Column(nullable = false)
	private Short nota = 0;

	private String cnpj;

	@Column(nullable = false)
	private String nome;
	
	@Column(nullable = false)
	private BigDecimal precoMedio = BigDecimal.ZERO;
	
	@Column(nullable = false)
	private BigDecimal totalInvestido = BigDecimal.ZERO;
	
	@Column(nullable = false)
	private BigDecimal quantidadeInvestida = BigDecimal.ZERO;
	
	@Column(nullable = false)
	private BigDecimal valorAtual = BigDecimal.ZERO;
	
	private LocalDate dataAtualizacaoPreco;
	
	@Column(nullable = false)
	private Boolean quarentena = false;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime dataCriacao;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime dataAtualizacao;
	
}
