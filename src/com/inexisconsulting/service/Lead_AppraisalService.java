package com.inexisconsulting.service;

import java.text.ParseException;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Lead_Appraisal;
import com.inexisconsulting.dao.Lead_AppraisalDAO;

@Service("leadAppraisalService")
public class Lead_AppraisalService {
	
	@Autowired
	private Lead_AppraisalDAO leadAppraisalDao;
	
	public void addLeadAppraisal(Lead_Appraisal lead_appraisal) {
		leadAppraisalDao.addLeadAppraisal(lead_appraisal);
	}

	public boolean checkDuplicateLeadAppraisal(Lead_Appraisal lead_Appraisal) throws HibernateException, ParseException {
		return leadAppraisalDao.checkDuplicateLeadAppraisal(lead_Appraisal);
	}
}
