package br.com.abs.invest.services;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import br.com.abs.invest.models.PercentualInvestimentoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.PercentualInvestimentoRepository;

@Service
public class PercentualInvestimentoService {

	private PercentualInvestimentoRepository PercentualInvestimentoRepository;
	
	public PercentualInvestimentoService(PercentualInvestimentoRepository PercentualInvestimentoRepository) {
		this.PercentualInvestimentoRepository = PercentualInvestimentoRepository;
	}

	public void delete(PercentualInvestimentoModel model) {
		PercentualInvestimentoRepository.delete(model);		
	}

	public PercentualInvestimentoModel save(PercentualInvestimentoModel PercentualInvestimentoModel) {
		return PercentualInvestimentoRepository.save(PercentualInvestimentoModel);		
	}

	public PercentualInvestimentoModel findByUsuario(UsuarioModel usuarioModel) {
		return PercentualInvestimentoRepository.findByUsuario(usuarioModel);
	}

	public Page<PercentualInvestimentoModel> findByUsuario(UsuarioModel usuarioModel, Pageable pageable) {
		return PercentualInvestimentoRepository.findByUsuario(usuarioModel, pageable);
	}

	public Optional<PercentualInvestimentoModel> findByUsuarioAndId(UsuarioModel usuarioModel, UUID id) {
		return PercentualInvestimentoRepository.findByUsuarioAndId( usuarioModel,  id);
	}



}
