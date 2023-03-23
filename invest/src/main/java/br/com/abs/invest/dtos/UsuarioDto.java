package br.com.abs.invest.dtos;

import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UsuarioDto {
	

	private UUID id;
	
	
}
