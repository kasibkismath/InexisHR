package com.inexisconsulting.controllers;


import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUploadController {
	
	@Autowired
	ServletContext servletContext;

	@RequestMapping(value="/FileUpload", method=RequestMethod.POST)
	@ResponseBody
	public void fileUpload(@RequestParam("fileName") String fileName,
			@RequestParam("file") MultipartFile file, HttpServletRequest request){
		
		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();
		
				String fullPath = "E:\\Eclipse Mars Working Files\\InexisHR\\WebContent"
						+ "\\resources\\images\\EmpProfileImages\\";

				// Create the file on server
				File serverFile = new File(fullPath
						+ File.separator + fileName);
				
				BufferedOutputStream stream = new BufferedOutputStream(
						new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();

			} catch (Exception e) {
				System.out.println(e);
			}
		} else {
			System.out.println("Couldn't upload file");
		}
	}
	
	
}


