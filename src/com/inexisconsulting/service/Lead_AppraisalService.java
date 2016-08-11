package com.inexisconsulting.service;

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
}
