package com.inexisconsulting.service;

import java.text.ParseException;
import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.CEO_Appraisal;
import com.inexisconsulting.dao.Lead_Appraisal;
import com.inexisconsulting.dao.Performance;
import com.inexisconsulting.dao.PerformanceDAO;

@Service("performanceService")
public class PerformanceService {
	
	@Autowired
	private PerformanceDAO performanceDao;

	public boolean checkPerformanceExists(Performance performance) throws HibernateException, ParseException {
		return performanceDao.checkPerformanceExists(performance);
	}

	public List<Performance> getPerformanceAppraisals() {
		return performanceDao.getPerformanceAppraisals();
	}

	public Performance getPerformanceId(Performance performance) throws HibernateException, ParseException {
		return performanceDao.getPerformanceId(performance);
	}

	public int addPerformance(Performance performance) throws ParseException {
		return performanceDao.addPerformance(performance);
	}

	public Long getSumOfTotalScore(Performance performance) {
		return performanceDao.getSumOfTotalScore(performance);
	}

	public Long getTotalScoreCount(Performance performance) throws HibernateException, ParseException {
		return performanceDao.getTotalScoreCount(performance);
	}

	public void updatePerformanceWithFinalScoreAndStatus(Performance performance) {
		performanceDao.updatePerformanceWithFinalScoreAndStatus(performance);
	}
}
