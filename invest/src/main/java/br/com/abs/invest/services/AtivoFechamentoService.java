package br.com.abs.invest.services;

import java.time.LocalDate;
import java.util.Optional;
import java.util.UUID;

import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import br.com.abs.invest.models.AtivoFechamentoModel;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.AtivoFechamentoRepository;

@Service
public class AtivoFechamentoService {

	private AtivoFechamentoRepository ativoFechamentoRepository;
	
	public AtivoFechamentoService(AtivoFechamentoRepository ativoFechamentoRepository) {
		this.ativoFechamentoRepository = ativoFechamentoRepository;
	}

	public void delete(AtivoFechamentoModel model) {
		ativoFechamentoRepository.delete(model);		
	}

	public AtivoFechamentoModel save(AtivoFechamentoModel ativoFechamentoModel) {
		return ativoFechamentoRepository.save(ativoFechamentoModel);		
	}

	public Page<AtivoFechamentoModel> findByUsuario(UsuarioModel usuarioModel, Pageable pageable) {
		return ativoFechamentoRepository.findByUsuario(usuarioModel, pageable);
	}

	public Optional<AtivoFechamentoModel> findByUsuarioAndId(UsuarioModel usuarioModel, UUID id) {
		return ativoFechamentoRepository.findByUsuarioAndId(usuarioModel, id);
	}

	@Transactional
	public void deletaTodosFechamentosAtivoAposData(UsuarioModel usuario, AtivoModel ativoModel, LocalDate inicio) {
		ativoFechamentoRepository.deletaTodosFechamentosAtivoAposData(usuario, ativoModel, inicio);
		
	}

	public Optional<AtivoFechamentoModel> findFirstUltimoFechamentoAtivoAntesData(
			UsuarioModel usuario, AtivoModel ativoModel, LocalDate data) {
		return ativoFechamentoRepository.findFirstByUsuarioAndAtivoAndDataBeforeOrderByDataDesc( 
				usuario, ativoModel, data);
	}

}
