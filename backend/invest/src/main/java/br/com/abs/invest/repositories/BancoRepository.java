package br.com.abs.invest.repositories;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import br.com.abs.invest.models.BancoModel;
import br.com.abs.invest.models.UsuarioModel;

public interface BancoRepository extends JpaRepository<BancoModel, UUID>, JpaSpecificationExecutor<BancoModel> {

	Optional<BancoModel> findByUsuarioAndNome(UsuarioModel usuarioModel, String nomeBanco);

	Optional<BancoModel> findByUsuarioAndId(UsuarioModel usuarioModel, UUID id);

	

}
