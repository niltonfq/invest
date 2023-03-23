package br.com.abs.invest.repositories;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import br.com.abs.invest.models.UsuarioModel;

public interface UsuarioRepository extends JpaRepository<UsuarioModel, UUID>, JpaSpecificationExecutor<UsuarioModel>{


}
