package br.com.abs.invest.controllers;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Optional;
import java.util.UUID;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import br.com.abs.invest.dtos.BancoDto;
import br.com.abs.invest.models.BancoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.services.BancoService;
import br.com.abs.invest.services.UsuarioService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
public class BancoController {
	
	@Autowired
	BancoService bancoService;
	
	@Autowired
	UsuarioService usuarioService;

	@GetMapping(value = "/usuario/{usuarioId}/bancos")
	public ResponseEntity<Object> getAll(			
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PageableDefault(page = 0, size = 10, sort = "id", direction = Direction.ASC) Pageable pageable
		) {
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Page<BancoModel> page = bancoService.findByUsuario(usuarioOptional.get(), pageable);
		
		if (!page.isEmpty()) {
			for (BancoModel banco : page.toList()) {
				banco.add(linkTo(methodOn(BancoController.class).getOne(usuarioId, banco.getId())).withSelfRel());
			}
		}
		
		return ResponseEntity.status(HttpStatus.OK).body(page);
	}
	
	@GetMapping(value = "/usuario/{usuarioId}/bancos/{id}")
	public ResponseEntity<Object> getOne(
			@PathVariable(value = "usuarioId") UUID usuarioId,	
			@PathVariable(value = "id") UUID id
		) { 
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<BancoModel> optional = bancoService.findByUsuarioAndId(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Banco não encontrado");
		} 
			
		return ResponseEntity.status(HttpStatus.OK).body(optional.get());
		
	}
	
	@DeleteMapping(value = "/usuario/{usuarioId}/bancos/{id}")
	public ResponseEntity<Object> delete(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PathVariable(value = "id") UUID id
		) { 
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<BancoModel> optional = bancoService.findByUsuarioAndId(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Banco não encontrado");
		} 
			
		bancoService.delete(optional.get());
		return ResponseEntity.status(HttpStatus.OK).body("Deletado com sucesso");
		
	}
	
	@PostMapping("/usuario/{usuarioId}/bancos")
	public ResponseEntity<Object> create(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@RequestBody @Valid BancoDto bancoDto
		) {
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		var bancoModel = new BancoModel();		
		BeanUtils.copyProperties(bancoDto, bancoModel);		
		
		bancoModel.setUsuario(usuarioOptional.get());
		bancoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
		bancoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
		bancoService.save(bancoModel);
		
		return ResponseEntity.status(HttpStatus.CREATED).body(bancoModel);
	}
	
	
	@PutMapping(value = "/usuario/{usuarioId}/bancos/{id}")
	public ResponseEntity<Object> update(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PathVariable(value = "id") UUID id,			
			@RequestBody @Valid BancoDto bancoDto
			
		) { 
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<BancoModel> optional = bancoService.findByUsuarioAndId(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Banco não encontrado");
		} 
			
		var bancoModel = optional.get();
		
		bancoDto.setId(id);
		BeanUtils.copyProperties(bancoDto, bancoModel);			
		bancoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));			
		bancoService.save(bancoModel);
		
		return ResponseEntity.status(HttpStatus.OK).body(bancoModel);
		
	}
	
}
