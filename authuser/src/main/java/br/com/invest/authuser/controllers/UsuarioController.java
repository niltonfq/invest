package br.com.invest.authuser.controllers;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Optional;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonView;

import br.com.invest.authuser.dtos.UsuarioDto;
import br.com.invest.authuser.dtos.UsuarioDto.UserView;
import br.com.invest.authuser.models.UsuarioModel;
import br.com.invest.authuser.services.UsuarioService;
import br.com.invest.authuser.specifications.SpecificationTemplate;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping(value = "/users")
public class UsuarioController {
	
	@Autowired
	UsuarioService service;
	
	@GetMapping
	public ResponseEntity<Page<UsuarioModel>> getAll(
			SpecificationTemplate.UserSpec spec,
			@PageableDefault(page = 0, size = 10, sort = "id", direction = Direction.ASC) Pageable pageable
			){
		Page<UsuarioModel> page = service.findAll(spec, pageable);
		
		if (!page.isEmpty()) {
			for (UsuarioModel user : page.toList()) {
				user.add(linkTo(methodOn(UsuarioController.class).getOne(user.getId())).withSelfRel());
			}
		}
		
		return ResponseEntity.status(HttpStatus.OK).body(page);
	}
	
	@GetMapping(value = "/{id}")
	public ResponseEntity<Object> getOne(@PathVariable(value = "id") UUID id) { 
		Optional<UsuarioModel> optional = service.findById(id);
		if (optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.OK).body(optional.get());
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não encontrado");
		}
	}
	
	@DeleteMapping(value = "/{id}")
	public ResponseEntity<Object> delete(@PathVariable(value = "id") UUID id) { 
		Optional<UsuarioModel> optional = service.findById(id);
		if (optional.isPresent()) {
			service.delete(optional.get());
			return ResponseEntity.status(HttpStatus.OK).body("Deletado com sucesso");
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não encontrado");
		}
	}
	
	@PutMapping(value = "/{id}")
	public ResponseEntity<Object> update(@PathVariable(value = "id") UUID id,
			@RequestBody
			@Validated(UsuarioDto.UserView.UserPut.class)
			@JsonView(UserView.UserPut.class) UsuarioDto usuarioDto) { 
		Optional<UsuarioModel> optional = service.findById(id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não encontrado");
		} else {
			
			var userModel = optional.get();
			userModel.setFullName(usuarioDto.getFullName());
			userModel.setPhoneNumber(usuarioDto.getPhoneNumber());
			userModel.setCpf(usuarioDto.getCpf());
			userModel.setLastUpdateDate(LocalDateTime.now(ZoneId.of("UTC")));
			
			service.save(userModel);
			
			return ResponseEntity.status(HttpStatus.OK).body(userModel);
		}
	}
	
	@PutMapping(value = "/{id}/password")
	public ResponseEntity<Object> updatePassword(@PathVariable(value = "id") UUID id,
			@RequestBody 
			@Validated(UsuarioDto.UserView.PasswordPut.class)
			@JsonView(UserView.PasswordPut.class) UsuarioDto usuarioDto) { 
		Optional<UsuarioModel> optional = service.findById(id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não encontrado");
		} 
		
		if (optional.get().getPassword().equals(usuarioDto.getOldPassword())) {
			return ResponseEntity.status(HttpStatus.OK).body("Senha antiga não confere");
		} else {
			
			var userModel = optional.get();
			userModel.setPassword(usuarioDto.getPassword());
			userModel.setLastUpdateDate(LocalDateTime.now(ZoneId.of("UTC")));
			
			service.save(userModel);
			
			return ResponseEntity.status(HttpStatus.OK).body("Senha atualizada com sucesso!");
		}
	}
	
	@PutMapping(value = "/{id}/image")
	public ResponseEntity<Object> updateImagem(@PathVariable(value = "id") UUID id,
			@RequestBody 
			@Validated(UsuarioDto.UserView.ImagemPut.class)
			@JsonView(UserView.ImagemPut.class) UsuarioDto usuarioDto) { 
		Optional<UsuarioModel> optional = service.findById(id);
		if (!optional.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Não encontrado");
		}  else {
			
			var userModel = optional.get();
			userModel.setImagemUrl(usuarioDto.getImagemUrl());
			userModel.setLastUpdateDate(LocalDateTime.now(ZoneId.of("UTC")));
			
			service.save(userModel);
			
			return ResponseEntity.status(HttpStatus.OK).body(userModel);
		}
	}

}
