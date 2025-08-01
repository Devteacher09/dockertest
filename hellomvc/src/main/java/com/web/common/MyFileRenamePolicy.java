package com.web.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class MyFileRenamePolicy implements FileRenamePolicy{

	@Override
	public File rename(File f) {
		String oriName=f.getName();
		File newFile=null;
		do {
			String prefix="BSLOVE_";
			SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
			int rnd=(int)(Math.random()*1000)+1;
			String ext=oriName.substring(oriName.lastIndexOf("."));
			String rename=prefix+sdf.format(new Date())+"_"+rnd+ext;
			newFile=new File(f.getParent(),rename);
		}while(!createFile(newFile));
		
		return newFile;
	}
	private boolean createFile(File newFile) {
		try {
			return newFile.createNewFile();
		}catch(IOException e) {
			return false;
		}
	}

	
	
}
