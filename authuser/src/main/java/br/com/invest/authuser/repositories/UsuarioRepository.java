package br.com.invest.authuser.repositories;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import br.com.invest.authuser.models.UsuarioModel;

public interface UsuarioRepository extends JpaRepository<UsuarioModel, UUID>, JpaSpecificationExecutor<UsuarioModel>{

	boolean existsByUsername(String username);

	boolean existsByEmail(String email);

}
