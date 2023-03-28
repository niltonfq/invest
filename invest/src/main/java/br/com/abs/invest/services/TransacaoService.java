package br.com.abs.invest.services;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import br.com.abs.invest.enums.Moeda;
import br.com.abs.invest.enums.TipoOperacao;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.BancoModel;
import br.com.abs.invest.models.TransacaoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.TransacaoRepository;

@Service
public class TransacaoService {
	
	
	private TransacaoRepository transacaoRepository;
	private BancoService bancoService;
	private AtivoService ativoService;
	
	public TransacaoService(
			TransacaoRepository transacaoRepository,
			BancoService bancoService,
			AtivoService ativoService
		) {
		this.transacaoRepository = transacaoRepository;
		this.bancoService = bancoService;
		this.ativoService = ativoService;
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
			    	bancoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
			    	bancoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
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


}
