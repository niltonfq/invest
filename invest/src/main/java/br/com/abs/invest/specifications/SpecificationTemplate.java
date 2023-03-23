package br.com.abs.invest.specifications;

import org.springframework.data.jpa.domain.Specification;

import br.com.abs.invest.models.AtivoModel;
import net.kaczmarzyk.spring.data.jpa.domain.Equal;
import net.kaczmarzyk.spring.data.jpa.web.annotation.And;
import net.kaczmarzyk.spring.data.jpa.web.annotation.Spec;

public class SpecificationTemplate {

	@And({
		@Spec(path = "usuario", spec = Equal.class)
	})
	public interface AtivoSpec extends Specification<AtivoModel> {}
}
