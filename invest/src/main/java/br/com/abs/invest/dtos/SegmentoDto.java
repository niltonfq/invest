package br.com.abs.invest.dtos;

import java.io.Serializable;
import java.util.UUID;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonInclude;



@JsonInclude(JsonInclude.Include.NON_NULL)
public class SegmentoDto implements Serializable {
	private static final long serialVersionUID = 1L;

	private UUID id;
	
	
	@NotBlank
	private String nome;

	public SegmentoDto() {
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
