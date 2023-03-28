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

import br.com.abs.invest.dtos.AtivoDto;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.services.AtivoService;
import br.com.abs.invest.services.UsuarioService;
import br.com.abs.invest.specifications.SpecificationTemplate;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
public class AtivoController {
	
	@Autowired
	AtivoService ativoService;
	
	@Autowired
	UsuarioService usuarioService;

	@GetMapping(value = "/usuario/{usuarioId}/ativos")
	public ResponseEntity<Object> getAll(			
			@PathVariable(value = "usuarioId") UUID usuarioId,
			SpecificationTemplate.AtivoSpec spec,	
			@PageableDefault(page = 0, size = 10, sort = "id", direction = Direction.ASC) Pageable pageable
		) {
		
		Page<AtivoModel> page = ativoService.findAllByUsuario(SpecificationTemplate.ativosUsuarioId(usuarioId).and(spec), pageable);
		
		if (!page.isEmpty()) {
			for (AtivoModel ativo : page.toList()) {
				ativo.add(linkTo(methodOn(AtivoController.class).getOne(usuarioId, ativo.getId())).withSelfRel());
			}
		}
		
		return ResponseEntity.status(HttpStatus.OK).body(page);
	}
	
	@GetMapping(value = "/usuario/{usuarioId}/ativos/{id}")
	public ResponseEntity<Object> getOne(
			@PathVariable(value = "usuarioId") UUID usuarioId,	
			@PathVariable(value = "id") UUID id
		) { 
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<AtivoModel> optional = ativoService.findByUsuario(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Ativo não encontrado");
		} 
			
		return ResponseEntity.status(HttpStatus.OK).body(optional.get());
		
	}
	
	@DeleteMapping(value = "/usuario/{usuarioId}/ativos/{id}")
	public ResponseEntity<Object> delete(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PathVariable(value = "id") UUID id
		) { 
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<AtivoModel> optional = ativoService.findByUsuario(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Ativo não encontrado");
		} 
			
		ativoService.delete(optional.get());
		return ResponseEntity.status(HttpStatus.OK).body("Deletado com sucesso");
		
	}
	
	@PostMapping("/usuario/{usuarioId}/ativos")
	public ResponseEntity<Object> create(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@RequestBody @Valid AtivoDto ativoDto
		) {
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		var ativoModel = new AtivoModel();		
		BeanUtils.copyProperties(ativoDto, ativoModel);		
		
		ativoModel.setUsuario(usuarioOptional.get());
		ativoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
		ativoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
		ativoService.save(ativoModel);
		
		return ResponseEntity.status(HttpStatus.CREATED).body(ativoModel);
	}
	
	
	@PutMapping(value = "/usuario/{usuarioId}/ativos/{id}")
	public ResponseEntity<Object> update(
			@PathVariable(value = "usuarioId") UUID usuarioId,
			@PathVariable(value = "id") UUID id,			
			@RequestBody @Valid AtivoDto ativoDto
			
		) { 
		
		Optional<UsuarioModel> usuarioOptional = usuarioService.findById(usuarioId);
		if (!usuarioOptional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Usuário não encontrado");
		}
		
		Optional<AtivoModel> optional = ativoService.findByUsuario(usuarioOptional.get(), id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Ativo não encontrado");
		} 
			
		var ativoModel = optional.get();
		
		ativoDto.setId(id);
		BeanUtils.copyProperties(ativoDto, ativoModel);			
		ativoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));			
		ativoService.save(ativoModel);
		
		return ResponseEntity.status(HttpStatus.OK).body(ativoModel);
		
	}
	
}
