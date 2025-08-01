package com.web.action.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.ajax.model.dto.Actor2;

/**
 * Servlet implementation class ElController
 */
@WebServlet("/eltest.do")
public class ElController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ElController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Actor2> actors=List.of(Actor2.builder()
				.userName("공유").age(45).profile("gongu.jpg")
				.phone("010-3421-8765")
				.build(),
				Actor2.builder()
				.userName("한소희").age(34).profile("hanso.avif")
				.phone("010-2341-0989")
				.build(),
				Actor2.builder()
				.userName("고윤정").age(28).profile("go.png")
				.phone("010-3467-7894")
				.build(),
				Actor2.builder()
				.userName("아이유").age(31).profile("iu.jpg")
				.phone("010-2472-3495")
				.build()
				);
		
		request.setAttribute("iu", actors.get(3));
		
		request.setAttribute("actors",actors);
		
		Map<String,Actor2> actorsMap=Map.of("a",Actor2.builder()
				.userName("공유").age(45).profile("gongu.jpg")
				.phone("010-3421-8765")
				.build(),
				"b",Actor2.builder()
				.userName("한소희").age(34).profile("hanso.avif")
				.phone("010-2341-0989")
				.build(),
				"c",Actor2.builder()
				.userName("고윤정").age(28).profile("go.png")
				.phone("010-3467-7894")
				.build(),
				"d",Actor2.builder()
				.userName("아이유").age(31).profile("iu.jpg")
				.phone("010-2472-3495")
				.build()
				);
		
		request.setAttribute("actorsMap", actorsMap);
		
		
		
		
		request.getRequestDispatcher("/WEB-INF/views/action/eltest.jsp")
		.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
