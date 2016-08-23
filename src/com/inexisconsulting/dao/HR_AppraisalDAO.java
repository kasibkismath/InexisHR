package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
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
	 
	public Long checkHRAppraisalExists(HR_Appraisal hr_Appraisal) throws HibernateException, ParseException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from lead appraisal object
		Date date = hr_Appraisal.getPerformance().getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);
		
		String hql = "select count(hrApp.hr_appraisal_id) as count from HR_Appraisal as hrApp "
				+ "where hrApp.employee.emp_id=:empId and hrApp.performance.date=:date "
				+ "and hrApp.status=:status";
		
		Query query = session().createQuery(hql);
		query.setParameter("empId", hr_Appraisal.getEmployee().getEmpId());
		query.setParameter("date", sdf.parse(stringDate));
		query.setParameter("status", "Completed");
		
		Long count = (Long)query.uniqueResult();
		return count;
	}
}
