package com.web.ajax.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Actor2 {
	private String userName;
	private String phone;
	private String profile;
	private int age;
}
