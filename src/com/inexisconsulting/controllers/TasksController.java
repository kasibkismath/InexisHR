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

	// get task by task_id
	@RequestMapping(value = "/Tasks/GetTaskByTaskId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Task getTaskByTaskId(@RequestBody Task task) {
		return taskService.getTaskByTaskId(task);
	}

	// update task by task_id
	@RequestMapping(value = "/Tasks/UpdateTask", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateTask(@RequestBody Task task) throws ParseException {
		taskService.updateTask(task);
	}

	// update my task by task_id
	@RequestMapping(value = "/Tasks/UpdateMyTask", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateMyTask(@RequestBody Task task) throws ParseException {
		taskService.updateMyTask(task);
	}

	// delete task by task_id
	@RequestMapping(value = "/Tasks/DeleteTask", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteTask(@RequestBody Task task) {
		taskService.deleteTask(task);
	}

	// get pending task count
	@RequestMapping(value = "/Tasks/GetPendingTaskCount", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int getPendingTaskCount(@RequestBody Task task) {
		return taskService.getPendingTaskCount(task);
	}

	// get on hold task count
	@RequestMapping(value = "/Tasks/GetOnHoldTaskCount", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int getOnHoldTaskCount(@RequestBody Task task) {
		return taskService.getOnHoldTaskCount(task);
	}

	// get completed task count
	@RequestMapping(value = "/Tasks/GetCompletedTaskCount", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int getCompletedTaskCount(@RequestBody Task task) {
		return taskService.getCompletedTaskCount(task);
	}

	// get terminated task count
	@RequestMapping(value = "/Tasks/GetTerminatedTaskCount", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int getTerminatedTaskCount(@RequestBody Task task) {
		return taskService.getTerminatedTaskCount(task);
	}

	// get overdue task count
	@RequestMapping(value = "/Tasks/GetOverdueTaskCount", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int getOverdueTaskCount(@RequestBody Task task) {
		return taskService.getOverdueTaskCount(task);
	}

	// get Employee Task Completion Percentage
	@RequestMapping(value = "/Tasks/GetEmployeeTaskCompletionPercentage", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Object[]> getEmployeeTaskCompletionPercentage(@RequestBody Task task) {
		return taskService.getEmployeeTaskCompletionPercentage(task);
	}

	// get By Status and Count by logged in emp
	@RequestMapping(value = "/Tasks/GetTaskStatusAndCount", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Object[]> getTaskStatusAndCount(@RequestBody Task task) {
		return taskService.getTaskStatusAndCount(task);
	}

	// get my tasks
	@RequestMapping(value = "/Tasks/GetMyTasks", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Task> getMyTasks(@RequestBody Task task) {
		return taskService.getMyTasks(task);
	}

	// get completed task percentage by employee - logged in emp
	@RequestMapping(value = "/Tasks/GetCompletedTaskPercentageByEmployee", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int getCompletedTaskPercentageByEmployee(@RequestBody Task task) {
		return taskService.getCompletedTaskPercentageByEmployee(task);
	}
}
