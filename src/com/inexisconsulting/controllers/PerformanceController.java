package com.inexisconsulting.controllers;

import java.security.Principal;
import java.text.ParseException;
import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.CEO_Appraisal;
import com.inexisconsulting.dao.Performance;
import com.inexisconsulting.dao.Team_Employee;
import com.inexisconsulting.service.CEO_AppraisalService;
import com.inexisconsulting.service.PerformanceService;
import com.inexisconsulting.service.Team_EmployeeService;

@Controller
public class PerformanceController {

	@Autowired
	private PerformanceService performanceService;
	
	@Autowired
	private CEO_AppraisalService ceoAppraisalService;
	
	@Autowired
	private Team_EmployeeService teamEmployeeService;

	@RequestMapping("/Performance")
	public String showPerformanceMainPage(Model model, Principal principal) {

		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);

		return "Performance/performanceMain";
	}

	@RequestMapping(value = "/Performance/AllPerformanceAppraisals", method = RequestMethod.GET, 
			produces = "application/json")
	@ResponseBody
	public List<Performance> getPerformanceAppraisals() {
		List<Performance> performances = performanceService.getPerformanceAppraisals();
		return performances;
	}

	// check if performance exists
	@RequestMapping(value = "/Performance/CheckPerformanceExists", method = RequestMethod.POST, 
			produces = "application/json")
	@ResponseBody
	public boolean checkPerformanceExists(@RequestBody Performance performance)
			throws HibernateException, ParseException {
		return performanceService.checkPerformanceExists(performance);
	}

	@RequestMapping(value = "/Performance/getPerformanceId", method = RequestMethod.POST, 
			produces = "application/json")
	@ResponseBody
	public Performance getPerformanceId(@RequestBody Performance performance) 
			throws HibernateException, ParseException{
		return performanceService.getPerformanceId(performance);
	}
	
	// add performance
	@RequestMapping(value = "/Performance/AddPerformance", method = RequestMethod.POST, 
			produces = "application/json")
	@ResponseBody
	public int addPerformance(@RequestBody Performance performance) throws ParseException {
		return performanceService.addPerformance(performance);
	}
	
	// add CEO Appraisal
	@RequestMapping(value = "/Performance/AddCEOAppraisal", method = RequestMethod.POST, 
			produces = "application/json")
	@ResponseBody
	public void addCEOAppraisal(@RequestBody CEO_Appraisal ceo_appraisal) {
		ceoAppraisalService.addCEOAppraisal(ceo_appraisal);
	}
	
	//getTeamEmployeeByLeadId
	@RequestMapping(value = "/Performance/GetTeamEmployeeByLeadId", method = RequestMethod.POST, 
			produces = "application/json")
	@ResponseBody
	public List<Team_Employee> getTeamEmployeesByLeadId(@RequestBody Team_Employee team_employee) {
		return teamEmployeeService.getTeamEmployeesByLeadId(team_employee);
	}
}
