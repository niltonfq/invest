package br.com.abs.invest.controllers;

import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.services.TransacaoService;
import br.com.abs.invest.services.UsuarioService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
public class TransacaoController {
	
	private UsuarioService usuarioService;
	private TransacaoService transacaoService;
	
	public TransacaoController(
			TransacaoService transacaoService,
			UsuarioService usuarioService
		) {
		this.transacaoService = transacaoService;
		this.usuarioService = usuarioService;

	}

	@PostMapping("/usuario/{usuarioId}/transacoes/importB3Negociacoes")
	public ResponseEntity<Object> importB3Negociacao(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@RequestParam("file") MultipartFile excel
		) throws IOException {
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		transacaoService.importarB3Negociacoes(excel, usuarioOptional.get());
		
	    return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Arquivo importado com sucesso");
	}

	
	@PostMapping("/usuario/{usuarioId}/transacoes/importar")
	public ResponseEntity<Object> importar(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@RequestParam("file") MultipartFile excel
			) throws IOException {
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		transacaoService.importar(excel, usuarioOptional.get());
		
		return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Arquivo importado com sucesso");
	}
	

	
	
}
