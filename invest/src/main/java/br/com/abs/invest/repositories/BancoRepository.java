package br.com.abs.invest.repositories;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import br.com.abs.invest.models.BancoModel;
import br.com.abs.invest.models.UsuarioModel;

public interface BancoRepository extends JpaRepository<BancoModel, UUID> {

	Optional<BancoModel> findByUsuarioAndNome(UsuarioModel usuarioModel, String nomeBanco);

	Page<BancoModel> findByUsuario(UsuarioModel usuarioModel, Pageable pageable);

	Optional<BancoModel> findByUsuarioAndId(UsuarioModel usuarioModel, UUID id);

}
