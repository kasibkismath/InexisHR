package com.inexisconsulting.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.Designation;
import com.inexisconsulting.dao.DesignationDAO;
import com.inexisconsulting.dao.Employee;
import com.inexisconsulting.service.DesignationService;

@Controller
public class DesignationController {
	
	@Autowired
	private DesignationService designationService;
	
	@RequestMapping(value="/desgination/all", method=RequestMethod.GET, produces="application/json")
	@ResponseBody
	public List<Designation> getDesginations(){
		List<Designation> designations = designationService.getDesignations();
		return designations;
	}
	
	@RequestMapping(value = "/designation/getDesignationById", method = RequestMethod.POST, 
			produces = "application/json")
	@ResponseBody
	public Designation getDesignationById(@RequestBody Designation designation) {
		Designation retreivedDesignation = designationService.getDesignationById(designation);
		return retreivedDesignation;
	}
	
	@RequestMapping(value = "/designation/checkDesignationExists", method = RequestMethod.POST, 
			produces = "application/json")
	@ResponseBody
	public boolean checkDesignationExists(@RequestBody Designation designation) {
		return designationService.checkDesignationExists(designation);
	}
}
