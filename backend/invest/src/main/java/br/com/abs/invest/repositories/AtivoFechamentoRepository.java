package br.com.abs.invest.repositories;

import java.time.LocalDate;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import br.com.abs.invest.models.AtivoFechamentoModel;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.UsuarioModel;

public interface AtivoFechamentoRepository extends JpaRepository<AtivoFechamentoModel, UUID> {

	Page<AtivoFechamentoModel> findByUsuario(UsuarioModel usuarioModel, Pageable pageable);

	Optional<AtivoFechamentoModel> findByUsuarioAndId(UsuarioModel usuarioModel, UUID id);

	@Modifying
	@Query("Delete from AtivoFechamentoModel af where af.usuario = :usuario and af.data > :inicio and af.ativo = :ativo ")
	void deletaTodosFechamentosAtivoAposData(UsuarioModel usuario, AtivoModel ativo, LocalDate inicio);

	
	Optional<AtivoFechamentoModel> findFirstByUsuarioAndAtivoAndDataBeforeOrderByDataDesc(UsuarioModel usuario,
			AtivoModel ativoModel, LocalDate data);

}
