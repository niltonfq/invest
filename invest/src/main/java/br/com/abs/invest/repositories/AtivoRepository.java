package br.com.abs.invest.repositories;

import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.UsuarioModel;

public interface AtivoRepository extends JpaRepository<AtivoModel, UUID>, JpaSpecificationExecutor<AtivoModel>{

	Page<AtivoModel> findByUsuario(Pageable pageable, UsuarioModel usuario);

	
}
