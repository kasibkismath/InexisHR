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
import com.inexisconsulting.dao.Project;
import com.inexisconsulting.dao.Team;
import com.inexisconsulting.service.EmployeeService;
import com.inexisconsulting.service.ProjectService;
import com.inexisconsulting.service.TeamService;

@Controller
public class ProjectsAndTeamController {

	@Autowired
	private ProjectService projectService;

	@Autowired
	private TeamService teamService;

	@Autowired
	private EmployeeService employeeService;

	@RequestMapping("/ProjectsAndTeams")
	@SuppressWarnings("unchecked")
	public String showProjectsMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Projects and Teams/projectsAndTeamsMain";
	}

	// get all projects
	@RequestMapping(value = "/ProjectsAndTeams/GetAllProjects", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Project> getAllProjects() {
		return projectService.getAllProjects();
	}

	// check duplicate project by project name
	@RequestMapping(value = "/ProjectsAndTeams/CheckDuplicateProject", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateProject(@RequestBody Project project) {
		return projectService.checkDuplicateProject(project);
	}

	// add new project
	@RequestMapping(value = "/ProjectsAndTeams/AddProject", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addProject(@RequestBody Project project) throws ParseException {
		projectService.addProject(project);
	}

	// get project by project id
	@RequestMapping(value = "/ProjectsAndTeams/GetProjectByProjectId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Project getProjectByProjectId(@RequestBody Project project) {
		return projectService.getProjectByProjectId(project);
	}

	// update project
	@RequestMapping(value = "/ProjectsAndTeams/UpdateProject", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateProject(@RequestBody Project project) throws ParseException {
		projectService.updateProject(project);
	}

	// delete project
	@RequestMapping(value = "/ProjectsAndTeams/DeleteProject", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteProject(@RequestBody Project project) {
		projectService.deleteProject(project);
	}

	// get all teams
	@RequestMapping(value = "/ProjectsAndTeams/GetAllTeams", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Team> getAllTeams() {
		return teamService.getAllTeams();
	}

	// get all In-Progress And On-Hold Projects
	@RequestMapping(value = "/ProjectsAndTeams/GetInProgressAndOnHoldProjects", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Project> getInProgressAndOnHoldProjects() {
		return projectService.getProjects();
	}

	// get all Lead Employees
	@RequestMapping(value = "/ProjectsAndTeams/GetLeadEmployees", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Employee> getAllLeadEmployees() {
		return employeeService.getAllEmployees();
	}

	// check duplicate team by project_id and team name
	@RequestMapping(value = "/ProjectsAndTeams/CheckDuplicateTeam", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateTeam(@RequestBody Team team) {
		return teamService.checkDuplicateTeam(team);
	}

	// add new team
	@RequestMapping(value = "/ProjectsAndTeams/AddTeam", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addTeam(@RequestBody Team team) {
		teamService.addTeam(team);
	}

	// get team by team_Id
	@RequestMapping(value = "/ProjectsAndTeams/GetTeamByTeamId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Team getTeamByTeamId(@RequestBody Team team) {
		return teamService.getTeamByTeamId(team);
	}

	// update team
	@RequestMapping(value = "/ProjectsAndTeams/UpdateTeam", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateTeam(@RequestBody Team team) {
		teamService.updateTeam(team);
	}

	// delete team
	@RequestMapping(value = "/ProjectsAndTeams/DeleteTeam", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteTeam(@RequestBody Team team) {
		teamService.deleteTeam(team);
	}
}
