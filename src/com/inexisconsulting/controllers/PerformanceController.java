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

import com.inexisconsulting.dao.CEO_Appraisal;
import com.inexisconsulting.dao.Employee;
import com.inexisconsulting.dao.HR_Appraisal;
import com.inexisconsulting.dao.HR_Appraisal_And_Employee;
import com.inexisconsulting.dao.Lead_Appraisal;
import com.inexisconsulting.dao.Performance;
import com.inexisconsulting.dao.Team;
import com.inexisconsulting.dao.TeamEmployee_And_Team;
import com.inexisconsulting.dao.Team_And_Performance;
import com.inexisconsulting.dao.Team_Employee;
import com.inexisconsulting.dao.Team_Member_And_Lead_Appraisal;
import com.inexisconsulting.service.CEO_AppraisalService;
import com.inexisconsulting.service.EmployeeService;
import com.inexisconsulting.service.HR_AppraisalService;
import com.inexisconsulting.service.Lead_AppraisalService;
import com.inexisconsulting.service.PerformanceService;
import com.inexisconsulting.service.TeamService;
import com.inexisconsulting.service.Team_EmployeeService;
import com.inexisconsulting.service.UserService;

@Controller
public class PerformanceController {

	@Autowired
	private PerformanceService performanceService;

	@Autowired
	private CEO_AppraisalService ceoAppraisalService;

	@Autowired
	private Lead_AppraisalService leadAppraisalService;

	@Autowired
	private HR_AppraisalService hrAppraisalService;

	@Autowired
	private Team_EmployeeService teamEmployeeService;

	@Autowired
	private TeamService teamService;

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private UserService userService;

	@RequestMapping("/Performance")
	@SuppressWarnings("unchecked")
	public String showPerformanceMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Performance/performanceMain";
	}

	@RequestMapping(value = "/Performance/AllPerformanceAppraisals", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Performance> getPerformanceAppraisals() {
		List<Performance> performances = performanceService.getPerformanceAppraisals();
		return performances;
	}

	@RequestMapping(value = "/Performance/GetLeadAppraisalsByLeadId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Lead_Appraisal> getLeadAppraisalsByLeadId(@RequestBody Lead_Appraisal leadAppraisal) {
		List<Lead_Appraisal> lead_appraisals = leadAppraisalService.getLeadAppraisalsByLeadId(leadAppraisal);
		return lead_appraisals;
	}

	@RequestMapping(value = "/Performance/GetHRAppraisalByAppraisalId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public HR_Appraisal getHRAppraisalsByAppraisalId(@RequestBody HR_Appraisal hrAppraisal) {
		return hrAppraisalService.getHRAppraisalsByAppraisalId(hrAppraisal);
	}

	@RequestMapping(value = "/Performance/GetCEOAppraisalByAppraisalId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public CEO_Appraisal getCEOAppraisalByAppraisalId(@RequestBody CEO_Appraisal ceoAppraisal) {
		return ceoAppraisalService.getCEOAppraisalByAppraisalId(ceoAppraisal);
	}

	@RequestMapping(value = "/Performance/GetHRAppraisals", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<HR_Appraisal> getHRAppraisals() {
		List<HR_Appraisal> hr_appraisals = hrAppraisalService.getHRAppraisals();
		return hr_appraisals;
	}

	@RequestMapping(value = "/Performance/GetCEOAppraisals", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<CEO_Appraisal> getCEOAppraisals() {
		List<CEO_Appraisal> ceo_appraisals = ceoAppraisalService.getCEOAppraisals();
		return ceo_appraisals;
	}

	@RequestMapping(value = "/Performance/GetLeadAppraisalByLeadAppraisalId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Lead_Appraisal getLeadAppraisalByLeadAppraisalId(@RequestBody Lead_Appraisal leadAppraisal) {
		Lead_Appraisal lead_appraisal = leadAppraisalService.getLeadAppraisalByLeadAppraisalId(leadAppraisal);
		return lead_appraisal;
	}

	// check if performance exists
	@RequestMapping(value = "/Performance/CheckPerformanceExists", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkPerformanceExists(@RequestBody Performance performance)
			throws HibernateException, ParseException {
		return performanceService.checkPerformanceExists(performance);
	}

	@RequestMapping(value = "/Performance/getPerformanceId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Performance getPerformanceId(@RequestBody Performance performance)
			throws HibernateException, ParseException {
		return performanceService.getPerformanceId(performance);
	}

	// add performance
	@RequestMapping(value = "/Performance/AddPerformance", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int addPerformance(@RequestBody Performance performance) throws ParseException {
		return performanceService.addPerformance(performance);
	}

	// add CEO Appraisal
	@RequestMapping(value = "/Performance/AddCEOAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addCEOAppraisal(@RequestBody CEO_Appraisal ceo_appraisal) {
		ceoAppraisalService.addCEOAppraisal(ceo_appraisal);
	}

	// add Lead Appraisal
	@RequestMapping(value = "/Performance/AddLeadAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addLeadAppraisal(@RequestBody Lead_Appraisal lead_appraisal) {
		leadAppraisalService.addLeadAppraisal(lead_appraisal);
	}

	// get hiredDate
	@RequestMapping(value = "/Performance/CheckAppraisalYear", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Employee getHiredDate(@RequestBody Employee employee) {
		return employeeService.getHiredDate(employee);
	}

	// getTeamEmployeeByLeadId
	@RequestMapping(value = "/Performance/GetTeamEmployeeByLeadId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Team_Employee> getTeamEmployeesByLeadId(@RequestBody Team_Employee team_employee) {
		return teamEmployeeService.getTeamEmployeesByLeadId(team_employee);
	}

	// getTeamsByLeadId
	@RequestMapping(value = "/Performance/GetTeamsByLeadId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Team> getTeamsByLeadId(@RequestBody Team team) {
		return teamService.getTeamsByLeadId(team);
	}

	// checkDuplicateLeadAppraisal
	@RequestMapping(value = "/Performance/CheckDuplicateLeadAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateLeadAppraisal(@RequestBody Lead_Appraisal lead_Appraisal)
			throws HibernateException, ParseException {
		return leadAppraisalService.checkDuplicateLeadAppraisal(lead_Appraisal);
	}

	// Get team employee count by Emp_Id
	@RequestMapping(value = "/Performance/GetTeamEmployeeCountByEmpId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Long getTeamEmployeeCountByEmpId(@RequestBody TeamEmployee_And_Team teamEmpAndTeam) {
		return teamEmployeeService.getTeamEmployeesByEmpId(teamEmpAndTeam);
	}

	// Get complete lead appraisal count by Emp_Id
	@RequestMapping(value = "/Performance/GetCompleteLeadAppraisalCountByEmpId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Long getCompleteLeadAppraisalCountByEmpId(@RequestBody Lead_Appraisal lead_Appraisal)
			throws HibernateException, ParseException {
		return leadAppraisalService.getCompleteLeadAppraisalCountByEmpId(lead_Appraisal);
	}

	// checks whether the lead appraisal are complete
	@RequestMapping(value = "/Performance/CheckLeadAppraisalComplete", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkLeadAppraisalComplete(@RequestBody Team_Member_And_Lead_Appraisal teamMemAndLeadApp)
			throws HibernateException, ParseException {

		TeamEmployee_And_Team teamEmployeeAndTeam = teamMemAndLeadApp.getTeamEmployeeAndTeam();
		Lead_Appraisal lead_appraisal = teamMemAndLeadApp.getLead_Appraisal();

		if (getTeamEmployeeCountByEmpId(teamEmployeeAndTeam) == getCompleteLeadAppraisalCountByEmpId(lead_appraisal))
			return true;

		return false;
	}

	// Add HR Appraisal
	@RequestMapping(value = "/Performance/AddHRAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addHRAppraisal(@RequestBody HR_Appraisal hr_appraisal) {
		hrAppraisalService.addHRAppraisal(hr_appraisal);
	}

	// Check HR Appraisal Exists
	@RequestMapping(value = "/Performance/CheckHRAppraisalExists", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkHRAppraisalExists(@RequestBody HR_Appraisal_And_Employee hrAppAndEmp)
			throws HibernateException, ParseException {

		HR_Appraisal hr_appraisal = hrAppAndEmp.getHr_appraisal();
		Employee employee = hrAppAndEmp.getEmp();

		Long count = hrAppraisalService.checkHRAppraisalExists(hr_appraisal);
		String userRole = userService.getUserRoleByEmpId(employee);

		// if HR Manager - HR Appraisal
		if (userRole.equals("ROLE_HR") && count == 0) {
			return true;
		}

		// if not HR Manager - HR Appraisal
		if (count == 1) {
			return true;
		}

		return false;
	}

	// Get user role by emp id
	@RequestMapping(value = "/Performance/GetUserRoleByEmpId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public String getUserRoleByEmpId(@RequestBody Employee employee) {
		return userService.getUserRoleByEmpId(employee);
	}

	// check duplicate HR Appraisal
	@RequestMapping(value = "/Performance/CheckDuplicateHRAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateHRAppraisal(@RequestBody HR_Appraisal hr_appraisal)
			throws HibernateException, ParseException {

		// get count
		Long count = hrAppraisalService.checkHRAppraisalExists(hr_appraisal);

		if (count == 1)
			return true;

		return false;
	}

	// check duplicate CEO Appraisal
	@RequestMapping(value = "/Performance/CheckDuplicateCEOAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateCEOAppraisal(@RequestBody CEO_Appraisal ceo_appraisal)
			throws HibernateException, ParseException {

		// get count
		Long count = ceoAppraisalService.checkDuplicateCEOAppraisal(ceo_appraisal);

		System.err.println(count);

		if (count == 1)
			return true;

		return false;
	}

	// get sum of total scores
	@RequestMapping(value = "/Performance/FinalScoreCalculation", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public double finalScoreCalculation(@RequestBody Performance performance)
			throws HibernateException, ParseException {

		long total_score = performanceService.getSumOfTotalScore(performance);
		long appraisal_count = getTotalScoreCount(performance);

		long distinct_criteria = 4;

		// final score calculation
		// final_score = total_score/(distinct_criteria * appraisal_count)
		// round final_score to upper boundary value
		double final_score = (((double) total_score) / ((double) distinct_criteria * appraisal_count));

		return final_score;
	}

	// get count for total score
	@RequestMapping(value = "/Performance/GetTotalScoreCount", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Long getTotalScoreCount(@RequestBody Performance performance) throws HibernateException, ParseException {

		return performanceService.getTotalScoreCount(performance);
	}

	// update performance details with final_score and status information
	@RequestMapping(value = "/Performance/UpdatePerformanceFinalScoreAndStatus", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updatePerformanceWithFinalScoreAndStatus(@RequestBody Performance performance) {

		performanceService.updatePerformanceWithFinalScoreAndStatus(performance);
	}

	// update performance details with final_score and status information
	@RequestMapping(value = "/Performance/SaveEditLeadAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateLeadAppraisal(@RequestBody Lead_Appraisal lead_Appraisal) {
		leadAppraisalService.updateLeadAppraisal(lead_Appraisal);
	}

	// delete lead appraisal
	@RequestMapping(value = "/Performance/DeleteLeadAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteLeadAppraisal(@RequestBody Lead_Appraisal lead_Appraisal) {
		leadAppraisalService.deleteLeadAppraisal(lead_Appraisal);
	}

	// get total score
	@RequestMapping(value = "/Performance/GetTotalScoresByLeadId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Object[]> getTotalScoresForEmployeeByLeadId(@RequestBody Team_And_Performance teamAndPerformance)
			throws HibernateException, ParseException {
		return performanceService.getTotalScoresForEmployeeByLeadId(teamAndPerformance);
	}

	// update performance details with final_score and status information given
	// by HR Manager
	@RequestMapping(value = "/Performance/SaveEditHRAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateHRAppraisal(@RequestBody HR_Appraisal hr_Appraisal) {
		hrAppraisalService.updateHRAppraisal(hr_Appraisal);
	}

	// delete HR appraisal
	@RequestMapping(value = "/Performance/DeleteHRAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteHRAppraisal(@RequestBody HR_Appraisal hr_Appraisal) {
		hrAppraisalService.deleteHRAppraisal(hr_Appraisal);
	}

	// get total score for HR
	@RequestMapping(value = "/Performance/GetTotalScoresByHR", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Object[]> getTotalScoresForEmployeeByHR(@RequestBody Performance performance)
			throws HibernateException, ParseException {
		return performanceService.getTotalScoresForEmployeeByHR(performance);
	}

	// update CEO Appraisal
	@RequestMapping(value = "/Performance/UpdateCEOAppraisalByAppraisalId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateCEOAppraisal(@RequestBody CEO_Appraisal ceo_Appraisal) {
		ceoAppraisalService.updateCEOAppraisal(ceo_Appraisal);
	}

	// delete CEO appraisal
	@RequestMapping(value = "/Performance/DeleteCEOAppraisal", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteCEOAppraisal(@RequestBody CEO_Appraisal ceo_Appraisal) {
		ceoAppraisalService.deleteCEOAppraisal(ceo_Appraisal);
	}

	// get total score for HR
	@RequestMapping(value = "/Performance/GetFinalScoreEmployeeByCEO", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Object[]> getFinalScoreEmployeeByCEO(@RequestBody Performance performance)
			throws HibernateException, ParseException {
		return performanceService.getFinalScoreEmployeeByCEO(performance);
	}
}
