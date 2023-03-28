package br.com.abs.invest.dtos;

import java.util.UUID;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonInclude;




@JsonInclude(JsonInclude.Include.NON_NULL)
public class BancoDto {
	
	private UUID id;
	
	@NotNull
	UsuarioDto usuario;
		
	@NotBlank
	private String nome;
	
	private String cnpj;	
	
	private String numero;

	public BancoDto() {
		super();
	}
	
	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public UsuarioDto getUsuario() {
		return usuario;
	}

	public void setUsuario(UsuarioDto usuario) {
		this.usuario = usuario;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public String getNumero() {
		return numero;
	}

	public void setNumero(String numero) {
		this.numero = numero;
	}	

	
	
}
