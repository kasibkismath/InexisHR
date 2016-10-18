package com.inexisconsulting.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.EmployeeTrainingDAO;
import com.inexisconsulting.dao.Training;

@Service("employeeTrainingService")
public class EmployeeTrainingService {
	
	@Autowired
	private EmployeeTrainingDAO employeeTrainingDao;

	public int getEmpTrainingCount(Training training) {
		return employeeTrainingDao.getEmpTrainingCount(training);
	}

}
