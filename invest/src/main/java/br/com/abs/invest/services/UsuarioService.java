package br.com.abs.invest.services;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;

import br.com.abs.invest.models.AtivoModel;

public interface UsuarioService {

	Page<AtivoModel> findAll(Specification<AtivoModel> spec, Pageable pageable);

	Optional<AtivoModel> findById(UUID id);

	void delete(AtivoModel userModel);

	void save(AtivoModel userModel);
	
	
}
