package com.web.board.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.Builder;

@Builder
public record Board(Integer boardNo, 
		String boardTitle, String boardWriter,
		String boardContent,String originalFilename,
		String renamedFilename,
		Date boardDate, int boardReadCount, List<BoardComment> comments) {
	
//	public Board incrementReadCount(int count) {
//		
//	}
}

