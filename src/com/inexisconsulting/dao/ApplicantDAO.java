package com.inexisconsulting.dao;

import java.util.Calendar;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("applicantDao")
public class ApplicantDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	public List<Applicant> getAllApplicantsByCurrentYear() {
		String hql = "from Applicant as applicant "
				+ "where year(applicant.vacancy.added_date)=:currentYear or "
				+ "year(applicant.vacancy.expiry_date)=:currentYear";
		
		Query query = session().createQuery(hql);
		query.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
		
		List<Applicant> result = query.list();
		return result;
	}
}
