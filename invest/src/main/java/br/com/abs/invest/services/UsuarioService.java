package br.com.abs.invest.services;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.UsuarioRepository;

@Service
public class UsuarioService {

	@Autowired
	UsuarioRepository repository;

	public Page<UsuarioModel> findAll(Pageable pageable) {
		return repository.findAll(pageable);
	}

	public Optional<UsuarioModel> findById(UUID id) {
		return repository.findById(id);
	}

	public void delete(UsuarioModel model) {
		repository.delete(model);		
	}

	public void save(UsuarioModel userModel) {
		repository.save(userModel);		
	}

}
