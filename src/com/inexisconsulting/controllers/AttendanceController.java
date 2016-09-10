package com.inexisconsulting.controllers;

import java.security.Principal;
import java.text.ParseException;
import java.util.Collection;
import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.Attendance;
import com.inexisconsulting.dao.Project;
import com.inexisconsulting.service.AttendanceService;
import com.inexisconsulting.service.ProjectService;

@Controller
public class AttendanceController {

	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private AttendanceService attendanceService;

	@RequestMapping("/Attendance")
	@SuppressWarnings("unchecked")
	public String showAttendanceMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Attendance/attendanceMain";
	}

	// get all projects
	@RequestMapping(value = "/Attendance/GetProjects", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Project> getProjects() {
		List<Project> projects = projectService.getProjects();
		return projects;
	}

	// check duplicate attendance exists
	@RequestMapping(value = "/Attendance/CheckAttendanceDuplicate", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkAttendanceDuplicate(@RequestBody Attendance attendance) throws HibernateException, ParseException {
		return attendanceService.checkAttendanceDuplicate(attendance);
	}
}
