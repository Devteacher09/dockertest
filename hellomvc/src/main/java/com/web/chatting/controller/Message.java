package com.web.chatting.controller;

import com.google.gson.Gson;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Message {
	private String type;
	private String sender;
	private String receiver;
	private String data;
	private String room;
	
	public String toJson() {
		return new Gson().toJson(this);
	}
}
