package br.com.abs.invest.dtos;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.UUID;

import javax.validation.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonInclude;

import br.com.abs.invest.enums.Moeda;
import br.com.abs.invest.enums.TipoAtivo;
import br.com.abs.invest.models.BancoModel;
import br.com.abs.invest.models.SegmentoModel;
import br.com.abs.invest.models.UsuarioModel;
import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AtivoDto {
	
	public interface AtivoView {
		public static interface AtivoPost {}
		public static interface AtivoPut {}
	}
	

	private UUID id;
	
	@NotBlank(groups = { AtivoView.AtivoPost.class })
	UsuarioModel usuario;
	
	private SegmentoModel segmento;
	
	private BancoModel banco;
	
	@NotBlank(groups = { AtivoView.AtivoPost.class, AtivoView.AtivoPut.class })
	private String codigo;
	
	@NotBlank(groups = { AtivoView.AtivoPost.class, AtivoView.AtivoPut.class })
	private TipoAtivo tipoAtivo;	
	
	@NotBlank(groups = { AtivoView.AtivoPost.class, AtivoView.AtivoPut.class })
	private Moeda moeda;	
	
	private String observacao;
	
	private Short nota = 0;

	private String cnpj;

	@NotBlank(groups = { AtivoView.AtivoPost.class, AtivoView.AtivoPut.class })
	private String nome;
	
	private BigDecimal precoMedio = BigDecimal.ZERO;
	
	private BigDecimal totalInvestido = BigDecimal.ZERO;
	
	private BigDecimal quantidadeInvestida = BigDecimal.ZERO;
	
	private BigDecimal valorAtual = BigDecimal.ZERO;
	
	private LocalDate dataAtualizacaoPreco;
	
	@NotBlank(groups = { AtivoView.AtivoPost.class, AtivoView.AtivoPut.class })
	private Boolean quarentena = false;
	
	
}
