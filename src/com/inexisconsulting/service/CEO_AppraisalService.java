package com.inexisconsulting.service;

import java.text.ParseException;
import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.CEO_Appraisal;
import com.inexisconsulting.dao.CEO_AppraisalDAO;

@Service("ceoAppraisalService")
public class CEO_AppraisalService {
	
	@Autowired
	private CEO_AppraisalDAO ceoAppraisalDao;
	
	public void addCEOAppraisal(CEO_Appraisal ceo_appraisal) {
		ceoAppraisalDao.addCEOAppraisal(ceo_appraisal);
	}

	public Long checkDuplicateCEOAppraisal(CEO_Appraisal ceo_appraisal) throws HibernateException, ParseException {
		return ceoAppraisalDao.checkDuplicateCEOExists(ceo_appraisal);
	}

	public List<CEO_Appraisal> getCEOAppraisals() {
		return ceoAppraisalDao.getCEOAppraisals();
	}

	public CEO_Appraisal getCEOAppraisalByAppraisalId(CEO_Appraisal ceoAppraisal) {
		return ceoAppraisalDao.getCEOAppraisalByAppraisalId(ceoAppraisal);
	}

	public void updateCEOAppraisal(CEO_Appraisal ceo_Appraisal) {
		ceoAppraisalDao.updateCEOAppraisal(ceo_Appraisal);
	}

	public void deleteCEOAppraisal(CEO_Appraisal ceo_Appraisal) {
		ceoAppraisalDao.deleteCEOAppraisal(ceo_Appraisal);
	}

}
