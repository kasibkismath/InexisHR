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
		
		int empId = EmployeeService.getEmpId();
		model.addAttribute("empIdNew", empId);
		System.err.println("From Employee Controller : " + empId);

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
	public int addNewEmployee(@RequestBody Employee employee) {
		return employeeService.addNewEmployee(employee);
		 
	}
	
	@RequestMapping(value = "/employeeProfile/employee/updateImageURL", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateImageURL(@RequestBody Employee employee) {
		employeeService.updateImageURL(employee);
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
	
	@RequestMapping(value = "/employeeProfile/employee/updateEditBasicInfoEmp", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateEditBasicInfoEmp(@RequestBody Employee employee) {
		employeeService.updateEditBasicInfoEmp(employee);
	}
	
	@RequestMapping(value = "/employeeProfile/employee/updateEditEduFormDetails", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateEditEduFormEmp(@RequestBody Employee employee) {
		employeeService.updateEditEduFormEmp(employee);
	}
	
	@RequestMapping(value = "/employeeProfile/employee/updateWorkHistory", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateWorkHistory(@RequestBody Employee employee) {
		employeeService.updateWorkHistory(employee);
	}
	
	@RequestMapping(value = "/employeeProfile/employee/deleteEmployee", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Employee deleteEmployee(@RequestBody Employee employee) {
		employeeService.deleteEmployee(employee);
		return employee;
	}
	
	@RequestMapping(value="/employeeProfile/employee/getEmpDesignationData", method=RequestMethod.GET, produces="application/json")
	@ResponseBody
	public List<Object[]> getEmpDesignationData(){
		List<Object[]> data = employeeService.getEmpDesignationData();
		return data;
	}
	
	@RequestMapping(value = "/employeeProfile/employee/disable",
			method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void disableEmployee(@RequestBody Employee employee) {
		employeeService.disableEmployee(employee);
	}
}
