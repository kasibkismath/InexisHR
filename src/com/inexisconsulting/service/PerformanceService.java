package com.inexisconsulting.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Performance;
import com.inexisconsulting.dao.PerformanceDAO;

@Service("performanceService")
public class PerformanceService {
	
	@Autowired
	private PerformanceDAO performanceDao;

	public boolean checkPerformanceExists(Performance performance) {
		return false;
	}

}
