package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Employee;
import com.inexisconsulting.dao.EmployeeDAO;
import com.inexisconsulting.dao.Team_Employee;
import com.inexisconsulting.dao.User;

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
	
	public List<Object[]> getEmpDesignationData() {
		return employeeDao.getEmpDesignationData();
	}

	public void disableEmployee(Employee employee) {
		employeeDao.disableEmployee(employee);
	}

	public Employee getStatus(Employee employee) {
		return employeeDao.getStatus(employee);
	}

	public User getEmployeeByUsername(User user) {
		return employeeDao.getEmployeeByUsername(user);
	}

	public Employee getHiredDate(Employee employee) {
		return employeeDao.getHiredDate(employee);
	}

	public List<Employee> getAllActiveEmployees(Employee employee) {
		return employeeDao.getAllActiveEmployees(employee);
	}

	public Employee getEmployeeByEmpId(Employee employee) {
		return employeeDao.getEmployeeByEmpId(employee);
	}
}
