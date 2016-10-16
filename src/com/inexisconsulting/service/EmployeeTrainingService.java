package com.inexisconsulting.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.EmployeeTrainingDAO;

@Service("employeeTrainingService")
public class EmployeeTrainingService {
	
	@Autowired
	private EmployeeTrainingDAO employeeTrainingDao;

}
