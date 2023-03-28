package br.com.abs.invest.dtos;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonInclude;

import br.com.abs.invest.enums.Moeda;
import br.com.abs.invest.enums.TipoAtivo;



@JsonInclude(JsonInclude.Include.NON_NULL)
public class AtivoDto {
	
	private UUID id;
	
	@NotNull
	UsuarioDto usuario;
	
	private SegmentoDto segmento;
	
	private BancoDto banco;
	
	@NotBlank
	private String codigo;
	
	@NotNull
	private TipoAtivo tipoAtivo;	
	
	@NotNull
	private Moeda moeda;	
	
	private String observacao;
	
	private Short nota = 0;

	private String cnpj;

	private String nome;
	
	private BigDecimal precoMedio = BigDecimal.ZERO;
	
	private BigDecimal totalInvestido = BigDecimal.ZERO;
	
	private BigDecimal quantidadeInvestida = BigDecimal.ZERO;
	
	private BigDecimal valorAtual = BigDecimal.ZERO;
	
	private LocalDate dataAtualizacaoPreco;
	
	@NotNull
	private Boolean quarentena = false;

	public AtivoDto() {
		super();
	}

	
	public UUID getId() {
		return id;
	}


	public void setId(UUID id) {
		this.id = id;
	}


	public UsuarioDto getUsuario() {
		return usuario;
	}

	public void setUsuario(UsuarioDto usuario) {
		this.usuario = usuario;
	}

	public SegmentoDto getSegmento() {
		return segmento;
	}

	public void setSegmento(SegmentoDto segmento) {
		this.segmento = segmento;
	}

	public BancoDto getBanco() {
		return banco;
	}

	public void setBanco(BancoDto banco) {
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
	
	
	
	
	
}
