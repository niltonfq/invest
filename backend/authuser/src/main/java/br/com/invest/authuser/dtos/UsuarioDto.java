package br.com.invest.authuser.dtos;

import java.util.UUID;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonView;

import br.com.invest.authuser.validation.UsernameConstraint;
import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UsuarioDto {
	
	public interface UserView {
		public static interface RegistrationPost {}
		public static interface UserPut {}
		public static interface PasswordPut {}
		public static interface ImagemPut {}
	}

	private UUID id;
	
	@NotBlank(groups = UserView.RegistrationPost.class)
	@Size(min = 4, max = 50, groups = UserView.RegistrationPost.class)
	@JsonView(UserView.RegistrationPost.class)
	@UsernameConstraint(groups = UserView.RegistrationPost.class)
	private String username;
	
	@NotBlank(groups = UserView.RegistrationPost.class)
	@Email(groups = UserView.RegistrationPost.class)
	@JsonView(UserView.RegistrationPost.class)
	private String email;
	
	@NotBlank(groups = { UserView.RegistrationPost.class, UserView.PasswordPut.class })
	@Size(min = 6, max = 20, groups = { UserView.RegistrationPost.class, UserView.PasswordPut.class })
	@JsonView({ UserView.RegistrationPost.class, UserView.PasswordPut.class })
	private String password;
	
	@NotBlank(groups = UserView.PasswordPut.class)
	@Size(min = 6, max = 20, groups = UserView.PasswordPut.class)
	@JsonView({ UserView.PasswordPut.class })
	private String oldPassword;
	
	@JsonView({ UserView.RegistrationPost.class, UserView.UserPut.class })
	private String fullName;
	
	@JsonView({ UserView.RegistrationPost.class, UserView.UserPut.class })
	private String phoneNumber;
	
	@JsonView({ UserView.RegistrationPost.class, UserView.UserPut.class })
	private String cpf;
	
	@NotBlank(groups = UserView.ImagemPut.class)
	@JsonView({ UserView.ImagemPut.class })
	private String imagemUrl;
}
