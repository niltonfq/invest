package br.com.abs.invest.services;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import br.com.abs.invest.enums.Moeda;
import br.com.abs.invest.enums.TipoAtivo;
import br.com.abs.invest.enums.TipoOperacao;
import br.com.abs.invest.models.AtivoFechamentoModel;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.BancoModel;
import br.com.abs.invest.models.SegmentoModel;
import br.com.abs.invest.models.TransacaoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.TransacaoRepository;

@Service
public class TransacaoService {
	
	
	private TransacaoRepository transacaoRepository;
	private BancoService bancoService;
	private AtivoService ativoService;
	private SegmentoService segmentoService;
	private AtivoFechamentoService ativoFechamentoService;
	
	public TransacaoService(
			TransacaoRepository transacaoRepository,
			BancoService bancoService,
			AtivoService ativoService,
			AtivoFechamentoService ativoFechamentoService,
			SegmentoService segmentoService
		) {
		this.transacaoRepository = transacaoRepository;
		this.bancoService = bancoService;
		this.ativoService = ativoService;
		this.ativoFechamentoService = ativoFechamentoService;
		this.segmentoService = segmentoService;
	}

	public void saveAll(List<TransacaoModel> lista) {
		transacaoRepository.saveAll(lista);
	}
	
	public void importarB3Negociacoes(MultipartFile excel, UsuarioModel usuario)
			throws IOException {
		List<TransacaoModel> lista = new ArrayList<TransacaoModel>();
	    
	    try (XSSFWorkbook workbook = new XSSFWorkbook(excel.getInputStream())) {
			XSSFSheet worksheet = workbook.getSheetAt(0);
			
			for(int i=1;i<worksheet.getPhysicalNumberOfRows() ;i++) {
				
				TransacaoModel transacao = new TransacaoModel();
			        
			    XSSFRow row = worksheet.getRow(i);
			    
			    
			    if (row.getCell(0) == null) {
			    	break;
			    }
			    
			    String dataTransacaoString = row.getCell(0).getStringCellValue();
			    LocalDate dataTransacao = LocalDate.of(
			    	Integer.parseInt( dataTransacaoString.substring(6, 10) ), 
			    	Integer.parseInt( dataTransacaoString.substring(3, 5) ), 
			    	Integer.parseInt( dataTransacaoString.substring(0, 2) )
			    );     
			    transacao.setData( dataTransacao );
			    
			    String tipo =  row.getCell(1).getStringCellValue();
			    if (tipo.equals("Compra")) {
			    	transacao.setTipoOperacao(TipoOperacao.Compra);
			    } else {
			    	transacao.setTipoOperacao(TipoOperacao.Venda);
			    }
			    
			    String mercado =  row.getCell(2).getStringCellValue();
			    
			    String nomeBanco = row.getCell(4).getStringCellValue();
			    nomeBanco = nomeBanco.replace("DISTRIBUIDORA DE TITULOS E VALORES MOBILIARIOS", "DTVM");
			    Optional<BancoModel> bancoOptional = bancoService.findByUsuarioAndNome(usuario, nomeBanco);
			    BancoModel bancoModel = new BancoModel();
			    if (!bancoOptional.isPresent()) {
			    	bancoModel.setId(null);
			    	bancoModel.setNome(nomeBanco);
			    	bancoModel.setUsuario(usuario);
			    	bancoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
			    	bancoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
			    	bancoModel =  bancoService.save(bancoModel);
			    } else {
			    	bancoModel = bancoOptional.get();
			    }
			    transacao.setBanco(bancoModel);
			    
			    String codigo = row.getCell(5).getStringCellValue();
			    if (mercado.equals("Mercado Fracionário")) {
			    	codigo = codigo.substring(0, codigo.length()-1);
			    }
			    Optional<AtivoModel> ativoOptional = ativoService.findByUsuarioAndCodigo(usuario, codigo);
			    AtivoModel ativoModel = new AtivoModel();
			    if (!ativoOptional.isPresent()) {
			    	ativoModel.setId(null);
			    	ativoModel.setCodigo(codigo);
			    	ativoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
			    	ativoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
			    	ativoModel.setMoeda(Moeda.R$);
			    	ativoModel.setQuarentena(false);
			    	ativoModel.setUsuario(usuario);
			    	ativoModel = ativoService.save(ativoModel);
			    } else {
			    	ativoModel = ativoOptional.get();
			    }
			    transacao.setAtivo(ativoModel);
			    
			    
			    
			    double quantidade = row.getCell(6).getNumericCellValue();
			    transacao.setQuantidade(BigDecimal.valueOf( quantidade) );

			    double preco = row.getCell(7).getNumericCellValue();
			    transacao.setValor(BigDecimal.valueOf( preco) );
			    
			    preco = row.getCell(8).getNumericCellValue();
			    transacao.setTotal(BigDecimal.valueOf( preco ));
			    transacao.setTotalLiquido(BigDecimal.valueOf( preco ));
			    transacao.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
			    transacao.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
			    transacao.setUsuario(usuario);
			    
			    Optional<TransacaoModel> transacaoOptional = transacaoRepository.findByUsuarioAndDataAndQuantidadeAndTipoOperacaoAndTotal(
			    		usuario,
			    		transacao.getData(),
			    		transacao.getQuantidade(),
			    		transacao.getTipoOperacao(),
			    		transacao.getTotal()
			    		
			    		);
			    if (!transacaoOptional.isPresent()) {
			    	lista.add(transacao);
			    }
			    
			}
			if (!lista.isEmpty()) {
				saveAll(lista);
			}
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
	}

	public void importar(MultipartFile excel, UsuarioModel usuario) throws IOException {
		List<TransacaoModel> lista = new ArrayList<TransacaoModel>();
	    
	    try (XSSFWorkbook workbook = new XSSFWorkbook(excel.getInputStream())) {
			XSSFSheet worksheet = workbook.getSheetAt(0);
			
			for(int i=1;i<worksheet.getPhysicalNumberOfRows() ;i++) {
				
				TransacaoModel transacao = new TransacaoModel();
			        
			    XSSFRow row = worksheet.getRow(i);
			    
			    
			    if (row.getCell(0) == null) {
			    	break;
			    }
			    
			    String dataTransacaoString = row.getCell(0).getStringCellValue();
			    if (dataTransacaoString.isEmpty()) {
			    	break;
			    }
			    LocalDate dataTransacao = LocalDate.of(
			    	Integer.parseInt( dataTransacaoString.substring(6, 10) ), 
			    	Integer.parseInt( dataTransacaoString.substring(3, 5) ), 
			    	Integer.parseInt( dataTransacaoString.substring(0, 2) )
			    );     
			    transacao.setData( dataTransacao );
			    
			    String codigo = row.getCell(1).getStringCellValue();
			    Optional<AtivoModel> ativoOptional = ativoService.findByUsuarioAndCodigo(usuario, codigo);
			    AtivoModel ativoModel;
			    if (!ativoOptional.isPresent()) {
			    	
			    	ativoModel = new AtivoModel();
			    	
			    	String tipoAtivo = row.getCell(2).getStringCellValue(); 
				    
				    switch (tipoAtivo) {
					case "Ações":
						ativoModel.setTipoAtivo(TipoAtivo.Acoes);
						break;
					case "ETF's":
						ativoModel.setTipoAtivo(TipoAtivo.ETF);
						
						break;
					case "FII's":
						ativoModel.setTipoAtivo(TipoAtivo.FII);
						
						break;
					case "Tesouro Direto":
						ativoModel.setTipoAtivo(TipoAtivo.Tesouro_Direto);
						
						break;
					case "Cripto":
						ativoModel.setTipoAtivo(TipoAtivo.Criptomoeda);
						
						break;
					case "ETF Exterior":
						ativoModel.setTipoAtivo(TipoAtivo.ETF_Exterior);
						
						break;
					case "Reits":
						ativoModel.setTipoAtivo(TipoAtivo.Reits);
						
						break;
					case "Stocks":
						ativoModel.setTipoAtivo(TipoAtivo.Stocks);
						
						break;
					case "BDR":
						ativoModel.setTipoAtivo(TipoAtivo.BDR);
						
						break;

					default:
						break;
					}
			   
			    	ativoModel.setId(null);
			    	ativoModel.setCodigo(codigo);
			    	ativoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
			    	ativoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
			    	
			    	if (
			    			ativoModel.getTipoAtivo().equals(TipoAtivo.ETF_Exterior) || 
			    			ativoModel.getTipoAtivo().equals(TipoAtivo.Reits) || 
			    			ativoModel.getTipoAtivo().equals(TipoAtivo.Stocks)  
			    	) {
			    		ativoModel.setMoeda(Moeda.US$);
			    	} else {
			    		ativoModel.setMoeda(Moeda.R$);
			    	}
			    	
			    	ativoModel.setQuarentena(false);
			    	ativoModel.setUsuario(usuario);
			    	
			    	if (row.getCell(11) != null) {
			    		ativoModel.setCnpj(row.getCell(11).getStringCellValue());
				    }
			    	
			    	if (row.getCell(12) != null) {
			    		String nome = row.getCell(12).getStringCellValue();
			    		
			    		ativoModel.setNome(nome);
			    	}
			    	
			    	if (row.getCell(13) != null) {
			    		String nomeBanco = row.getCell(13).getStringCellValue();
			    		
			    		ativoModel.setBanco(resolveBanco(usuario, nomeBanco));
				    }
			    	
			    	if (row.getCell(14) != null) {
			    		String nomeSegmento = row.getCell(14).getStringCellValue();
			    		ativoModel.setSegmento(resolveSegmento(usuario, nomeSegmento));
			    	}
			    	
			    	if (row.getCell(15) != null) {
			    		String atividade = row.getCell(15).getStringCellValue();
			    		
			    		ativoModel.setAtividade(atividade);
			    	}				    	
			    	
			    	ativoModel = ativoService.save(ativoModel);
			    } else {
			    	ativoModel = ativoOptional.get();
			    }
			    transacao.setAtivo(ativoModel);
			    
			    double quantidade = row.getCell(3).getNumericCellValue();
			    transacao.setQuantidade(BigDecimal.valueOf( Math.abs(quantidade) ) );
			    
			    double preco = row.getCell(4).getNumericCellValue();
			    preco = Math.abs(preco);
			    transacao.setValor(BigDecimal.valueOf( preco ) );
			    
			    double totalLiquido = row.getCell(5).getNumericCellValue();
			    totalLiquido = Math.abs( totalLiquido );
			    transacao.setTotalLiquido(BigDecimal.valueOf( totalLiquido ));

			    double tarifas = row.getCell(6).getNumericCellValue();
			    tarifas = Math.abs(tarifas);
			    transacao.setTarifas(BigDecimal.valueOf( tarifas ));
			    
			    double total = row.getCell(7).getNumericCellValue();
			    total = Math.abs(total);
			    transacao.setTotal( BigDecimal.valueOf( total ));
			    
			    if (quantidade > 0) {
			    	transacao.setTipoOperacao(TipoOperacao.Compra);
			    } else {
			    	transacao.setTipoOperacao(TipoOperacao.Venda);
			    }
			    	    
			    if (row.getCell(8) != null)  {
			    	String dataVenctoString = row.getCell(8).getStringCellValue();
			    	if (!dataVenctoString.isEmpty()) {
					    LocalDate dataVencto = LocalDate.of(
					    	Integer.parseInt( dataVenctoString.substring(6, 10) ), 
					    	Integer.parseInt( dataVenctoString.substring(3, 5) ), 
					    	Integer.parseInt( dataVenctoString.substring(0, 2) )
					    );     
					    transacao.setVencimento(dataVencto);
			    	}
			    }			    
			    			    
			    String nomeBanco = row.getCell(9).getStringCellValue();
			    
			    transacao.setBanco(resolveBanco(usuario, nomeBanco));
			    
			    if (row.getCell(10) != null) {
			    	transacao.setObservacao(row.getCell(10).getStringCellValue());
			    }
			    
			    transacao.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
			    transacao.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
			    transacao.setUsuario(usuario);
			    
			    Optional<TransacaoModel> transacaoOptional = transacaoRepository.findByUsuarioAndDataAndQuantidadeAndTipoOperacaoAndTotal(
			    		usuario,
			    		transacao.getData(),
			    		transacao.getQuantidade(),
			    		transacao.getTipoOperacao(),
			    		transacao.getTotal()
			    		
			    		);
			    if (!transacaoOptional.isPresent()) {
			    	lista.add(transacao);
			    }
			    
			}
			if (!lista.isEmpty()) {
				saveAll(lista);
			}
			
			calcularPrecoMedioTodos(usuario);
			
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
	}

	private SegmentoModel resolveSegmento(UsuarioModel usuario, String nomeSegmento) {
		if (nomeSegmento.isEmpty()) {
			return null;
		}
		
	    Optional<SegmentoModel> segmentoOptional = segmentoService.findByUsuarioAndNome(usuario, nomeSegmento);
	    SegmentoModel segmentoModel; 
	    if (!segmentoOptional.isPresent()) {
	    	segmentoModel = new SegmentoModel();
	    	segmentoModel.setId(null);
	    	segmentoModel.setNome(nomeSegmento);
	    	segmentoModel.setUsuario(usuario);
	    	segmentoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
	    	segmentoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
	    	segmentoModel =  segmentoService.save(segmentoModel);
	    } else {
	    	segmentoModel = segmentoOptional.get();
	    }
		return segmentoModel;
	}

	private BancoModel resolveBanco(UsuarioModel usuario, String nomeBanco) {
		if (nomeBanco.isEmpty()) {
			return null;
		}
		
		nomeBanco = nomeBanco.replace("DISTRIBUIDORA DE TITULOS E VALORES MOBILIARIOS", "DTVM");
	    Optional<BancoModel> bancoOptional = bancoService.findByUsuarioAndNome(usuario, nomeBanco);
	    BancoModel bancoModel;
	    if (!bancoOptional.isPresent()) {
	    	bancoModel = new BancoModel();
	    	bancoModel.setId(null);
	    	bancoModel.setNome(nomeBanco);
	    	bancoModel.setUsuario(usuario);
	    	bancoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
	    	bancoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
	    	bancoModel =  bancoService.save(bancoModel);
	    } else {
	    	bancoModel = bancoOptional.get();
	    }
		return bancoModel;
	}

	public void calcularPrecoMedioTodos(UsuarioModel usuario) {
		LocalDate date = LocalDate.of(1980, 1, 1);
		List<AtivoModel> ativos = ativoService.findAllByUsuario(usuario);		
		for (AtivoModel ativoModel : ativos) {
			
			ativoModel.setTotalInvestido(BigDecimal.ZERO);
			ativoModel.setQuantidadeInvestida(BigDecimal.ZERO);
			ativoModel.setPrecoMedio(BigDecimal.ZERO);
			
			calcularPrecoMedioAtivo(usuario, ativoModel, date);
			
		}
		
	}

	@Transactional
	private BigDecimal calcularPrecoMedioAtivo(UsuarioModel usuario, AtivoModel ativoModel, LocalDate inicio) {
		
		ativoFechamentoService.deletaTodosFechamentosAtivoAposData(usuario, ativoModel, inicio);
		
		Optional<AtivoFechamentoModel> ultimoFechamento = 
				ativoFechamentoService.findFirstUltimoFechamentoAtivoAntesData(usuario, ativoModel, inicio);
		
		BigDecimal totalValor = BigDecimal.ZERO;
		BigDecimal totalQuantidade = BigDecimal.ZERO;
		BigDecimal precoMedio = BigDecimal.ZERO;
		BigDecimal lucroPrejuizo = BigDecimal.ZERO;
		LocalDate dataInicial;
		
		if (ultimoFechamento.isPresent()) {
			totalQuantidade = ultimoFechamento.get().getQuantidade(); 
			totalValor = ultimoFechamento.get().getTotal(); 
			precoMedio = ultimoFechamento.get().getPrecoMedio();
			dataInicial = ultimoFechamento.get().getData().plusDays(1);
		} else {
			Optional<TransacaoModel> primeiraTransacao = transacaoRepository
					.findFirstByUsuarioAndAtivoOrderByData(usuario, ativoModel);
			if (!primeiraTransacao.isPresent()) {
				return BigDecimal.ZERO;
			}
			dataInicial = LocalDate.of(primeiraTransacao.get().getData().getYear(), 
					primeiraTransacao.get().getData().getMonthValue(), 1);
		}
		
		while ( dataInicial.isBefore(LocalDate.now()) ) {
				
			LocalDate dataFinal = dataInicial.plusMonths(1);
			dataFinal = dataFinal.minusDays(1);
			
			List<TransacaoModel> listaTransacao = transacaoRepository
					.findByUsuarioAndAtivoAndDataBetweenOrderByDataAscTipoOperacaoAsc(
							usuario, ativoModel, dataInicial, dataFinal
			);
			for (TransacaoModel transacaoModel : listaTransacao) {
				
				if (transacaoModel.getTipoOperacao().equals(TipoOperacao.Venda)) {
					totalValor = totalValor.subtract(transacaoModel.getTotalLiquido()) ;
					totalQuantidade = totalQuantidade.subtract(transacaoModel.getQuantidade());
					
					lucroPrejuizo = transacaoModel.getTotalLiquido().subtract( precoMedio.multiply(transacaoModel.getQuantidade()) );
					
					transacaoModel.setLucroPrejuizo(lucroPrejuizo);					
					transacaoRepository.save(transacaoModel);
					
					if (totalQuantidade.compareTo(BigDecimal.ZERO) <= 0) {
						totalValor = BigDecimal.ZERO;
						totalQuantidade = BigDecimal.ZERO;
						precoMedio = BigDecimal.ZERO;
					} 
					
				} else {
					totalValor = totalValor.add(transacaoModel.getTotalLiquido()) ;
					totalQuantidade = totalQuantidade.add(transacaoModel.getQuantidade());
					precoMedio = totalValor.divide(totalQuantidade, 2, RoundingMode.HALF_UP);
				}
				
				ativoModel.setPrecoMedio(precoMedio); 
				ativoModel.setQuantidadeInvestida(totalQuantidade);
				ativoModel.setTotalInvestido( totalValor );
				
			}	
			
			AtivoFechamentoModel ativoFechamentoModel = new AtivoFechamentoModel();
			ativoFechamentoModel.setId(null);
			ativoFechamentoModel.setUsuario(usuario);
			ativoFechamentoModel.setAtivo(ativoModel);
			ativoFechamentoModel.setPrecoMedio(precoMedio);
			ativoFechamentoModel.setData(dataFinal);
			ativoFechamentoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
			ativoFechamentoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
			ativoFechamentoService.save(ativoFechamentoModel);
			
			dataInicial = dataFinal;
			dataInicial = dataInicial.plusDays(1);
		}
			
		ativoService.save(ativoModel);
		
		return precoMedio;
	}
}
