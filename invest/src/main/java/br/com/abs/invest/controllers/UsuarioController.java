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
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonView;

import br.com.abs.invest.dtos.AtivoDto;
import br.com.abs.invest.dtos.AtivoDto.AtivoView;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.services.UsuarioService;
import br.com.abs.invest.specifications.SpecificationTemplate;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping(value = "/grupoUsuaria")
public class UsuarioController {
	
	@Autowired
	UsuarioService service;
	
	@GetMapping
	public ResponseEntity<Page<AtivoModel>> getAll(
			SpecificationTemplate.AtivoSpec spec,
			@PageableDefault(page = 0, size = 10, sort = "id", direction = Direction.ASC) Pageable pageable
			){
		Page<AtivoModel> page = service.findAll(spec, pageable);
		
		if (!page.isEmpty()) {
			for (AtivoModel user : page.toList()) {
				user.add(linkTo(methodOn(UsuarioController.class).getOne(user.getId())).withSelfRel());
			}
		}
		
		return ResponseEntity.status(HttpStatus.OK).body(page);
	}
	
	@GetMapping(value = "/{id}")
	public ResponseEntity<Object> getOne(@PathVariable(value = "id") UUID id) { 
		Optional<AtivoModel> optional = service.findById(id);
		if (optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.OK).body(optional.get());
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não encontrado");
		}
	}
	
	@DeleteMapping(value = "/{id}")
	public ResponseEntity<Object> delete(@PathVariable(value = "id") UUID id) { 
		Optional<AtivoModel> optional = service.findById(id);
		if (optional.isPresent()) {
			service.delete(optional.get());
			return ResponseEntity.status(HttpStatus.OK).body("Deletado com sucesso");
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não encontrado");
		}
	}
	
	@PostMapping
	public ResponseEntity<Object> registerAtivo(
			@RequestBody @Valid AtivoDto ativoDto) {
		
		var ativoModel = new AtivoModel();
		BeanUtils.copyProperties(ativoDto, ativoModel);
		
		ativoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
		ativoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
		service.save(ativoModel);
		return ResponseEntity.status(HttpStatus.CREATED).body(ativoModel);
	}
	
	
	@PutMapping(value = "/{id}")
	public ResponseEntity<Object> update(@PathVariable(value = "id") UUID id,
			@RequestBody
			@Validated(AtivoDto.AtivoView.AtivoPut.class)
			@JsonView(AtivoView.AtivoPut.class) AtivoDto ativoDto) { 
		Optional<AtivoModel> optional = service.findById(id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não encontrado");
		} else {
			
			var userModel = optional.get();
			
			userModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
			
			service.save(userModel);
			
			return ResponseEntity.status(HttpStatus.OK).body(userModel);
		}
	}
	/*
	@PutMapping(value = "/{id}/password")
	public ResponseEntity<Object> updatePassword(@PathVariable(value = "id") UUID id,
			@RequestBody 
			@Validated(AtivoDto.AtivoView.PasswordPut.class)
			@JsonView(AtivoView.PasswordPut.class) AtivoDto userDto) { 
		Optional<AtivoModel> optional = service.findById(id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não encontrado");
		} 
		
		if (optional.get().getPassword().equals(userDto.getOldPassword())) {
			return ResponseEntity.status(HttpStatus.OK).body("Senha antiga não confere");
		} else {
			
			var userModel = optional.get();
			userModel.setPassword(userDto.getPassword());
			userModel.setLastUpdateDate(LocalDateTime.now(ZoneId.of("UTC")));
			
			service.save(userModel);
			
			return ResponseEntity.status(HttpStatus.OK).body("Senha atualizada com sucesso!");
		}
	}
	
	@PutMapping(value = "/{id}/image")
	public ResponseEntity<Object> updateImagem(@PathVariable(value = "id") UUID id,
			@RequestBody 
			@Validated(AtivoDto.AtivoView.ImagemPut.class)
			@JsonView(AtivoView.ImagemPut.class) AtivoDto userDto) { 
		Optional<AtivoModel> optional = service.findById(id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não encontrado");
		}  else {
			
			var userModel = optional.get();
			userModel.setImagemUrl(userDto.getImagemUrl());
			userModel.setLastUpdateDate(LocalDateTime.now(ZoneId.of("UTC")));
			
			service.save(userModel);
			
			return ResponseEntity.status(HttpStatus.OK).body(userModel);
		}
	}
*/
}
