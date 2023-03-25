package br.com.abs.invest.repositories;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import br.com.abs.invest.models.AtivoModel;

//@SpringBootTest
//@TestMethodOrder(OrderAnnotation.class)
class AtivoRepositoryTest {
	
	@Autowired
	private AtivoRepository ativoRepository;

	
  
//	@Test
//	@Order(1)
	public void listAtivos_ReturnsNoAtivos() {
		
		List<AtivoModel> response = ativoRepository.findAll();

		assertThat(response.size() == 1);
	}

}
