package com.inexisconsulting.controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.Employee;
import com.inexisconsulting.dao.User;
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
	
	@RequestMapping(value = "/employeeProfile/employee/checkEmpExists", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkEmpExists(@RequestBody Employee employee) {
		return employeeService.checkEmpExists(employee);
	}
	
	@RequestMapping(value = "/employeeProfile/employee/getById", method = RequestMethod.GET)
	public String showEmployeeProfileById(@RequestParam("EmpID") int empId, Model model, Principal principal) {
		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		
		// pass empId to employeeProfileAngular
		model.addAttribute("empId", empId);
		
				
		return "Employee Profile/showEmployee";
	}
	
	@RequestMapping(value = "/employeeProfile/employee/getEditEmp", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Employee getEditEmployee(@RequestBody Employee employee) {
		Employee getEditEmp = employeeService.getEditEmployee(employee);
		return getEditEmp;
	}

}
