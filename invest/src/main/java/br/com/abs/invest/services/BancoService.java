package br.com.abs.invest.services;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import br.com.abs.invest.models.BancoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.BancoRepository;

@Service
public class BancoService {

	private BancoRepository bancoRepository;
	
	public BancoService(BancoRepository bancoRepository) {
		this.bancoRepository = bancoRepository;
	}

	public void delete(BancoModel model) {
		bancoRepository.delete(model);		
	}

	public BancoModel save(BancoModel bancoModel) {
		return bancoRepository.save(bancoModel);		
	}

	public Optional<BancoModel> findByUsuarioAndNome(UsuarioModel usuarioModel, String nomeBanco) {
		return bancoRepository.findByUsuarioAndNome(usuarioModel, nomeBanco);
	}

	public Page<BancoModel> findByUsuario(UsuarioModel usuarioModel, Pageable pageable) {
		return bancoRepository.findByUsuario(usuarioModel, pageable);
	}

	public Optional<BancoModel> findByUsuarioAndId(UsuarioModel usuarioModel, UUID id) {
		return bancoRepository.findByUsuarioAndId(usuarioModel, id);
	}

}
