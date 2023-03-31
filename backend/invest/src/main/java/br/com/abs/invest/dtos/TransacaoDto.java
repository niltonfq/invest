package br.com.abs.invest.dtos;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

import br.com.abs.invest.enums.TipoOperacao;

public class TransacaoDto {
	
	private UUID id;
	private TipoOperacao tipoOperacao;
	private AtivoDto ativo;
	private BancoDto banco;
	private CarteiraDto carteira;
	private MetaDto meta;
	private LocalDate data;
	private BigDecimal quantidade;
	private BigDecimal valor;
	private BigDecimal totalLiquido;
	private BigDecimal custos;
	private BigDecimal total;
	private LocalDate vencimento;
	
	public TransacaoDto() {
		super();
	}

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public TipoOperacao getTipoOperacao() {
		return tipoOperacao;
	}

	public void setTipoOperacao(TipoOperacao tipoOperacao) {
		this.tipoOperacao = tipoOperacao;
	}

	public AtivoDto getAtivo() {
		return ativo;
	}

	public void setAtivo(AtivoDto ativo) {
		this.ativo = ativo;
	}

	public BancoDto getBanco() {
		return banco;
	}

	public void setBanco(BancoDto banco) {
		this.banco = banco;
	}

	public CarteiraDto getCarteira() {
		return carteira;
	}

	public void setCarteira(CarteiraDto carteira) {
		this.carteira = carteira;
	}

	public MetaDto getMeta() {
		return meta;
	}

	public void setMeta(MetaDto meta) {
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

	public BigDecimal getCustos() {
		return custos;
	}

	public void setCustos(BigDecimal custos) {
		this.custos = custos;
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
	
	

}
