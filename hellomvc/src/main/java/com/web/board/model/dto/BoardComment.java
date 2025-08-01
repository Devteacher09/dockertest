package com.web.board.model.dto;

import java.sql.Date;

import lombok.Builder;

@Builder
public record BoardComment(int boardCommentNo,
		int boardCommentLevel,String boardCommentWriter,
		String boardCommentContent,int boardRef, int boardCommentRef,
		Date boardCommentDate) {}
