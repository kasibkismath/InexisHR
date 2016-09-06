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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.User;
import com.inexisconsulting.service.UserService;

@Controller
public class UserSettingsController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/user/settings")
	public String showUserSettings(Model model, Principal principal) {
		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);

		return "User Settings/userSettings";
	}

	@RequestMapping(value = "/user/settings/getUser", method = RequestMethod.POST, consumes = {
			"application/json;charset=UTF-8" }, produces = { "application/json;charset=UTF-8" })
	@ResponseBody
	public User getUser(@RequestBody User user) {
		User fetchedUser = userService.getUser(user);
		return fetchedUser;
	}

	@RequestMapping(value = "/user/settings/updateUser", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateUser(@RequestBody User user) {
		userService.updateUserSettings(user);
	}

	@RequestMapping(value = "/user/settings/updateUserPassword", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateUserPassword(@RequestBody User user) {
		userService.updateUserPassword(user);
	}

	@RequestMapping(value = "/sendChangePasswordMail", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void sendMessage(@RequestBody User data) {
		final String username = "kasibtest@gmail.com";
		final String password = "kasibtest@123";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		String email = data.getEmail();

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("kasibtest@gmail.com", "Inexis Consulting"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			message.setSubject("Password Changed --  Inexis HR");
			message.setText("Your Password has been changed please visit InexisHR for more info" + "\nFrom : "
					+ "admin@inexisconsutling.com");
			Transport.send(message);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Sending email failed");
		}

	}


}
