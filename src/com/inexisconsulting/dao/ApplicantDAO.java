package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
	
	// adds new applicant
	public void addApplicant(Applicant applicant) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date appliedDate = applicant.getApplied_date();
		String stringAppliedDate = sdf.format(appliedDate);
		
		applicant.setApplied_date(sdf.parse(stringAppliedDate));
		
		session().saveOrUpdate(applicant);
	}
}
