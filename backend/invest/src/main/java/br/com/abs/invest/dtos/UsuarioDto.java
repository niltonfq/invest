package br.com.abs.invest.dtos;

import java.io.Serializable;
import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonInclude;




@JsonInclude(JsonInclude.Include.NON_NULL)
public class UsuarioDto implements Serializable {
	private static final long serialVersionUID = 1L;
	
	
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
