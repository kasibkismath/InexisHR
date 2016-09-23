package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
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
	
	// get applicant by applicant id
	public Applicant getApplicantByApplicantId(Applicant applicant) {
		Criteria crit = session().createCriteria(Applicant.class);
		crit.add(Restrictions.eq("applicant_id", applicant.getApplicant_id()));
		Applicant result = (Applicant) crit.uniqueResult();
		return result;
	}

	// update applicant
	public void updateApplicant(Applicant applicant) throws ParseException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date appliedDate = applicant.getApplied_date();
		String stringAppliedDate = sdf.format(appliedDate);
		
		Criteria crit = session().createCriteria(Applicant.class);
		crit.add(Restrictions.eq("applicant_id", applicant.getApplicant_id()));

		Applicant updatedApplicant = (Applicant) crit.uniqueResult();
		updatedApplicant.setApplied_date(sdf.parse(stringAppliedDate));
		updatedApplicant.setFirstName(applicant.getFirstName());
		updatedApplicant.setLastName(applicant.getLastName());
		updatedApplicant.setVacancy(applicant.getVacancy());
		updatedApplicant.setEmail(applicant.getEmail());
		updatedApplicant.setContact_no(applicant.getContact_no());
		updatedApplicant.setExperience(applicant.getExperience());
		updatedApplicant.setQualification(applicant.getQualification());
		updatedApplicant.setReferred_by(applicant.getReferred_by());
		updatedApplicant.setStatus(applicant.getStatus());
		updatedApplicant.setExam_result(applicant.getExam_result());
		updatedApplicant.setInterview_result(applicant.getInterview_result());
		
		session().saveOrUpdate(updatedApplicant);
	}

	public void deleteApplicant(Applicant applicant) {
		Query query = session().createQuery("delete from Applicant where applicant_id=:applicantId");
		query.setInteger("applicantId", applicant.getApplicant_id());
		query.executeUpdate();
	}
}
