package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Employee;
import com.inexisconsulting.dao.EmployeeDAO;

@Service("employeeService")
public class EmployeeService {
	
	@Autowired
	private EmployeeDAO employeeDao;
	
	public List<Employee> getAllEmployees(){
		return employeeDao.getAllEmployees();
	}

	public int addNewEmployee(Employee employee) {
		return employeeDao.addNewEmployee(employee);
	}

	public boolean checkEmpExists(Employee employee) {
		return employeeDao.checkEmpExists(employee);
	}

	public Employee getEditEmployee(Employee employee) {
		return employeeDao.getEditEmployee(employee);
	}

	public void updateEditBasicInfoEmp(Employee employee) {
		employeeDao.updateEditBasicInfoEmp(employee);
	}

	public void updateEditEduFormEmp(Employee employee) {
		employeeDao.updateEditEduFormEmp(employee);
	}
	
	public static int getEmpId() {
		return EmployeeDAO.getEmpId();
	}

	public void updateImageURL(Employee employee) {
		employeeDao.updateImageURL(employee);
	}

	public void updateWorkHistory(Employee employee) {
		employeeDao.updateWorkHistory(employee);
	}

	public void deleteEmployee(Employee employee) {
		employeeDao.deleteEmployee(employee);
	}
}
