package com.inexisconsulting.service;

import java.text.ParseException;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.HR_Appraisal;
import com.inexisconsulting.dao.HR_AppraisalDAO;
import com.inexisconsulting.dao.HR_Appraisal_And_Employee;

@Service("hrAppraisalService")
public class HR_AppraisalService {
	
	@Autowired
	private HR_AppraisalDAO hrAppraisalDao;

	public void addHRAppraisal(HR_Appraisal hr_appraisal) {
		hrAppraisalDao.addHRAppraisal(hr_appraisal);
	}

	public Long checkHRAppraisalExists(HR_Appraisal hr_Appraisal) throws HibernateException, ParseException {
		return hrAppraisalDao.checkHRAppraisalExists(hr_Appraisal);
	}
		
}
