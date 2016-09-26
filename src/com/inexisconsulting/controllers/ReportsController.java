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

import com.inexisconsulting.dao.AllAttendanceReport;
import com.inexisconsulting.dao.Attendance;
import com.inexisconsulting.service.AttendanceService;

@Controller
public class ReportsController {
	
	@Autowired
	private AttendanceService attendanceService;

	@RequestMapping("/Reports")
	@SuppressWarnings("unchecked")
	public String showAttendanceMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Reports/reportsMain";
	}

	// get all attendances for report
	@RequestMapping(value = "/Reports/GetAllAttendacesForReport", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Attendance> getAllAttendacesForReport(@RequestBody AllAttendanceReport allAttendaceReport) throws HibernateException, ParseException {
		return attendanceService.getAllAttendacesForReport(allAttendaceReport);
	}

}
