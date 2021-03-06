package com.kemenkes.epu.ui.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.kemenkes.epu.entity.Participant;

public class ParticipantValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return Participant.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "code", "field.required", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "field.required", "field.required");
	}

}
