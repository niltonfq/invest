package br.com.invest.authuser.services;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import br.com.invest.authuser.models.UsuarioModel;

public interface UsuarioService {

	Page<UsuarioModel> findAll(Specification<UsuarioModel> spec, Pageable pageable);

	Optional<UsuarioModel> findById(UUID id);

	void delete(UsuarioModel usuarioModel);

	void save(UsuarioModel usuarioModel);

	boolean existsByUsername(String username);

	boolean existsByEmail(String email);
	
	
}
