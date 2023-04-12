package br.com.abs.invest.dtos;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import br.com.abs.invest.enums.TipoAtivo;

public class PosicaoTipoAtivoDto implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private TipoAtivo tipoAtipo;
	private Long quantidade;
	private BigDecimal percentual;
	private BigDecimal total;
	private BigDecimal totalDesejado;
	private BigDecimal diferenca;
	private BigDecimal aporte;
	private List<PosicaoAtivoDto> ativos = new ArrayList<>();
	
	public PosicaoTipoAtivoDto() {
		super();
	}
	
	

	public PosicaoTipoAtivoDto(TipoAtivo tipoAtipo, Long quantidade, BigDecimal percentual, BigDecimal total) {
		super();
		this.tipoAtipo = tipoAtipo;
		this.quantidade = quantidade;
		this.percentual = percentual;
		this.total = total;
	}

	public BigDecimal getDiferenca() {
		return diferenca;
	}

	public void setDiferenca(BigDecimal diferenca) {
		this.diferenca = diferenca;
	}

	public BigDecimal getAporte() {
		return aporte;
	}

	public void setAporte(BigDecimal aporte) {
		this.aporte = aporte;
	}

	public BigDecimal getTotalDesejado() {
		return totalDesejado;
	}

	public void setTotalDesejado(BigDecimal totalDesejado) {
		this.totalDesejado = totalDesejado;
	}

	public TipoAtivo getTipoAtipo() {
		return tipoAtipo;
	}

	public void setTipoAtipo(TipoAtivo tipoAtipo) {
		this.tipoAtipo = tipoAtipo;
	}

	public Long getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(Long quantidade) {
		this.quantidade = quantidade;
	}

	public BigDecimal getPercentual() {
		return percentual;
	}

	public void setPercentual(BigDecimal percentual) {
		this.percentual = percentual;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public List<PosicaoAtivoDto> getAtivos() {
		return ativos;
	}

	public void setAtivos(List<PosicaoAtivoDto> ativos) {
		this.ativos = ativos;
	}

	
	
}
