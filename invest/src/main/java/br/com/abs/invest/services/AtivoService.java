package br.com.abs.invest.services;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.AtivoRepository;

@Service
public class AtivoService {

	@Autowired
	AtivoRepository repository;

	public Optional<AtivoModel> findByUsuario(UsuarioModel usuario, UUID id) {
		return repository.findByUsuarioAndId(usuario, id);
	}

	public void delete(AtivoModel model) {
		repository.delete(model);		
	}

	public void save(AtivoModel userModel) {
		repository.save(userModel);		
	}

    public Page<AtivoModel> findAllByUsuario(Specification<AtivoModel> spec, Pageable pageable) {
		return repository.findAll(spec, pageable);
    }

	
}
