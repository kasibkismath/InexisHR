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

import com.inexisconsulting.dao.Leave;
import com.inexisconsulting.dao.Leave_Type;
import com.inexisconsulting.service.LeaveService;
import com.inexisconsulting.service.LeaveTypeService;

@Controller
public class LeaveController {

	@Autowired
	private LeaveService leaveService;

	@Autowired
	private LeaveTypeService leaveTypeService;

	@RequestMapping("/Leave")
	@SuppressWarnings("unchecked")
	public String showLeaveMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Leave/leaveMain";
	}

	// get all leave types
	@RequestMapping(value = "/Leave/GetLeaveTypes", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Leave_Type> getLeaveTypes() {
		List<Leave_Type> leaveTypes = leaveTypeService.getLeaveTypes();
		return leaveTypes;
	}

	// get causal leave type id
	@RequestMapping(value = "/Leave/GetCasualLeaveTypeId", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public int getCasualLeaveTypeId() {
		return leaveTypeService.getCasualLeaveTypeId();
	}

	// get medical leave type id
	@RequestMapping(value = "/Leave/GetMedicalLeaveTypeId", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public int getMedicalLeaveTypeId() {
		return leaveTypeService.getMedicalLeaveTypeId();
	}

	// get all leave types
	@RequestMapping(value = "/Leave/GetLeaveTypeId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Leave_Type getLeaveTypeId(@RequestBody Leave_Type leaveType) {
		return leaveTypeService.getLeaveTypeId(leaveType);
	}

	// get leave no of days sum by year and leave type
	@RequestMapping(value = "/Leave/GetLeaveSumByLeaveTypeAndYear", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Long getLeaveSumByLeaveTypeAndYear(@RequestBody Leave leave) {
		return leaveService.getLeaveSumByLeaveTypeAndYear(leave);
	}

	// get leave no of days sum by year for casual and medical leaves
	@RequestMapping(value = "/Leave/GetLeaveSumByYearForCausalAndMedicalLeaves", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public float getLeaveSumByYearForCausalAndSickLeaves(@RequestBody Leave leave) {
		return leaveService.getLeaveSumByYearForCausalAndMedicalLeaves(leave);
	}

	// check for duplicate leave
	@RequestMapping(value = "/Leave/CheckDuplicateLeave", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateLeave(@RequestBody Leave leave) throws HibernateException, ParseException {
		return leaveService.checkDuplicateLeave(leave);
	}
}
