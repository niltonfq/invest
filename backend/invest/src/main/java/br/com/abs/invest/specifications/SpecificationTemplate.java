package br.com.abs.invest.specifications;

import java.util.Collection;
import java.util.UUID;

import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Root;

import org.springframework.data.jpa.domain.Specification;

import br.com.abs.invest.models.AtivoModel;
import br.com.abs.invest.models.UsuarioModel;
import net.kaczmarzyk.spring.data.jpa.domain.Equal;
import net.kaczmarzyk.spring.data.jpa.web.annotation.And;
import net.kaczmarzyk.spring.data.jpa.web.annotation.Or;
import net.kaczmarzyk.spring.data.jpa.web.annotation.Spec;
import net.kaczmarzyk.spring.data.jpa.domain.Like;

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
}
