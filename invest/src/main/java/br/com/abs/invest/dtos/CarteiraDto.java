package br.com.abs.invest.dtos;

import java.io.Serializable;
import java.util.UUID;

public class CarteiraDto implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private UUID id;
	private String nome;
	
	public CarteiraDto() {
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
	
	
}
