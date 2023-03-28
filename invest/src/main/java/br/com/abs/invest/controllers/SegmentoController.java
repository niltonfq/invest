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

import br.com.abs.invest.dtos.SegmentoDto;
import br.com.abs.invest.models.SegmentoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.services.SegmentoService;
import br.com.abs.invest.services.UsuarioService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
public class SegmentoController {
	
	@Autowired
	SegmentoService segmentoService;
	
	@Autowired
	UsuarioService usuarioService;

	@GetMapping(value = "/usuario/{usuarioId}/segmentos")
	public ResponseEntity<Object> getAll(			
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PageableDefault(page = 0, size = 10, sort = "id", direction = Direction.ASC) Pageable pageable
		) {
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Page<SegmentoModel> page = segmentoService.findByUsuario(usuarioOptional.get(), pageable);
		
		if (!page.isEmpty()) {
			for (SegmentoModel segmento : page.toList()) {
				segmento.add(linkTo(methodOn(SegmentoController.class).getOne(usuarioId, segmento.getId())).withSelfRel());
			}
		}
		
		return ResponseEntity.status(HttpStatus.OK).body(page);
	}
	
	@GetMapping(value = "/usuario/{usuarioId}/segmentos/{id}")
	public ResponseEntity<Object> getOne(
			@PathVariable(value = "usuarioId") UUID usuarioId,	
			@PathVariable(value = "id") UUID id
		) { 
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<SegmentoModel> optional = segmentoService.findByUsuarioAndId(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Segmento não encontrado");
		} 
			
		return ResponseEntity.status(HttpStatus.OK).body(optional.get());
		
	}
	
	@DeleteMapping(value = "/usuario/{usuarioId}/segmentos/{id}")
	public ResponseEntity<Object> delete(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PathVariable(value = "id") UUID id
		) { 
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<SegmentoModel> optional = segmentoService.findByUsuarioAndId(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Segmento não encontrado");
		} 
			
		segmentoService.delete(optional.get());
		return ResponseEntity.status(HttpStatus.OK).body("Deletado com sucesso");
		
	}
	
	@PostMapping("/usuario/{usuarioId}/segmentos")
	public ResponseEntity<Object> create(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@RequestBody @Valid SegmentoDto segmentoDto
		) {
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		var segmentoModel = new SegmentoModel();		
		BeanUtils.copyProperties(segmentoDto, segmentoModel);		
		
		segmentoModel.setUsuario(usuarioOptional.get());
		segmentoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
		segmentoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
		segmentoService.save(segmentoModel);
		
		return ResponseEntity.status(HttpStatus.CREATED).body(segmentoModel);
	}
	
	
	@PutMapping(value = "/usuario/{usuarioId}/segmentos/{id}")
	public ResponseEntity<Object> update(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PathVariable(value = "id") UUID id,			
			@RequestBody @Valid SegmentoDto segmentoDto
			
		) { 
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<SegmentoModel> optional = segmentoService.findByUsuarioAndId(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Segmento não encontrado");
		} 
			
		var segmentoModel = optional.get();
		
		segmentoDto.setId(id);
		BeanUtils.copyProperties(segmentoDto, segmentoModel);			
		segmentoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));			
		segmentoService.save(segmentoModel);
		
		return ResponseEntity.status(HttpStatus.OK).body(segmentoModel);
		
	}
	
}
