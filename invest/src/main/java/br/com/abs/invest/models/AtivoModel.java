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
	@Column(nullable = false, columnDefinition="char(36)")
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

	@Column(length = 14)
	private String cnpj;

	@Column
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

	
	
	public AtivoModel() {
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

	public SegmentoModel getSegmento() {
		return segmento;
	}

	public void setSegmento(SegmentoModel segmento) {
		this.segmento = segmento;
	}

	public BancoModel getBanco() {
		return banco;
	}

	public void setBanco(BancoModel banco) {
		this.banco = banco;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public TipoAtivo getTipoAtivo() {
		return tipoAtivo;
	}

	public void setTipoAtivo(TipoAtivo tipoAtivo) {
		this.tipoAtivo = tipoAtivo;
	}

	public Moeda getMoeda() {
		return moeda;
	}

	public void setMoeda(Moeda moeda) {
		this.moeda = moeda;
	}

	public String getObservacao() {
		return observacao;
	}

	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}

	public Short getNota() {
		return nota;
	}

	public void setNota(Short nota) {
		this.nota = nota;
	}

	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public BigDecimal getPrecoMedio() {
		return precoMedio;
	}

	public void setPrecoMedio(BigDecimal precoMedio) {
		this.precoMedio = precoMedio;
	}

	public BigDecimal getTotalInvestido() {
		return totalInvestido;
	}

	public void setTotalInvestido(BigDecimal totalInvestido) {
		this.totalInvestido = totalInvestido;
	}

	public BigDecimal getQuantidadeInvestida() {
		return quantidadeInvestida;
	}

	public void setQuantidadeInvestida(BigDecimal quantidadeInvestida) {
		this.quantidadeInvestida = quantidadeInvestida;
	}

	public BigDecimal getValorAtual() {
		return valorAtual;
	}

	public void setValorAtual(BigDecimal valorAtual) {
		this.valorAtual = valorAtual;
	}

	public LocalDate getDataAtualizacaoPreco() {
		return dataAtualizacaoPreco;
	}

	public void setDataAtualizacaoPreco(LocalDate dataAtualizacaoPreco) {
		this.dataAtualizacaoPreco = dataAtualizacaoPreco;
	}

	public Boolean getQuarentena() {
		return quarentena;
	}

	public void setQuarentena(Boolean quarentena) {
		this.quarentena = quarentena;
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
	
	
}
