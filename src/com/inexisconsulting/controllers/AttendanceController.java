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

	// get all projects for the current emp
	@RequestMapping(value = "/Attendance/GetProjectsByEmpId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Project> getProjectsByEmpId(@RequestBody Attendance attendance) {
		List<Project> projects = projectService.getProjectsByEmpId(attendance);
		return projects;
	}

	// get all projects
	@RequestMapping(value = "/Attendance/GetProjects", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Project> getProjects() {
		List<Project> projects = projectService.getProjects();
		return projects;
	}

	// get all attendances for the current emp for current year
	@RequestMapping(value = "/Attendance/GetAttendancesByEmpId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Attendance> getAttendancesByEmpId(@RequestBody Attendance attendance) {
		List<Attendance> attendances = attendanceService.getAttendancesByEmpId(attendance);
		return attendances;
	}

	// get all attendances for current year
	@RequestMapping(value = "/Attendance/GetAttendancesForCurrentYear", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Attendance> getAttendancesForCurrentYear() {
		List<Attendance> attendances = attendanceService.getAttendancesForCurrentYear();
		return attendances;
	}

	// get attendance by attendance_id
	@RequestMapping(value = "/Attendance/GetAttendanceByAttendanceId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Attendance getAttendanceByAttendanceId(@RequestBody Attendance attendance) {
		return attendanceService.getAttendanceByAttendanceId(attendance);
	}

	// check duplicate attendance exists
	@RequestMapping(value = "/Attendance/CheckAttendanceDuplicate", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkAttendanceDuplicate(@RequestBody Attendance attendance)
			throws HibernateException, ParseException {
		return attendanceService.checkAttendanceDuplicate(attendance);
	}

	// add attendance
	@RequestMapping(value = "/Attendance/AddAttendance", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addAttendance(@RequestBody Attendance attendance) throws ParseException {
		attendanceService.addAttendance(attendance);
	}

	// update attendance
	@RequestMapping(value = "/Attendance/UpdateAttendance", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateAttendance(@RequestBody Attendance attendance) throws ParseException {
		attendanceService.updateAttendance(attendance);
	}

	// delete attendance
	@RequestMapping(value = "/Attendance/DeleteAttendance", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteAttendance(@RequestBody Attendance attendance) {
		attendanceService.deleteAttendance(attendance);
	}

	// get daily hours by logged in employee
	@RequestMapping(value = "/Attendance/GetDailyHoursByLoggedInEmp", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public float getDailyHoursByLoggedInEmp(@RequestBody Attendance attendance)
			throws HibernateException, ParseException {
		return attendanceService.getDailyHoursByLoggedInEmp(attendance);
	}

	// get weekly hours by logged in employee
	@RequestMapping(value = "/Attendance/GetWeeklyHoursByLoggedInEmp", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public float getWeeklyHoursByLoggedInEmp(@RequestBody Attendance attendance) {
		return attendanceService.getWeeklyHoursByLoggedInEmp(attendance);
	}

	// get User Lead and HR Summary Chart
	@RequestMapping(value = "/Attendance/UserLeadAndHRSummaryChart", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Object[]> userLeadAndHRSummaryChart(@RequestBody Attendance attendance) {
		return attendanceService.userLeadAndHRSummaryChart(attendance);
	}

	// get HR and CEO Summary Chart
	@RequestMapping(value = "/Attendance/GetAttendanceSummaryForCEOAndHR", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Object[]> hrAndCeoSummaryChart() {
		return attendanceService.hrAndCeoSummaryChart();
	}
}
