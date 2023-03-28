package br.com.abs.invest.repositories;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.abs.invest.enums.TipoProvento;
import br.com.abs.invest.models.ProventoModel;
import br.com.abs.invest.models.UsuarioModel;

public interface ProventoRepository extends JpaRepository<ProventoModel, UUID> {

	Optional<ProventoModel> findByUsuarioAndDataAndQuantidadeAndTipoProventoAndTotal(UsuarioModel usuario,
			LocalDate data, BigDecimal quantidade, TipoProvento tipoProvento, BigDecimal total);

}
