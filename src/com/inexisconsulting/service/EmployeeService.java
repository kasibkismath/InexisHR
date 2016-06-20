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

	public void addNewEmployee(Employee employee) {
		employeeDao.addNewEmployee(employee);
	}

	public boolean checkEmpExists(Employee employee) {
		return employeeDao.checkEmpExists(employee);
	}

	public Employee getEditEmployee(Employee employee) {
		return employeeDao.getEditEmployee(employee);
	}
}
