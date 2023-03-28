package br.com.abs.invest.dtos;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.UUID;

import javax.validation.constraints.NotBlank;

public class MetaDto implements Serializable {
	private static final long serialVersionUID = 1L;

	private UUID id;
	
	@NotBlank
	private String nome;
	
	private BigDecimal montante;

	public MetaDto() {
		super();
	}
	
	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public BigDecimal getMontante() {
		return montante;
	}

	public void setMontante(BigDecimal montante) {
		this.montante = montante;
	}
	
	
	
}
