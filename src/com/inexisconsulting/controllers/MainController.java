package com.inexisconsulting.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	@RequestMapping("/header")
	public String headerPage() {
		return "header";
	}
}
