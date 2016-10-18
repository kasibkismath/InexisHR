package com.inexisconsulting.controllers;

import java.security.Principal;
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

import com.inexisconsulting.dao.Training;
import com.inexisconsulting.dao.TrainingsAndAvailability;
import com.inexisconsulting.service.EmployeeTrainingService;
import com.inexisconsulting.service.TrainingService;

@Controller
public class TrainingController {

	@Autowired
	private TrainingService trainingService;

	@Autowired
	private EmployeeTrainingService employeeTrainingService;

	@RequestMapping("/Training")
	@SuppressWarnings("unchecked")
	public String showTrainingMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Training/trainingMain";
	}

	// get all trainings for current year
	@RequestMapping(value = "/Trainings/GetAllTrainingsByYear", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<TrainingsAndAvailability> getAllTrainingsByYear() {
		return trainingService.getAllTrainingsByYear();
	}

	// get employee training count by training id
	@RequestMapping(value = "/Trainings/GetEmpTrainingCountByTrainingId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int getEmpTrainingCount(@RequestBody Training training) {
		return employeeTrainingService.getEmpTrainingCount(training);
	}

}
