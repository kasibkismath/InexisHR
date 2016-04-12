package com.inexisconsulting.controllers;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
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
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MailSender mailSender;
	
	@RequestMapping(value="/")
	public String showLogin(){
		return "login";
	}
	
	@RequestMapping("/admin-dashboard")
	public String onLoginSuccessAdmin(Model model ,Principal principal) {
		
		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		
		return "admin-dashboard";
	}
	
	@RequestMapping("/user/settings")
	public String showUserSettings(Model model, Principal principal) {
		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		
		return "userSettings";
	}
	
	@RequestMapping(value="/user/settings/getUser",method=RequestMethod.POST, 
			consumes = {"application/json;charset=UTF-8"}, produces={"application/json;charset=UTF-8"})
	@ResponseBody
	public User getUser(@RequestBody User user)  {
		User fetchedUser = userService.getUser(user);
		return fetchedUser;
	}
	
	@RequestMapping(value="/user/settings/updateUser", method=RequestMethod.POST, produces="application/json" )
	@ResponseBody
	public void updateUser(@RequestBody User user)  {
		userService.updateUserSettings(user);
	}
	
	
	@RequestMapping(value="/user/settings/updateUserPassword", method=RequestMethod.POST, 
			produces="application/json" )
	@ResponseBody
	public void updateUserPassword(@RequestBody User user)  {
		userService.updateUserPassword(user);
	}
	
	@RequestMapping(value="/sendChangePasswordMail", method=RequestMethod.POST, 
			produces="application/json")
	@ResponseBody
	public void sendMessage(@RequestBody User data){
		
		String email = data.getEmail();
		
		SimpleMailMessage mail = new SimpleMailMessage();
		mail.setFrom("kasibtest@gmail.com");
		mail.setTo(email);
		mail.setSubject("Password Changed --  Inexis HR");
		mail.setText("Your Password has been changed please visit InexisHR for more info" + "\nFrom : " + "admin@inexisconsutling.com");
		
		try{
			mailSender.send(mail);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Sending email failed");
		}
		
	}
	
}
