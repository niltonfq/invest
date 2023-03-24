package br.com.abs.invest.models;

import java.io.Serializable;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Type;
import org.springframework.hateoas.RepresentationModel;

import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "dominio")
public class DominioModel extends RepresentationModel<DominioModel> implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Type(type = "uuid-char")
	@Column(nullable = false, columnDefinition="char(36)")
	private UUID id;
	
	
	@Column(nullable = false,length = 100)
	private String tabela;
	
	
	@Column(nullable = false, length = 100)
	private String campo;
	
	@Column(nullable = false,length = 255)
	private String valor;
	
	@Column(nullable = false,  length = 255)
	private String descricao;
	
	@Column(length = 11)
	private short ordem;

	public DominioModel() {
		super();
	}

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public String getTabela() {
		return tabela;
	}

	public void setTabela(String tabela) {
		this.tabela = tabela;
	}

	public String getCampo() {
		return campo;
	}

	public void setCampo(String campo) {
		this.campo = campo;
	}

	public String getValor() {
		return valor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public short getOrdem() {
		return ordem;
	}

	public void setOrdem(short ordem) {
		this.ordem = ordem;
	}
	
	
	
	
	
}
