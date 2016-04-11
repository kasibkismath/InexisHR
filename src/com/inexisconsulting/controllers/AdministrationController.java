package com.inexisconsulting.controllers;

import java.security.Principal;
import java.util.List;

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
public class AdministrationController {
	
	@Autowired
	private UserService userService;

	@RequestMapping(value="/administration")
	public String showAdministrationPage(Model model, Principal principal) {

		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);

		return "administration";
	}
	
	@RequestMapping(value="/administration/user/all", method=RequestMethod.GET, produces="application/json" )
	@ResponseBody
	public List<User> getAllUsers()  {
		List<User> allUsers = userService.getAllUsers();
		return allUsers;
	}
	
	
	@RequestMapping(value="/administration/user/delete", method=RequestMethod.POST, produces="application/json" )
	@ResponseBody
	public User deleteUser(@RequestBody User user)  {
		userService.deleteUser(user);
		return user;
	}
	
	@RequestMapping(value="/administration/user/getEditUser", method=RequestMethod.POST, produces="application/json" )
	@ResponseBody
	public User getEditUser(@RequestBody User user)  {
		User getEditUser = userService.getEditUser(user);
		return getEditUser;
	}
	
	
	@RequestMapping(value="/administration/user/updateEditUser", method=RequestMethod.POST, produces="application/json" )
	@ResponseBody
	public void updateEditUser(@RequestBody User user)  {
		userService.updateEditUser(user);
	}
	
	@RequestMapping(value="/administration/user/addNewUser", method=RequestMethod.POST, produces="application/json" )
	@ResponseBody
	public void addNewUser(@RequestBody User user)  {
		userService.addNewUser(user);
	}
	
	@RequestMapping(value="/administration/user/checkUserExists", method=RequestMethod.POST, produces="application/json" )
	@ResponseBody
	public boolean checkUserExists(@RequestBody User user)  {
		return userService.checkUserExists(user);
	}
}
