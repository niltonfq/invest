package br.com.abs.invest.dtos;

import java.io.Serializable;
import java.math.BigDecimal;

public class PosicaoAtivoDto implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String codigo;
	private BigDecimal precoMedio;
	private BigDecimal precoAtual;
	private BigDecimal diferenca;
	private BigDecimal quantidade;
	private BigDecimal totalInvestido;
	private BigDecimal patrimonio;
	private BigDecimal percentual;
	private BigDecimal percentualCarteira;
	
	public PosicaoAtivoDto() {
		super();
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public BigDecimal getPrecoMedio() {
		return precoMedio;
	}

	public void setPrecoMedio(BigDecimal precoMedio) {
		this.precoMedio = precoMedio;
	}

	public BigDecimal getPrecoAtual() {
		return precoAtual;
	}

	public void setPrecoAtual(BigDecimal precoAtual) {
		this.precoAtual = precoAtual;
	}

	public BigDecimal getDiferenca() {
		return diferenca;
	}

	public void setDiferenca(BigDecimal diferenca) {
		this.diferenca = diferenca;
	}

	public BigDecimal getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(BigDecimal quantidade) {
		this.quantidade = quantidade;
	}

	public BigDecimal getTotalInvestido() {
		return totalInvestido;
	}

	public void setTotalInvestido(BigDecimal totalInvestido) {
		this.totalInvestido = totalInvestido;
	}

	public BigDecimal getPatrimonio() {
		return patrimonio;
	}

	public void setPatrimonio(BigDecimal patrimonio) {
		this.patrimonio = patrimonio;
	}

	public BigDecimal getPercentual() {
		return percentual;
	}

	public void setPercentual(BigDecimal percentual) {
		this.percentual = percentual;
	}

	public BigDecimal getPercentualCarteira() {
		return percentualCarteira;
	}

	public void setPercentualCarteira(BigDecimal percentualCarteira) {
		this.percentualCarteira = percentualCarteira;
	}
	
	
}
