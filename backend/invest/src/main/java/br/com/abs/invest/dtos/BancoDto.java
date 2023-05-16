package br.com.abs.invest.dtos;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonInclude;




@JsonInclude(JsonInclude.Include.NON_NULL)
public class BancoDto {
	
	
	
		
	@NotBlank
	private String nome;
	
	private String cnpj;	
	
	private String numero;

	public BancoDto() {
		super();
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
