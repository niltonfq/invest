package br.com.abs.invest.validation;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class AtivonameConstraintImpl implements ConstraintValidator<AtivonameConstraint, String> {

	@Override
	public void initialize(AtivonameConstraint constraintAnnotation) {
		ConstraintValidator.super.initialize(constraintAnnotation);
	}
	
	@Override
	public boolean isValid(String username, ConstraintValidatorContext context) {
		
		if (username == null || username.trim().isEmpty() || username.contains(" ")) {
			return false;
		}
		return true;
	}

}
