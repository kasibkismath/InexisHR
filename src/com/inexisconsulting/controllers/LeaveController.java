package com.inexisconsulting.controllers;

import java.security.Principal;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.Leave_Type;
import com.inexisconsulting.dao.Performance;
import com.inexisconsulting.service.LeaveTypeService;

@Controller
public class LeaveController {
	
	@Autowired
	private LeaveTypeService leaveTypeService;
	
	@RequestMapping("/Leave")
	@SuppressWarnings("unchecked")
	public String showLeaveMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Leave/leaveMain";
	}
	
	// get all leave types
	@RequestMapping(value = "/Leave/GetLeaveTypes", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Leave_Type> getLeaveTypes() {
		List<Leave_Type> leaveTypes = leaveTypeService.getLeaveTypes();
		return leaveTypes;
	}

}
