package br.com.abs.invest.dtos;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonInclude;


import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class BancoDto {
	
	public interface BancoView {
		public static interface BancoPost {}
		public static interface BancoPut {}
	
	}
	
	@NotBlank(groups = { BancoView.BancoPost.class })
	UsuarioModel usuario;
	
	
	
	private BancoModel banco;
	
	@NotBlank(groups = { BancoView.BancoPost.class, BancoView.BancoPut.class })
	private String nome;
	
	@NotBlank(groups = { BancoView.BancoPost.class, BancoView.BancoPut.class })
	private String cnpj;	
	
	@NotBlank(groups = { BancoView.BancoPost.class, BancoView.BancoPut.class })
	private String numero;	

	
	
}
