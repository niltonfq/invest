package br.com.abs.invest.dtos;

import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonInclude;




@JsonInclude(JsonInclude.Include.NON_NULL)
public class UsuarioDto {
	

	private UUID id;

	public UsuarioDto() {
		super();
	}

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}
	
	
	
	
}
