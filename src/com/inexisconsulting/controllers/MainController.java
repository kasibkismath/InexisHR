package com.inexisconsulting.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.inexisconsulting.dao.User;
import com.inexisconsulting.service.UserService;

@Controller
public class MainController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/header")
	public String headerPage(){
		return "header";
	}
	
	
}
