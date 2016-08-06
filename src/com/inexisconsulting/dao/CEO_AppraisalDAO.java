package com.inexisconsulting.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("ceoAppraisalDao")
public class CEO_AppraisalDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	public void addCEOAppraisal(CEO_Appraisal ceo_appraisal) {
		session().saveOrUpdate(ceo_appraisal);
	}

}
