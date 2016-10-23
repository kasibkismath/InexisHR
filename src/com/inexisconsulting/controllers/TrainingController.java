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

import com.inexisconsulting.dao.Employee;
import com.inexisconsulting.dao.EmployeeTraining;
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

	// checks for duplicate trainings
	@RequestMapping(value = "/Trainings/CheckTrainingDuplicate", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateTraining(@RequestBody Training training) throws HibernateException, ParseException {
		return trainingService.checkDuplicateTraining(training);
	}

	// add new training
	@RequestMapping(value = "/Trainings/AddTraining", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addTraining(@RequestBody Training training) throws HibernateException, ParseException {
		trainingService.addTraining(training);
	}

	// get training by training_id
	@RequestMapping(value = "/Trainings/GetTrainingByTrainingId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Training getTrainingByTrainingId(@RequestBody Training training) {
		return trainingService.getTrainingByTrainingId(training);
	}

	// add new training
	@RequestMapping(value = "/Trainings/UpdateTraining", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateTraining(@RequestBody Training training) throws HibernateException, ParseException {
		trainingService.updateTraining(training);
	}

	// delete training
	@RequestMapping(value = "/Trainings/DeleteTraining", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteTraining(@RequestBody Training training) {
		trainingService.deleteTraining(training);
	}

	// get all emp trainings for current year
	@RequestMapping(value = "/Trainings/GetAllEmpTrainingsByYear", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<EmployeeTraining> getAllEmpTrainingsByYear() {
		return employeeTrainingService.getAllEmpTrainingsByYear();
	}

	// get all emp trainings employees
	@RequestMapping(value = "/Training/GetEmpTrainingEmployees", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Employee> getEmpTrainingEmployees() {
		return employeeTrainingService.getEmpTrainingEmployees();
	}

	// checks for duplicate emp trainings
	@RequestMapping(value = "/Training/CheckEmpTrainingDuplicate", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateEmpTraining(@RequestBody EmployeeTraining empTraining) {
		return employeeTrainingService.checkDuplicateEmpTraining(empTraining);
	}

	// checks for training availability
	@RequestMapping(value = "/Training/CheckEmpTrainingAvailability", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkEmpTrainingAvailability(@RequestBody EmployeeTraining empTraining) {
		return employeeTrainingService.checkEmpTrainingAvailability(empTraining);
	}

	// add emp training
	@RequestMapping(value = "/Training/AddEmpTraining", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addEmpTraining(@RequestBody EmployeeTraining empTraining) {
		employeeTrainingService.addEmpTraining(empTraining);
	}

	// get emp training by emp_training_id
	@RequestMapping(value = "/Training/GetEmpTrainingByEmpTrainingId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public EmployeeTraining getEmpTrainingByEmpTrainingId(@RequestBody EmployeeTraining empTraining) {
		return employeeTrainingService.getEmpTrainingByEmpTrainingId(empTraining);
	}

	// update emp training
	@RequestMapping(value = "/Training/UpdateEmpTraining", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateEmpTraining(@RequestBody EmployeeTraining empTraining) {
		employeeTrainingService.updateEmpTraining(empTraining);
	}

	// delete emp training
	@RequestMapping(value = "/Training/DeleteEmpTraining", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteEmpTraining(@RequestBody EmployeeTraining empTraining) {
		employeeTrainingService.deleteEmpTraining(empTraining);
	}

	// get employee trainings by empId
	@RequestMapping(value = "/Training/GetEmpTrainingByEmpId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<EmployeeTraining> getEmpTrainingsByEmpId(@RequestBody EmployeeTraining empTraining) {
		return employeeTrainingService.getEmpTrainingsByEmpId(empTraining);
	}

	// update user emp training
	@RequestMapping(value = "/Training/UpdateUserEmpTraining", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateUserEmpTraining(@RequestBody EmployeeTraining empTraining) throws ParseException {
		employeeTrainingService.updateUserEmpTraining(empTraining);
	}
}
