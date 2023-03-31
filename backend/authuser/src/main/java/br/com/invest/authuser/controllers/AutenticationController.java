package br.com.invest.authuser.controllers;

import java.time.LocalDateTime;
import java.time.ZoneId;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonView;

import br.com.invest.authuser.dtos.UsuarioDto;
import br.com.invest.authuser.dtos.UsuarioDto.UserView;
import br.com.invest.authuser.enums.UsuarioStatus;
import br.com.invest.authuser.enums.UsuarioType;
import br.com.invest.authuser.models.UsuarioModel;
import br.com.invest.authuser.services.UsuarioService;

@RestController
@CrossOrigin(origins = "*", maxAge = 3600)
@RequestMapping(value = "/auth")
public class AutenticationController {

	@Autowired
	UsuarioService service;
	
	@PostMapping("/signup")
	public ResponseEntity<Object> registerUser(
			@RequestBody 
			@Validated(UsuarioDto.UserView.RegistrationPost.class)
			@JsonView(UserView.RegistrationPost.class) UsuarioDto usuarioDto){
		
		if (service.existsByUsername(usuarioDto.getUsername())) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("username já utilizado!");
		}
		
		if (service.existsByEmail(usuarioDto.getEmail())) {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("email já utilizado!");
		}
		
		var userModel = new UsuarioModel();
		BeanUtils.copyProperties(usuarioDto, userModel);
		userModel.setUsuarioStatus(UsuarioStatus.ACTIVE);
		userModel.setUsuarioType(UsuarioType.STUDENT);
		userModel.setCreationDate(LocalDateTime.now(ZoneId.of("UTC")));
		userModel.setLastUpdateDate(LocalDateTime.now(ZoneId.of("UTC")));
		service.save(userModel);
		return ResponseEntity.status(HttpStatus.CREATED).body(userModel);
	}
}
