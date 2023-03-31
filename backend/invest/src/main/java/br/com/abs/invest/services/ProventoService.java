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
import br.com.abs.invest.enums.TipoProvento;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.BancoModel;
import br.com.abs.invest.models.ProventoModel;
import br.com.abs.invest.models.UsuarioModel;
import br.com.abs.invest.repositories.ProventoRepository;

@Service
public class ProventoService {

	private ProventoRepository proventoRepository;
	private BancoService bancoService;
	private AtivoService ativoService;
	
	public ProventoService(
			ProventoRepository proventoRepository,
			BancoService bancoService,
			AtivoService ativoService
		) {
		this.proventoRepository = proventoRepository;
		this.bancoService = bancoService;
		this.ativoService = ativoService;
	}

	public void saveAll(List<ProventoModel> lista) {
		proventoRepository.saveAll(lista);
	}

	public void importarB3Movimento(MultipartFile excel, UsuarioModel usuario)
			throws IOException {
		List<ProventoModel> lista = new ArrayList<ProventoModel>();
	    
	    try (XSSFWorkbook workbook = new XSSFWorkbook(excel.getInputStream())) {
			XSSFSheet worksheet = workbook.getSheetAt(0);
			
			for(int i=1;i<worksheet.getPhysicalNumberOfRows() ;i++) {
				
				ProventoModel provento = new ProventoModel();
			        
			    XSSFRow row = worksheet.getRow(i);
			    
			    if (row.getCell(0) == null) {
			    	break;
			    }
			    
			    provento.setUsuario(usuario);
			    
			    String dataTransacaoString = row.getCell(1).getStringCellValue();
			    LocalDate dataTransacao = LocalDate.of(
			    	Integer.parseInt( dataTransacaoString.substring(6, 10) ), 
			    	Integer.parseInt( dataTransacaoString.substring(3, 5) ), 
			    	Integer.parseInt( dataTransacaoString.substring(0, 2) )
			    );     
			    provento.setData( dataTransacao );
			    
			    String movimento =  row.getCell(2).getStringCellValue();
			    if (movimento.equals("Juros Sobre Capital Próprio")) {
			    	provento.setTipoProvento(TipoProvento.JCP);
			    } else if (movimento.equals("Rendimento") || (movimento.equals("Dividendo"))) {
			    	provento.setTipoProvento(TipoProvento.Dividendos);
			    } else if (movimento.equals("Juros")) {
			    	provento.setTipoProvento(TipoProvento.Juros);
			    } else {
			    	continue;
			    }
			    
			    String codigo = row.getCell(3).getStringCellValue();
			    String[] partes = codigo.split(" - ", 2);
			    codigo = partes[0];
			    Optional<AtivoModel> ativoOptional = ativoService.findByUsuarioAndCodigo(usuario, codigo);
			    AtivoModel ativoModel = new AtivoModel();
			    if (!ativoOptional.isPresent()) {
			    	ativoModel.setId(null);
			    	ativoModel.setCodigo(codigo);
			    	if (partes.length > 1) {
			    		ativoModel.setNome(partes[1]);
			    	}
			    	ativoModel.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
			    	ativoModel.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
			    	ativoModel.setMoeda(Moeda.R$);
			    	ativoModel.setQuarentena(false);
			    	ativoModel.setUsuario(usuario);
			    	ativoModel = ativoService.save(ativoModel);
			    } else {
			    	ativoModel = ativoOptional.get();
			    }
			    provento.setAtivo(ativoModel);
			    
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
			    	bancoModel =  bancoService.save(bancoModel);
			    } else {
			    	bancoModel = bancoOptional.get();
			    }
			    provento.setBanco(bancoModel);
			    
			    double quantidade = row.getCell(5).getNumericCellValue();
			    provento.setQuantidade(BigDecimal.valueOf( quantidade) );

			    double valor = row.getCell(7).getNumericCellValue();
			    provento.setTotal(BigDecimal.valueOf( valor) );
			    
			    double preco = valor / quantidade;
			    provento.setValor(BigDecimal.valueOf( preco) );
			    
			    provento.setDataAtualizacao(LocalDateTime.now(ZoneId.of("UTC")));
			    provento.setDataCriacao(LocalDateTime.now(ZoneId.of("UTC")));
			    
			    Optional<ProventoModel> proventoOptional = proventoRepository.findByUsuarioAndDataAndQuantidadeAndTipoProventoAndTotal(
			    		usuario,
			    		provento.getData(),
			    		provento.getQuantidade(),
			    		provento.getTipoProvento(),
			    		provento.getTotal()
			    		
			    		);
			    if (!proventoOptional.isPresent()) {
			    	lista.add(provento);
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
