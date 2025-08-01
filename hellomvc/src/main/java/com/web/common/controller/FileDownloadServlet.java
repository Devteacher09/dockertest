package com.web.common.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.common.CommonTemplate;

@WebServlet("/filedownload.do")
public class FileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FileDownloadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type");
		String fileName=request.getParameter("filename");
		
		//1. 파일위치를 가져오기
		String path="";
		switch(type) {
			case "notice" : path=CommonTemplate.NOTICE_UPLOAD_PATH;break; 
			default:path=CommonTemplate.BASIC_UPLOAD_PATH;break;
		}
		path=getServletContext().getRealPath(path);
		//2.파일클래스 생성
		File downloadFile=new File(path+"/"+fileName);
		
		//contentType설정 : MIME-TYPE application/octet-stream 알려지 않은 파일을 전송할때 사용
		//다운로드 파일명 : response header에 Content-disposition속성을 설정
		//               attachment(다운로드창 열림);filename='다운로드파일명'
		//               index(브라우저에서 열수있는 확장자는 브라우저에서 오픈);
		try(FileInputStream fis=new FileInputStream(downloadFile);
				BufferedInputStream bis=new BufferedInputStream(fis);
				BufferedOutputStream bos=new BufferedOutputStream(
						response.getOutputStream())){
			
			response.setContentType("application/octet-stream");
			response.setHeader("Content-disposition", "attachment;filename="+fileName);
			
			int data=-1;
			while((data=bis.read())!=-1) {
				bos.write(data);
			}
			
		}catch(IOException e) {
			e.printStackTrace();
		}
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
