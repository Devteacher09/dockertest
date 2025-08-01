package com.web.ajax.model.dto;

import lombok.Builder;

@Builder
public record Actor(String userName,
		String phone,String profile,
		int age) {

	@Override
	public String toString() {
		return userName+","+phone+","+profile+","+age;
	}
	
}
