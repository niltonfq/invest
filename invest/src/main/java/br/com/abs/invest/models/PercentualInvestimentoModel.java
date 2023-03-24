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
import org.hibernate.type.descriptor.sql.SmallIntTypeDescriptor;
import org.springframework.hateoas.RepresentationModel;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;




@JsonInclude(JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "banco", 
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
	
	@Column(length = 11)
	private SmallIntTypeDescriptor rendaFixa;
	
	@Column(length = 11)
	private SmallIntTypeDescriptor acoesNacionais;
	
	@Column(length = 11)
	private SmallIntTypeDescriptor acoesInternacionais;
	
	@Column(length = 11)
	private SmallIntTypeDescriptor fundosImobiliarios;
	
	@Column(length = 11)
	private SmallIntTypeDescriptor reits;
	
	@Column(length = 11)
	private SmallIntTypeDescriptor criptoMoedas;
	
	

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



	public SmallIntTypeDescriptor getRendaFixa() {
		return rendaFixa;
	}



	public void setRendaFixa(SmallIntTypeDescriptor rendaFixa) {
		this.rendaFixa = rendaFixa;
	}



	public SmallIntTypeDescriptor getAcoesNacionais() {
		return acoesNacionais;
	}



	public void setAcoesNacionais(SmallIntTypeDescriptor acoesNacionais) {
		this.acoesNacionais = acoesNacionais;
	}



	public SmallIntTypeDescriptor getAcoesInternacionais() {
		return acoesInternacionais;
	}



	public void setAcoesInternacionais(SmallIntTypeDescriptor acoesInternacionais) {
		this.acoesInternacionais = acoesInternacionais;
	}



	public SmallIntTypeDescriptor getFundosImobiliarios() {
		return fundosImobiliarios;
	}



	public void setFundosImobiliarios(SmallIntTypeDescriptor fundosImobiliarios) {
		this.fundosImobiliarios = fundosImobiliarios;
	}



	public SmallIntTypeDescriptor getReits() {
		return reits;
	}



	public void setReits(SmallIntTypeDescriptor reits) {
		this.reits = reits;
	}



	public SmallIntTypeDescriptor getCriptoMoedas() {
		return criptoMoedas;
	}



	public void setCriptoMoedas(SmallIntTypeDescriptor criptoMoedas) {
		this.criptoMoedas = criptoMoedas;
	}
	
	

	
	
	
		
}

