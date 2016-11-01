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
import com.inexisconsulting.dao.AppraisalReport;
import com.inexisconsulting.dao.Attendance;
import com.inexisconsulting.dao.EmployeeHoursWorked;
import com.inexisconsulting.dao.Leave;
import com.inexisconsulting.dao.Performance;
import com.inexisconsulting.dao.Task;
import com.inexisconsulting.dao.Training;
import com.inexisconsulting.dao.TrainingReportSentData;
import com.inexisconsulting.dao.Vacancy;
import com.inexisconsulting.service.AttendanceService;
import com.inexisconsulting.service.LeaveService;
import com.inexisconsulting.service.PerformanceService;
import com.inexisconsulting.service.TaskService;
import com.inexisconsulting.service.TrainingService;
import com.inexisconsulting.service.VacancyService;

@Controller
public class ReportsController {

	@Autowired
	private AttendanceService attendanceService;

	@Autowired
	private LeaveService leaveService;

	@Autowired
	private TaskService taskService;

	@Autowired
	private PerformanceService performanceService;

	@Autowired
	private VacancyService vacancyService;

	@Autowired
	private TrainingService trainingService;

	@RequestMapping("/Reports")
	@SuppressWarnings("unchecked")
	public String showReportsMainPage(Model model, Principal principal) {

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
	public List<Attendance> getAllAttendacesForReport(@RequestBody AllAttendanceReport allAttendaceReport)
			throws HibernateException, ParseException {
		return attendanceService.getAllAttendacesForReport(allAttendaceReport);
	}

	// get employee hours worked report
	@RequestMapping(value = "/Reports/GetEmployeeHoursWorkedReport", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<EmployeeHoursWorked> getEmployeeHoursWorkedReport(@RequestBody AllAttendanceReport attendance)
			throws HibernateException, ParseException {
		return attendanceService.getEmployeeHoursWorkedReport(attendance);
	}

	// get all leaves for report
	@RequestMapping(value = "/Reports/GenerateLeavesReport", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Leave> generateLeavesReport(@RequestBody Leave leave) throws HibernateException, ParseException {
		return leaveService.generateLeavesReport(leave);
	}

	// get all tasks for report
	@RequestMapping(value = "/Reports/GenerateTasksReport", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Task> generateTasksReport(@RequestBody Task task) throws HibernateException, ParseException {
		return taskService.generateTasksReport(task);
	}

	// get all appraisals for report
	@RequestMapping(value = "/Reports/GenerateAppraisalsReport", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<AppraisalReport> generateAppraisalsReport(@RequestBody Performance performance)
			throws HibernateException, ParseException {
		return performanceService.generateAppraisalsReport(performance);
	}

	// get all vacancies for report
	@RequestMapping(value = "/Reports/GenerateVacanciesReport", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Vacancy> generateVacanciesReport() {
		return vacancyService.generateVacanciesReport();
	}

	// get all trainings for report
	@RequestMapping(value = "/Reports/GenerateTrainingsReport", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Training> generateTrainingsReport(@RequestBody TrainingReportSentData trainingReportData) 
			throws HibernateException, ParseException {
		return trainingService.generateTrainingsReport(trainingReportData);
	}

}
