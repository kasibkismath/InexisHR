package com.inexisconsulting.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("leadAppraisalDao")
public class Lead_AppraisalDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	public void addLeadAppraisal(Lead_Appraisal lead_appraisal) {
		session().saveOrUpdate(lead_appraisal);
	}
}
