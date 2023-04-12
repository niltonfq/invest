package br.com.abs.invest.services;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.jayway.jsonpath.JsonPath;

import br.com.abs.invest.dtos.PosicaoAtivoDto;
import br.com.abs.invest.dtos.PosicaoTipoAtivoDto;
import br.com.abs.invest.enums.Moeda;
import br.com.abs.invest.enums.TipoAtivo;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.PercentualInvestimentoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.AtivoRepository;

@Service
public class AtivoService {

	AtivoRepository ativoRepository;
	PercentualInvestimentoService percentualInvestimentoService;
	
	public AtivoService(
			AtivoRepository ativoRepository,
			PercentualInvestimentoService percentualInvestimentoService
		) {
		this.ativoRepository = ativoRepository;
		this.percentualInvestimentoService = percentualInvestimentoService;
	}

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
		
		if (ativoModel.getTipoAtivo().equals(TipoAtivo.Criptomoedas)) {
			uri = "https://www.mercadobitcoin.net/api/"+ativoModel.getCodigo()+"/ticker/";
		} else if ( ativoModel.getMoeda().equals(Moeda.R$))  {
          uri = "https://query2.finance.yahoo.com/v11/finance/quoteSummary/"+ativoModel.getCodigo()+".SA?modules=price";
		} else {
          uri = "https://query2.finance.yahoo.com/v11/finance/quoteSummary/"+ativoModel.getCodigo()+"?modules=price";
		}
		
		Double preco = 0.0;
		if ((ativoModel.getQuantidadeInvestida().compareTo(BigDecimal.ZERO) > 0) && (!ativoModel.getTipoAtivo().equals(TipoAtivo.Tesouro_Direto))){
			try {
				result = restTemplate.getForObject(uri, String.class);
				preco = JsonPath.read(result, "$['quoteSummary']['result'][0]['price']['regularMarketPrice']['raw']");
				
			} catch (Exception e) {
				preco = 0.0;
			}
		}
	    ativoModel.setDataAtualizacaoPreco(LocalDate.now());
	    
	    if (ativoModel.getTipoAtivo().equals(TipoAtivo.Tesouro_Direto)) {
	    	ativoModel.setTotalAtual(ativoModel.getTotalInvestido());
	    	ativoModel.setValorAtual(ativoModel.getPrecoMedio());
	    } else {
		    if (
		    		(ativoModel.getTipoAtivo().equals(TipoAtivo.Criptomoedas)) ||
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
	    }
	    ativoRepository.save(ativoModel);
	    
	    return dolar;
	}

	public List<PosicaoTipoAtivoDto> posicaoPorTipo(UsuarioModel usuarioModel) {
		BigDecimal total = ativoRepository.totalPorUsuario(usuarioModel.getId());
		List<PosicaoTipoAtivoDto> list = ativoRepository.TotalPorTipo(usuarioModel.getId(), total );
		
		for (PosicaoTipoAtivoDto posicaoTipoAtivoDto : list) {
			BigDecimal totalTipoAtivo = ativoRepository.totalTipoAtivoUsuario(
					usuarioModel.getId(), posicaoTipoAtivoDto.getTipoAtipo());
			
			List<PosicaoAtivoDto> listItens = ativoRepository.AtivosPorTipoUsuario(
					usuarioModel.getId(), totalTipoAtivo, total, posicaoTipoAtivoDto.getTipoAtipo() );
			
			posicaoTipoAtivoDto.getAtivos().addAll(listItens);
		}
		
		return list;
	}
	
	public List<PosicaoTipoAtivoDto>  calculaPercentualAporte(UsuarioModel usuarioModel, BigDecimal aporte) {
		
		PercentualInvestimentoModel percentualInvestimentoModel = percentualInvestimentoService.findByUsuario(usuarioModel);
		
		BigDecimal total = aporte;
		BigDecimal totalDiferenca = BigDecimal.ZERO;
		BigDecimal percentual = BigDecimal.ZERO;
		List<PosicaoTipoAtivoDto> totalPorTipo = posicaoPorTipo(usuarioModel);
		
		for (PosicaoTipoAtivoDto posicaoTipoAtivoDto : totalPorTipo) {
			total = total.add(posicaoTipoAtivoDto.getTotal());
			
		}
		
		for (PosicaoTipoAtivoDto posicaoTipoAtivoDto : totalPorTipo) {
			
			percentual = resolvePercentual(percentualInvestimentoModel, percentual, posicaoTipoAtivoDto);
			
			posicaoTipoAtivoDto.setTotalDesejado(
					total.multiply(percentual)
					);
			if (posicaoTipoAtivoDto.getTotal()
					.compareTo(posicaoTipoAtivoDto.getTotalDesejado()) >= 0) {
				posicaoTipoAtivoDto.setDiferenca(BigDecimal.ZERO);
				
				
			} else {
				posicaoTipoAtivoDto.setDiferenca(
						posicaoTipoAtivoDto.getTotalDesejado().subtract(posicaoTipoAtivoDto.getTotal()));
				
			}
			totalDiferenca = totalDiferenca.add(posicaoTipoAtivoDto.getDiferenca());
		}
		
		for (PosicaoTipoAtivoDto posicaoTipoAtivoDto : totalPorTipo) {
			posicaoTipoAtivoDto.setAporte( 
					aporte.multiply(posicaoTipoAtivoDto.getDiferenca().divide(totalDiferenca, 2, RoundingMode.HALF_UP) ));
		}
		
		return totalPorTipo;
	}

	private BigDecimal resolvePercentual(PercentualInvestimentoModel percentualInvestimentoModel, BigDecimal percentual,
			PosicaoTipoAtivoDto posicaoTipoAtivoDto) {
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.Ações)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getAcoes()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.BDRs)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getBdrs()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.CDB)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getCdb()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.Cri_e_Cra)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getCriCra()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.Criptomoedas)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getCriptoMoedas()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.Debendures)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getDebendures()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.ETFs_Internacionais)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getEtfsInternacional()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.ETFs_Nacionais)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getEtfsNacional()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.Fiagro)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getFiagro()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.Fundos_Imobiliários)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getFundosImobiliarios()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.Fundos_Investimentos)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getFundosInvestimentos()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.LCI_e_LCA)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getLciLca()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.Reits)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getReits()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.Stocks)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getStocks()/100.0);
		}
		if (posicaoTipoAtivoDto.getTipoAtipo().equals(TipoAtivo.Tesouro_Direto)) {
			percentual = BigDecimal.valueOf( percentualInvestimentoModel.getTesouroDireto()/100.0);
		}
		return percentual;
	}
}








