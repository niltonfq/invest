package br.com.invest.authuser.services.impl;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import br.com.invest.authuser.models.UsuarioModel;
import br.com.invest.authuser.repositories.UsuarioRepository;
import br.com.invest.authuser.services.UsuarioService;

@Service
public class UsuarioServiceImpl implements UsuarioService {

	@Autowired
	UsuarioRepository repository;

	@Override
	public Page<UsuarioModel> findAll(Specification<UsuarioModel> spec, Pageable pageable) {
		return repository.findAll(spec, pageable);
	}

	@Override
	public Optional<UsuarioModel> findById(UUID id) {
		return repository.findById(id);
	}

	@Override
	public void delete(UsuarioModel model) {
		repository.delete(model);		
	}

	@Override
	public void save(UsuarioModel usuarioModel) {
		repository.save(usuarioModel);		
	}

	@Override
	public boolean existsByUsername(String username) {
		return repository.existsByUsername(username);
	}

	@Override
	public boolean existsByEmail(String email) {
		return repository.existsByEmail(email);
	}
	
}
