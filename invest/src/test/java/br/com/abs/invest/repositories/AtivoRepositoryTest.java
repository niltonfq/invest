package br.com.abs.invest.repositories;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import br.com.abs.invest.models.AtivoModel;

@SpringBootTest
class AtivoRepositoryTest {
	
	@Autowired
	private AtivoRepository ativoRepository;

	
  
	@Test
	public void listAtivos_ReturnsNoAtivos() {
		
		List<AtivoModel> response = ativoRepository.findAll();

		assertThat(response).isEmpty();
	}

}
