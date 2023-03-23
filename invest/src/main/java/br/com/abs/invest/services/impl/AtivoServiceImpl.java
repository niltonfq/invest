package br.com.abs.invest.services.impl;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.repositories.AtivoRepository;
import br.com.abs.invest.services.AtivoService;

@Service
public class AtivoServiceImpl implements AtivoService {

	@Autowired
	AtivoRepository repository;

	@Override
	public Page<AtivoModel> findAll(Specification<AtivoModel> spec, Pageable pageable) {
		return repository.findAll(spec, pageable);
	}

	@Override
	public Optional<AtivoModel> findById(UUID id) {
		return repository.findById(id);
	}

	@Override
	public void delete(AtivoModel model) {
		repository.delete(model);		
	}

	@Override
	public void save(AtivoModel userModel) {
		repository.save(userModel);		
	}

	
}
