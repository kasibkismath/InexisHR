package com.inexisconsulting.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("hrAppraisalDao")
public class HR_AppraisalDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	public void addHRAppraisal(HR_Appraisal hr_appraisal) {
		session().saveOrUpdate(hr_appraisal);
	}
}
