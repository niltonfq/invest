package br.com.abs.invest.specifications;

import java.util.Collection;
import java.util.UUID;

import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Root;

import org.springframework.data.jpa.domain.Specification;

import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.BancoModel;
import br.com.abs.invest.models.UsuarioModel;
import net.kaczmarzyk.spring.data.jpa.domain.Equal;
import net.kaczmarzyk.spring.data.jpa.domain.Like;
import net.kaczmarzyk.spring.data.jpa.web.annotation.And;
import net.kaczmarzyk.spring.data.jpa.web.annotation.Spec;

public class SpecificationTemplate {

    @And({
        @Spec(path = "tipoAtivo", spec = Equal.class),
        @Spec(path = "segmento", spec = Equal.class)
        
    })
    public interface AtivoSpec extends Specification<AtivoModel> {}
    

    public static Specification<AtivoModel> ativosUsuarioId(final UUID usuarioId) {
        return (root, query, cb) -> {
            query.distinct(true);
            Root<AtivoModel> ativo = root;
            Root<UsuarioModel> usuario = query.from(UsuarioModel.class);
            Expression<Collection<AtivoModel>> usuarioAtivos = usuario.get("ativos");
            return cb.and(cb.equal(usuario.get("id"), usuarioId), cb.isMember(ativo, usuarioAtivos));
        };
    }
    
    @Spec(path = "nome", spec = Like.class)
    public interface BancoSpec extends Specification<BancoModel> {}
    
    public static Specification<BancoModel> bancoUsuarioId(final UUID id) {
        return (root, query, cb) -> {
            query.distinct(true);
            Root<BancoModel> a = root;
            Root<UsuarioModel> b = query.from(UsuarioModel.class);
            Expression<Collection<BancoModel>> colecttionBA = b.get("bancos");
            return cb.and(cb.equal(b.get("id"), id), cb.isMember(a, colecttionBA));
        };
    }
}
