package br.com.abs.invest.dtos;

import java.io.Serializable;
import java.util.UUID;

import org.hibernate.annotations.Type;

import com.fasterxml.jackson.annotation.JsonInclude;


@JsonInclude(JsonInclude.Include.NON_NULL)
public class PercentualInvestimentoDto implements Serializable {
	private static final long serialVersionUID = 1L;

	@Type(type = "uuid-char")
	private UUID id;
	
	UsuarioDto usuario;
	
	private short rendaFixa;
	private short rendaVariavel;
	private short acoes;
	private short fundosImobiliarios;
	private short fundosInvestimentos;
	private short fiagro;
	private short stocks;
	private short reits;
	private short etfsNacional;
	private short etfsInternacional;
	private short criptoMoedas;
	private short tesouroDireto;
	private short cdb;
	private short lciLca;
	private short criCra;
	private short debendures;
	private short bdrs;

	public PercentualInvestimentoDto() {
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

	public short getRendaFixa() {
		return rendaFixa;
	}

	public void setRendaFixa(short rendaFixa) {
		this.rendaFixa = rendaFixa;
	}

	public short getFundosImobiliarios() {
		return fundosImobiliarios;
	}

	public void setFundosImobiliarios(short fundosImobiliarios) {
		this.fundosImobiliarios = fundosImobiliarios;
	}

	public short getReits() {
		return reits;
	}

	public void setReits(short reits) {
		this.reits = reits;
	}

	public short getCriptoMoedas() {
		return criptoMoedas;
	}

	public void setCriptoMoedas(short criptoMoedas) {
		this.criptoMoedas = criptoMoedas;
	}

	public short getRendaVariavel() {
		return rendaVariavel;
	}

	public void setRendaVariavel(short rendaVariavel) {
		this.rendaVariavel = rendaVariavel;
	}

	public short getAcoes() {
		return acoes;
	}

	public void setAcoes(short acoes) {
		this.acoes = acoes;
	}

	public short getFundosInvestimentos() {
		return fundosInvestimentos;
	}

	public void setFundosInvestimentos(short fundosInvestimentos) {
		this.fundosInvestimentos = fundosInvestimentos;
	}

	public short getFiagro() {
		return fiagro;
	}

	public void setFiagro(short fiagro) {
		this.fiagro = fiagro;
	}

	public short getStocks() {
		return stocks;
	}

	public void setStocks(short stocks) {
		this.stocks = stocks;
	}

	public short getEtfsNacional() {
		return etfsNacional;
	}

	public void setEtfsNacional(short etfsNacional) {
		this.etfsNacional = etfsNacional;
	}

	public short getEtfsInternacional() {
		return etfsInternacional;
	}

	public void setEtfsInternacional(short etfsInternacional) {
		this.etfsInternacional = etfsInternacional;
	}

	public short getTesouroDireto() {
		return tesouroDireto;
	}

	public void setTesouroDireto(short tesouroDireto) {
		this.tesouroDireto = tesouroDireto;
	}

	public short getCdb() {
		return cdb;
	}

	public void setCdb(short cdb) {
		this.cdb = cdb;
	}

	public short getLciLca() {
		return lciLca;
	}

	public void setLciLca(short lciLca) {
		this.lciLca = lciLca;
	}

	public short getCriCra() {
		return criCra;
	}

	public void setCriCra(short criCra) {
		this.criCra = criCra;
	}

	public short getDebendures() {
		return debendures;
	}

	public void setDebendures(short debendures) {
		this.debendures = debendures;
	}

	public short getBdrs() {
		return bdrs;
	}

	public void setBdrs(short bdrs) {
		this.bdrs = bdrs;
	}
	
}
