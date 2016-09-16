package com.inexisconsulting.controllers;

import java.security.Principal;
import java.text.ParseException;
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
import com.inexisconsulting.dao.Task;
import com.inexisconsulting.dao.Team;
import com.inexisconsulting.dao.Team_Employee;
import com.inexisconsulting.service.EmployeeService;
import com.inexisconsulting.service.TaskService;
import com.inexisconsulting.service.TeamService;

@Controller
public class TasksController {

	@Autowired
	private TeamService teamService;

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private TaskService taskService;

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

	// check duplicate task
	@RequestMapping(value = "/Tasks/CheckDuplicateTask", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateTask(@RequestBody Task task) {
		return taskService.checkDuplicateTask(task);
	}

	// add task
	@RequestMapping(value = "/Tasks/AddTask", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addTask(@RequestBody Task task) throws ParseException {
		taskService.addTask(task);
	}

	// get assigned tasks by lead_id
	@RequestMapping(value = "/Tasks/GetAssignedTasksByLeadId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Task> getAssignedTasksByLeadId(@RequestBody Task task) {
		return taskService.getAssignedTasksByLeadId(task);
	}
}
