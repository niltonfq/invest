package br.com.abs.invest.services;

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



}
