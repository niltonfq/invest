package br.com.abs.invest.dtos;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SegmentoDto {

	@NotBlank
	private String nome;
	
}
