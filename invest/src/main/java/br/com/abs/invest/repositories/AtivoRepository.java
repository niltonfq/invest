package br.com.abs.invest.repositories;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import br.com.abs.invest.models.AtivoModel;

public interface AtivoRepository extends JpaRepository<AtivoModel, UUID>, JpaSpecificationExecutor<AtivoModel>{

	
}
