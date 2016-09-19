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

import com.inexisconsulting.dao.Project;
import com.inexisconsulting.service.ProjectService;

@Controller
public class ProjectsAndTeamController {

	@Autowired
	private ProjectService projectService;

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
}
