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
import br.com.abs.invest.services.ProventoService;
import br.com.abs.invest.services.UsuarioService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
public class ProventoController {
	
	private UsuarioService usuarioService;
	private ProventoService proventoService;
	
	public ProventoController(
			ProventoService transacaoService,
			UsuarioService usuarioService
		) {
		this.proventoService = transacaoService;
		this.usuarioService = usuarioService;

	}

	@PostMapping("/proventos/importB3Movimentacao/usuario/{usuarioId}")
	public ResponseEntity<Object> importB3Movimento(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@RequestParam("file") MultipartFile excel
			) throws IOException {
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		proventoService.importarB3Movimento(excel, usuarioOptional.get());
		
		return ResponseEntity.status(HttpStatus.CREATED).body("Arquivo importado com sucesso");
	}

}
