package br.com.abs.invest.repositories;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import br.com.abs.invest.dtos.PosicaoAtivoDto;
import br.com.abs.invest.dtos.PosicaoTipoAtivoDto;
import br.com.abs.invest.enums.TipoAtivo;
import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.UsuarioModel;

public interface AtivoRepository extends JpaRepository<AtivoModel, UUID>, JpaSpecificationExecutor<AtivoModel>{

	Page<AtivoModel> findByUsuario(Pageable pageable, UsuarioModel usuario);

	Optional<AtivoModel> findByUsuarioAndId(UsuarioModel usuario, UUID id);

	Optional<AtivoModel> findByUsuarioAndCodigo(UsuarioModel usuarioModel, String codigo);

	List<AtivoModel> findAllByUsuario(UsuarioModel usuario);

	List<AtivoModel> findAllByUsuarioAndDataAtualizacaoPrecoBeforeOrDataAtualizacaoPrecoNull(UsuarioModel usuario,
			LocalDate now);

	@Query(value = "Select new br.com.abs.invest.dtos.PosicaoTipoAtivoDto (atv.tipoAtivo, \n"
			+ "       count(*) as quantidade, \n"
			+ "       case when sum(atv.totalAtual) <> 0 then\n"
			+ "       	  ((sum(atv.totalAtual) / :total) * 100)\n"
			+ "       else \n"
			+ "       	((sum(atv.totalInvestido) / :total) * 100)\n"
			+ "       end as percentual,\n"
			+ "       case when sum(atv.totalAtual) <> 0 then\n"
			+ "          sum(atv.totalAtual) \n"
			+ "       else\n"
			+ "          sum(atv.totalInvestido)\n"
			+ "       end as total) \n"
			+ "from AtivoModel atv\n"
			+ "where atv.quantidadeInvestida > 0\n"
			+ "  and atv.usuario.id = :uuid\n"
			+ "group by atv.tipoAtivo")
	List<PosicaoTipoAtivoDto> TotalPorTipo(UUID uuid, BigDecimal total);

	@Query(value = "Select case when sum(atv.totalAtual) <> 0 then\n"
			+ "          sum(atv.totalAtual) \n"
			+ "       else\n"
			+ "          sum(atv.totalInvestido)\n"
			+ "       end as total\n"
			+ "from AtivoModel atv\n"
			+ "where atv.quantidadeInvestida > 0\n"
			+ "  and atv.usuario.id = :id")
	BigDecimal totalPorUsuario(UUID id);

	@Query(value = "select sum(atv.totalAtual)\n"
			+ "from AtivoModel atv\n"
			+ "where atv.usuario.id = :id \n"
			+ "  and atv.tipoAtivo = :tipoAtivo \n"
			+ "  and atv.quantidadeInvestida > 0")
	BigDecimal totalTipoAtivoUsuario(UUID id, TipoAtivo tipoAtivo);

	@Query(value = "select new br.com.abs.invest.dtos.PosicaoAtivoDto( "
			+ "       atv.codigo, atv.precoMedio, atv.valorAtual,\n"
			+ "       atv.valorAtual - atv.precoMedio as diferenca,\n"
			+ "       atv.quantidadeInvestida, atv.totalInvestido,  \n"
			+ "       atv.totalAtual, \n"
			+ "       (atv.totalAtual / :totalTipoAtivo) * 100 as percentual,\n"
			+ "       (atv.totalAtual / :total) * 100 as percentualCarteira) \n"
			+ "       \n"
			+ "from AtivoModel atv\n"
			+ "where atv.usuario.id = :id\n"
			+ "  and atv.tipoAtivo = :tipoAtivo \n"
			+ "  and atv.quantidadeInvestida > 0\n"
			+ "order by atv.codigo")
	List<PosicaoAtivoDto> AtivosPorTipoUsuario(UUID id, BigDecimal totalTipoAtivo, BigDecimal total, TipoAtivo tipoAtivo);

	
}
