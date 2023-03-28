package br.com.abs.invest.repositories;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import br.com.abs.invest.models.SegmentoModel;
import br.com.abs.invest.models.UsuarioModel;

public interface SegmentoRepository extends JpaRepository<SegmentoModel, UUID> {

	Optional<SegmentoModel> findByUsuarioAndNome(UsuarioModel usuarioModel, String nomeSegmento);

	Page<SegmentoModel> findByUsuario(UsuarioModel usuarioModel, Pageable pageable);

	Optional<SegmentoModel> findByUsuarioAndId(UsuarioModel usuarioModel, UUID id);

}
