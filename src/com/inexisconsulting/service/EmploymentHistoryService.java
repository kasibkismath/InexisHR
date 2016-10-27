package com.inexisconsulting.service;

import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.EmploymentHistory;
import com.inexisconsulting.dao.EmploymentHistoryDAO;

@Service("employmentHistoryService")
public class EmploymentHistoryService {
	
	@Autowired
	private EmploymentHistoryDAO employmentHistoryDAO;

	public void addEmploymentHistory(EmploymentHistory empHistory) throws ParseException {
		employmentHistoryDAO.addEmploymentHistory(empHistory);
	}

}
