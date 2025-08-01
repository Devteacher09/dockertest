package com.web.notice.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.web.common.CommonTemplate;
import com.web.common.MyFileRenamePolicy;
import com.web.notice.model.dto.Notice;
import com.web.notice.model.service.NoticeService;

/**
 * Servlet implementation class NoticeWriteEndServlet
 */
@WebServlet("/notice/noticewriteend.do")
public class NoticeWriteEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeWriteEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//multipart/form-data형식으로 요청된 데이터 처리하기
		//바이너리로 넘어온것을 파싱해서처리 
		//  -> cos.jar라이브러리가 제공하는 MultipartRequest클래스를 이용
		
		//톰켓 10이상은 cos를 이용하지못함. -> commons-io, common-fileupload2라이브러리를 이용하면 됨.
		
		//MultipartRequest객체 이용하기
		// 매개변수 있는 생성자로 객체를 생성
		//5개의 매개변수를 전달
		// 1 : HttpServletRequest객체 -> HttpServletRequest
		// 2 : upload할 파일경로를 설정(절대경로) -> String
		// 3 : 업로드파일 크기설정(byte) 예) 1024*1024 -> int
		// 4 : 인코딩방식 설정 -> String / utf-8
		// 5 : filerename 규칙 설정 / 저장되는 파일명을 설정하는 객체
		//					-> DefaultFileRenamePolicy클래스 이용
		
		//파일 업로드 경로가져오기
		String path=getServletContext()
				.getRealPath("/resources/upload/notice");

		//업로드파일 크기
		int size=1024*1024*100;//100MB
		
		//인코딩설정
		String encoding="utf-8";
		
		//파일 리네임 규칙
		DefaultFileRenamePolicy dfrp=new DefaultFileRenamePolicy();
		
		MultipartRequest mr=new MultipartRequest(
				request,
				path,
				size,
				encoding,
				new MyFileRenamePolicy());
		
		//정보가져오기
		//파일에 대한 정보
		//실제파일명, 리네임된 파일명
		//실제파일명 : getOriginalFileName("input name속성")
		//리네임된 파일명 : getFilesystemName("intpu name속성") 
		String oriFile=mr.getOriginalFileName("upfile");
		String renameFile=mr.getFilesystemName("upfile");
		System.out.println(oriFile);
		System.out.println(renameFile);
		//클라이언트가 전달한 paramter데이터
		String title=mr.getParameter("title");
		String content=mr.getParameter("content");
		String writer=mr.getParameter("writer");
		System.out.println(title+content+writer);
		
		Notice n=Notice.builder()
				.noticeTitle(title)
				.noticeContent(content)
				.noticeWriter(writer)
				.filePath(renameFile)
				.build();
		
		int result=NoticeService.noticeService().insertNotice(n);
		String msg,loc;
		if(result>0) {
			msg="공지사항 등록 성공 :)";
			loc="/notice/noticelist.do";
		}else {
			msg="공지사항 실패 :( 다시 시도하세요";
			loc="/notice/noticewrite.do";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher(
				CommonTemplate.WEB_VIEWS+"/common/msg.jsp")
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
