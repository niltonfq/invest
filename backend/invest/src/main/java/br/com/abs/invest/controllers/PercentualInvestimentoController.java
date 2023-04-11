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

import br.com.abs.invest.dtos.PercentualInvestimentoDto;
import br.com.abs.invest.models.PercentualInvestimentoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.services.PercentualInvestimentoService;
import br.com.abs.invest.services.UsuarioService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
public class PercentualInvestimentoController {
	
	@Autowired
	PercentualInvestimentoService percentualInvestimentoService;
	
	@Autowired
	UsuarioService usuarioService;

	@GetMapping(value = "/percentualInvestimentos/usuario/{usuarioId}")
	public ResponseEntity<Object> getAll(			
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PageableDefault(page = 0, size = 10, sort = "id", direction = Direction.ASC) Pageable pageable
		) {
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Page<PercentualInvestimentoModel> page = percentualInvestimentoService.findByUsuario(usuarioOptional.get(), pageable);
		
		if (!page.isEmpty()) {
			for (PercentualInvestimentoModel percentualInvestimento : page.toList()) {
				percentualInvestimento.add(linkTo(methodOn(PercentualInvestimentoController.class).getOne(usuarioId, percentualInvestimento.getId())).withSelfRel());
			}
		}
		
		return ResponseEntity.status(HttpStatus.OK).body(page);
	}
	
	@GetMapping(value = "/percentualInvestimentos/{id}/usuario/{usuarioId}")
	public ResponseEntity<Object> getOne(
			@PathVariable(value = "usuarioId") UUID usuarioId,	
			@PathVariable(value = "id") UUID id
		) { 
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<PercentualInvestimentoModel> optional = percentualInvestimentoService.findByUsuarioAndId(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("PercentualInvestimento não encontrado");
		} 
			
		return ResponseEntity.status(HttpStatus.OK).body(optional.get());
		
	}
	
	@DeleteMapping(value = "/percentualInvestimentos/{id}/usuario/{usuarioId}")
	public ResponseEntity<Object> delete(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PathVariable(value = "id") UUID id
		) { 
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<PercentualInvestimentoModel> optional = percentualInvestimentoService.findByUsuarioAndId(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("PercentualInvestimento não encontrado");
		} 
			
		percentualInvestimentoService.delete(optional.get());
		return ResponseEntity.status(HttpStatus.OK).body("Deletado com sucesso");
		
	}
	
	@PostMapping("/percentualInvestimentos/usuario/{usuarioId}")
	public ResponseEntity<Object> create(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@RequestBody @Valid PercentualInvestimentoDto percentualInvestimentoDto
		) {
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		var percentualInvestimentoModel = new PercentualInvestimentoModel();		
		BeanUtils.copyProperties(percentualInvestimentoDto, percentualInvestimentoModel);		
		
		percentualInvestimentoModel.setUsuario(usuarioOptional.get());
		percentualInvestimentoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
		percentualInvestimentoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
		percentualInvestimentoService.save(percentualInvestimentoModel);
		
		return ResponseEntity.status(HttpStatus.CREATED).body(percentualInvestimentoModel);
	}
	
	
	@PutMapping(value = "/percentualInvestimentos/{id}/usuario/{usuarioId}")
	public ResponseEntity<Object> update(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PathVariable(value = "id") UUID id,			
			@RequestBody @Valid PercentualInvestimentoDto percentualInvestimentoDto
			
		) { 
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<PercentualInvestimentoModel> optional = percentualInvestimentoService.findByUsuarioAndId(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("PercentualInvestimento não encontrado");
		} 
			
		var percentualInvestimentoModel = optional.get();
		
		percentualInvestimentoDto.setId(id);
		BeanUtils.copyProperties(percentualInvestimentoDto, percentualInvestimentoModel);			
		percentualInvestimentoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));			
		percentualInvestimentoService.save(percentualInvestimentoModel);
		
		return ResponseEntity.status(HttpStatus.OK).body(percentualInvestimentoModel);
		
	}
	
}
