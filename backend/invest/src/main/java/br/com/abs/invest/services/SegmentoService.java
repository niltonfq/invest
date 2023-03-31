package br.com.abs.invest.services;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import br.com.abs.invest.models.SegmentoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.SegmentoRepository;

@Service
public class SegmentoService {

	private SegmentoRepository segmentoRepository;
	
	public SegmentoService(SegmentoRepository segmentoRepository) {
		this.segmentoRepository = segmentoRepository;
	}

	public void delete(SegmentoModel model) {
		segmentoRepository.delete(model);		
	}

	public SegmentoModel save(SegmentoModel segmentoModel) {
		return segmentoRepository.save(segmentoModel);		
	}

	public Optional<SegmentoModel> findByUsuarioAndNome(UsuarioModel usuarioModel, String nomeSegmento) {
		return segmentoRepository.findByUsuarioAndNome(usuarioModel, nomeSegmento);
	}

	public Page<SegmentoModel> findByUsuario(UsuarioModel usuarioModel, Pageable pageable) {
		return segmentoRepository.findByUsuario(usuarioModel, pageable);
	}

	public Optional<SegmentoModel> findByUsuarioAndId(UsuarioModel usuarioModel, UUID id) {
		return segmentoRepository.findByUsuarioAndId(usuarioModel, id);
	}

}
