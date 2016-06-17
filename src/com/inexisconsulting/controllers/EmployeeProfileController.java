package com.inexisconsulting.controllers;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.Employee;
import com.inexisconsulting.service.EmployeeService;

@Controller
public class EmployeeProfileController {
	
	@Autowired
	private EmployeeService employeeService;

	@RequestMapping(value="/employeeProfile")
	public String showEmployeeProfilePage(Model model, Principal principal) {
		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);

		return "Employee Profile/employeeProfile";
	}
	
	@RequestMapping(value="/employeeProfile/employee/all", method=RequestMethod.GET, produces="application/json")
	@ResponseBody
	public List<Employee> getAllEmployees(){
		List<Employee> allEmployees = employeeService.getAllEmployees();
		return allEmployees;
	}
	
	@RequestMapping(value = "/employeeProfile/employee/addNewEmp", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addNewEmployee(@RequestBody Employee employee) {
		employeeService.addNewEmployee(employee);
	}

}
