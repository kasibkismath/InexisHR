package com.inexisconsulting.controllers;

import java.security.Principal;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.User;
import com.inexisconsulting.service.UserService;

@Controller
public class LoginController {

	@RequestMapping(value = "/")
	public String showLogin() {
		return "Login/login";
	}

	@RequestMapping("/admin-main-menu")
	public String onLoginSuccessAdmin(Model model, Principal principal) {

		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);

		return "Main Menu/admin-main-menu";
	}
	
	@RequestMapping("/user-main-menu")
	public String onLoginSuccessUser(Model model, Principal principal) {

		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);

		return "Main Menu/user-main-menu";
	}
}
