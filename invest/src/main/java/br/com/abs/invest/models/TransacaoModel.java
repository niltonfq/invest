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

import org.hibernate.annotations.Type;
import org.springframework.hateoas.RepresentationModel;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.fasterxml.jackson.annotation.JsonInclude;

import br.com.abs.invest.enums.TipoOperacao;

@JsonInclude(JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "transacao")
public class TransacaoModel extends RepresentationModel<AtivoModel> implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Type(type = "uuid-char")
	@Column(nullable = false, columnDefinition="char(36)")
	private UUID id;
	
	@ManyToOne
	@JoinColumn(name="usuarioId", nullable=false)
	UsuarioModel usuario;
	
	@Column(nullable = false, length = 10)
	@Enumerated(EnumType.STRING)
	private TipoOperacao tipoOperacao;
	
	@ManyToOne
	@JoinColumn(name="ativoId", nullable=false)
	private AtivoModel ativo;
	
	@ManyToOne
	@JoinColumn(name="bancoId", nullable=false)
	private BancoModel banco;
	
	@ManyToOne
	@JoinColumn(name="carteiraId")
	private CarteiraModel carteira;
	
	@ManyToOne
	@JoinColumn(name="metaId")
	private MetaModel meta;
	
	private LocalDate data;
	
	@Column(nullable = false, precision = 15, scale = 10)
	private BigDecimal quantidade = BigDecimal.ZERO;

	@Column(nullable = false, precision = 15, scale = 10)
	private BigDecimal valor = BigDecimal.ZERO;

	@Column(nullable = false)
	private BigDecimal totalLiquido = BigDecimal.ZERO;
	
	@Column(nullable = false)
	private BigDecimal tarifas = BigDecimal.ZERO;

	@Column(nullable = false)
	private BigDecimal total = BigDecimal.ZERO;
	private LocalDate vencimento;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime dataCriacao;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime dataAtualizacao;
	
	public TransacaoModel() {
		super();
	}

	public TipoOperacao getTipoOperacao() {
		return tipoOperacao;
	}

	public void setTipoOperacao(TipoOperacao tipoOperacao) {
		this.tipoOperacao = tipoOperacao;
	}

	public AtivoModel getAtivo() {
		return ativo;
	}

	public void setAtivo(AtivoModel ativo) {
		this.ativo = ativo;
	}

	public BancoModel getBanco() {
		return banco;
	}

	public void setBanco(BancoModel banco) {
		this.banco = banco;
	}

	public CarteiraModel getCarteira() {
		return carteira;
	}

	public void setCarteira(CarteiraModel carteira) {
		this.carteira = carteira;
	}

	public MetaModel getMeta() {
		return meta;
	}

	public void setMeta(MetaModel meta) {
		this.meta = meta;
	}

	public LocalDate getData() {
		return data;
	}

	public void setData(LocalDate data) {
		this.data = data;
	}

	public BigDecimal getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(BigDecimal quantidade) {
		this.quantidade = quantidade;
	}

	public BigDecimal getValor() {
		return valor;
	}

	public void setValor(BigDecimal valor) {
		this.valor = valor;
	}

	public BigDecimal getTotalLiquido() {
		return totalLiquido;
	}

	public void setTotalLiquido(BigDecimal totalLiquido) {
		this.totalLiquido = totalLiquido;
	}

	public BigDecimal getTarifas() {
		return tarifas;
	}

	public void setTarifas(BigDecimal tarifas) {
		this.tarifas = tarifas;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public LocalDate getVencimento() {
		return vencimento;
	}

	public void setVencimento(LocalDate vencimento) {
		this.vencimento = vencimento;
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

	
}
