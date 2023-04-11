package br.com.abs.invest.repositories;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import br.com.abs.invest.models.PercentualInvestimentoModel;
import br.com.abs.invest.models.UsuarioModel;

public interface PercentualInvestimentoRepository extends JpaRepository<PercentualInvestimentoModel, UUID>{

	PercentualInvestimentoModel findByUsuario(UsuarioModel usuarioModel);

	Page<PercentualInvestimentoModel> findByUsuario(UsuarioModel usuarioModel, Pageable pageable);

	Optional<PercentualInvestimentoModel> findByUsuarioAndId(UsuarioModel usuarioModel, UUID id);

}
