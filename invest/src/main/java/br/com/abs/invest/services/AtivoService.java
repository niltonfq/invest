package br.com.abs.invest.services;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.jayway.jsonpath.JsonPath;

import br.com.abs.invest.enums.Moeda;
import br.com.abs.invest.enums.TipoAtivo;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.AtivoRepository;

@Service
public class AtivoService {

	@Autowired
	AtivoRepository ativoRepository;
	private Object read;

	public Optional<AtivoModel> findByUsuario(UsuarioModel usuario, UUID id) {
		return ativoRepository.findByUsuarioAndId(usuario, id);
	}

	public void delete(AtivoModel model) {
		ativoRepository.delete(model);		
	}

	public AtivoModel save(AtivoModel ativoModel) {
		return ativoRepository.save(ativoModel);		
	}

    public Page<AtivoModel> findAllByUsuario(Specification<AtivoModel> spec, Pageable pageable) {
		return ativoRepository.findAll(spec, pageable);
    }

	public Optional<AtivoModel> findByUsuarioAndCodigo(UsuarioModel usuarioModel, String codigo) {
		return ativoRepository.findByUsuarioAndCodigo( usuarioModel, codigo);
	}

	public List<AtivoModel> findAllByUsuario(UsuarioModel usuario) {
		return ativoRepository.findAllByUsuario(usuario);
	}

	public void valorizarTodos(UsuarioModel usuario) throws JsonMappingException, JsonProcessingException {
		Double dolar = 0.0;
		List<AtivoModel> ativos = ativoRepository.findAllByUsuarioAndDataAtualizacaoPrecoBeforeOrDataAtualizacaoPrecoNull(usuario, LocalDate.now());		
		for (AtivoModel ativoModel : ativos) {
			dolar = valorizarAtivo(usuario, ativoModel, dolar);
		}
		
	}

	private Double valorizarAtivo(UsuarioModel usuario, AtivoModel ativoModel, Double dolar )  {
		RestTemplate restTemplate = new RestTemplate();
		
		String result;
		if (dolar == 0.0) {
			result = restTemplate.getForObject("https://economia.awesomeapi.com.br/last/USD-BRL", String.class);
			String dolarStr = JsonPath.read(result, "$['USDBRL']['high']");
			dolar = Double.valueOf(dolarStr);
		}		   
		
		String uri;
		
		if (ativoModel.getTipoAtivo().equals(TipoAtivo.Criptomoeda)) {
			uri = "https://www.mercadobitcoin.net/api/"+ativoModel.getCodigo()+"/ticker/";
		} else if ( ativoModel.getMoeda().equals(Moeda.R$))  {
          uri = "https://query1.finance.yahoo.com/v11/finance/quoteSummary/"+ativoModel.getCodigo()+".SA?modules=financialData";
		} else {
          uri = "https://query1.finance.yahoo.com/v11/finance/quoteSummary/"+ativoModel.getCodigo()+"?modules=financialData";
		}
		
		Double preco;
		try {
			result = restTemplate.getForObject(uri, String.class);
			preco = JsonPath.read(result, "$['quoteSummary']['result'][0]['financialData']['currentPrice']['raw']");
			
		} catch (Exception e) {
			preco = 0.0;
		}
	    
	    ativoModel.setDataAtualizacaoPreco(LocalDate.now());
	    if (
	    		(ativoModel.getTipoAtivo().equals(TipoAtivo.Criptomoeda)) ||
	    		( ativoModel.getMoeda().equals(Moeda.R$))
	    	) {
	    	ativoModel.setTotalAtual(ativoModel.getQuantidadeInvestida()
	    			.multiply(BigDecimal.valueOf(preco)));
		} else {
			ativoModel.setTotalAtual(ativoModel.getQuantidadeInvestida()
					.multiply(BigDecimal.valueOf(preco))
					.multiply(BigDecimal.valueOf(dolar)));
		}
	    ativoModel.setValorAtual(BigDecimal.valueOf(preco));
	    ativoRepository.save(ativoModel);
	    
	    return dolar;
	}

	
}
