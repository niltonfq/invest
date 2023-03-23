package br.com.abs.invest.dtos;

import java.math.BigDecimal;
import java.time.LocalDate;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonInclude;

import br.com.abs.invest.enums.Moeda;
import br.com.abs.invest.enums.TipoAtivo;
import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AtivoDto {
	
	@NotBlank
	UsuarioDto usuario;
	
	private SegmentoDto segmento;
	
	private BancoDto banco;
	
	@NotBlank
	private String codigo;
	
	@NotBlank
	private TipoAtivo tipoAtivo;	
	
	@NotBlank
	private Moeda moeda;	
	
	private String observacao;
	
	private Short nota = 0;

	private String cnpj;

	private String nome;
	
	private BigDecimal precoMedio = BigDecimal.ZERO;
	
	private BigDecimal totalInvestido = BigDecimal.ZERO;
	
	private BigDecimal quantidadeInvestida = BigDecimal.ZERO;
	
	private BigDecimal valorAtual = BigDecimal.ZERO;
	
	private LocalDate dataAtualizacaoPreco;
	
	@NotBlank
	private Boolean quarentena = false;
	
	
}
