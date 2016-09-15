package com.inexisconsulting.controllers;

import java.security.Principal;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.Employee;
import com.inexisconsulting.dao.Team;
import com.inexisconsulting.dao.Team_Employee;
import com.inexisconsulting.service.EmployeeService;
import com.inexisconsulting.service.TeamService;

@Controller
public class TasksController {

	@Autowired
	private TeamService teamService;
	
	@Autowired
	private EmployeeService employeeService;

	@RequestMapping("/Tasks")
	@SuppressWarnings("unchecked")
	public String showAttendanceMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Tasks/tasksMain";
	}

	// get all employees for a given lead
	@RequestMapping(value = "/Tasks/GetEmployeesByLeadId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Team_Employee> getEmployeesByLeadId(@RequestBody Team team) {
		return teamService.getEmployeesByLeadId(team);
	}

	// get all active employees
	@RequestMapping(value = "/Tasks/GetAllEmployees", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Employee> getAllActiveEmployees(@RequestBody Employee employee) {
		return employeeService.getAllActiveEmployees(employee);
	}
}
