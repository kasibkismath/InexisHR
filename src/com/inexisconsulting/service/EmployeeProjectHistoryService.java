package com.inexisconsulting.service;

import java.text.ParseException;
import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.EmployeeProjectHistory;
import com.inexisconsulting.dao.EmployeeProjectHistoryDAO;

@Service("employeeProjectHistoryService")
public class EmployeeProjectHistoryService {
	
	@Autowired
	private EmployeeProjectHistoryDAO employeeProjectHistoryDao;

	public void addEmployeeProjectHistory(EmployeeProjectHistory empProjectHistory) 
			throws ParseException {
		employeeProjectHistoryDao.addEmployeeProjectHistory(empProjectHistory);
	}

	public boolean checkDuplicateEmpProjectHistory(EmployeeProjectHistory empProjectHistory) 
			throws HibernateException, ParseException {
		return employeeProjectHistoryDao.checkDuplicateEmpProjectHistory(empProjectHistory);
	}

	public List<EmployeeProjectHistory> getAllEmpProjectHistories() {
		return employeeProjectHistoryDao.getAllEmpProjectHistories();
	}

	public EmployeeProjectHistory getEmpProjectById(EmployeeProjectHistory empProjectHistory) {
		return employeeProjectHistoryDao.getEmpProjectById(empProjectHistory);
	}

	public void updateEmpProjectHistory(EmployeeProjectHistory empProjectHistory) throws ParseException {
		employeeProjectHistoryDao.updateEmpProjectHistory(empProjectHistory);
	}

	public void deleteEmpProjectHistory(EmployeeProjectHistory empProjectHistory) {
		employeeProjectHistoryDao.deleteEmpProjectHistory(empProjectHistory);
	}
	
	
}
