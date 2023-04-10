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
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.fasterxml.jackson.annotation.JsonInclude;




@JsonInclude(JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "percentualInvestimento", 
	   uniqueConstraints = { @UniqueConstraint(columnNames = {"usuarioId"}) }
)
public class PercentualInvestimentoModel extends RepresentationModel<BancoModel> implements Serializable {
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
	
	@Column( nullable = false)
	private short rendaFixa;
	
	@Column( nullable = false)
	private short rendaVariavel;
	
	
	
	@Column( nullable = false)
	private short acoes;
	
	@Column( nullable = false)
	private short fundosImobiliarios;
	
	@Column( nullable = false)
	private short fundosInvestimentos;
	
	@Column( nullable = false)
	private short fiagro;
	
	@Column( nullable = false)
	private short stocks;
	
	@Column( nullable = false)
	private short reits;
	
	@Column( nullable = false)
	private short etfsNacional;
	
	@Column( nullable = false)
	private short etfsInternacional;
	
	@Column( nullable = false)
	private short criptoMoedas;
	
	@Column( nullable = false)
	private short tesouroDireto;
	
	@Column( nullable = false)
	private short cdb;
	
	@Column( nullable = false)
	private short lciLca;
	
	@Column( nullable = false)
	private short criCra;
	
	@Column( nullable = false)
	private short debendures;
	
	@Column( nullable = false)
	private short bdrs;

	public PercentualInvestimentoModel() {
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

