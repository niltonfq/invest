package br.com.abs.invest.repositories;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.abs.invest.enums.TipoOperacao;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.TransacaoModel;
import br.com.abs.invest.models.UsuarioModel;

public interface TransacaoRepository extends JpaRepository<TransacaoModel, UUID>{

	Optional<TransacaoModel> findByUsuarioAndDataAndQuantidadeAndTipoOperacaoAndTotal(
			UsuarioModel usuario,
			LocalDate data, 
			BigDecimal quantidade,
			TipoOperacao tipoOperacao, 
			BigDecimal total
		);

	
	List<TransacaoModel> findByUsuarioAndAtivoAndDataBetweenOrderByDataAscTipoOperacaoAsc(UsuarioModel usuario, AtivoModel ativo, LocalDate dataInicial, LocalDate dataFinal);


	Optional<TransacaoModel> findFirstByUsuarioAndAtivoOrderByData(UsuarioModel usuario, AtivoModel ativoModel);

}
