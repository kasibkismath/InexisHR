package com.inexisconsulting.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EmployeeProfileController {

	@RequestMapping(value="/employeeProfile")
	public String showEmployeeProfilePage(Model model, Principal principal) {
		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);

		return "Employee Profile/employeeProfile";
	}

}
