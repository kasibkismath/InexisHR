package com.inexisconsulting.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	private DesignationService desginationService;
	
	@RequestMapping(value="/desgination/all", method=RequestMethod.GET, produces="application/json")
	@ResponseBody
	public List<Designation> getDesginations(){
		List<Designation> designations = desginationService.getDesignations();
		return designations;
	}

}
