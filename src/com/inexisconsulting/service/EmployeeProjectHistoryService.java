package com.inexisconsulting.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.EmployeeProjectHistoryDAO;

@Service("employeeProjectHistoryService")
public class EmployeeProjectHistoryService {
	
	@Autowired
	private EmployeeProjectHistoryDAO employeeProjectHistoryDao;
	
	
}
