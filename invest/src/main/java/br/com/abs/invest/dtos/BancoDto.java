package br.com.abs.invest.dtos;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class BancoDto {
		
	@NotNull
	UsuarioDto usuario;
		
	@NotBlank
	private String nome;
	
	private String cnpj;	
	
	private String numero;	

	
	
}
