package com.inexisconsulting.service;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Employee;
import com.inexisconsulting.dao.EmployeeTraining;
import com.inexisconsulting.dao.EmployeeTrainingDAO;
import com.inexisconsulting.dao.Training;

@Service("employeeTrainingService")
public class EmployeeTrainingService {
	
	@Autowired
	private EmployeeTrainingDAO employeeTrainingDao;

	public int getEmpTrainingCount(Training training) {
		return employeeTrainingDao.getEmpTrainingCount(training);
	}

	public List<EmployeeTraining> getAllEmpTrainingsByYear() {
		return employeeTrainingDao.getAllEmpTrainingsByYear();
	}

	public List<Employee> getEmpTrainingEmployees() {
		return employeeTrainingDao.getEmpTrainingEmployees();
	}

	public boolean checkDuplicateEmpTraining(EmployeeTraining empTraining) {
		return employeeTrainingDao.checkDuplicateEmpTraining(empTraining);
	}

	public void addEmpTraining(EmployeeTraining empTraining) {
		employeeTrainingDao.addEmpTraining(empTraining);
	}

	public boolean checkEmpTrainingAvailability(EmployeeTraining empTraining) {
		return employeeTrainingDao.checkEmpTrainingAvailability(empTraining);
	}

	public EmployeeTraining getEmpTrainingByEmpTrainingId(EmployeeTraining empTraining) {
		return employeeTrainingDao.getEmpTrainingByEmpTrainingId(empTraining);
	}

	public void updateEmpTraining(EmployeeTraining empTraining) {
		employeeTrainingDao.updateEmpTraining(empTraining);
	}

	public void deleteEmpTraining(EmployeeTraining empTraining) {
		employeeTrainingDao.deleteEmpTraining(empTraining);
	}

	public List<EmployeeTraining> getEmpTrainingsByEmpId(EmployeeTraining empTraining) {
		return employeeTrainingDao.getEmpTrainingsByEmpId(empTraining);
	}

	public void updateUserEmpTraining(EmployeeTraining empTraining) throws ParseException {
		employeeTrainingDao.updateUserEmpTraining(empTraining);
	}

}
