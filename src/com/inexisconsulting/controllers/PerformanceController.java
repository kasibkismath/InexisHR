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

import com.inexisconsulting.dao.Designation;
import com.inexisconsulting.dao.Performance;
import com.inexisconsulting.service.PerformanceService;

@Controller
public class PerformanceController {
	
	@Autowired
	private PerformanceService performanceService;
	
	@RequestMapping("/Performance")
	public String showPerformanceMainPage(Model model, Principal principal) {
		
		// get logged in username
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);

		return "Performance/performanceMain";
	}
	
	@RequestMapping(value="/Performance/AllPerformanceAppraisals", method=RequestMethod.GET, 
			produces="application/json")
	@ResponseBody
	public List<Performance> getPerformanceAppraisals(){
		List<Performance> performances = performanceService.getPerformanceAppraisals();
		return performances;
	}
	
	// check if performance exists
	@RequestMapping(value = "/Performance/CheckPerformanceExists", method = RequestMethod.POST, 
					produces = "application/json")
	@ResponseBody
	public boolean checkPerformanceExists(@RequestBody Performance performance) throws HibernateException, ParseException {
		return performanceService.checkPerformanceExists(performance);
	}
}
